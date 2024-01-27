local util = require("modules.util")

-- leader key
vim.g.mapleader = ","

-- pair completion
map('i', '{', '{}<Esc>ha')
map('i', '(', '()<Esc>ha')
map('i', '[', '[]<Esc>ha')
map('i', '<', '<><Esc>ha')
map('i', '"', '""<Esc>ha')
map('i', "'", "''<Esc>ha")
map('i', "`", "``<Esc>ha")

-- navigate between splits
map('n', "<c-k>", ":wincmd k<CR>", { noremap = true, silent = true })
map('n', "<c-j>", ":wincmd j<CR>", { noremap = true, silent = true })
map('n', "<c-h>", ":wincmd h<CR>", { noremap = true, silent = true })
map('n', "<c-l>", ":wincmd l<CR>", { noremap = true, silent = true })
