local function toggle_tree()
    local api = require("nvim-tree.api")
    local view = require("nvim-tree.view")

    if view.is_visible() then
        api.tree.close()
    else
        api.tree.open()
    end
end

return {
    "nvim-tree/nvim-tree.lua",
    keys = {
        { "<leader>ft", toggle_tree, { noremap = true, silent = true } }
    }
}
