return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = function()
        local ask_install = {}

        function _G.ensure_treesitter_language_installed()
            local parsers = require("nvim-treesitter.parsers")
            local lang = parsers.get_buf_lang()

            if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) and ask_install[lang] ~= false then
                vim.schedule_wrap(function()
                    vim.ui.select({"yes", "no"}, { prompt = "Install tree-sitter parsers for " .. lang .. "?" }, function(item)
                        if item == "yes" then
                            vim.cmd("TSInstall " .. lang)
                        elseif item == "no" then
                            ask_install[lang] = false
                        end
                    end)
                end)()
            end
        end

        vim.cmd[[autocmd FileType * :lua ensure_treesitter_language_installed()]]

        return {
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query"
            },
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            }
        }
    end,
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
