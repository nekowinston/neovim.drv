return function()
	require("snacks").setup({
		bigfile = { enabed = true },
		notifier = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		styles = {
			input = {
				border = vim.o.winborder,
				relative = "cursor",
				row = -3,
				col = 0,
			},
		},
	})
end
