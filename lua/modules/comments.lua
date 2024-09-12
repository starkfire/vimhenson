local function is_commented(token, line)
    return vim.startswith(string.gsub(line, "^%s*", ""), token)
end

-- Comment/uncomment selected line(s)
local function attach()
    local lang_comment_mapping = {
        lua = "-- ",
        python = "# ",
        elixir = "# "
    }

    local comment_token = lang_comment_mapping[vim.bo.filetype] or "// "
    local mode = vim.api.nvim_get_mode().mode

    if mode == "n" or mode == "N" then
        local line = vim.api.nvim_get_current_line()
        local indent = line:match("^%s*")
        
        if is_commented(comment_token, line) then
            local uncommented = indent .. line:gsub("^%s*" .. vim.pesc(comment_token), "")
            vim.api.nvim_set_current_line(uncommented)
        else
            local commented = indent .. comment_token .. line:sub(#indent + 1)
            vim.api.nvim_set_current_line(commented)
        end
    elseif mode == "v" or mode == "V" then
        local s_pos = vim.fn.line("v")
        local e_pos = vim.fn.line(".")

        if s_pos > e_pos then
            s_pos, e_pos = e_pos, s_pos
        end

        for i = s_pos, e_pos do
            local line = vim.fn.getline(i)
            local indent = line:match("^%s*")

            if is_commented(comment_token, line) then
                local uncommented = indent .. line:gsub("^%s*" .. vim.pesc(comment_token), "")
                vim.fn.setline(i, uncommented)
            else
                local commented = comment_token .. indent .. line:sub(#indent + 1)
                vim.fn.setline(i, commented)
            end
        end
    end
end

local comments = {
    attach = attach
}

return comments
