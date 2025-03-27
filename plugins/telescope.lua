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
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	})

	-- hotfix workaround for https://github.com/nvim-telescope/telescope.nvim/issues/3436
	vim.api.nvim_create_autocmd("User", {
		pattern = "TelescopeFindPre",
		callback = function()
			vim.opt_local.winborder = "none"
			vim.api.nvim_create_autocmd("WinLeave", {
				once = true,
				callback = function()
					vim.opt_local.winborder = vim.o.winborder
				end,
			})
		end,
	})
end
