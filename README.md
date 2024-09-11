# vimhenson

## Preview

| Environment | Sample |
| ----------- | ------ |
| Kitty on Arch + Hyprland | ![vimhenson-kitty-arch](https://github.com/user-attachments/assets/b9d46bd9-3d3b-4ebd-84c5-78f9669966e0) |
| Windows Terminal (Powershell 7) | ![vimhenson-example](https://github.com/user-attachments/assets/45aa0f9c-fef2-4dfa-8feb-8ab7b93574a2) |

## Motivation

* I wanted a code editor setup that already comes with almost everything I need, regardless of a project's scale.
* a full-blown Neovim setup is still faster than VSCode.
* I want to work fast in any environment I am in.

## Features

* [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.
* [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim) and [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) for LSP support.
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for syntax highlighting.
* pre-configured LSP for Lua, Python, Rust, Zig, Elixir, C, C++, JavaScript/TypeScript, and Vue (Volar).
    * this setup uses [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) for Rust instead of the LSP servers provided by Mason.
    * the Python setup uses [pyright](https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/pyright.lua).
    * if Volar fails to start when opening Vue files, you can check out this [issue](https://github.com/vuejs/language-tools/issues/4706).
* fuzzy finding via [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
* gruvbox theme from [sainnhe/gruvbox-material](https://github.com/sainnhe/gruvbox-material).
* status bar using [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).
    * the existing config is based on [evil_lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua), modifying it to display the active language server and gruvbox-material's internal color palette.
* file tree using [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua).
* indent guides using [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).
* Git delta indicators using [gitsigns.nvim](https://github.com/neoclide/coc.nvim).
* diagnostics with [trouble.nvim](https://github.com/folke/trouble.nvim).
* run Git commands within the editor via [vim-fugitive](https://github.com/tpope/vim-fugitive).
* native pair completion, wrapping, and single/multi-line commenting.

## Notes

### Future Improvements

Starting [`a71341`](https://github.com/starkfire/vimhenson/commit/a7134101bcd94b0ba4440abf9cdff922ca449592), I can no longer test these configurations on Windows environments and won't be able to address Windows-related issues. This configuration will be primarily tested in Arch and Ubuntu instead. If there are Windows-related issues in the latest versions, please feel free to roll back to the aforementioned commit.

## Usage

* the default `<leader>` key is `,`
* LSP
    * `K` for hover
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
* Commenting (Normal and Visual Mode)
    * `<leader>c` to comment out the current line (or selected lines in visual mode)
    * `<leader>cu` to undo the comment on current line (or selected lines in visual mode)
    * no plugin is used for commenting, and the comment token will depend on the filetype:
        * `# ` for Python and Elixir
        * `-- ` for Lua
        * `// ` for others (e.g. Rust, Zig, C, C++)
    * I might consider working on multi-line commenting, especially for docs which can be helpful in Python, JSDoc, and Zig.
* Wrapping (Visual Mode)
    * you can select words within a line and wrap them with pairing quotes, brackets, and parentheses.
    * `<leader>'` to wrap in single-quotes
    * `<leader>"` to wrap in double-quotes
    * `<leader>(` to wrap in parentheses
    * `<leader>{` to wrap in braces
    * `<leader>[` to wrap in brackets

## Troubleshooting

### Volar

If Volar fails to run whenever Vue files are being opened, you can check out this [issue](https://github.com/vuejs/language-tools/issues/4706).
