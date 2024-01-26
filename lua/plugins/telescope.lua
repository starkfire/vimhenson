local telescopeConfig = {
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
        find_files = {
            -- theme = "dropdown"
        }
    }
}

return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',
    module = 'telescope',
    config = function()
        require('telescope').setup(telescopeConfig)
    end
}
