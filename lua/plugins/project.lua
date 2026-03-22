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
        require("project_nvim").setup(opts)
        pcall(require("telescope").load_extension, "projects")
        vim.keymap.set("n", "<leader>fj", "<cmd>Telescope projects<cr>", { desc = "Projects" })
    end,
}
