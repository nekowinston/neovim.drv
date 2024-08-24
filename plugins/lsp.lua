return function()
	local lsp_present, lspconfig = pcall(require, "lspconfig")
	local cmp_present, cmp = pcall(require, "cmp")
	local luasnip_present, luasnip = pcall(require, "luasnip")
	local navic_present, navic = pcall(require, "nvim-navic")

	if not (cmp_present and lsp_present and luasnip_present) then
		vim.notify("lsp, cmp, luasnip not present", vim.log.levels.ERROR)
		return
	end

	vim.opt.completeopt = "menu,menuone,noselect"
	require("luasnip.loaders.from_vscode").lazy_load()

	-- border style
	require("lspconfig.ui.windows").default_options.border = vim.g.bc.style
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = vim.g.bc.style,
	})
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
		window = {
			completion = cmp_borders,
			documentation = cmp_borders,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),

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
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				local kind = require("lspkind").cmp_format({
					mode = "symbol_text",
					ellipsis_char = "…",
					maxwidth = 50,
				})(entry, vim_item)
				local strings = vim.split(kind.kind, "%s", { trimempty = true })

				kind.kind = " " .. (strings[1] or "") .. " "
				kind.menu = "   (" .. (strings[2] or "") .. ")"

				return kind
			end,
		},
	})

	vim.api.nvim_create_autocmd("BufRead", {
		group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
		pattern = "Cargo.toml",
		callback = function()
			cmp.setup.buffer({ sources = { { name = "crates" } } })
		end,
	})

	local git_ft = { "gitcommit", "NeogitCommitMessage", "Octo" }
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

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)

			if client == nil then
				return
			end

			if navic_present and client.server_capabilities.documentSymbolProvider then
				navic.attach(client, ev.buf)
			end

			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
			end

			local opts = { buffer = ev.buf }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "<space>lr", vim.cmd.LspRestart, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "<space>fm", function()
				vim.lsp.buf.format({ async = true })
			end, opts)
		end,
	})

	local common = { capabilities = capabilities }

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
			expose_as_code_action = {
				"add_missing_imports",
				"fix_all",
				"remove_unused",
			},
      -- Nix silliness
      -- stylua: ignore
      tsserver_path = vim.fn.resolve(vim.fn.exepath("tsserver") .. "/../../lib/node_modules/typescript/bin/tsserver"),
		},
	})

	local schemastore = require("schemastore")

	local servers = {
		astro = {},
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
				"typescriptreact",
				"javascriptreact",
				"typescript",
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
				require("ltex_extra").setup({
					load_langs = { "en-US", "de-AT" },
					path = vim.fn.stdpath("data") .. "/dictionary",
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
		serve_d = {},
		sourcekit = {
			filetypes = { "swift", "c", "cpp", "objc", "objcpp" },
		},
		tailwindcss = {},
		taplo = {},
		teal_ls = {},
		yamlls = {
			settings = {
				yaml = {
					completion = true,
					validate = true,
					suggest = {
						parentSkeletonSelectedFirst = true,
					},
					schemas = vim.tbl_extend("keep", {
            -- https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.0-standalone/all.json
            -- stylua: ignore
            kubernetes = {
              'deployment.yaml', 'deployment.yml', 'deployment-*.yaml', 'deployment-*.yml', '*-deployment.yaml', '*-deployment.yml',
              'clusterrole-contour.yaml', 'clusterrole-contour.yml',
              'clusterrole.yaml', 'clusterrole.yml',
              'clusterrolebinding.yaml', 'clusterrolebinding.yml',
              'configmap.yaml', 'configmap.yml',
              'cronjob.yaml', 'cronjob.yml',
              'daemonset.yaml', 'daemonset.yml',
              'hpa.yaml', 'hpa.yml',
              'ingress.yaml', 'ingress.yml',
              'job.yaml', 'job.yml',
              'kubectl-edit-*.yaml',
              'namespace.yaml', 'namespace.yml',
              'pvc.yaml', 'pvc.yml',
              'rbac.yaml', 'rbac.yml',
              'replicaset.yaml', 'replicaset.yml',
              'role.yaml', 'role.yml',
              'rolebinding.yaml', 'rolebinding.yml',
              'secret.yaml', 'secret.yml',
              'service.yaml', 'service.yml', 'service-*.yaml', 'service-*.yml', '*-service.yaml', '*-service.yml',
              'service-account.yaml', 'service-account.yml', 'serviceaccount.yaml', 'serviceaccount.yml', 'serviceaccounts.yaml', 'serviceaccounts.yml', 'sa.yaml', 'sa.yml',
              'statefulset.yaml', 'statefulset.yml'
            },
					}, schemastore.yaml.schemas()),
				},
				redhat = {
					telemetry = {
						enabled = false,
					},
				},
			},
		},
		zls = {},
	}

	for server, config in pairs(servers) do
		if config == {} then
			lspconfig[server].setup(common)
		else
			lspconfig[server].setup(vim.tbl_extend("force", common, config))
		end
	end
end
