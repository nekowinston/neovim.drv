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
			settings = {
				files = {
					-- https://github.com/rust-lang/rust-analyzer/issues/12613
					excludeDirs = { ".direnv" },
				},
			},
		},
		tools = {
			float_win_config = {
				border = vim.g.bc.style,
			},
		},
	}
end
