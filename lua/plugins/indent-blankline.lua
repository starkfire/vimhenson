return {
    "lukas-reineke/indent-blankline.nvim",
    opts = {},
    config = function()
        require("ibl").setup()

        vim.opt.list = true
        vim.opt.listchars = { lead = '·' }
    end
}
