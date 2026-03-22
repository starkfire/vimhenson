local function prepend_path(path)
    if vim.fn.isdirectory(path) ~= 1 then
        return
    end

    local current_path = vim.env.PATH or ""
    for entry in string.gmatch(current_path, "([^:]+)") do
        if entry == path then
            return
        end
    end

    vim.env.PATH = path .. ":" .. current_path
end

-- link `asdf`
-- if there is no `~/.asdf/shims` directory, this will not proceed
local asdf_root = vim.fn.expand("~/.asdf")
local asdf_bin = asdf_root .. "/bin"
local asdf_shims = asdf_root .. "/shims"

if vim.fn.isdirectory(asdf_shims) == 1 then
    prepend_path(asdf_bin)
    prepend_path(asdf_shims)
end

require("config")
require("config.lazy")
