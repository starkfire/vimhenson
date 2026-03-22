return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        indent = {
            char = "│",
            tab_char = "│",
        },
        whitespace = {
            remove_blankline_trail = false,
        },
        scope = {
            enabled = true,
            show_start = false,
            show_end = false,
        },
        exclude = {
            buftypes = {
                "terminal",
                "quickfix",
                "nofile",
                "prompt",
            },
            filetypes = {
                "TelescopePrompt",
                "TelescopeResults",
                "Trouble",
                "aerial",
                "alpha",
                "checkhealth",
                "help",
                "lazy",
                "lspinfo",
                "man",
                "mason",
                "NvimTree",
                "toggleterm",
                "trouble",
            },
        },
    }
}
