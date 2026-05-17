
export message="${1:-}"
export title="${2:-harry-notify}"

if command -v osascript; then
  osascript -e 'display notification (system attribute "message") with title (system attribute "title")' 
elif command -v notify-send; then
  notify-send "$message" "$title"
else
  echo >&2 "no program available to send a notification :("
  exit 1
fi
