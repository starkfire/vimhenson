-- Autowrap Module
--
-- functions for selecting and wrapping selected words with character pairs,
-- such as wrapping multiple lines with quotes, parentheses, etc.

local function wrap_text(opening, closing)
    local s_pos = vim.fn.getpos("v")
    local e_pos = vim.fn.getpos(".")

    -- swap positions when the direction of selection is backwards
    if (s_pos[2] > e_pos[2]) or ((s_pos[2] == e_pos[2]) and (s_pos[3] > e_pos[3])) then
        s_pos, e_pos = e_pos, s_pos
    end

    local selected_text = vim.api.nvim_buf_get_text(s_pos[1], s_pos[2] - 1, s_pos[3] - 1, e_pos[2] - 1, e_pos[3], {})
    local wrapped_text = opening .. table.concat(selected_text, "\n") .. closing

    vim.api.nvim_buf_set_text(s_pos[1], s_pos[2] - 1, s_pos[3] - 1, e_pos[2] - 1, e_pos[3], { wrapped_text })
end

local function wrap_visual(wrapper)
    wrap_text(wrapper, wrapper)
end

local function wrap_paired_visual(opening, closing)
    wrap_text(opening, closing)
end

local autowrap = {
    wrap = wrap_visual,
    wrap_paired = wrap_paired_visual
}

return autowrap
