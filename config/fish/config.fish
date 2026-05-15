set --export EDITOR nvim

# Add entries to PATH. Like fish_add_path, except that it won't put stuff in
# front of the nix stuff from the parent shell if SHLVL > 1
set --local my_paths /opt/homebrew/bin
for my_path in $my_paths
  if ! contains $my_path $PATH
    fish_add_path --global $my_path
  end
end

# Set up nix last, so that nix is at the front of the path
if test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
  source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end

if status --is-interactive
  fish_vi_key_bindings

  abbr ls eza
  abbr tree eza --tree

  # Nix-provided fish config is added to XDG_DATA_DIRS too late, after fish has
  # already sourced vendor config. This fixes that.
  #
  # We need this for the direnv hook and for completions for nix-provided
  # programs in particular.
  set --global --append fish_complete_path \
      ~/.nix-profile/share/fish/vendor_completions.d \
      ~/.nix-profile/share/fish/completions
  set --global --append fish_function_path \
      ~/.nix-profile/share/fish/vendor_functions.d \
      ~/.nix-profile/share/fish/functions
  # https://github.com/fish-shell/fish-shell/issues/10078#issuecomment-1786490675
  for file in ~/.nix-profile/share/fish/vendor_conf.d/*.fish
      source $file
  end

  if command -v nix-your-shell >/dev/null
    nix-your-shell fish | source
  end
end
