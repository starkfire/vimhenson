local bufferline_path = vim.fn.stdpath("data") .. "/lazy/nvim-cokeline"

if vim.loop.fs_stat(bufferline_path) then
    vim.opt.rtp:prepend(bufferline_path)

    -- switch between tabs
    map('n', "<S-Tab>", ":BufferLineCyclePrev<CR>")
    map('n', "<Tab>", ":BufferLineCycleNext<CR>")

    for i = 1, 9 do
        -- switch between tabs
        map(
            'n',
            ("<Leader>%s"):format(i),
            ("<Cmd>lua require('bufferline').go_to(%s, true)<CR>"):format(i)
        )
    end

    map('n', "<Leader>$", "<Cmd>lua require('bufferline').go_to(-1, true)<CR>")
end


local bufferline_config = {
    options = {
        numbers = "ordinal",
        diagnostics = "coc", -- change to "nvim_lsp" if not using CoC
        diagnostics_update_in_insert = true,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = ""

            for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " "
                    or (e == "warning" and " " or "" )

                s = s .. n .. sym
            end

            return s
        end
    }
}

return bufferline_config
