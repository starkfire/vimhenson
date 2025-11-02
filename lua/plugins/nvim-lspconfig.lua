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
        
        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.diagnostic.on_publish_diagnostics,
            diagnostic_opts
        )

        -- configure servers and use defaults
        for _, name in ipairs(servers) do
            local ok, server_opts = pcall(require, 'lsp.' .. name)
            
            if not ok then
                server_opts = {}
            end

            local opts = vim.tbl_deep_extend('force', { on_attach = on_attach, capabilities = capabilities }, server_opts)

            vim.lsp.config(name, opts)
            vim.lsp.enable(name)
        end

    end
}
