return function()
	local bufferline = require("bufferline")

	local v = vim.version()
	local vStr = string.format("v%d.%d.%d", v.major, v.minor, v.patch)

	bufferline.setup({
		highlights = require("milspec.utils.bufferline").get(),
		options = {
			close_command = function(n)
				Snacks.bufdelete(n)
			end,
			show_close_icon = true,
			show_buffer_close_icons = true,
			offsets = {
				{
					filetype = "NvimTree",
					text = "   neovim " .. vStr,
					text_align = "left",
					-- FIXME: change this depending to vim.o.winborder
					separator = "│",
				},
			},
			left_mouse_command = "buffer %d",
			middle_mouse_command = function(bufnum)
				require("snacks").bufdelete({ buf = bufnum })
			end,
			right_mouse_command = nil,
			numbers = "ordinal",
		},
	})

	local map = function(lhs, rhs, opts)
		vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", { silent = true }, opts or {}))
	end

	map("<A-,>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Select buffer to the left" })
	map("<A-.>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Select buffer to the right" })

	map("<A-<>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
	map("<A->>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })

	for i = 1, 9 do
		map("<A-" .. tostring(i) .. ">", function()
			bufferline.go_to(i, true)
		end, { desc = "Go to buffer " .. tostring(i) })
	end
	map("<A-0>", function()
		bufferline.go_to(-1, true)
	end, { desc = "Go to last buffer" })

	map("<A-p>", "<Cmd>BufferLineTogglePin<CR>", { desc = "Pin/unpin buffer" })
	map("<A-x>", function()
		require("snacks").bufdelete()
	end, { desc = "Close buffer" })
	map("<A-X>", function()
		require("snacks").bufdelete({ force = true })
	end, { desc = "Close buffer (force)" })
	map("<A-c>", "<Cmd>enew<CR>", { desc = "Create new buffer" })

	map("<A-space>", "<Cmd>BufferLinePick<CR>", { desc = "Pick buffer" })
	map("<leader>bd", "<Cmd>BufferLineSortByDirectory<CR>", { desc = "Sort buffers by directory" })
	map("<leader>bl", "<Cmd>BufferLineSortByExtension<CR>", { desc = "Sort buffers by extension" })
end
