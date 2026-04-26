autoload -Uz compinit
compinit

command -v jj >/dev/null && source <(COMPLETE=zsh jj)
