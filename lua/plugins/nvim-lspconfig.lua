return {
    "neovim/nvim-lspconfig",
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup {
            ensure_installed = {
                "rust_analyzer",
                "lua_ls",
                "pyright",
                "tsserver",
                "volar",
                "prismals",
            }
        }
        
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
            settings = {
                Lua = {}
            }
        }
        
        -- Rust
        require'lspconfig'.rust_analyzer.setup{}

        -- Python
        require'lspconfig'.pyright.setup{}

        -- JS/TS
        require'lspconfig'.tsserver.setup{}

        -- Vue
        require'lspconfig'.volar.setup{}

        -- Prisma
        require'lspconfig'.prismals.setup{}

        -- Hover
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client.server_capabilities.hoverProvider then
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
                end
            end,
        })
    end
}
