if not vim.g.neovide then
	return
end

local system = vim.uv.os_uname().sysname

vim.opt.guifont = "Berkeley Mono,Symbols Nerd Font:h14:#e-subpixelantialias"
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_input_macos_option_key_is_meta = system == "Darwin" and "only_left" or "none"
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_scroll_animation_length = 0.3

-- options only currently available on macOS
if system == "Darwin" then
	vim.g.neovide_transparency = 0.8
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
	vim.keymap.set({ "n", "v" }, "<D-v>", '"+p')
	vim.keymap.set("v", "<D-c>", '"+y')
else
	vim.keymap.set({ "n", "v" }, "<C-v>", '"+p')
	vim.keymap.set("v", "<C-c>", '"+y')
end
