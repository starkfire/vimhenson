return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-file-browser.nvim"
    },
    opts = function()
        local builtin = require("telescope.builtin")

        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

        -- LSP
        vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
        vim.keymap.set('n', '<leader>fS', builtin.lsp_workspace_symbols, {})
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})

        -- help
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

        -- Git
        vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
        vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
        vim.keymap.set('n', '<leader>gs', builtin.git_status, {})

        -- command palette
        vim.keymap.set('n', '<leader>fp', builtin.commands, {})

        -- file browser
        vim.keymap.set('n', '<leader>fe', function()
            require("telescope").extensions.file_browser.file_browser()
        end)

        return {
            defaults = {
                theme = "center",
                prompt_prefix = "   ",
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.5,
                        results_width = 0.8
                    }
                }
            },
            pickers = {
                find_files = {}
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            }
        }
    end,
    config = function(_, opts)
        require('telescope').setup(opts)
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'file_browser')
    end
}
