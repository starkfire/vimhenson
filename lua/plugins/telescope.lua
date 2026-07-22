local is_windows = vim.fn.has("win32") == 1

local function run_build(plugin, command)
    local result = vim.system(command, { cwd = plugin.dir, text = true }):wait()

    if result.code ~= 0 then
        error((result.stdout or "") .. (result.stderr or ""))
    end
end

-- check for CMake provided by MSVC
local function is_msvc_cmake(path)
    path = path:lower()

    return path:find("microsoft visual studio", 1, true) ~= nil
        or path:find("visualstudio", 1, true) ~= nil
        or path:find("/microsoft/cmake/", 1, true) ~= nil
        or path:find("\\microsoft\\cmake\\", 1, true) ~= nil
end

-- check if make is provided by MSYS
local function is_msys_mingw_make(path)
    path = path:lower()

    return path:find("\\msys64\\mingw", 1, true) ~= nil
        or path:find("\\msys64\\ucrt64\\", 1, true) ~= nil
        or path:find("/msys64/mingw", 1, true) ~= nil
        or path:find("/msys64/ucrt64/", 1, true) ~= nil
end

-- find make provided by Windows
local function find_windows_make()
    for _, executable in ipairs({ "make", "mingw32-make" }) do
        local path = vim.fn.exepath(executable)

        if path ~= "" and is_msys_mingw_make(path) then
            return path
        end
    end

    return ""
end

-- build telescope-fzf-native: identify the provided CMake and make on Windows before building
local function native_fzf_build(plugin)
    local cmake = vim.fn.exepath("cmake")
    local make = is_windows and find_windows_make() or vim.fn.exepath("make")

    -- prefer CMake if available (use CMake on Windows only if provided by MSVC)
    if cmake ~= "" and (not is_windows or is_msvc_cmake(cmake)) then
        run_build(plugin, { "cmake", "-S.", "-Bbuild", "-DCMAKE_BUILD_TYPE=Release" })
        run_build(plugin, { "cmake", "--build", "build", "--config", "Release", "--target", "install" })

        return
    end

    if is_windows and cmake ~= "" then
        vim.notify("Ignoring non-MSVC cmake for telescope-fzf-native: " .. cmake, vim.log.levels.WARN)
    end

    -- use make (on Windows, make must be provided by MSYS2 MinGW)
    if make ~= "" then
        if is_windows then
            local build_dir = plugin.dir .. "/build"

            if vim.fn.isdirectory(build_dir) == 1 then
                vim.fn.delete(build_dir, "rf")
            end
        end

        run_build(plugin, { make })

        return
    end

    if is_windows then
        error(
            "telescope-fzf-native requires MSVC CMake or MSYS2 MinGW make on Windows. "
            .. "Resolved cmake: " .. (cmake ~= "" and cmake or "not found") .. ". "
            .. "Resolved MSYS2 MinGW make: " .. (make ~= "" and make or "not found")
        )
    end

    error("telescope-fzf-native requires cmake or make")
end

return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = native_fzf_build,
        },
        "nvim-telescope/telescope-file-browser.nvim"
    },
    opts = function()
        local builtin = require("telescope.builtin")

        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

        -- LSP
        vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
        vim.keymap.set('n', '<leader>fS', builtin.lsp_workspace_symbols, {})
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})

        -- help
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

        -- Git
        vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
        vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
        vim.keymap.set('n', '<leader>gs', builtin.git_status, {})

        -- command palette
        vim.keymap.set('n', '<leader>fp', builtin.commands, {})

        -- file browser
        vim.keymap.set('n', '<leader>fe', function()
            require("telescope").extensions.file_browser.file_browser()
        end)

        return {
            defaults = {
                theme = "center",
                prompt_prefix = "   ",
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.5,
                        results_width = 0.8
                    }
                }
            },
            pickers = {
                find_files = {}
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            }
        }
    end,
    config = function(_, opts)
        require('telescope').setup(opts)
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'file_browser')
    end
}
