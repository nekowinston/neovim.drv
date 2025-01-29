return function()
	local lspconfig = require("lspconfig")
	local cmp = require("cmp")

	local luasnip = require("luasnip")
	require("luasnip.loaders.from_vscode").lazy_load()

	vim.o.completeopt = "menu,menuone,noselect"

	-- border style
	local cmp_borders = {
		border = {
			vim.g.bc.topleft,
			vim.g.bc.horiz,
			vim.g.bc.topright,
			vim.g.bc.vert,
			vim.g.bc.botright,
			vim.g.bc.horiz,
			vim.g.bc.botleft,
			vim.g.bc.vert,
		},
		winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
	}

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		preselect = cmp.PreselectMode.Item,
		mapping = cmp.mapping.preset.insert({
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),

			["<CR>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					if luasnip.expandable() then
						luasnip.expand()
					else
						cmp.confirm({ select = true })
					end
				else
					fallback()
				end
			end),

			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.locally_jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "vim-dadbod-completion" },
			{ name = "buffer" },
			{ name = "lazydev", group_index = 0 },
		}),
		formatting = {
			expandable_indicator = true,
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				local kind = require("lspkind").cmp_format({
					mode = "symbol_text",
					ellipsis_char = "…",
					maxwidth = 50,
				})(entry, vim_item)
				local strings = vim.split(kind.kind, "%s", { trimempty = true })

				kind.kind = strings[1] or ""
				kind.menu = string.format("  (%s)", strings[2] or "")

				return kind
			end,
		},
		sorting = require("cmp.config.default")().sorting,
		experimental = {
			ghost_text = {
				hl_group = "CmpGhostText",
			},
		},
		window = {
			completion = cmp_borders,
			documentation = cmp_borders,
		},
	})

	vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

	vim.api.nvim_create_autocmd("BufRead", {
		group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
		pattern = "Cargo.toml",
		callback = function()
			cmp.setup.buffer({ sources = { { name = "crates" } } })
		end,
	})

	local git_ft = { "gitcommit", "NeogitCommitMessage" }
	cmp.setup.filetype(git_ft, {
		sources = cmp.config.sources({
			{ name = "git" },
		}, {
			{ name = "buffer" },
		}),
	})
	require("cmp_git").setup({
		filetypes = git_ft,
		enableRemoteUrlRewrites = true,
	})

	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path", option = { trailing_slash = true } },
		}, {
			{ name = "cmdline" },
		}),
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)

			if client == nil then
				return
			end

			-- use navic, show symbols in the winbar
			local navic_present, navic = pcall(require, "nvim-navic")
			if navic_present and client.server_capabilities.documentSymbolProvider then
				navic.attach(client, ev.buf)
			end

			-- enable inlay hints
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
			end

			-- local keymaps
			local map = vim.keymap.set
			local opts = { buffer = ev.buf }
			local lsp = vim.lsp.buf

			-- peeking & navigation
			map("n", "K", lsp.hover, opts)
			map("n", "gD", lsp.declaration, opts)
			map("n", "gd", lsp.definition, opts)
			map("n", "gi", lsp.implementation, opts)
			map("n", "gK", lsp.signature_help, opts)
			map("i", "<C-k>", lsp.signature_help, opts)
			map("n", "gr", lsp.references, opts)
			-- jump to diagnostics
			map("n", "]d", function()
				vim.diagnostic.goto_next({ float = { border = vim.g.bc.style } })
			end, opts)
			map("n", "[d", function()
				vim.diagnostic.goto_prev({ float = { border = vim.g.bc.style } })
			end, opts)
			-- workspace config
			map("n", "<leader>wa", lsp.add_workspace_folder, opts)
			map("n", "<leader>wr", lsp.remove_workspace_folder, opts)
			map("n", "<leader>D", lsp.type_definition, opts)
			-- editing
			map({ "n", "v" }, "<leader>ca", lsp.code_action, opts)
			map("n", "<leader>rn", lsp.rename, opts)
			-- formatting
			map("n", "<leader>fm", function()
				lsp.format({ async = true })
			end, opts)
			-- kickstart the server
			map("n", "<leader>lr", vim.cmd.LspRestart, opts)
		end,
	})

	require("typescript-tools").setup({
		single_file_support = false,
		root_dir = function(fname)
			local root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json")(fname)

			-- this is needed to make sure we don't pick up root_dir inside node_modules
			local node_modules_index = root_dir and root_dir:find("node_modules", 1, true)
			if node_modules_index and node_modules_index > 0 then
				---@diagnostic disable-next-line: need-check-nil
				root_dir = root_dir:sub(1, node_modules_index - 2)
			end

			return root_dir
		end,
		settings = {
      -- Nix silliness
      -- stylua: ignore
      tsserver_path = vim.fn.resolve(vim.fn.exepath("tsserver") .. "/../../lib/node_modules/typescript/bin/tsserver"),
		},
	})

	local schemastore = require("schemastore")

	local servers = {
		astro = {},
		basedpyright = {},
		bashls = {},
		cssls = {},
		denols = {
			root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			single_file_support = false,
		},
		dockerls = {},
		elmls = {},
		emmet_language_server = {
			filetypes = {
				"astro",
				"css",
				"eruby",
				"html",
				"htmltera",
				"javascript",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"pug",
				"typescriptreact",
			},
		},
		gopls = {},
		graphql = {
			filetypes = {
				"graphql",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"javascript",
			},
		},
		helm_ls = {},
		jqls = {},
		jsonls = {
			settings = {
				json = {
					schemas = schemastore.json.schemas(),
					validate = { enable = true },
				},
			},
		},
		lua_ls = {},
		html = {},
		ltex = {
			on_attach = function()
				local data_path = vim.fn.stdpath("data")
				---@cast data_path string

				require("ltex_extra").setup({
					load_langs = { "en-US", "de-AT" },
					path = vim.fs.joinpath(data_path, "/dictionary"),
				})
			end,
			settings = {
				ltex = {
					language = "en-US",
					additionalRules = {
						enablePickyRules = true,
						motherTongue = "de_AT",
					},
				},
			},
		},
		nixd = {},
		nushell = {},
		phpactor = {},
		purescriptls = {
			flags = {
				debounce_text_changes = 150,
			},
			settings = {
				purescript = {
					addSpagoSources = true,
					formatter = "purs-tidy",
				},
			},
		},
		tailwindcss = {},
		taplo = {},
		teal_ls = {},
		tinymist = {},
		yamlls = {
			settings = {
				yaml = {
					completion = true,
					schemas = schemastore.yaml.schemas(),
					suggest = { parentSkeletonSelectedFirst = true },
					validate = true,
				},
			},
		},
		zls = {},
	}

	local common = {
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = vim.g.bc.style }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = vim.g.bc.style }),
		},
	}

	for server, config in pairs(servers) do
		lspconfig[server].setup(config == {} and {} or vim.tbl_extend("force", common, config))
	end
end
