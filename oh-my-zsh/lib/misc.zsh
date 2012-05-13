## MISC
# Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
REPORTTIME=10 # print elapsed time when more than 10 seconds

autoload -U url-quote-magic
zle -N self-insert url-quote-magic
autoload -U edit-command-line
zle -N edit-command-line
