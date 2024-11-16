local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.window_decorations = "RESIZE"

config.color_scheme = "Catppuccin Mocha"
config.colors = {
	tab_bar = {
		background = "rgba(30,30,46,0.95)",
	},
}

-- window transparency
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 40

config.enable_kitty_keyboard = true

config.max_fps = 120

return config
