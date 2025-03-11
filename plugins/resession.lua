return function()
	local resession = require("resession")
	resession.setup()

	local function get_session_name()
		local name = vim.fn.getcwd()
		local branch = vim.trim(vim.fn.system("git branch --show-current"))
		if vim.v.shell_error == 0 then
			return name .. branch
		else
			return name
		end
	end

	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			-- Only load the session if nvim was started with no args
			if vim.fn.argc(-1) ~= 0 then
				return
			end

			resession.load(get_session_name(), { dir = "dirsession", silence_errors = true })
			vim.api.nvim_exec_autocmds("BufRead", { buffer = vim.api.nvim_get_current_buf() })
		end,
	})

	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			resession.save(get_session_name(), { dir = "dirsession", notify = false })
		end,
	})
end
