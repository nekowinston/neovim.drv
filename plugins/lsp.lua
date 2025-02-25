return function()
	local lspconfig = require("lspconfig")

	require("luasnip.loaders.from_vscode").lazy_load()

	vim.o.completeopt = "menu,menuone,noselect"

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
					schemas = require("schemastore").json.schemas(),
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
		nil_ls = {},
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
					schemas = require("schemastore").yaml.schemas(),
					suggest = { parentSkeletonSelectedFirst = true },
					validate = true,
				},
			},
		},
		zls = {},
	}

	for server, config in pairs(servers) do
		local common = {
			capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities),
			handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = vim.g.bc.style }),
				["textDocument/signatureHelp"] = vim.lsp.with(
					vim.lsp.handlers.signature_help,
					{ border = vim.g.bc.style }
				),
			},
		}

		lspconfig[server].setup(config == {} and {} or vim.tbl_extend("force", common, config))
	end
end
