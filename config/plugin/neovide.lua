if not vim.g.neovide then
	return
end

local map = vim.keymap.set
local system = vim.uv.os_uname().sysname

vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_input_macos_option_key_is_meta = system == "Darwin" and "only_left" or "none"

-- options only currently available on macOS
if system == "Darwin" then
	vim.g.neovide_transparency = 0.95
	vim.g.neovide_window_blurred = true
end

vim.keymap.set("n", "<M-CR>", function()
	vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end)

vim.g.neovide_scale_factor = 1.0

local change_scale_factor = function(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	vim.cmd.redraw()
end

vim.keymap.set("n", "<D-=>", function()
	change_scale_factor(1.25)
end)
vim.keymap.set("n", "<D-->", function()
	change_scale_factor(1 / 1.25)
end)

if system == "Darwin" then
	map("n", "<D-s>", ":w<CR>")
	map("v", "<D-c>", '"+y')
	map({ "n", "v" }, "<D-v>", '"+p')
	map("c", "<D-v>", "<C-R>+")
	map("i", "<D-v>", '<esc>l"+pa')
end
