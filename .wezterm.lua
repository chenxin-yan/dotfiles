local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.window_decorations = "RESIZE"

config.color_scheme = "Catppuccin Mocha"

config.window_background_opacity = 0.95
config.macos_window_background_blur = 45

return config
