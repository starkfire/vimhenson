local is_nix = vim.env.VIMHENSON_NIX == "1"

local parsers = {
    "bash",
    "c",
    "go",
    "html",
    "lua",
    "luadoc",
    "luap",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
    "javascript",
    "typescript",
    "tsx",
    "jsdoc",
    "python",
    "rust",
    "xml",
    "yaml",
}

-- Incremental selection (`an`/`in`/`]n`/`[n`/`]N`/`[N`) is a Neovim core
-- default (runtime/lua/vim/_core/defaults.lua, vim.treesitter._select) as of
-- v0.12 — no plugin config needed; nvim-treesitter's `main` branch dropped
-- its own `incremental_selection` module in favor of this.

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter").setup({})

        if not is_nix then
            require("nvim-treesitter").install(parsers)
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function(args)
                local max_filesize = 100 * 1024
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
                if ok and stats and stats.size > max_filesize then
                    return
                end

                pcall(vim.treesitter.start, args.buf)
                pcall(function()
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end)
            end,
        })
    end,
}
