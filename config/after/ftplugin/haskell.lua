local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<space>fs", ht.hoogle.hoogle_signature, { buffer = bufnr, desc = "Search Hoogle", silent = true })
vim.keymap.set("n", "<space>lr", function()
	local hls = vim.lsp.get_clients({ name = "haskell-tools.nvim" })[1]

	-- this either restarts HLS if already attached to the buffer, or attache it
	-- to the current buffer
	if hls and vim.tbl_contains(hls.attached_buffers, bufnr, {}) then
		vim.cmd.DirenvExport()
		ht.lsp.restart()
	else
		ht.lsp.start(bufnr)
	end
end, { buffer = bufnr, desc = "Search Hoogle", silent = true, remap = true })
