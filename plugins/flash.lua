return function()
	local flash = require("flash")

	require("which-key").register({
		["s"] = {
			function()
				flash.jump()
			end,
			"Flash",
			mode = { "n", "x", "o" },
		},
		["S"] = {
			function()
				flash.treesitter()
			end,
			"Flash Treesitter",
			mode = { "n", "o", "x" },
		},
		["r"] = {
			function()
				flash.remote()
			end,
			"Remote Flash",
			mode = "o",
		},
		["R"] = {
			function()
				flash.treesitter_search()
			end,
			"Treesitter Search",
			mode = { "o", "x" },
		},
		["<c-f>"] = {
			function()
				flash.toggle()
			end,
			"Toggle Flash Search",
			mode = { "c" },
		},
	})
end
