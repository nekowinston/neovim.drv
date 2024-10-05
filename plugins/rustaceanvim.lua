return function()
	vim.g.rustaceanvim = {
		server = {
			on_attach = function(client, _)
				client.server_capabilities.workspace.didChangeWatchedFiles = {
					dynamicRegistration = false,
					relativePatternSupport = false,
				}
			end,
		},
		tools = {
			float_win_config = {
				-- FIXME: this should use `vim.g.bc.style`
				border = "rounded",
			},
		},
	}
end
