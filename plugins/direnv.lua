return function()
	local direnv = vim.api.nvim_create_augroup("direnv", {})

	---@param callback fun()
	---@return fun(): nil | nil
	local guard_envrc = function(callback)
		if vim.fn.filereadable(vim.fn.fnamemodify(".envrc", ":p")) == 1 then
			return callback
		end
		return function() end
	end

	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "flake.nix", "shell.nix" },
		callback = guard_envrc(function()
			vim.cmd("DirenvExport")
		end),
		group = direnv,
	})
end
