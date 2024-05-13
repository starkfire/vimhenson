local util = require("modules.util")
local telescope = require("plugins.telescope")
local tree = require("plugins.nvim-tree")

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

-- navigate between splits (for people who use arrowkeys)
map('n', "<leader><Up>", ":wincmd k<CR>", { noremap = true, silent = true })
map('n', "<leader><Down>", ":wincmd j<CR>", { noremap = true, silent = true })
map('n', "<leader><Left>", ":wincmd h<CR>", { noremap = true, silent = true })
map('n', "<leader><Right>", ":wincmd l<CR>", { noremap = true, silent = true })

-- Telescope
telescope.set_mappings()

-- nvim-tree
vim.keymap.set('n', "<leader>ft", tree.toggle_tree, { noremap = true, silent = true })

