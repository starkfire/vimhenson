local opt         = vim.opt

opt.updatetime    = 300
opt.signcolumn    = "yes"
opt.shiftwidth    = 4
opt.tabstop       = 4
opt.softtabstop   = 4
opt.expandtab     = true
opt.showcmd       = true
opt.number        = true
opt.ignorecase    = true
opt.smartcase     = true

opt.wrap          = true
opt.background    = "dark"
opt.termguicolors = true

-- Treesitter (folding)
opt.foldmethod    = "expr"
opt.foldexpr      = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel     = 99
opt.foldlevelstart = 99
opt.foldenable    = true
