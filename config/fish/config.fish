set --export EDITOR nvim

# nb: nonexistent directories are ignored
fish_add_path --global \
  "/opt/homebrew/bin" \
  "$HOME/.bin"

# Set up nix last, so that nix is at the front of the path
if test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
  source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end

if status --is-interactive
  fish_vi_key_bindings

  if command -v buck2 >/dev/null
    buck2 completion fish | source
  end

  if command -v nix-your-shell >/dev/null
    nix-your-shell fish | source
  end
end
