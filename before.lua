-- set exrc very early
vim.opt.exrc = true

-- use space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---@class BorderChars
---@field style string
---@field vert string
---@field vertleft string
---@field vertright string
---@field horiz string
---@field horizup string
---@field horizdown string
---@field verthoriz string
---@field topleft string
---@field topright string
---@field botleft string
---@field botright string

---@type table<string, BorderChars>
local borderchars = {
	single = {
		style = "single",
		vert = "│",
		vertleft = "┤",
		vertright = "├",
		horiz = "─",
		horizup = "┴",
		horizdown = "┬",
		verthoriz = "┼",
		topleft = "┌",
		topright = "┐",
		botleft = "└",
		botright = "┘",
	},
	double = {
		style = "double",
		vert = "║",
		vertleft = "╣",
		vertright = "╠",
		horiz = "═",
		horizup = "╩",
		horizdown = "╦",
		verthoriz = "╬",
		topleft = "╔",
		topright = "╗",
		botleft = "╚",
		botright = "╝",
	},
	rounded = {
		style = "rounded",
		vert = "│",
		vertleft = "┤",
		vertright = "├",
		horiz = "─",
		horizup = "┴",
		horizdown = "┬",
		verthoriz = "┼",
		topleft = "╭",
		topright = "╮",
		botleft = "╰",
		botright = "╯",
	},
}

-- my custom borderchars
vim.g.bc = borderchars.rounded
vim.opt.fillchars:append({
	horiz = vim.g.bc.horiz,
	horizup = vim.g.bc.horizup,
	horizdown = vim.g.bc.horizdown,
	vert = vim.g.bc.vert,
	vertright = vim.g.bc.vertright,
	vertleft = vim.g.bc.vertleft,
	verthoriz = vim.g.bc.verthoriz,
})
