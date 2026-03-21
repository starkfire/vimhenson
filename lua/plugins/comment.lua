return {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        padding = true,
        sticky = true,
        ignore = "^$",
        mappings = {
            basic = true,
            extra = true,
        },
    },
}
