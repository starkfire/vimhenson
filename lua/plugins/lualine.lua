return {
    "nvim-lualine/lualine.nvim",
    opts = function()
        local configuration = vim.fn['gruvbox_material#get_configuration']()
        local palette = vim.fn['gruvbox_material#get_palette'](configuration.background, configuration.foreground, configuration.colors_override)

        local colors = {
            bg          = '#202328',
            fg          = '#bbc2cf',
            yellow      = '#ecbe7b',
            blue        = '#51afef',
            cyan        = '#008080',
            darkblue    = '#081633',
            green       = '#98be65',
            orange      = '#ff8800',
            black       = '#080808',
            white       = '#c6c6c6',
            red         = '#ec5f67',
            violet      = '#a9a1e1',
            magenta     = '#c678dd',
            grey        = '#303030'
        }

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 100
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand('%:p:h')
                local gitdir = vim.fn.finddir('.git', filepath .. ';')
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        local config = {
            options = {
                component_separators = '',
                section_separators = '',
                theme = {
                    normal = {
                        a = { bg = palette.grey2[1], fg = palette.bg0[1], gui = 'bold' },
                        b = { bg = palette.bg_statusline3[1], fg = palette.grey2[1] },
                        c = { bg = palette.bg_statusline2[1], fg = palette.grey2[1] }
                    },
                    inactive = {
                        a = { bg = palette.bg_statusline2[1], fg = palette.grey2[1] },
                        b = { bg = palette.bg_statusline2[1], fg = palette.grey2[1] },
                        c = { bg = palette.bg_statusline2[1], fg = palette.grey2[1] }
                    }
                }
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            }
        }


        -- sections.lualine_c
        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        -- sections.lualine_x
        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end

        ins_left {
            function()
                return '▊'
            end,
            color = { fg = palette.aqua[1] },
            padding = { left = 0, right = 1 }
        }

        ins_left {
            function()
                return ''
            end,
            color = function()
                local mode_color = {
                    n = colors.red,
                    i = colors.green,
                    v = colors.blue,
                    [''] = colors.blue,
                    V = colors.blue,
                    c = colors.magenta,
                    no = colors.red,
                    s = colors.orange,
                    S = colors.orange,
                    [''] = colors.orange,
                    ic = colors.yellow,
                    R = colors.violet,
                    Rv = colors.violet,
                    cv = colors.red,
                    ce = colors.red,
                    r = colors.cyan,
                    rm = colors.cyan,
                    ['r?'] = colors.cyan,
                    ['!'] = colors.red,
                    t = colors.red,
                }
                return { fg = mode_color[vim.fn.mode()] }
            end,
            padding = { right = 1 }
        }

        ins_left {
            'filesize',
            cond = conditions.buffer_not_empty,
        }

        ins_left {
            'filename',
            cond = conditions.buffer_not_empty,
            color = { fg = colors.magenta, gui = 'bold' }
        }

        ins_left { 'location' }

        ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

        ins_left {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
                color_error = { fg = colors.red },
                color_warn = { fg = colors.yellow },
                color_info = { fg = colors.cyan },
            },
        }

        ins_left {
            function()
                return '%='
            end,
        }

        ins_left {
            function()
                local msg = 'No Active Lsp'
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                    return msg
                end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return msg
                -- use only if you are using CoC
                -- return "%{coc#status()}%{get(b:,'coc_current_function','')}"
            end,
            icon = ' LSP:',
            color = { fg = '#ffffff', gui = 'bold' },
        }

        ins_right {
            'o:encoding',
            fmt = string.upper,
            cond = conditions.hide_in_width,
            color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
            'fileformat',
            fmt = string.upper,
            icons_enabled = false,
            color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
            'branch',
            icon = '',
            color = { fg = colors.violet, gui = 'bold' }
        }

        ins_right {
            'diff',
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
            },
            cond = conditions.hide_in_width,
        }

        ins_right {
            function()
                return '▊'
            end,
            color = { fg = palette.aqua[1] },
            padding = { left = 1 },
        }

        return config
    end
}
