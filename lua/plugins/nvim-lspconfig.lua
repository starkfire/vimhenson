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
        vim.lsp.config('lua_ls', {
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
        })
        vim.lsp.enable('lua_ls')

        -- Python
        vim.lsp.config('pyright', {
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
        })
        vim.lsp.enable('pyright')

        -- C / C++ / CUDA / ObjC / ObjCpp / Proto
        vim.lsp.config('clangd', {
            on_attach = on_attach,
            capabilities = capabilities
        })
        vim.lsp.enable('clangd')

        -- Golang
        vim.lsp.config('gopls', {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable('gopls')

        -- Zig
        vim.lsp.config('zls', {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable('zls')

        -- Elixir
        vim.lsp.config('elixirls', {
            filetypes = { "ex", "exs", "elixir", "eelixir", "heex", "surface" },
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable('elixirls')

        -- Nim
        vim.lsp.config('nim_langserver', {
            filetypes = { "nim" },
            on_attach = on_attach,
            capabilities = capabilities
        })
        vim.lsp.enable('nim_langserver')

        -- JS/TS + Vue Language Server
        local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

        vim.lsp.config('ts_ls', {
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
        })
        vim.lsp.enable('ts_ls')

        -- Vue
        vim.lsp.config('volar', {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable('volar')

        -- Haskell
        vim.lsp.config('hls', {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "haskell", "lhaskell", "cabal" }
        })
        vim.lsp.enable('hls')

        -- Gleam
        vim.lsp.config('gleam', {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable('gleam')

        -- JSON
        vim.lsp.config('jsonls', {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable('jsonls')

    end
}
