-- Comments Module

-- Determine the appropriate comment token according to the buffer's filetype
local function get_comment_token()
    local filetype = vim.bo.filetype

    if filetype == "python" or filetype == "elixir" then
        return '# '
    elseif filetype == "lua" then
        return '-- '
    else
        return '// '
    end
end

-- Comments a line in Normal Mode
local function comment_normal()
    local comment_token = get_comment_token()
    local line = vim.api.nvim_get_current_line()
    local indent = line:match("^%s*")
    local new_line = indent .. comment_token .. line:sub(#indent + 1)
    vim.api.nvim_set_current_line(new_line)
end

-- Removes comments for a line in Normal Mode
local function comment_undo_normal()
    local comment_token = get_comment_token()
    local line = vim.api.nvim_get_current_line()
    local uncommented = line:gsub("^%s*" .. vim.pesc(comment_token), "")
    vim.api.nvim_set_current_line(uncommented)
end

-- Comments selected lines in Visual Mode
local function comment_visual()
    local comment_token = vim.fn.escape(get_comment_token(), '/\\')

    vim.cmd(string.format("'<,'>s/^/%s/", comment_token))
    vim.cmd("noh")
end

-- Removes comments for selected lines in Visual Mode
local function comment_undo_visual()
    local comment_token = get_comment_token()

    vim.cmd(string.format("'<,'>s/^%s//", comment_token))
    vim.cmd("noh")
end


local comments = {
    normal = comment_normal,
    undo_normal = comment_undo_normal,
    visual = comment_visual,
    undo_visual = comment_undo_visual
}

return comments
