return function()
	--- @type fun(text: string[]): { type: string, val: table, opts: table }
	local function render_header(text)
		local lines = {}
		for _, line in pairs(text) do
			table.insert(lines, {
				type = "text",
				val = line,
				opts = {
					hl = "AlphaHeader",
					shrink_margin = false,
					position = "center",
				},
			})
		end

		return {
			type = "group",
			val = lines,
			opts = { position = "center" },
		}
	end

	local alpha = require("alpha")
	local theta = require("alpha.themes.theta")
	local dashboard = require("alpha.themes.dashboard")

	local header = {
		[[            ____             ]],
		[[           /\   \            ]],
		[[          /  \   \           ]],
		[[         /    \   \          ]],
		[[        /      \   \         ]],
		[[       /   /\   \   \        ]],
		[[      /   /  \   \   \       ]],
		[[     /   /    \   \   \      ]],
		[[    /   /    / \   \   \     ]],
		[[   /   /    /   \   \   \    ]],
		[[  /   /    /---------'   \   ]],
		[[ /   /    /_______________\  ]],
		[[ \  /                     /  ]],
		[[  \/_____________________/   ]],
	}

	local buttons = {
		type = "group",
		position = "center",
		val = {
			dashboard.button("n", "  New file", ":ene <bar> startinsert <cr>"),
			dashboard.button("SPC fd", "  Find file", ":Telescope find_files<cr>"),
			dashboard.button("SPC fg", "  Live grep", ":Telescope live_grep<cr>"),
			dashboard.button("s", "  Show sessions", ":SessionManager load_session<cr>"),
			dashboard.button("SPC fp", "  Projects", ":Telescope project<CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		},
	}

	local v = vim.version()
	local vStr = string.format("v%d.%d.%d", v.major, v.minor, v.patch)

	local footer = {
		type = "group",
		position = "center",
		val = {
			{
				type = "text",
				val = "neovim " .. vStr,
				opts = { hl = "Comment", position = "center" },
			},
			{
				type = "text",
				val = require("lazy").stats().count .. " plugins",
				opts = { hl = "Comment", position = "center" },
			},
		},
	}

	theta.config.layout = {
		{ type = "padding", val = 4 },
		render_header(header),
		{ type = "padding", val = 1 },
		buttons,
		{ type = "padding", val = 1 },
		footer,
	}

	alpha.setup(theta.config)

	vim.api.nvim_create_autocmd("User", {
		pattern = { "AlphaReady" },
		callback = function()
			vim.o.showtabline = 0
		end,
	})
	vim.api.nvim_create_autocmd("BufUnload", {
		callback = function()
			vim.o.showtabline = 2
		end,
	})
end
