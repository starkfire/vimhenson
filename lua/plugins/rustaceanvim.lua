return {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = { "rust" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    init = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        vim.g.rustaceanvim = {
            server = {
                capabilities = capabilities,
                default_settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                        checkOnSave = true,
                        check = {
                            command = "clippy",
                        },
                    },
                },
            },
        }
    end,
}
