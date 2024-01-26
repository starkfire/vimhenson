vim.opt.list = true
vim.opt.listchars = { lead = '·' }

return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function()
        require('ibl').setup(config)
    end
}
