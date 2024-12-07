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

            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics,
                {
                    underline = true,
                    virtual_text = false,
                    signs = true,
                    update_in_insert = false
                }
            )
        end

        -- Lua
        require'lspconfig'.lua_ls.setup{
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                    return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                        }
                    }
                })
            end,
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {}
            }
        }

        -- Python
        require'lspconfig'.pyright.setup{
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = 'openFilesOnly'
                    }
                }
            }
        }

        -- C / C++ / CUDA / ObjC / ObjCpp / Proto
        require'lspconfig'.clangd.setup{
            on_attach = on_attach,
            capabilities = capabilities
        }

        -- Golang
        require'lspconfig'.gopls.setup{
            on_attach = on_attach,
            capabilities = capabilities
        }

        -- Zig
        require'lspconfig'.zls.setup{
            on_attach = on_attach,
            capabilities = capabilities
        }

        -- Elixir
        require'lspconfig'.elixirls.setup{
            on_attach = on_attach,
            capabilities = capabilities
        }

        -- JS/TS + Vue Language Server
        local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

        require'lspconfig'.ts_ls.setup{
            on_attach = on_attach,
            capabilities = capabilities,
            init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vue_language_server_path,
                        languages = { 'vue' },
                    },
                },
            },
            filetypes = {
                "javascript",
                "typescript",
                "javascriptreact",
                "javascript.jsx",
                "typescriptreact",
                "typescript.tsx",
                "vue"
            },
        }

        -- Vue
        require'lspconfig'.volar.setup{
            on_attach = on_attach,
            capabilities = capabilities,
        }

        -- Haskell
        require'lspconfig'.hls.setup{
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "haskell", "lhaskell", "cabal" }
        }

        -- Gleam
        require'lspconfig'.gleam.setup{
            on_attach = on_attach,
            capabilities = capabilities,
        }

        -- JSON
        require'lspconfig'.jsonls.setup{
            on_attach = on_attach,
            capabilities = capabilities,
        }

    end
}
