return function()
	local lspkind = require("lspkind")
	local devicons = require("nvim-web-devicons")

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
			documentation = { window = { border = vim.g.bc.style } },
			menu = {
				border = vim.g.bc.style,
				draw = {
					components = {
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								local icon = ctx.kind_icon
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, _ = devicons.get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = lspkind.symbolic(ctx.kind, { mode = "symbol" })
								end

								return icon .. ctx.icon_gap
							end,

							-- Optionally, use the highlight groups from nvim-web-devicons
							-- You can also add the same function for `kind.highlight` if you want to
							-- keep the highlight groups in sync with the icons.
							highlight = function(ctx)
								local hl = "BlinkCmpKind" .. ctx.kind
									or require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, dev_hl = devicons.get_icon(ctx.label)
									if dev_icon then
										hl = dev_hl
									end
								end
								return hl
							end,
						},
					},
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
		signature = { window = { border = vim.g.bc.style } },
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

	require("blink.cmp").setup(opts)
end
