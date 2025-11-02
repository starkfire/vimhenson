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

        local lsp_local_cfg = {
            notify = true,
            notify_level = vim.log.levels.WARN,
            mason_name_map = {
                lua_ls = 'lua-language-server',
                ts_ls = 'typescript-language-server',
            },
        }

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
            vim.notify("No publishDiagnostics handler available; diagnostics may not display correctly", vim.log.levels.WARN)
        end

        -- configure servers and use defaults
        for _, name in ipairs(servers) do
            local ok, server_opts = pcall(require, 'lsp.' .. name)

            if not ok then
                server_opts = {}
            end

            -- check if the server binary is available from Mason
            local is_installed = true

            local mason_name = lsp_local_cfg.mason_name_map[name] or name
            local ok_pkg, pkg = pcall(function()
                return mason_registry.get_package(mason_name)
            end)

            if ok_pkg and pkg then
                is_installed = pkg:is_installed()
            else
                -- as a fallback, check for an explicit cmd in the server opts, if provided
                if server_opts.cmd and type(server_opts.cmd) == 'table' and server_opts.cmd[1] then
                    is_installed = vim.fn.executable(server_opts.cmd[1]) == 1
                end
            end

            if not is_installed then
                if lsp_local_cfg.notify then
                    vim.notify(string.format("LSP server '%s' not installed; skipping enable. Install via mason or provide a 'cmd' in lsp/%s.lua.", name, name), lsp_local_cfg.notify_level)
                end
                goto continue
            end

            local opts = vim.tbl_deep_extend('force', { on_attach = on_attach, capabilities = capabilities }, server_opts)

            vim.lsp.config(name, opts)
            vim.lsp.enable(name)

            ::continue::
        end

    end
}
