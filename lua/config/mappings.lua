require("modules.util")

local autowrap = require("modules.autowrap")
local comment = require("modules.comments")

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
vim.keymap.set('v', '<leader>"', function() autowrap.wrap('"') end, { noremap = true })
vim.keymap.set('v', "<leader>'", function() autowrap.wrap("'") end, {})
vim.keymap.set('v', "<leader>(", function() autowrap.wrap_paired("(", ")") end, {})
vim.keymap.set('v', "<leader>[", function() autowrap.wrap_paired("[", "]") end, {})
vim.keymap.set('v', "<leader>{", function() autowrap.wrap_paired("{", "}") end, {})

-- commenting
vim.keymap.set('n', "<leader>c", comment.normal, {})
vim.keymap.set('n', "<leader>cu", comment.undo_normal, {})
vim.keymap.set('v', "<leader>c", comment.visual, {})
vim.keymap.set('v', "<leader>cu", comment.undo_visual, {})
