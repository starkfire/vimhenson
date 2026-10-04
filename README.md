# vimhenson

## Preview

| Environment | Sample |
| ----------- | ------ |
| Kitty on Arch + Hyprland | ![vimhenson-kitty-arch](https://github.com/user-attachments/assets/b9d46bd9-3d3b-4ebd-84c5-78f9669966e0) |
| Windows Terminal (Powershell 7) | ![vimhenson-example](https://github.com/user-attachments/assets/45aa0f9c-fef2-4dfa-8feb-8ab7b93574a2) |

## Features/Plugins

* [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.
* [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim) and [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) for LSP setup.
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for syntax highlighting and parsing.
* [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) for code context.
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) for code completion + [LuaSnip](https://github.com/L3MON4D3/LuaSnip) and [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) for snippet expansion.
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for fuzzy finding and browsing.
* [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) for file tree navigation.
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) for Git signs, delta indicators, and hunk actions.
* [trouble.nvim](https://github.com/folke/trouble.nvim) for diagnostics and symbol lists.
* [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) for a custom statusline.
    * the existing config is based on [evil_lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua), modifying it to display the active language server and gruvbox-material's internal color palette.
* [nvim-cokeline](https://github.com/willothy/nvim-cokeline) for bufferline.
* [aerial.nvim](https://github.com/stevearc/aerial.nvim) for symbol navigation (along with Telescope).
* [sainnhe/gruvbox-material](https://github.com/sainnhe/gruvbox-material) for the Gruvbox theme.
* [comment.nvim](https://github.com/numtostr/comment.nvim) for commenting.
* [project.nvim](https://github.com/ahmedkhalf/project.nvim) for project picker.
* [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) for indentation guides.
* [which-key.nvim](https://github.com/folke/which-key.nvim) for keymap guide.
* built-in editing helpers for pair insertion and visual wrapping.

## Requirements

* [Neovim](https://neovim.io/) (v0.12)
* Telescope dependencies
    * [ripgrep](https://github.com/BurntSushi/ripgrep)
    * [fd](https://github.com/sharkdp/fd) (optional)
* Treesitter
    * [tree-sitter-cli](https://www.npmjs.com/package/tree-sitter-cli)
* rustc (>=1.96.x)

## Install

### Default (Recommended)

The default way to set up this project would be to use this as your Neovim config:

```sh
cd ~/.config
git clone https://github.com/starkfire/vimhenson nvim
```

## Structure

* `init.lua`: top-level entrypoint
* `lua/config/init.lua` for options and global keymaps
* `lua/config/lazy.lua` for bootstrapping `lazy.nvim` and loading all plugin specs from `lua/plugins`
* `lua/config/options.lua`: general editor options
* `lua/config/keymaps.lua`: non-plugin global keymaps
* `lua/config/lazy.lua`: lazy.nvim bootstrap and setup
* `lua/plugins/*.lua`: plugin specs and plugin-local config
* `lua/modules/*.lua`: helper functions used by the config

## Usage

### Core Defaults

* the default `<leader>` key is `,`
* `shiftwidth`, `tabstop`, and `softtabstop` are all set to `4`
* `expandtab`, `wrap`, and `termguicolors` are enabled
* `signcolumn` is always shown

### LSP

By default, this uses [mason-lspconfig](https://github.com/mason-org/mason-lspconfig.nvim) for configuring LSP servers:

* `clangd`
* `elixirls`
* `gopls`
* `jsonls`
* `lua_ls`
* `nim_langserver`
* `ty`
* `ts_ls`
* `vue_ls`
* `zls`

See `lua/plugins/lsp.lua` to modify the default servers.

**Rust** integration is provided via [rustaceanvim](https://github.com/mrcjkb/rustaceanvim).

**Gleam** integration is provided directly through [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) as Mason does not manage it.

**Haskell** integration is provided via [haskell-tools](https://github.com/mrcjkb/haskell-tools.nvim).

### UI and Navigation

* Toggle keymap guides with [which-key.nvim](https://github.com/folke/which-key.nvim)
    * use `<leader>?` to open guide
* Bufferline + Buffer Switching (see `lua/plugins/nvim-cokeline.lua`)
    * `<Tab>` and `<S-Tab>` to move focus between buffers
    * `<leader>1` to `<leader>9` to jump to buffers
    * `<leader>n` to move/reorder buffer forward
    * `<leader>p` to move/reorder buffer backward
    * `<F1>` to `<F9>` keys to reorder buffers
* Status Line (see `lua/plugins/lualine.lua`)
    * displays
        * no. of warnings and errors (diagnostics)
        * current mode (e.g., green = INSERT, red = NORMAL, blue = VISUAL)
        * file encoding
        * attached LSP
        * line additions/updates/deletions (Git)
* Split Navigation
    * `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` to move between splits
    * `<leader><Left>`, `<leader><Down>`, `<leader><Up>`, `<leader><Right>` to move between splits (via arrowkeys)
* Context Line ([nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context))
    * run `:TSContext` to toggle
* File Tree
    * `<leader>ft` to toggle file tree
* Terminal
    * `<C-\>` to toggle terminal
    * `<leader>tf` for floating terminal
    * `<leader>th` for horizontal terminal
    * `<leader>tv` for vertical terminal
* Incremental Selection
    * `an` / `in` (visual/operator-pending) select parent/child node
    * `]n` / `[n` (visual) select next/previous node
    * `]N` / `[N` (visual) select next/previous sibling node
* Folding (Treesitter)
    * `zR` to open all folds
    * `zM` to close all folds
    * `zo` to open fold under cursor
    * `zc` to close fold under cursor

### Search and Discovery

* Telescope
    * Note that the Telescope integration for this project also uses:
        * [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
        * [telescope-file-browser](https://github.com/nvim-telescope/telescope-file-browser.nvim)
    * `<leader>ff` to find files
    * `<leader>fg` for live grep
    * `<leader>fb` for buffers
    * `<leader>fh` for help tags
    * `<leader>fp` for command palette
    * `<leader>fe` for file browser extension
    * `<leader>fs` for document symbols
    * `<leader>fS` for workspace symbols
    * `<leader>fd` for diagnostics
    * `<leader>gc` for Git commits
    * `<leader>gb` for Git branches
    * `<leader>gs` for Git status
* [aerial.nvim](https://github.com/stevearc/aerial.nvim)
    * added this as an alternative way to navigate through symbols other than Telescope
    * `<leader>fa` to toggle outline
    * `<leader>fA` to toggle nav window
    * `]a` and `[a` to jump to next/previous symbol
* [persistence.nvim](https://github.com/folke/persistence.nvim) for session management
    * `,qs` to restore the current directory session
    * `,qS` to select a session
    * `,ql` to restore last session
    * `,qd` to stop session saving for the current session
* [project.nvim](https://github.com/ahmedkhalf/project.nvim) for project picker
    * use `<leader>fj` or `:Telescope projects` to open picker

### Syntax Highlighting

See `lua/plugins/treesitter.lua`:
* default parsers:
    * `bash`
    * `c`
    * `go`
    * `html`
    * `javascript`
    * `jsdoc`
    * `lua`
    * `luadoc`
    * `luap`
    * `python`
    * `rust`
    * `vim`
    * `vimdoc`
    * `query`
    * `markdown`
    * `markdown_inline`
    * `tsx`
    * `typescript`
    * `xml`
    * `yaml`
* automatic parser installation is disabled
* highlighting is enabled by default, but will be disabled for files larger than 100 KB

### Completion

* insert-mode and command-line completions are available
* see `lua/plugins/cmp.lua`:
    * `<C-n>`, `<C-p>`: move through completion items
    * `<C-d>`, `<C-f>`: scroll documentation
    * `<C-Space>`: trigger completion manually
    * `<C-e>`: abort completion
    * `<CR>`: confirm selected completion item
    * `<Tab>`: select next completion item or jump/expand snippet
    * `<S-Tab>`: select previous completion item or jump backward in snippet
* commenting using [comment.nvim](https://github.com/numtostr/comment.nvim)
    * (NORMAL) `gcc` to comment current line
    * (VISUAL) `gc` for multiline linewise comment
    * (VISUAL) `gb` for multiline blockwise comment

### Pair Insertion and Wrapping

* see `lua/config/keymaps.lua` and `lua/modules/autowrap.lua`:
    * insert mode, typing `{`, `(`, `[`, `<`, `"`, `'`, or `` ` `` inserts a pair
    * in visual mode:
        * `<leader>"`: wrap selection in double quotes
        * `<leader>'`: wrap selection in single quotes
        * `<leader>(`: wrap selection in parentheses
        * `<leader>[`: wrap selection in brackets
        * `<leader>{`: wrap selection in braces

### Diagnostics

* via [trouble.nvim](https://github.com/folke/trouble.nvim)
    * `<leader>xx` to toggle diagnostics
    * `<leader>xX` to toggle buffer diagnostics
    * `<leader>cs` to toggle document symbols
    * `<leader>cl` to toggle LSP definitions and references
    * `<leader>xL` to toggle location list
    * `<leader>xQ` to toggle quickfix list
* via lspconfig
    * `gD`: declaration
    * `gd`: definition
    * `grr`: references
        * note that `gr` is a built-in Neovim command prefix
    * `gi`: implementation
    * `K`: hover documentation
    * `<C-s>`: signature help
    * `<leader>D`: type definition
    * `<leader>rn`: rename
    * `<leader>ca`: code action
    * `<leader>wa`: add workspace folder
    * `<leader>wr`: remove workspace folder 
    * `<leader>wl`: list workspace folders
    * `so`: Telescope references picker
    * `<C-k>`: diagnostics float at cursor

### Git

* `[c` and `]c` to navigate between hunks
* `<leader>hs` to stage hunk
* `<leader>hr` to reset hunk
* `<leader>hS` to stage buffer
* `<leader>hu` to undo stage for a hunk
* `<leader>hR` to reset buffer
* `<leader>hp` to preview hunk
* `<leader>hb` for line blame
* `<leader>tb` to toggle inline line blame
* `<leader>hd` for diff against staged/last commit
* `<leader>hD` for diff relative to parent commit
* `<leader>td` to toggle visibility for deleted lines

## Notes

* the configured version of Treesitter in this project uses the `master` branch.

