# vimhenson

## Features

* uses [CoC](https://github.com/neoclide/coc.nvim) as LSP client
  * show documentation preview using `<K>`
* status bar using [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
    * this config customizes the [evil_lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua) theme to scan for CoC-compatible LSPs
* borderless Telescope with Tokyonight color scheme
* indentation guides using [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).
* pair completion
* Git delta indicators and diagnostics using [gitsigns.nvim](https://github.com/neoclide/coc.nvim) and [trouble.nvim](https://github.com/folke/trouble.nvim)
    * use `[c` and `]c` to navigate through hunks
    * use `<leader>hp` to preview hunks
    * check out [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) for the other keybinds
* call Git commands within the editor via [vim-fugitive](https://github.com/tpope/vim-fugitive)
* trigger code completion using `<Tab>` and `<Enter>`.

## Preview

![image](https://github.com/starkfire/vimhenson/assets/26057339/b27d2138-42ee-4cba-afa0-33edbc1fbbb5)
![image](https://github.com/starkfire/vimhenson/assets/26057339/17cf0fca-b4d0-42ae-b7cc-f8c806b74693)
![image](https://github.com/starkfire/vimhenson/assets/26057339/a9f61059-d626-4f24-8ceb-daa718b758bd)
![image](https://github.com/starkfire/vimhenson/assets/26057339/b67e76c5-acd1-4cf5-a79e-2249632aeb39)
![image](https://github.com/starkfire/vimhenson/assets/26057339/31038cca-3e2e-4c07-baa6-372b8b9d22c6)


## Plugins

* [coc.nvim](https://github.com/neoclide/coc.nvim)
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
* [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
* [lazy.nvim](https://github.com/folke/lazy.nvim)
* [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
* [mason.nvim](https://github.com/williamboman/mason.nvim)
* [nvim-treesitter](https://github.com/nvim-lualine/lualine.nvim)
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
* [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
* [trouble.nvim](https://github.com/folke/trouble.nvim)
* [vim-fugitive](https://github.com/tpope/vim-fugitive)

## Some Notes

* this config automatically assigns `,` as the `<leader>` key.
* only CoC-compatible LSPs are guaranteed to seamlessly work in this setup. I'm considering transitions to nvim-lspconfig in the future.
