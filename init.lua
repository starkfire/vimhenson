require("config.options")
require("config.mappings")

-- Python provider
vim.g.python3_host_prog = 'C:/Python39/python.EXE'

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end

vim.opt.rtp:prepend(lazypath)

-- load plugins
local plugins = {
    {
        'neoclide/coc.nvim',
        branch = 'master',
        build = 'npm ci',
        config = function()
            require("plugins.coc")
        end
    },
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = function()
            return require("plugins.lualine")
        end,
        config = function(_, opts)
            require('lualine').setup(opts)
        end
    },
    --[[
    {
        'akinsho/bufferline.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = function()
            return require("plugins.bufferline")
        end,
        config = function(_, opts)
            require('bufferline').setup(opts)
        end
    },
    ]]--
    {
        'willothy/nvim-cokeline',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'stevearc/resession.nvim'
        },
        opts = function()
            return require("plugins.cokeline")
        end,
        config = function(_, opts)
            require('cokeline').setup(opts)
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        version = '*',
        lazy = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('nvim-tree').setup {}
        end,
    },
    {
        'folke/tokyonight.nvim',
        config = function()
            require('tokyonight').setup()
            require("plugins.tokyonight")
            vim.cmd("colorscheme tokyonight-night")
        end
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'Telescope',
        opts = function()
            return require("plugins.telescope")
        end,
        config = function(_, opts)
            require('telescope').setup(opts.telescope_config)
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = function()
            return require("plugins.treesitter")
        end,
        config = function(_, opts)
            local configs = require('nvim-treesitter.configs')

            configs.setup(opts)
        end
    },
    {
        'tpope/vim-fugitive'
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
        config = function()
            require('ibl').setup()

            vim.opt.list = true
            vim.opt.listchars = { lead = '·' }
        end
    },
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = function()
            return require("plugins.gitsigns")
        end,
        config = function(_, opts)
            require('gitsigns').setup(opts)
        end
    },
    {
        'dstein64/vim-startuptime'
    },
    {
        'lbrayner/vim-rzip'
    }
}

require('lazy').setup(plugins)
