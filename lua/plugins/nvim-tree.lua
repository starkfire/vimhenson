local M = {}

M.toggle_tree = function()
    local api = require('nvim-tree.api')
    local view = require('nvim-tree.view')

    if view.is_visible() then
        api.tree.close()
    else
        api.tree.open()
    end
end

return M
