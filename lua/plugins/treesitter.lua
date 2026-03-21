return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    opts = function()
        return {
            ensure_installed = {
                "c",
                "go",
                "html",
                "lua",
                "luadoc",
                "luap",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "javascript",
                "typescript",
                "tsx",
                "jsdoc",
                "python",
                "rust",
                "xml",
                "yaml"
            },
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true,
                disable = function(_, buf)
                    local max_filesize = 100 * 1024
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>ss", -- start selection
                    node_incremental = "<leader>si", -- increment
                    scope_incremental = "<leader>sc", -- scope
                    node_decremental = "<leader>sd", -- decrement
                },
            },
        }
    end,
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end
}
