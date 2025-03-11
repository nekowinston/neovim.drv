---@param mode string
---@param key string
---@param callback fun(): nil
local map = function(mode, key, callback)
	vim.keymap.set(mode, key, callback, { silent = true, buffer = vim.api.nvim_get_current_buf() })
end

-- supports rust-analyzer's grouping
map("n", "<leader>ca", function()
	vim.cmd.RustLsp("codeAction")
end)

-- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
map("n", "K", function()
	vim.cmd.RustLsp({ "hover", "actions" })
end)
