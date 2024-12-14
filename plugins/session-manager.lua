return function()
	local config = require("session_manager.config")
	local utils = require("session_manager.utils")
	local session_manager = require("session_manager")

	session_manager.setup({
		autoload_mode = {
			config.AutoloadMode.GitSession,
			config.AutoloadMode.CurrentDir,
		},
	})

	-- delete the current session if all buffers are closed on vim exit.
	vim.api.nvim_create_autocmd("VimLeave", {
		callback = function()
			if not utils.is_restorable_buffer_present() then
				session_manager.delete_current_dir_session()
			end
		end,
	})
end
