return function()
	local border_style = { border = vim.g.bc.style }

	---@type blink.cmp.Config
	local borderopts = {
		completion = {
			menu = border_style,
			documentation = { window = border_style },
		},
		signature = { window = border_style },
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
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				lua = { "lazydev", "lsp", "path", "snippets", "buffer" },
				markdown = { "markdown" },
				sql = { "snippets", "dadbod", "buffer" },
			},
			providers = {
				snippets = {
					name = "Snippets",
					module = "blink.cmp.sources.snippets",
					opts = {
						search_paths = {
							vim.fn.stdpath("config") .. "/snippets",
							vim.g.config_dir,
						},
					},
				},
				dadbod = {
					name = "Dadbod",
					module = "vim_dadbod_completion.blink",
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				markdown = {
					name = "RenderMarkdown",
					module = "render-markdown.integ.blink",
					fallbacks = { "lsp" },
				},
			},
		},
	}

	require("blink.cmp").setup(vim.tbl_extend("force", borderopts, opts))
end
