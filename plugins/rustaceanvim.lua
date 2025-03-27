---@module "rustaceanvim"
return function()
	---@type rustaceanvim.Opts
	vim.g.rustaceanvim = {
		---@type rustaceanvim.lsp.ClientOpts
		server = {
			---@param client vim.lsp.Client
			---@param bufnr integer
			on_attach = function(client, bufnr)
				client.server_capabilities.workspace.didChangeWatchedFiles = {
					dynamicRegistration = false,
					relativePatternSupport = false,
				}
			end,
			default_settings = {
				["rust-analyzer"] = {
					files = {
						-- https://github.com/rust-lang/rust-analyzer/issues/12613
						exclude = { ".direnv" },
					},
				},
			},
		},
	}
end
