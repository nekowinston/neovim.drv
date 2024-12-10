return function()
	local ollamaAdapter = { adapter = "ollama" }

	require("codecompanion").setup({
		strategies = {
			agent = ollamaAdapter,
			chat = ollamaAdapter,
			cmd = ollamaAdapter,
			inline = ollamaAdapter,
			workflow = ollamaAdapter,
		},
		adapters = {
			ollama = function()
				return require("codecompanion.adapters").extend("ollama", {
					schema = {
						model = { default = "qwen2.5-coder:7b" },
					},
				})
			end,
		},
		display = {
			action_palette = { provider = "telescope" },
			chat = { render_headers = false },
		},
	})
end
