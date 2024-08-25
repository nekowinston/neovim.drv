local map = vim.keymap.set

-- easier split navigation
map("n", "<C-J>", "<C-W>j", { desc = "Activate pane below" })
map("n", "<C-K>", "<C-W>k", { desc = "Activate pane above" })
map("n", "<C-L>", "<C-W>l", { desc = "Activate pane right" })
map("n", "<C-H>", "<C-W>h", { desc = "Activate pane left" })
map("n", "<C-W>\\", ":vsplit<CR>", { desc = "Split vertically" })
map("n", "<C-W>-", ":split<CR>", { desc = "Split horizontally" })
map("n", "<C-W>x", ":q<CR>", { desc = "Close buffer" })

-- escape :terminal easier
map("t", "<Esc>", "<C-\\><C-n>")
-- ignore shift for space and backspace
map("t", "<S-Space>", "<Space>")
map("t", "<S-Backspace>", "<Backspace>")

-- keep cursor in the middle when scrolling and searching
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- system clipboard
map({ "n", "v" }, "<space>y", '"+y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<space>p", '"+p', { desc = "Paste from clipboard" })
