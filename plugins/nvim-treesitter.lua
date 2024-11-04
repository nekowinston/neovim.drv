return function()
	local uv = vim.uv or vim.loop

	require("nvim-treesitter.configs").setup({
		auto_install = false,
		highlight = {
			enable = true,
			disable = function(_, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local name = vim.api.nvim_buf_get_name(buf)
				local ok, stats = pcall(vim.loop.fs_stat, name)
				if ok and stats and stats.size > max_filesize then
					vim.notify("Performance: TreeSitter disabled for buffer " .. vim.api.nvim_buf_get_name(buf))
					return true
				end
			end,
		},
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = 8192,
		},
		textobjects = {
			lsp_interop = {
				enable = true,
			},
		},
	})

	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.blade = {
		install_info = {
			url = "https://github.com/EmranMR/tree-sitter-blade",
			files = { "src/parser.c" },
			branch = "main",
		},
		filetype = "blade",
	}
end
