local is_nix = vim.env.VIMHENSON_NIX == "1"

return {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
        manual_mode = false,
        detection_methods = { "lsp", "pattern" },
        patterns = {
            ".git",
            "package.json",
            "pyproject.toml",
            "go.mod",
            "Cargo.toml",
            "Makefile",
            "lua",
        },
        silent_chdir = true,
        scope_chdir = "global",
    },
    config = function(_, opts)
        -- project.nvim needs to be loaded differently within Nix
        if is_nix then
            require("project").setup(opts)
        else
            require("project_nvim").setup(opts)
        end

        pcall(require("telescope").load_extension, "projects")
        vim.keymap.set("n", "<leader>fj", "<cmd>Telescope projects<cr>", { desc = "Projects" })
    end,
}
