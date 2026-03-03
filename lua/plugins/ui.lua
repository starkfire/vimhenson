return {
    --[[{
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("tokyonight")
        end,
    },]] --
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_foreground = "original"
            vim.g.gruvbox_material_background = "hard"
            vim.cmd.colorscheme("gruvbox-material")
        end,
    },
}
