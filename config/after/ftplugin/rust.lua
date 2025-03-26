---@type vim.keymap.set.Opts
local opts = { buffer = vim.api.nvim_get_current_buf(), silent = true }
local map = vim.keymap.set

-- supports rust-analyzer's grouping
map("n", "<leader>ca", function()
	vim.cmd.RustLsp("codeAction")
end, opts)

-- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
map("n", "K", function()
	vim.cmd.RustLsp({ "hover", "actions" })
end, opts)
