function fish_greeting
  if test -n "$IN_NIX_SHELL" # Don't show in Nix shells.
    return
  end

  echo -s (set_color normal) \
    "It's " (set_color cyan) (date) (set_color normal) ", " \
     "up " (set_color cyan) (uptime | sed 's/.*up *\([^,]*\),.*/\1/;') (set_color normal) "."
end
