return {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = {
        "ToggleTerm",
        "TermExec",
    },
    keys = {
        { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal float" },
        { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal horizontal" },
        { "<leader>tv", "<cmd>ToggleTerm size=60 direction=vertical<cr>", desc = "Terminal vertical" },
    },
    opts = {
        open_mapping = [[<c-\\>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
            width = function()
                return math.floor(vim.o.columns * 0.9)
            end,
            height = function()
                return math.floor(vim.o.lines * 0.85)
            end,
        },
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)

        -- quick escape from terminal-mode to normal-mode.
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], {
            noremap = true,
            silent = true,
            desc = "Terminal normal mode",
        })

        -- buffer navigation
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { noremap = true, silent = true, desc = "Window left" })
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { noremap = true, silent = true, desc = "Window down" })
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { noremap = true, silent = true, desc = "Window up" })
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { noremap = true, silent = true, desc = "Window right" })
        vim.keymap.set("t", "<leader><Left>", [[<Cmd>wincmd h<CR>]], { noremap = true, silent = true, desc = "Window left" })
        vim.keymap.set("t", "<leader><Down>", [[<Cmd>wincmd j<CR>]], { noremap = true, silent = true, desc = "Window down" })
        vim.keymap.set("t", "<leader><Up>", [[<Cmd>wincmd k<CR>]], { noremap = true, silent = true, desc = "Window up" })
        vim.keymap.set("t", "<leader><Right>", [[<Cmd>wincmd l<CR>]], { noremap = true, silent = true, desc = "Window right" })
    end,
}
