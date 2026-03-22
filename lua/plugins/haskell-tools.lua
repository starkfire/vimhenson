return {
    {
        "mrcjkb/haskell-tools.nvim",
        version = "^4",
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp"
        },
        init = function()
            vim.g.haskell_tools = function()
                local capabilities = require("cmp_nvim_lsp").default_capabilities()

                return {
                    hls = {
                        capabilities = capabilities,
                    }
                }
            end
        end
    },
}
