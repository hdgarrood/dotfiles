function fish_greeting
  if test -n "$IN_NIX_SHELL" # Don't show in Nix shells.
    return
  end

  echo -s (set_color normal)
  echo -s "It's " (set_color cyan) (date +'%H:%M') (set_color normal) " on " (set_color cyan) (date +'%a, %d %b') (set_color normal)
  echo -s "Uptime: " (set_color cyan) (uptime | sed 's/.*up *\([^,]*\),.*/\1/;') (set_color normal)

  if command -v df >/dev/null && test -d /nix/store
    df --human-readable --output=size,used,pcent /nix/store \
      | sed 1d \
      | read --tokenize size used pcent
    set pcent (string replace '%' '' $pcent)
    if test "$pcent" -gt 80
      echo
      echo "The file system containing the Nix store is getting full!"
      echo -s "Used: " (set_color cyan) $used (set_color normal) " / " (set_color cyan) "$size" (set_color normal) " (" (set_color cyan) "$pcent%" (set_color normal) ")"
      echo "Time for a nix-collect-garbage -d?"
    end
  end
end
