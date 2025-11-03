return {
    -- configuration for lua/plugins/nvim-lspconfig.lua
	lsp = {
		-- if true, vim.notify will trigger warning messages
		enable_warnings = true,
		-- if true, warnings will be passed to :checkhealth (if true, this also ignores `enable_warnings`)
		report_to_checkhealth = true,
		-- optional extra mason name mappings
		mason_name_map = {},
	}
}
