return function()
	---@type blink.cmp.Config
	local borderopts = {
		completion = {
			documentation = {
				window = {
					border = vim.g.bc.style,
				},
			},
			menu = {
				border = vim.g.bc.style,
			},
		},
		signature = {
			window = {
				border = vim.g.bc.style,
			},
		},
	}

	---@type blink.cmp.Config
	local opts = {
		appearance = {
			use_nvim_cmp_as_default = true,
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			list = {
				selection = {
					preselect = function()
						return not require("blink.cmp").snippet_active({ direction = 1 })
					end,
				},
			},
			trigger = {
				show_in_snippet = false,
			},
		},
		keymap = {
			preset = "super-tab",
			["<CR>"] = {
				function(cmp)
					if cmp.is_visible() then
						if cmp.snippet_active() then
							cmp.accept()
							return cmp.snippet_forward()
						end

						return cmp.accept_and_enter()
					end
				end,
				"fallback",
			},
			["<Tab>"] = {
				function(cmp)
					if cmp.is_visible() then
						if cmp.snippet_active() then
							return cmp.snippet_forward()
						end

						return cmp.select_next()
					end
				end,
				"fallback",
			},
			["<S-Tab>"] = {
				function(cmp)
					if cmp.is_visible() then
						if cmp.snippet_active() then
							return cmp.snippet_backward()
						end

						return cmp.select_prev()
					end
				end,
				"fallback",
			},
		},
	}

	require("blink.cmp").setup(vim.tbl_extend("force", borderopts, opts))
end
