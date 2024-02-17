local ask_install = {}

-- automatically install treesitter parser for an opened buffer
-- see: https://github.com/nvim-treesitter/nvim-treesitter/issues/2108#issuecomment-995069984
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

local treesitter_config = {
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

return treesitter_config
