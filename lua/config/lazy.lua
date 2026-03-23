local is_nix = vim.env.VIMHENSON_NIX == "1"

local nix_plugin_name_map = {
    luasnip = "LuaSnip",
}

local spec = {
    { import = "plugins" },
}

-- change root path to Lazy depending on whether it runs on Nix or not
local lazy_root = is_nix
    and (vim.fn.stdpath("state") .. "/lazy-nix")
    or (vim.fn.stdpath("data") .. "/lazy")

-- Nix
-- on Nix: Lazy will only act as a loader and plugin management needs to be done within flake.nix
if is_nix then
    local packaged_plugins = vim.fn.globpath(vim.o.packpath, "pack/*/start/*", false, true)

    for _, path in ipairs(packaged_plugins) do
        local basename = vim.fn.fnamemodify(path, ":t")
        local name = nix_plugin_name_map[basename] or basename
        
        table.insert(spec, 1, {
            name = name,
            dir = vim.fn.resolve(path),
        })
    end
end

-- default
-- on local/default install: we just install Lazy in the default manner
if not is_nix then
    local lazypath = lazy_root .. "/lazy.nvim"

    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--branch=stable",
            lazyrepo,
            lazypath
        })

        -- indicate if lazy failed to install
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out, "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end

    vim.opt.rtp:prepend(lazypath)
end

require("lazy").setup({
    root = lazy_root,
    spec = spec,
    install = {
        missing = not is_nix,
    },
    checker = {
        enabled = not is_nix
    },
    change_detection = {
        enabled = not is_nix,
        notify = not is_nix,
    },
    performance = {
        reset_packpath = not is_nix,
        rtp = {
            reset = not is_nix,
        },
    },
})
