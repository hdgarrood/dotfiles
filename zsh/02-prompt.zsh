# Allow command substitution
setopt prompt_subst

# Command timing
function preexec() {
  _zsh_prompt_timer_ms=$(($(date +%s%N)/1000000))
}

function precmd() {
  local now elapsed
  if [ "$_zsh_prompt_timer_ms" ]; then
    now=$(($(date +%s%N)/1000000))
    elapsed=$(converts $(($now-$_zsh_prompt_timer_ms)))
    _zsh_prompt_elapsed="[${elapsed# }]"
    unset _zsh_prompt_timer_ms
  fi
}

converts() {
  local t=$1

  local d=$((t/1000/60/60/24))
  local h=$((t/1000/60/60%24))
  local m=$((t/100/60%60))
  local s=$((t/1000%60))
  local ms=$((t%1000))

  if [[ $d -gt 0 ]]; then
    echo -n " ${d}d"
  fi
  if [[ $h -gt 0 ]]; then
    echo -n " ${h}h"
  fi
  if [[ $m -gt 0 ]]; then
    echo -n " ${m}m"
  fi
  if [[ $s -gt 0 ]]; then
    echo -n " ${s}s"
  fi
  if [[ $ms -gt 0 ]]; then
    echo -n " ${ms}ms"
  fi
  echo
}

PS1="%B%(?..%F{red}[%?]%f )\$_zsh_prompt_elapsed%b
%F{cyan}%n%f@%F{yellow}\$(hostname-for-prompt)%f: %F{green}%~%f %F{blue}\$(nix-shell-info)%f %F{5}\$(jj-prompt-info \"(%s)\")%f
$ "
