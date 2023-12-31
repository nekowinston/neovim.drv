return function()
	local C = require("catppuccin.palettes").get_palette()

	local devicons = require("nvim-web-devicons")
	local justfile = {
		icon = "󱚣",
		name = "Justfile",
		color = C.peach,
	}
	devicons.setup({
		override_by_extension = {
			["astro"] = {
				icon = "",
				name = "Astro",
				color = C.red,
			},
			["dt"] = {
				icon = "",
				name = "Diet",
				color = "#427819",
			},
			["norg"] = {
				icon = "",
				name = "Neorg",
				color = C.green,
			},
		},
		override_by_filename = {
			[".ecrc"] = {
				icon = "",
				name = "EditorConfigChecker",
				color = C.green,
			},
			[".envrc"] = {
				icon = "",
				name = "envrc",
				color = C.yellow,
			},
			[".editorconfig"] = {
				icon = "",
				name = "EditorConfig",
				color = C.green,
			},
			[".luacheckrc"] = {
				icon = "󰢱",
				name = "LuacheckRC",
				color = C.blue,
			},
			[".Justfile"] = justfile,
			[".justfile"] = justfile,
			["Justfile"] = justfile,
			["justfile"] = justfile,
		},
	})
end
