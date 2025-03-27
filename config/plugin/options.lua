-- execute .nvim.lua, .nvimrc, and .exrc files in directories
vim.o.exrc = true

-- netrw is handled by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- true colors
vim.o.termguicolors = true
vim.o.cmdheight = 0
-- disable mouse in insert mode
vim.o.mouse = "nv"
-- line numbers
vim.o.number = true
vim.o.relativenumber = true
-- scroll offsets
vim.o.scrolloff = 5
vim.o.sidescrolloff = 15
-- always show status
vim.o.laststatus = 3
-- hide tab line
vim.o.showtabline = 0
-- completion height
vim.o.pumheight = 15
-- split directions
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.wrap = false
-- case insensitive search unless there is a capital letter
vim.o.ignorecase = true
vim.o.smartcase = true
-- redefine word boundaries - '_' is a word separator, this helps with snake_case
vim.opt.iskeyword:remove("_")
-- indentations settings
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.expandtab = true
-- always show 1 column of sign column (gitsigns, etc.)
vim.o.signcolumn = "yes:1"
-- hide search notices, intro
vim.opt.shortmess:append("s")
