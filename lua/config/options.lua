local o = vim.opt

o.updatetime        = 300
o.signcolumn        = "yes"
o.shiftwidth        = 4
o.tabstop           = 4
o.softtabstop       = 4
o.expandtab         = true
o.showcmd           = true
o.number            = true
o.ignorecase        = true
o.smartcase         = true

o.wrap              = true
o.termguicolors     = true

-- some servers have issues with backup files (coc.nvim #649)
o.backup            = false
o.writebackup       = false
