return function()
	local snacks = require("snacks")

	snacks.setup({
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
		terminal = {
			win = {
				border = vim.o.winborder,
				position = "float",
			},
		},
	})

	vim.keymap.set({ "n", "t" }, "<C-t>", function()
		snacks.terminal.toggle()
	end, { silent = true, desc = "Toggle floating terminal" })
end
