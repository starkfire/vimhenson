# vimhenson

## Motivation

* I wanted a code editor setup that already comes with almost everything I need, regardless of a project's scale.
* a full-blown Neovim setup is still faster than VSCode and any other bulky editors.
* I want to work fast in any environment I am in.

## Preview

| Environment | Sample |
| ----------- | ------ |
| Kitty on Arch + Hyprland | ![vimhenson-kitty-arch](https://github.com/user-attachments/assets/b9d46bd9-3d3b-4ebd-84c5-78f9669966e0) |
| Windows Terminal (Powershell 7) | ![vimhenson-example](https://github.com/user-attachments/assets/45aa0f9c-fef2-4dfa-8feb-8ab7b93574a2) |

## Features

* [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.
* [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim) and [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) for LSP support.
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for syntax highlighting.
* pre-configured LSP for Lua, Python, Rust, Zig, Elixir, C, C++, JavaScript/TypeScript, and Vue (Volar).
    * this setup uses [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) for Rust instead of the LSP servers provided by Mason.
    * the Python setup uses [pyright](https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/pyright.lua).
* fuzzy finding via [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
* gruvbox theme from [sainnhe/gruvbox-material](https://github.com/sainnhe/gruvbox-material).
* status bar using [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).
    * the existing config is based on [evil_lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua), modifying it to display the active language server and gruvbox-material's internal color palette.
* file tree using [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua).
* indent guides using [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).
* Git delta indicators using [gitsigns.nvim](https://github.com/neoclide/coc.nvim).
* diagnostics with [trouble.nvim](https://github.com/folke/trouble.nvim).
* run Git commands within the editor via [vim-fugitive](https://github.com/tpope/vim-fugitive).
* built-in pair completion, wrapping, and single/multi-line commenting.

## Usage

* the default `<leader>` key is `,`
* LSP
    * `K` to open hover window/documentation.
* Buffer Switching
    * navigate between window splits using `<C-h>`, `<C-j>`, `<C-k>`, and `<C-l>`
    * or `<leader><Up>`, `<leader><Down>`, `<leader><Left>`, and `<leader><Right>` if you like arrowkeys
    * `<Tab>` and `<S-Tab>` to switch between buffers within the bufferline as if they are tabs
    * `<leader>p` and `<leader>n` to move buffer orders in bufferline
* Telescope
    * `<leader>ff` to find files
    * `<leader>fg` for file grep
    * `<leader>fb` for buffers
    * `<leader>fh` for help tags
* File Tree
    * `<leader>ft` to toggle file tree
* Git
    * `[c` and `]c` to navigate through hunks
    * `<leader>hp` to preview hunks
    * `<leader>hs` to stage hunk
    * `<leader>hr` to reset hunk
    * `<leader>tb` to toggle current line blame
    * `<leader>hd` to view diff
* Trouble
    * `<leader>xx` to toggle diagnostics
    * `<leader>xX` to toggle buffer diagnostics
    * `<leader>cs` to toggle document symbols
    * `<leader>cl` to toggle LSP definitions and references
    * `<leader>xL` to toggle location list
    * `<leader>xQ` to toggle quickfix list
* Commenting
    * `<leader>cc` to comment/uncomment the current line (in Normal Mode) or selected lines (in Visual Mode).
    * no plugin is used for commenting, and the comment token will depend on the filetype:
        * `# ` for Python and Elixir
        * `-- ` for Lua
        * `// ` for others
    * in Neovim v0.10, you can already do this out of the box with `gc` on Visual Mode. However, this implementation lets you comment lines on Normal Mode as well.
* Wrapping
    * in Visual Mode, you can select words (within a single line or multiple lines) and wrap them between quotes, brackets, or parentheses.
    * `<leader>'` to wrap in single-quotes
    * `<leader>"` to wrap in double-quotes
    * `<leader>(` to wrap in parentheses
    * `<leader>{` to wrap in braces
    * `<leader>[` to wrap in brackets

## Troubleshooting

### Rust

By default, this setup uses [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) for interfacing with `rust-analyzer`.

If `rust_analyzer` is not being detected, you can try to check for the `~/.local/state/nvim/lsp.log` file for the following error:

```
"error: Unknown binary 'rust-analyzer' in official toolchain 'stable-x86_64-unknown-linux-gnu'.\n"
```

In this case, if you have already pre-installed Cargo and `rustc`, you need to manually retrieve the standard library sources:

```sh
rustup component add rust-analyzer
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

### Haskell

To setup autocompletion, the recommended approach is to install GHC, HLS, Cabal, and Stack altogether with [ghcup](https://www.haskell.org/ghcup/).

### Gleam

To work with Gleam, you only need the Treesitter grammar. Mason does not provide language servers for Gleam.
