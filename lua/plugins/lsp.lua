return {
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig"
        },
        -- event = { "BufReadPre", "BufNewFile" },
        opts = {
            ensure_installed = {
                "lua_ls",
                "pyright",
                "clangd",
                "ts_ls",
                "gopls",
                "zls",
                "elixirls",
                "nim_langserver",
                "jsonls"
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
                rust_analyzer = function() end,
            },
        },
    },
}
