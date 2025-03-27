if not vim.g.neovide then
	return
end

---@type vim.keymap.set.Opts
local opts = { silent = true }
local map = vim.keymap.set
local system = vim.uv.os_uname().sysname

vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_hide_mouse_when_typing = true

map("n", "<M-CR>", function()
	vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end)

vim.g.neovide_scale_factor = 1.0
if vim.o.winborder == "rounded" then
	vim.g.neovide_floating_corner_radius = 0.5
end

local change_scale_factor = function(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	vim.cmd.redraw()
end

map("n", "<D-=>", function()
	change_scale_factor(1.25)
end, opts)
map("n", "<D-->", function()
	change_scale_factor(1 / 1.25)
end, opts)

if system == "Darwin" then
	-- options only available on macOS
	vim.g.neovide_input_macos_option_key_is_meta = "only_left"
	vim.g.neovide_transparency = 0.95
	vim.g.neovide_window_blurred = true
	-- save with ⌘+S
	map("n", "<D-s>", ":w<CR>", opts)
	-- clipboard with ⌘+C and ⌘+V
	map("v", "<D-c>", '"+y', opts)
	map({ "n", "v" }, "<D-v>", '"+p', opts)
	map("c", "<D-v>", "<C-R>+", opts)
	map("i", "<D-v>", '<Esc>l"+pa', opts)
end
