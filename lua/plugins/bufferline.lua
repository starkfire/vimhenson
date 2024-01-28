local config = {
    options = {
        numbers = "ordinal",
        indicator = {
            icon = '▎',
            style = 'underline'
        },
        hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
        },
        diagnostics = "coc", -- change to "nvim_lsp" if not using CoC,
        diagnostics_update_in_insert = true,
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return "(" .. icon .. count .. ")"
        end
    }
}

return {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('bufferline').setup(config)
    end
}
