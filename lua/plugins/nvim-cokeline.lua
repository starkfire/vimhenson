return {
    "willothy/nvim-cokeline",
    opts = function()
        require("modules.util")

        local colors = require("config.colors")
        local gruvbox = colors.gruvbox_original_hard

        local function set_tab_fg_color(is_focused)
            return is_focused and gruvbox.active_fg or gruvbox.inactive_fg
        end

        -- switch between tabs
        map('n', "<S-Tab>", "<Plug>(cokeline-focus-prev)")
        map('n', "<Tab>", "<Plug>(cokeline-focus-next)")

        -- switch tab order
        map('n', "<Leader>p", "<Plug>(cokeline-switch-prev)")
        map('n', "<Leader>n", "<Plug>(cokeline-switch-next)")

        for i = 1, 9 do
            -- switch between tabs
            map(
                'n',
                ("<Leader>%s"):format(i),
                ("<Plug>(cokeline-focus-%s)"):format(i)
            )

            -- switch tab order
            map(
                'n',
                ("<F%s>"):format(i),
                ("<Plug>(cokeline-switch-%s)"):format(i)
            )
        end

        return {
            default_hl = {
                fg = function(buffer)
                    return buffer.is_focused and gruvbox.active_fg or gruvbox.inactive_fg
                end,
                bg = function(buffer)
                    return buffer.is_focused and gruvbox.active_bg or gruvbox.inactive_bg
                end,
            },
            sidebar = {
                filetype = {'NvimTree', 'neo-tree'},
                components = {
                    {
                        text = function(buf)
                            return buf.filetype
                        end,
                        bg = gruvbox.background,
                        bold = true,
                    }
                },
            },
            components = {
                {
                    text = ' | ',
                    fg = function(buffer)
                        return buffer.is_modified and gruvbox.modified or gruvbox.unmodified
                    end,
                },
                {
                    text = function(buffer)
                        return buffer.devicon.icon .. ' '
                    end,
                    fg = function(buffer)
                        return buffer.devicon.color
                    end
                },
                {
                    text = function(buffer)
                        return buffer.index .. ': '
                    end,
                    fg = function(buffer)
                        return set_tab_fg_color(buffer.is_focused)
                    end,
                },
                {
                    text = function(buffer)
                        return buffer.unique_prefix
                    end,
                    fg = function(buffer)
                        return set_tab_fg_color(buffer.is_focused)
                    end,
                    italic = true,
                },
                {
                    text = function(buffer)
                        return buffer.filename .. ' '
                    end,
                    fg = function(buffer)
                        return set_tab_fg_color(buffer.is_focused)
                    end,
                },
                {
                    text = ' ',
                },
            }
        }
    end
}
