local is_nix = vim.env.VIMHENSON_NIX == "1"

if not is_nix then
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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
    spec = {
        { import = "plugins" },
    },
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
