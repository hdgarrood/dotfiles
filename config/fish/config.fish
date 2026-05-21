set --export EDITOR nvim
# less options:
# - R: use colours
# - F: don't page if there's less than one screenful of output
set --export LESS RF
# this works better with the other colors in my prompt
set --global fish_color_user brred

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
  abbr gdiff git diff --no-index --

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

  if command --query nix-your-shell
    nix-your-shell fish | source
  end

  # These have to go here rather than in functions/*.fish because they wouldn't
  # get autoloaded there
  function __jj_snapshot_for_prompt --on-event fish_prompt --desc "run a jj snapshot so that prompt info is up-to-date"
    ~/.nix-profile/bin/jj log -r 'none()' 2>/dev/null
  end

  # Notify me when a command that took longer than 5s finishes
  # Note! we use a custom impl rather than just vendoring done.fish because this
  # way we can let wezterm take responsibility for choosing whether to deliver
  # the notification. Importantly, wezterm is able to suppress notifications
  # which are generated from the currently focused pane (tab), via
  #
  #     config.notification_handling = "SuppressFromFocusedPane"
  #
  # and done.fish can't do this.
  set --global notify_slow_command_threshold_ms 5000

  function __notify_slow_command_finished --on-event fish_postexec --desc "send a notification when long-running commands finish"
    set --local cmd_status $status
    if test "$CMD_DURATION" -gt "$notify_slow_command_threshold_ms"
      set --local title (string split --fields 1 ' ' "$argv")
      if test $cmd_status -eq 0
        set --append title "succeeded in"
      else
        set --append title "failed ($cmd_status) in"
      end
      set --append title (ms_to_human $CMD_DURATION)
      wezterm_notify "$title" "$PWD: $argv"
    end
  end
end
