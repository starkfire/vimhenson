return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    opts = function()
        local telescope_path = vim.fn.stdpath("data") .. "/lazy/telescope.nvim"

        if vim.loop.fs_stat(telescope_path) then
            vim.opt.rtp:prepend(telescope_path)

            local builtin = require("telescope.builtin")

            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end

        return {
            defaults = {
                theme = "center",
                prompt_prefix = "   ",
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.5,
                        results_width = 0.8
                    }
                }
            },
            pickers = {
                find_files = {}
            }
        }
    end,
    config = function(_, opts)
        require('telescope').setup(opts)
    end
}
