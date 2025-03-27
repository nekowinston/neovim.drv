-- netrw is handled by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local o = vim.opt
-- execute .nvim.lua, .nvimrc, and .exrc files in directories
o.exrc = true
-- true colors
o.termguicolors = true
o.cmdheight = 0
-- disable mouse in insert mode
o.mouse = "nv"
-- line numbers
o.number = true
o.relativenumber = true
-- scroll offsets
o.scrolloff = 5
o.sidescrolloff = 15
-- always show status
o.laststatus = 3
-- hide tab line
o.showtabline = 0
-- completion height
o.pumheight = 15
-- split directions
o.splitbelow = true
o.splitright = true
o.wrap = false
-- case insensitive search unless there is a capital letter
o.ignorecase = true
o.smartcase = true
-- redefine word boundaries - '_' is a word separator, this helps with snake_case
o.iskeyword:remove("_")
-- indentations settings
o.expandtab = true -- use spaces instead of tabs
o.shiftround = true -- make <</>> round to the next shiftwidth
o.shiftwidth = 2 -- size of an indent
o.tabstop = 2 -- nr of spaces a tab counts as
-- always show 1 column of sign column (gitsigns, etc.)
o.signcolumn = "yes:1"
-- hide search notices
o.shortmess:append("s")
-- preview substitutions
o.inccommand = "split"

o.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

o.list = true
o.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}
