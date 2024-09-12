-- Autowrap Module
--
-- functions for selecting and wrapping selected words with character pairs,
-- such as wrapping multiple lines with quotes, parentheses, etc.

local function wrap_text(opening, closing)
    local s_pos = vim.fn.getpos("v")
    local e_pos = vim.fn.getpos(".")
    local bufnr = vim.api.nvim_get_current_buf()

    -- swap positions when the direction of selection is backwards
    if (s_pos[2] > e_pos[2]) or ((s_pos[2] == e_pos[2]) and (s_pos[3] > e_pos[3])) then
        s_pos, e_pos = e_pos, s_pos
    end

    local selected_text = vim.api.nvim_buf_get_text(bufnr, s_pos[2] - 1, s_pos[3] - 1, e_pos[2] - 1, e_pos[3] - 1, {})

    if #selected_text == 1 then
        selected_text[1] = opening .. selected_text[1] .. closing
    else
        selected_text[1] = opening .. selected_text[1]
        selected_text[#selected_text] = selected_text[#selected_text] .. closing
    end

    vim.api.nvim_buf_set_text(bufnr, s_pos[2] - 1, s_pos[3] - 1, e_pos[2] - 1, e_pos[3] - 1, selected_text)
end

local autowrap = {
    wrap = wrap_text,
}

return autowrap
