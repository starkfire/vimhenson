require("modules.util")

local autowrap = require("modules.autowrap")
local comment = require("modules.comments")

local default_set_opts = { noremap = true, silent = true }

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
vim.keymap.set('v', '<leader>"', function() autowrap.wrap('"', '"') end, default_set_opts)
vim.keymap.set('v', "<leader>'", function() autowrap.wrap("'", "'") end, default_set_opts)
vim.keymap.set('v', "<leader>(", function() autowrap.wrap("(", ")") end, default_set_opts)
vim.keymap.set('v', "<leader>[", function() autowrap.wrap("[", "]") end, default_set_opts)
vim.keymap.set('v', "<leader>{", function() autowrap.wrap("{", "}") end, default_set_opts)

-- commenting
vim.keymap.set('n', "<leader>cc", comment.attach, default_set_opts)
vim.keymap.set('v', "<leader>cc", comment.attach, default_set_opts)
