local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.default_prog = { os.getenv("HOME") .. '/.nix-profile/bin/fish' }
config.initial_cols = 100
config.initial_rows = 60
config.scrollback_lines = 10000
-- allow left-option (for eg #) on macos. idk why this isn't the default
config.send_composed_key_when_left_alt_is_pressed = true

-- Appearance
config.color_scheme = 'flexoki-dark'
config.font_size = 15
config.font = wezterm.font 'PT Mono'

return config
