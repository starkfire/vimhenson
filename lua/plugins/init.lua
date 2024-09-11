return {
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
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim"
        },
        opts = {}
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp"
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
    },
    {
        "saadparwaiz1/cmp_luasnip"
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        }
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        opts = {},
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        cmd = "Telescope",
    },
    {
        "nvim-treesitter/nvim-treesitter"
    },
    {
        "willothy/nvim-cokeline",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "stevearc/resession.nvim"
        }
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble"
    },
    {
        "lewis6991/gitsigns.nvim",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
    },
    -- Rust
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
    }
}
