function wezterm_notify --desc "Send a notification via ghostty/wezterm's escape codes"
  # Remove semicolons, since I don't think they can be escaped in this terminal
  # escape sequence
  set --local title (string replace --all ";" "" "$argv[1]")
  set --local message (string replace --all ";" "" "$argv[2]")
  if test "$TERM_PROGRAM" = ghostty; or test "$TERM_PROGRAM" = WezTerm
    printf "\x1b]777;notify;%s;%s\x1b\\" "$title" "$message"
  end
end
