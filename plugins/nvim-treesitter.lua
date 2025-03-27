return function()
	require("nvim-treesitter.configs").setup({
		auto_install = false,
		sync_install = false,
		highlight = { enable = true },
		textobjects = {
			select = { enable = true },
			lsp_interop = { enable = true },
		},
	})

	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.lean = {
		install_info = {
			url = "https://github.com/Julian/tree-sitter-lean",
			files = { "src/parser.c" },
			branch = "main",
		},
		filetype = "lean",
	}
end
