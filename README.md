# vimhenson

## Features

* uses [CoC](https://github.com/neoclide/coc.nvim) as LSP client
  * show documentation preview using `<K>`
* status bar using [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
    * this config customizes the [evil_lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua) theme to scan for CoC-compatible LSPs
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for syntax highlighting
* borderless Telescope with Tokyonight color scheme
* indentation guides using [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).
* pair completion for `{}`, `[]`, `()`, `<>`, `""`, ````, and `''`.
* Git delta indicators and diagnostics using [gitsigns.nvim](https://github.com/neoclide/coc.nvim) and [trouble.nvim](https://github.com/folke/trouble.nvim)
    * use `[c` and `]c` to navigate through hunks
    * use `<leader>hp` to preview hunks
    * check out [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) for the other keybinds
* call Git commands within the editor via [vim-fugitive](https://github.com/tpope/vim-fugitive)
* trigger code completion using `<Tab>` and `<Enter>`.
* navigate between splits using `<C-h>`, `<C-j>`, `<C-k>`, and `<C-l>`

## Preview

![image](https://github.com/starkfire/vimhenson/assets/26057339/b27d2138-42ee-4cba-afa0-33edbc1fbbb5)
![image](https://github.com/starkfire/vimhenson/assets/26057339/45552415-b39a-4b32-b168-d6f973788c9b)
![image](https://github.com/starkfire/vimhenson/assets/26057339/6ffb202a-5bc3-47ef-ad89-9a92d53368be)
![image](https://github.com/starkfire/vimhenson/assets/26057339/e1690f25-603d-43ab-a11e-d8a275a7e161)

## Plugins

* [coc.nvim](https://github.com/neoclide/coc.nvim)
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
* [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
* [lazy.nvim](https://github.com/folke/lazy.nvim)
* [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
* [mason.nvim](https://github.com/williamboman/mason.nvim)
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
* [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
* [trouble.nvim](https://github.com/folke/trouble.nvim)
* [vim-fugitive](https://github.com/tpope/vim-fugitive)

## Some Notes

* this config automatically assigns `,` as the `<leader>` key.
* only CoC-compatible LSPs are guaranteed to seamlessly work in this setup. I'm considering transitions to nvim-lspconfig in the future.
