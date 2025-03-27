---@param mode string | string[]
---@param lhs string
---@param rhs string | fun(): nil
---@param opts? vim.keymap.set.Opts
local map = function(mode, lhs, rhs, opts)
	opts = vim.tbl_extend("force", { silent = true, buffer = vim.api.nvim_get_current_buf() }, opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

return function()
	local dap = require("dap")
	local dapui = require("dapui")
	local dapui_widgets = require("dap.ui.widgets")

	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end

	vim.api.nvim_create_user_command("DapToggleUI", function()
		dapui.toggle()
	end, { desc = "Toggle DAP UI" })

	map("n", "<F5>", function()
		dap.continue()
	end, { desc = "DAP: Continue" })
	map("n", "<F10>", function()
		dap.step_over()
	end, { desc = "DAP: Step Over" })
	map("n", "<F11>", function()
		dap.step_into()
	end, { desc = "DAP: Step Into" })
	map("n", "<F12>", function()
		dap.step_out()
	end, { desc = "DAP: Step Out" })
	map("n", "<leader>b", function()
		dap.toggle_breakpoint()
	end, { desc = "DAP: Toggle Breakpoint" })
	map("n", "<leader>B", function()
		dap.set_breakpoint()
	end, { desc = "DAP: Set Breakpoint" })
	map("n", "<leader>lp", function()
		dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end, { desc = "DAP: Log Point" })
	map("n", "<leader>dr", function()
		dap.repl.open()
	end, { desc = "DAP: Open REPL" })
	map("n", "<leader>dl", function()
		dap.run_last()
	end, { desc = "DAP: Run Last" })
	map({ "n", "v" }, "<leader>dh", function()
		dapui_widgets.hover()
	end, { desc = "DAP: Hover" })
	map({ "n", "v" }, "<leader>dp", function()
		dapui_widgets.preview()
	end, { desc = "DAP: Preview" })
	map("n", "<leader>df", function()
		dapui_widgets.centered_float(dapui_widgets.frames)
	end, { desc = "DAP: Frames" })
	map("n", "<leader>ds", function()
		dapui_widgets.centered_float(dapui_widgets.scopes)
	end, { desc = "DAP: Scopes" })
end
