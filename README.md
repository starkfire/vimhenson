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

* [Neovim](https://neovim.io/) (v0.11)
* Telescope dependencies
    * [ripgrep](https://github.com/BurntSushi/ripgrep)
    * [fd](https://github.com/sharkdp/fd) (optional)
* Treesitter
    * [tree-sitter-cli](https://www.npmjs.com/package/tree-sitter-cli)

## Install

### Default (Recommended)

The default way to set up this project would be to use this as your Neovim config:

```sh
cd ~/.config
git clone https://github.com/starkfire/vimhenson nvim
```

### Nix

Alternatively, you may clone this project and run it on top of Nix:

```sh
git clone https://github.com/starkfire/vimhenson
cd vimhenson

nix develop
# or...
nix build #.default
./result/bin/vimhenson
```

**Additional Notes:**

* on Nix, Lazy no longer handles plugin management. Plugins must be managed in `flake.nix`.
* Mason is also not available on Nix mode and nvim-lspconfig is directly called. LSP packages must be managed in `flake.nix`.
* Treesitter features like incremental selection may not work as there is currently no Nix package that lets us use Treesitter's older `master` branch (which this project still currently uses).

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
* `pyright`
* `ts_ls`
* `zls`

See `lua/plugins/lsp.lua` to modify the default servers.

**Rust** integration is provided via [rustaceanvim](https://github.com/mrcjkb/rustaceanvim).

**Gleam** integration is provided directly through [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) as Mason does not manage it.

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
* Incremental Selection (Treesitter)
    * `<leader>ss` to start selection
    * `<leader>si` to increment selection (`node_incremental`)
    * `<leader>sc` to increment selection (`scope_incremental`)
    * `<leader>sd` to decrement selection (`node_decremental`)
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
        * `c`
        * `lua`
        * `vim`
        * `vimdoc`
        * `query`
        * `markdown`
        * `markdown_inline`
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

## Troubleshooting

### Go

You will need to install [Go](https://go.dev/doc/install) for `gopls` to work.

### Elixir & Gleam

[Gleam](https://gleam.run/) requires [installing Gleam](https://gleam.run/install/).

One easy way to install Gleam would be to use [asdf](https://asdf-vm.com/):

```sh
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin add rebar https://github.com/Stratus3D/asdf-rebar.git
asdf plugin add gleam https://github.com/vic/asdf-gleam.git

asdf set -u erlang latest
asdf set -u rebar latest
asdf set -u gleam latest

asdf install
```

Then run:

```
asdf exec gleam -V
```

You may also install Elixir in the same manner:

```sh
asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git

# install the version compatible with your current Erlang/OTP version.
asdf install elixir 1.19.5
```

This project is also configured to link `asdf` to Neovim (see `init.lua`). The `~/.asdf/shims` directory needs to exist for nvim-lspconfig to be able to resolve `gleam` through `asdf` (and subsequently `gleam lsp`).

If Elixir fails to load when running `asdf exec elixir`, see [this issue comment](https://github.com/asdf-vm/asdf-erlang/issues/319#issuecomment-2746127824).

### Haskell

You need to install Haskell, preferably through [GHCup](https://www.haskell.org/ghcup/):

```sh
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

You may opt out by removing `hls` from `lua/plugins/lsp.lua`.

### Python

This configuration may not work well in **Windows** environments when using pyenv-win. See this [issue](https://github.com/williamboman/mason.nvim/issues/1753]).

### Rust

If `rust_analyzer` is not being detected, you can try to check for the `~/.local/state/nvim/lsp.log` file for the following error:

```
"error: Unknown binary 'rust-analyzer' in official toolchain 'stable-x86_64-unknown-linux-gnu'.\n"
```

In this case, if you have already pre-installed Cargo and `rustc`, you need to manually retrieve the standard library sources:

```sh
rustup component add rust-analyzer
```

### Nim

You need to install [nimlangserver](https://github.com/nim-lang/langserver) using the `nimble` package manager:

```sh
nimble install nimlangserver
```

In some cases, this may fail because some package repositories provide outdated versions of Nim. In this case, you may use [choosenim](https://github.com/dom96/choosenim) to install Nim.

### TypeScript

You will need the `typescript-language-server` and `typescript` packages globally installed:

```sh
npm install -g typescript-language-server typescript
```

### Volar

By default, this configuration uses Volar's default Hybrid Mode.

To use Volar, you will need to install `@vue/language-server` globally:

```sh
npm install -g @vue/language-server
```

You may also need to set up `@vue/typescript-plugin`:

```sh
npm install -g @vue/typescript-plugin
```

If Volar fails to run whenever Vue files are being opened, you can check out this [issue](https://github.com/vuejs/language-tools/issues/4706).

