autoload -Uz compinit
compinit

command -v jj && source <(COMPLETE=zsh jj)
