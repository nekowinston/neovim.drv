vim.api.nvim_create_autocmd("VimEnter", {
	nested = true,
	callback = function()
		local filepath = vim.fn.fnamemodify(".nvim.lua", ":p")
		local file = vim.secure.read(filepath)
		if not file then
			return
		end

		if vim.fn.filereadable(filepath) == 1 then
			vim.cmd("luafile .nvim.lua")
		end
	end,
	desc = "Workaround for exrc not working with neovim.nix",
})

vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	command = "wincmd =",
	desc = "Automatically resize windows when the host window size changes.",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
	desc = "Highlight yanked text",
})

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
	callback = function(data)
		local msg = data.event == "RecordingEnter" and "Recording macro..." or "Macro recorded"
		vim.notify(msg, vim.log.levels.INFO, { title = "Macro" })
	end,
	desc = "Notify when recording macro",
})

local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", {})

---@param callback fun(): nil
---@return nil
local function numbertoggle_guard(callback)
	local not_relative = vim.api.nvim_win_get_config(vim.api.nvim_get_current_win()).relative == ""
	local ft_ok = not vim.tbl_contains({
		"",
		"alpha",
		"fugitive",
		"help",
		"lazy",
		"noice",
		"toggleterm",
		"NeogitCommitView",
		"NeogitConsole",
		"NeogitStatus",
		"NvimTree",
		"TelescopePrompt",
		"Trouble",
	}, vim.bo.filetype)

	if ft_ok and not_relative then
		callback()
	end
end

vim.api.nvim_create_autocmd({ "InsertEnter", "BufLeave", "WinLeave", "FocusLost" }, {
	callback = function()
		numbertoggle_guard(function()
			vim.opt_local.rnu = false
		end)
	end,
	group = numbertoggle,
})
vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter", "WinEnter", "FocusGained" }, {
	callback = function()
		numbertoggle_guard(function()
			vim.opt_local.rnu = true
		end)
	end,
	group = numbertoggle,
})
vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
	callback = function(data)
		numbertoggle_guard(function()
			vim.o.rnu = data.event == "CmdlineLeave"
			vim.cmd.redraw()
		end)
	end,
	group = numbertoggle,
})
