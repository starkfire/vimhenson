local cokeline_path = vim.fn.stdpath("data") .. "/lazy/nvim-cokeline"

if vim.loop.fs_stat(cokeline_path) then
    vim.opt.rtp:prepend(cokeline_path)
end

local colors = require('config.colors')
local bfl_colors = colors.bufferline

function set_color(is_focused)
    return is_focused and bfl_colors.active or bfl_colors.inactive
end

local options = {
    default_hl = {
        fg = function(buffer)
            return buffer.is_focused and bfl_colors.active or bfl_colors.inactive
        end,
        bg = bfl_colors.background
    },
    components = {
        {
            text = ' ',
            bg = bfl_colors.background,
        },
        {
            text = '',
            fg = function(buffer)
                return set_color(buffer.is_focused)
            end,
            bg = bfl_colors.background
        },
        {
            text = function(buffer)
                return buffer.devicon.icon
            end,
            fg = function(buffer)
                return buffer.is_focused and "#ffffff" or buffer.devicon.color
            end,
            bg = function(buffer)
                return set_color(buffer.is_focused)
            end
        },
        {
            text = ' ',
            bg = function(buffer)
                return set_color(buffer.is_focused)
            end
        },
        {
            text = function(buffer) return buffer.index .. ': ' end,
            fg = "#ffffff",
            bg = function(buffer) return set_color(buffer.is_focused) end
        },
        {
            text = function(buffer) return buffer.filename .. '  ' end,
            style = function(buffer)
                return buffer.is_focused and 'bold' or nil
            end,
            fg = "#ffffff",
            bg = function(buffer)
                return set_color(buffer.is_focused)
            end
        },
        {
            text = 'x',
            delete_buffer_on_left_click = true,
            fg = "#ffffff",
            bg = function(buffer)
                return set_color(buffer.is_focused)
            end
        },
        {
            text = '',
            fg = colors.tokyonight_color,
            bg = colors.bg_dark
        },
    },
}



return {
    'willothy/nvim-cokeline',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'stevearc/resession.nvim'
    },
    config = function()
        require('cokeline').setup(options)
    end
}
