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

return function()
	require("lualine").setup({
		inactive_winbar = {
			lualine_c = {
				{ "navic", draw_empty = true },
			},
		},
		options = {
			component_separators = {
				left = "",
				right = "",
			},
			disabled_filetypes = {
				statusline = { "alpha" },
				winbar = { "alpha" },
			},
			icons_enabled = true,
			section_separators = {
				left = "",
				right = "",
			},
			theme = "milspec",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{ "branch", fmt = shorten },
				"diff",
				"diagnostics",
			},
			lualine_c = { "searchcount" },
			lualine_x = { "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		winbar = {
			lualine_c = {
				{ "navic", draw_empty = true },
			},
		},
	})
end
