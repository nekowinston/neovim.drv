return function()
	require("zen-mode").setup({
		config = {
			plugins = {
				options = {
					laststatus = 0,
				},
				neovide = {
					enabled = vim.g.neovide,
				},
				wezterm = {
					enabled = vim.fn.environ().TERM_PROGRAM == "WezTerm",
				},
			},
		},
	})
end
