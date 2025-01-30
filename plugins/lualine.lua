local function shorten(s)
	local ellipsis = "…"
	local w = 20

	if #s > w then
		if w < #ellipsis then
			return ellipsis:sub(1, w)
		end
		return s:sub(1, w - #ellipsis) .. ellipsis
	end
	return s
end

local navic = {
	"navic",
	navic_opts = {
		highlight = true,
	},
	draw_empty = true,
}

return function()
	require("lualine").setup({
		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			theme = "milspec",
		},
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(str)
						return str:sub(1, 1)
					end,
				},
			},
			lualine_b = {
				{ "branch", fmt = shorten },
				"diff",
			},
			lualine_c = { "diagnostics" },
			lualine_x = { "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		winbar = {
			lualine_c = { navic },
		},
		inactive_winbar = {
			lualine_c = { navic },
		},
	})
end
