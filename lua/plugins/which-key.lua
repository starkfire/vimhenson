return {
    "folke/which-key.nvim",
    cmd = "WhichKey",
    keys = {
        {
            "<leader>?",
            "<cmd>WhichKey <leader><cr>",
            desc = "Leader keymaps",
        },
    },
    opts = {
        preset = "modern",
        delay = 300,
    },
    config = function(_, opts)
        local wk = require("which-key")

        wk.setup(opts)
        wk.add({
            { "<leader>c", group = "Code" },
            { "<leader>f", group = "Find" },
            { "<leader>g", group = "Git" },
            { "<leader>h", group = "Hunks" },
            { "<leader>t", group = "Toggle/Terminal" },
            { "<leader>w", group = "Workspace/Window" },
            { "<leader>x", group = "Diagnostics/List" },
        })
    end,
}
