local M = {}

function M.check()
    local ok_health, health = pcall(function() return vim.health end)

    if not ok_health or type(health) ~= "table" then
        -- print collected warnings if Health API is unavailable
        local warnings = vim.g.vimhenson_lsp_warnings or {}

        if #warnings == 0 then
            print("vimhenson: no warnings recorded")
        else
            print("vimhenson: found warnings")
            for _, w in ipairs(warnings) do
                print(" - " .. w)
            end
        end

        return
    end

    if type(health.start) == "function" then
        health.start("vimhenson")
    end

    local warnings = vim.g.vimhenson_lsp_warnings or {}
    if #warnings == 0 then
        if type(health.ok) == "function" then
            health.ok("No warnings detected by vimhenson")
        else
            print("vimhenson: no warnings detected")
        end
        return
    end

    for _, w in ipairs(warnings) do
        if type(health.warn) == "function" then
            health.warn(w)
        else
            print("vimhenson: " .. w)
        end
    end

    return
end

return { check = M.check }