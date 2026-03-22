return {
    "stevearc/aerial.nvim",
    cmd = {
        "AerialToggle",
        "AerialOpen",
        "AerialClose",
        "AerialNavToggle",
        "AerialNavOpen",
        "AerialNavClose",
        "AerialInfo",
    },
    keys = {
        { "<leader>fa", "<cmd>AerialToggle!<cr>", desc = "Aerial outline" },
        { "<leader>fA", "<cmd>AerialNavToggle<cr>", desc = "Aerial nav" },
        { "]a", "<cmd>AerialNext<cr>", desc = "Next symbol" },
        { "[a", "<cmd>AerialPrev<cr>", desc = "Previous symbol" },
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    opts = {
        backends = { "treesitter", "lsp", "markdown", "man" },
        attach_mode = "window",
        close_automatic_events = { "unsupported" },
        layout = {
            default_direction = "prefer_right",
            min_width = 28,
            max_width = { 40, 0.3 },
            resize_to_content = true,
        },
        show_guides = true,
        filter_kind = false,
        highlight_on_jump = 300,
        manage_folds = false,
    },
}

