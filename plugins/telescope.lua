return function()
	local telescope = require("telescope")

	telescope.load_extension("fzf")

	telescope.setup({
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			multi_icon = "│",
		},
		extensions = {
			file_browser = {
				grouped = true,
				sorting_strategy = "ascending",
			},
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	})
end
