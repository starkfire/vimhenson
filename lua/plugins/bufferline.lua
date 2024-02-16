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
