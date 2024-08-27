require("modules.util")

-- leader key
vim.g.mapleader = ","

-- navigate between splits
map('n', "<c-k>", ":wincmd k<CR>", { noremap = true, silent = true })
map('n', "<c-j>", ":wincmd j<CR>", { noremap = true, silent = true })
map('n', "<c-h>", ":wincmd h<CR>", { noremap = true, silent = true })
map('n', "<c-l>", ":wincmd l<CR>", { noremap = true, silent = true })

-- navigate between splits (for people who use arrowkeys)
map('n', "<leader><Up>", ":wincmd k<CR>", { noremap = true, silent = true })
map('n', "<leader><Down>", ":wincmd j<CR>", { noremap = true, silent = true })
map('n', "<leader><Left>", ":wincmd h<CR>", { noremap = true, silent = true })
map('n', "<leader><Right>", ":wincmd l<CR>", { noremap = true, silent = true })

-- pair completion
map('i', '{', '{}<Esc>ha')
map('i', '(', '()<Esc>ha')
map('i', '[', '[]<Esc>ha')
map('i', '<', '<><Esc>ha')
map('i', '"', '""<Esc>ha')
map('i', "'", "''<Esc>ha")
map('i', "`", "``<Esc>ha")

-- pair completion via word selection
local function get_selection_range()
    return vim.fn.getpos("'<"), vim.fn.getpos("'>")
end

local function wrap_selected(start_pos, end_pos, opening, closing)
    local start_line, start_col = start_pos[2], start_pos[3]
    local end_line, end_col = end_pos[2], end_pos[3] + 1

    if start_line == end_line then
        local line = vim.fn.getline(start_line)
        local before = line:sub(1, start_col - 1)
        local selected = line:sub(start_col, end_col - 1)
        local after = line:sub(end_col)
        vim.fn.setline(start_line, before .. opening .. selected .. closing .. after)
    end
end

function _G.wrap_visual(wrapper)
    local start_pos, end_pos = get_selection_range()
    wrap_selected(start_pos, end_pos, wrapper, wrapper)
    vim.cmd("normal! gv")
end

function _G.wrap_paired_visual(opening, closing)
    local start_pos, end_pos = get_selection_range()
    wrap_selected(start_pos, end_pos, opening, closing)
    vim.cmd("normal! gv")
end

map('v', '<leader>"', ':lua wrap_visual(\'"\')<CR>')
map('v', "<leader>'", ":lua wrap_visual(\"'\")<CR>")
map('v', "<leader>(", ':lua wrap_paired_visual("(", ")")<CR>')
map('v', "<leader>[", ':lua wrap_paired_visual("[", "]")<CR>')
map('v', "<leader>{", ':lua wrap_paired_visual("{", "}")<CR>')

-- commenting
function _G.get_comment_token()
    local filetype = vim.bo.filetype

    if filetype == "python" or filetype == "elixir" then
        return '# '
    elseif filetype == "lua" then
        return '-- '
    else
        return '// '
    end
end

function _G.comment_normal()
    local comment_token = get_comment_token()
    local line = vim.api.nvim_get_current_line()
    local indent = line:match("^%s*")
    local new_line = indent .. comment_token .. line:sub(#indent + 1)
    vim.api.nvim_set_current_line(new_line)
end

function _G.comment_undo_normal()
    local comment_token = get_comment_token()
    local line = vim.api.nvim_get_current_line()
    local uncommented = line:gsub("^%s*" .. vim.pesc(comment_token), "")
    vim.api.nvim_set_current_line(uncommented)
end

function _G.comment_visual()
    local comment_token = vim.fn.escape(get_comment_token(), '/\\')

    vim.cmd(string.format("'<,'>s/^/%s/", comment_token))
    vim.cmd("noh")
end

function _G.comment_undo_visual()
    local comment_token = get_comment_token()

    vim.cmd(string.format("'<,'>s/^%s//", comment_token))
    vim.cmd("noh")
end

map('n', "<leader>c", ":lua comment_normal()<CR>")
map('n', "<leader>cu", ":lua comment_undo_normal()<CR>")
map('v', "<leader>c", ":lua comment_visual()<CR>")
map('v', "<leader>cu", ":lua comment_undo_visual()<CR>")
