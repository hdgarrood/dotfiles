local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.default_prog = { os.getenv("HOME") .. '/.nix-profile/bin/fish' }
config.initial_cols = 100
config.initial_rows = 60
config.scrollback_lines = 10000

-- allow left-option (for eg #) on macos. idk why this isn't the default
config.send_composed_key_when_left_alt_is_pressed = true

-- See also: config/fish/config.fish
config.notification_handling = "SuppressFromFocusedPane"

-- Appearance
config.color_scheme = 'flexoki-dark'
config.font_size = 15
-- nix build --no-link --print-out-paths nixpkgs#maple-mono.NL-Variable
config.font = wezterm.font 'Maple Mono NL'
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_frame = {
  font_size = 14
}

wezterm.on('window-config-reloaded', function(window, pane)
  window:toast_notification('wezterm', 'configuration reloaded!', nil, 4000)
end)

return config

