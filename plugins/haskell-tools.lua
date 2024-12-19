return function()
	vim.g.haskell_tools = {}

	local augroup_ht = vim.api.nvim_create_augroup("haskell-tools", {})

	--- Only executes the callback if `hpack` is available on the `$PATH`.
	---
	---@param callback fun(): nil
	---@return fun(): nil | nil
	local function guard_hpack(callback)
		if vim.fn.executable("hpack") == 1 then
			return callback
		end
		return function() end
	end

	--- Runs `hpack` and subsequently restarts the Haskell LSP, if the Cabal file
	--- changed.
	--- Notifies via `vim.notify` when an error was encountered.
	---
	---@param args table<string,string>? optional args provided to hpack
	---@return nil
	local function run_hpack(args)
		if not args then
			args = {}
		end

		vim.system(vim.list_extend({ "hpack" }, args), { text = true }, function(out)
			if out.code ~= 0 then
				vim.notify("hpack autocmd error:\n" .. out.stdout)
				return
			end

			if out.stdout:find(" is up%-to%-date") == nil then
				vim.notify("Cabal file changed, reloading LSP.")

				-- need to schedule this because it calls Vimscript functions
				vim.schedule(function()
					require("haskell-tools").lsp.restart()
				end)
			end
		end)
	end

	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "package.yaml" },
		callback = guard_hpack(run_hpack),
		group = augroup_ht,
	})

	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "*.hs" },
		callback = guard_hpack(function()
			local hpack_spec_fp = vim.fs.root(0, "package.yaml")

			if hpack_spec_fp ~= nil then
				run_hpack({ hpack_spec_fp })
			end
		end),
		group = augroup_ht,
	})
end
