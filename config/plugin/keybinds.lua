local map = vim.keymap.set

-- easier split navigation
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<Space>w", "<C-w>", { desc = "Windows", remap = true })
map("n", "<Space>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<Space>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<Space>wd", "<C-W>c", { desc = "Delete Window", remap = true })

map({ "i", "n" }, "<Esc>", "<Cmd>noh<CR><Esc>", { desc = "Escape and Clear hlsearch" })

-- keep cursor in the middle when scrolling and searching
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- system clipboard
map({ "n", "v" }, "<space>y", '"+y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<space>p", '"+p', { desc = "Paste from clipboard" })

-- escape :terminal easier
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- ignore shift for space and backspace,
map("t", "<S-Space>", "<Space>")
map("t", "<S-Backspace>", "<Backspace>")
