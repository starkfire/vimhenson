local telescope_config = {
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

return telescope_config
