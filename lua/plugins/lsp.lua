-- check if this project runs on top of Nix
local is_nix = vim.env.VIMHENSON_NIX == "1"

-- helper function to determine the path to Vue Language Server
-- depending on whether this project runs with/without Nix.
-- see `flake.nix` which exports `VIMHENSON_VUE_TS_PLUGIN_PATH`
-- and `VUE_LANGUAGE_SERVER_LIB_PATH`
local function get_vue_ts_plugin_path()
    local packaged_path = vim.env.VIMHENSON_VUE_TS_PLUGIN_PATH
    if packaged_path and packaged_path ~= "" then
        return packaged_path
    end

    local mason_path = vim.fn.stdpath("data")
        .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

    if vim.fn.isdirectory(mason_path) == 1 then
        return mason_path
    end

    if vim.env.VUE_LANGUAGE_SERVER_LIB_PATH and vim.env.VUE_LANGUAGE_SERVER_LIB_PATH ~= "" then
        return vim.env.VUE_LANGUAGE_SERVER_LIB_PATH
    end

    return nil
end

-- primary logic for handling LSP configuration
local function configure_lsp()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Lua
    vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })

    local ts_ls_config = {
        capabilities = capabilities,
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
        },
    }

    -- Vue
    local vue_ts_plugin_path = get_vue_ts_plugin_path()
    
    if vue_ts_plugin_path then
        ts_ls_config.init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = vue_ts_plugin_path,
                    languages = { "javascript", "typescript", "vue" },
                },
            },
        }
    end

    vim.lsp.config("ts_ls", ts_ls_config)

    vim.lsp.config("vue_ls", {
        capabilities = capabilities,
    })

    vim.lsp.config("gleam", {
        capabilities = capabilities,
    })

    vim.lsp.config("nim_langserver", {
        settings = {
            nim = {
                inlayHints = {
                    typeHints = true,
                    parameterHints = true,
                    exceptionHints = true
                }
            }
        },
        on_attach = function(client, bufnr)
            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
        end,
        capabilities = capabilities
    })

    if is_nix then
        for _, server in ipairs({
            "lua_ls",
            "pyright",
            "clangd",
            "ts_ls",
            "gopls",
            "zls",
            "elixirls",
            "nim_langserver",
            "jsonls",
            "vue_ls",
            "nil_ls",
            "gleam",
        }) do
            vim.lsp.enable(server)
        end
    else
        vim.lsp.enable("gleam")
    end

    vim.diagnostic.config({
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = false,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(args)
            local bufnr = args.buf
            local attach_opts = { buffer = bufnr, silent = true }

            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, attach_opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, attach_opts)
            vim.keymap.set("n", "grr", vim.lsp.buf.references, attach_opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, attach_opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, attach_opts)
            vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, attach_opts)
            vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, attach_opts)
            vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, attach_opts)
            vim.keymap.set("n", "<leader>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, attach_opts)
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, attach_opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, attach_opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, attach_opts)

            vim.keymap.set("n", "so", function()
                require("telescope.builtin").lsp_references()
            end, attach_opts)

            -- Diagnostics for the current cursor position.
            vim.keymap.set("n", "<C-k>", function()
                vim.diagnostic.open_float(nil, { scope = "cursor" })
            end, attach_opts)
        end,
    })

end

-- Nix (does not use Mason)
if is_nix then
    return {
        {
            "neovim/nvim-lspconfig",
            lazy = false,
            init = configure_lsp,
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
            },
        },
    }
end

-- local
return {
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        init = configure_lsp,
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
        opts = {
            ensure_installed = {
                "lua_ls",
                "pyright",
                "clangd",
                "ts_ls",
                "gopls",
                "zls",
                "elixirls",
                "nim_langserver",
                "jsonls",
                "vue_ls"
            },
            automatic_enable = {
                exclude = { "rust_analyzer", "hls" },
            },
        },
    },
}
