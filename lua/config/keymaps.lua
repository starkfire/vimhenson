require("modules.utils")

local autowrap = require("modules.autowrap")

local default_set_opts = {
    noremap = true,
    silent = true,
}

-- leader key
vim.g.mapleader = ","

-- navigate between splits
map('n', "<c-k>", ":wincmd k<CR>")
map('n', "<c-j>", ":wincmd j<CR>")
map('n', "<c-h>", ":wincmd h<CR>")
map('n', "<c-l>", ":wincmd l<CR>")

-- navigate between splits (for people who use arrowkeys)
map('n', "<leader><Up>", ":wincmd k<CR>")
map('n', "<leader><Down>", ":wincmd j<CR>")
map('n', "<leader><Left>", ":wincmd h<CR>")
map('n', "<leader><Right>", ":wincmd l<CR>")

-- pair completion
map('i', '{', '{}<Esc>ha')
map('i', '(', '()<Esc>ha')
map('i', '[', '[]<Esc>ha')
map('i', '<', '<><Esc>ha')
map('i', '"', '""<Esc>ha')
map('i', "'", "''<Esc>ha")
map('i', "`", "``<Esc>ha")

-- pair completion via word selection
vim.keymap.set('v', '<leader>"', function() autowrap.wrap('"', '"') end, default_set_opts)
vim.keymap.set('v', "<leader>'", function() autowrap.wrap("'", "'") end, default_set_opts)
vim.keymap.set('v', "<leader>(", function() autowrap.wrap("(", ")") end, default_set_opts)
vim.keymap.set('v', "<leader>[", function() autowrap.wrap("[", "]") end, default_set_opts)
vim.keymap.set('v', "<leader>{", function() autowrap.wrap("{", "}") end, default_set_opts)


--[[
local map = vim.keymap.set

map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostics: open float" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostics: previous" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostics: next" })
]] --
