autoload -Uz compinit
compinit

command -v jj >/dev/null && source <(COMPLETE=zsh jj)
command -v buck2 >/dev/null && source <(buck2 completion zsh)
