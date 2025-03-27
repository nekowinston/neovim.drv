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
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
			ghost_text = {
				enabled = true,
			},
			list = {
				selection = {
					preselect = false,
				},
			},
			menu = {
				draw = {
					components = {
						kind_icon = {
							ellipsis = true,

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
			trigger = {
				show_in_snippet = false,
			},
		},
		keymap = {
			preset = "enter",
			["<CR>"] = {
				function(cmp)
					if cmp.is_visible() then
						if cmp.snippet_active() then
							cmp.accept()
							return cmp.snippet_forward()
						end

						return cmp.accept()
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
			default = function()
				local filename = vim.fs.basename(vim.api.nvim_buf_get_name(0))

				if filename == "Cargo.toml" then
					return { "crates", "lsp", "path", "snippets", "buffer" }
				end

				local success, node = pcall(vim.treesitter.get_node)
				if
					success
					and node
					and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
				then
					return { "path", "buffer" }
				end

				return { "lsp", "path", "snippets", "buffer" }
			end,
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
				crates = {
					name = "crates",
					module = "blink.compat.source",
					score_offset = 3,
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
