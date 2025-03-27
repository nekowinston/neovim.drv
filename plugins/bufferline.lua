return function()
	local bufferline = require("bufferline")

	local v = vim.version()
	local vStr = string.format("v%d.%d.%d", v.major, v.minor, v.patch)

	bufferline.setup({
		highlights = require("milspec.utils.bufferline").get(),
		options = {
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
			middle_mouse_command = "bdelete! %d",
			right_mouse_command = nil,
			numbers = "ordinal",
		},
	})

	local map = vim.keymap.set

	map("n", "<A-,>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Select buffer to the left" })
	map("n", "<A-.>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Select buffer to the right" })

	map("n", "<A-<>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
	map("n", "<A->>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })

	map("n", "<A-1>", "<Cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
	map("n", "<A-2>", "<Cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
	map("n", "<A-3>", "<Cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
	map("n", "<A-4>", "<Cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
	map("n", "<A-5>", "<Cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })
	map("n", "<A-6>", "<Cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6" })
	map("n", "<A-7>", "<Cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7" })
	map("n", "<A-8>", "<Cmd>BufferLineGoToBuffer 8<CR>", { desc = "Go to buffer 8" })
	map("n", "<A-9>", "<Cmd>BufferLineGoToBuffer 9<CR>", { desc = "Go to buffer 9" })
	map("n", "<A-0>", "<Cmd>BufferLineGoToBuffer -1<CR>", { desc = "Go to last buffer" })

	map("n", "<A-p>", "<Cmd>BufferLineTogglePin<CR>", { desc = "Pin/unpin buffer" })
	map("n", "<A-x>", "<Cmd>bdelete<CR>", { desc = "Close buffer" })
	map("n", "<A-X>", "<Cmd>bdelete!<CR>", { desc = "Close buffer (force)" })
	map("n", "<A-c>", "<Cmd>enew<CR>", { desc = "Create new buffer" })

	map("n", "<A-space>", "<Cmd>BufferLinePick<CR>", { desc = "Pick buffer" })
	map("n", "<leader>bd", "<Cmd>BufferLineSortByDirectory<CR>", { desc = "Sort buffers by directory" })
	map("n", "<leader>bl", "<Cmd>BufferLineSortByExtension<CR>", { desc = "Sort buffers by extension" })
end
