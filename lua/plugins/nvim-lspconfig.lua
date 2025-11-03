return {
    "neovim/nvim-lspconfig",
    config = function()
        local servers = {
            "lua_ls",
            "clangd",
            "pyright",
            "ts_ls",
            "gopls",
            "zls",
            "elixirls",
            "nim_langserver",
            "volar",
            "hls",
            "jsonls"
        }

        require("mason").setup()
        require("mason-lspconfig").setup {
            ensure_installed = servers,
            handlers = {
                rust_analyzer = function() end,
            },
        }

        local mason_registry = require('mason-registry')

        -- local configuration (can be overridden from `lua/vimhenson/config.lua`)
        local lsp_local_cfg = {
            notify = true,
            notify_level = vim.log.levels.WARN,
            report_to_checkhealth = false,
            mason_name_map = {
                lua_ls = 'lua-language-server',
                ts_ls = 'typescript-language-server',
            },
        }

        -- load user overrides from `lua/vimhenson/config.lua`.
        do
            local ok_conf, user_cfg = pcall(require, 'vimhenson.config')
            if ok_conf and type(user_cfg) == 'table' and type(user_cfg.lsp) == 'table' then
                local u = user_cfg.lsp
                if u.enable_warnings ~= nil then lsp_local_cfg.notify = u.enable_warnings end
                if u.report_to_checkhealth ~= nil then lsp_local_cfg.report_to_checkhealth = u.report_to_checkhealth end
                if u.notify_level ~= nil then lsp_local_cfg.notify_level = u.notify_level end
                if type(u.mason_name_map) == 'table' then
                    for k,v in pairs(u.mason_name_map) do lsp_local_cfg.mason_name_map[k] = v end
                end
            end
        end

        -- checkhealth warnings
        local health_warnings = {}
        
        -- expose to runtime so a checkhealth provider can read it
        vim.g.vimhenson_lsp_warnings = health_warnings

        local function record_or_notify(msg, level)
            msg = tostring(msg)

            -- track errors and warnings for checkhealth
            if (level == vim.log.levels.WARN or level == vim.log.levels.ERROR) then
                table.insert(health_warnings, msg)
                vim.g.vimhenson_lsp_warnings = health_warnings
            end

            -- suppress notification if checkhealth reporting is enabled
            if lsp_local_cfg.report_to_checkhealth then
                return
            end

            if lsp_local_cfg.notify then
                vim.notify(msg, level or lsp_local_cfg.notify_level)
            end
        end

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local on_attach = function(_, bufnr)
            local attach_opts = { buffer = bufnr, silent = true }

            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, attach_opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, attach_opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, attach_opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, attach_opts)
            vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, attach_opts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, attach_opts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, attach_opts)
            vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, attach_opts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, attach_opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, attach_opts)
            vim.keymap.set('n', 'so', require('telescope.builtin').lsp_references, attach_opts)

            -- diagnostics
            vim.keymap.set('n', '<C-K>', vim.diagnostic.open_float, attach_opts)
        end

        -- configure the vim.diagnostic API globally
        vim.diagnostic.config({
            underline = true,
            virtual_text = false,
            signs = true,
            update_in_insert = false
        })
        
        -- set publishDiagnostics handler
        local publish_handler = nil
        
        if vim.diagnostic and vim.diagnostic.on_publish_diagnostics then
            publish_handler = vim.diagnostic.on_publish_diagnostics
        elseif vim.lsp and vim.lsp.diagnostic and vim.lsp.diagnostic.on_publish_diagnostics then
            publish_handler = vim.lsp.diagnostic.on_publish_diagnostics
        end

        if publish_handler then
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                publish_handler,
                diagnostic_opts
            )
        else
            record_or_notify("No publishDiagnostics handler available; diagnostics may not display correctly", vim.log.levels.WARN)
        end

        -- configure servers and use defaults
        for _, name in ipairs(servers) do
            local ok, server_opts = pcall(require, 'lsp.' .. name)

            -- verify if module loaded properly
            if not ok then
                -- handle missing lsp/*.lua configs
                record_or_notify(
                    string.format(
                        "Could not load config from lsp/%s.lua: %s\nUsing default configuration.", 
                        name, 
                        tostring(server_opts):match("lsp.*") or server_opts
                    ), 
                    lsp_local_cfg.notify_level
                )
                
                server_opts = {}
            elseif type(server_opts) ~= 'table' then
                -- handle non-table outputs
                record_or_notify(
                    string.format(
                        "Config file lsp/%s.lua must return a table, got %s\nUsing default configuration.",
                        name,
                        type(server_opts)
                    ), 
                    lsp_local_cfg.notify_level
                )
                
                server_opts = {}
            elseif vim.tbl_isempty(server_opts) then
                -- handle empty table outputs
                record_or_notify(
                    string.format(
                        "Config file lsp/%s.lua returned empty table\nUsing default configuration.", 
                        name
                    ), 
                    vim.log.levels.INFO
                )
            end

            -- tbl_deep_extend requires a table
            server_opts = server_opts or {}

            -- check if the server binary is available in Mason
            local is_installed = false
            local installation_source = nil

            local mason_name = lsp_local_cfg.mason_name_map[name] or name
            local ok_pkg, pkg = pcall(
                function()
                    return mason_registry.get_package(mason_name)
                end
            )

            if ok_pkg and pkg then
                is_installed = pkg:is_installed()
                if is_installed then
                    installation_source = "mason"
                end
            end

            -- check if the server binary is available in command-line (if not found in Mason)
            if not is_installed and type(server_opts) == 'table' then
                if server_opts.cmd and type(server_opts.cmd) == 'table' and server_opts.cmd[1] then
                    is_installed = vim.fn.executable(server_opts.cmd[1]) == 1
                    if is_installed then
                        installation_source = "custom"
                    end
                end
            end

            if not is_installed then
                if lsp_local_cfg.notify then
                    local msg = string.format(
                        "LSP server '%s' not found. To resolve:\n" ..
                        "1. Install via :MasonInstall %s, or\n" ..
                        "2. Provide a valid 'cmd' in lsp/%s.lua",
                        name, mason_name, name
                    )
                    record_or_notify(msg, lsp_local_cfg.notify_level)
                end
                goto continue
            end

            record_or_notify(string.format("Found LSP server '%s' (%s installation)", name, installation_source), vim.log.levels.INFO)

            -- safely merge configurations
            local ok_merge, opts = pcall(vim.tbl_deep_extend, 'force',
                { 
                    on_attach = on_attach, 
                    capabilities = capabilities 
                }, 
                server_opts
            )

            if not ok_merge then
                record_or_notify(string.format("Failed to merge LSP configs for '%s': %s\nUsing default configuration.", name, opts), lsp_local_cfg.notify_level)
                opts = {
                    on_attach = on_attach,
                    capabilities = capabilities
                }
            end

            -- configure and enable the server
            local ok_config = pcall(vim.lsp.config, name, opts)
            if not ok_config then
                record_or_notify(string.format("Failed to configure LSP server '%s'", name), lsp_local_cfg.notify_level)
                goto continue
            end

            local ok_enable = pcall(vim.lsp.enable, name)
            if not ok_enable then
                record_or_notify(string.format("Failed to enable LSP server '%s'", name), lsp_local_cfg.notify_level)
            else
                record_or_notify(string.format("Successfully configured and enabled LSP server '%s'", name), vim.log.levels.INFO)
            end

            ::continue::
        end
    end
}
