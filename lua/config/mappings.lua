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

-- navigate between splits (for people who use arrowkeys)
map('n', "<leader><Up>", ":wincmd k<CR>", { noremap = true, silent = true })
map('n', "<leader><Down>", ":wincmd j<CR>", { noremap = true, silent = true })
map('n', "<leader><Left>", ":wincmd h<CR>", { noremap = true, silent = true })
map('n', "<leader><Right>", ":wincmd l<CR>", { noremap = true, silent = true })

-- buffer navigation via bufferline
local bufferline_path = vim.fn.stdpath("data") .. "/lazy/nvim-cokeline"

if vim.loop.fs_stat(bufferline_path) then
    vim.opt.rtp:prepend(bufferline_path)

    for i = 1, 9 do
        map(
            'n',
            ("<Leader>%s"):format(i),
            ("<Cmd>BufferLineGoToBuffer %s<CR>"):format(i)
        )
    end

    map('n', "<Leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>")
end

-- Telescope
local telescope_path = vim.fn.stdpath("data") .. "/lazy/telescope.nvim"

if vim.loop.fs_stat(telescope_path) then
    vim.opt.rtp:prepend(telescope_path)

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
end

-- Cokeline
local cokeline_path = vim.fn.stdpath("data") .. "/lazy/nvim-cokeline"

if vim.loop.fs_stat(cokeline_path) then
    vim.opt.rtp:prepend(cokeline_path)

    map('n', "<S-Tab>", "<Plug>(cokeline-focus-prev)")
    map('n', "<Tab>", "<Plug>(cokeline-focus-next)")
    map('n', "<Leader>p", "<Plug>(cokeline-switch-prev)")
    map('n', "<Leader>n", "<Plug>(cokeline-switch-next)")

    for i = 1, 9 do
        map(
            'n',
            ("<Leader>%s"):format(i),
            ("<Plug>(cokeline-focus-%s)"):format(i)
        )
        map(
            'n',
            ("<F%s>"):format(i),
            ("<Plug>(cokeline-switch-%s)"):format(i)
        )
    end
end
