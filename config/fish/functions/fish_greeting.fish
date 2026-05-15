function fish_greeting
  if test -n "$IN_NIX_SHELL" # Don't show in Nix shells.
    return
  end

  echo -s (set_color normal)
  echo -s "It's " (set_color cyan) (date +'%H:%M') (set_color normal) " on " (set_color cyan) (date +'%a, %d %b') (set_color normal)
  echo -s "Uptime: " (set_color cyan) (uptime | sed 's/.*up *\([^,]*\),.*/\1/;') (set_color normal)
end
