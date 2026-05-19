local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.default_prog = { os.getenv("HOME") .. '/.nix-profile/bin/fish' }
config.color_scheme = 'flexoki-dark'
config.font_size = 15
config.font = wezterm.font 'PT Mono'

return config
