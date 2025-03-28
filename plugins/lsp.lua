return function()
	local lspconfig = require("lspconfig")

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
			---@type vim.keymap.set.Opts
			local opts = { buffer = ev.buf, silent = true }
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
				vim.diagnostic.jump({ count = 1, float = true })
			end, opts)
			map("n", "[d", function()
				vim.diagnostic.jump({ count = -1, float = true })
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

	---@type table<string, lspconfig.Config>
	---@diagnostic disable: missing-fields
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
		html = {},
		jqls = {},
		jsonls = {
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		},
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
		lua_ls = {},
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
		vtsls = {
			single_file_support = false,
			---@type (string | fun(filename: string, bufnr: number): string)?
			root_dir = function(filename)
				local root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json")(filename)

				-- this is needed to make sure we don't pick up root_dir inside node_modules
				local node_modules_index = root_dir and root_dir:find("node_modules", 1, true)
				if node_modules_index and node_modules_index > 0 then
					---@diagnostic disable-next-line: need-check-nil
					root_dir = root_dir:sub(1, node_modules_index - 2)
				end

				return root_dir
			end,
		},
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
	---@diagnostic enable: missing-fields

	for server, config in pairs(servers) do
		lspconfig[server].setup(vim.tbl_extend("force", {
			capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities),
			handlers = {
				["textDocument/hover"] = vim.lsp.buf.hover({ border = vim.o.winborder }),
				["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({ border = vim.o.winborder }),
			},
		}, config))
	end
end
