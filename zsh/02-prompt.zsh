# Git prompt info settings
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=auto

# Allow command substitution
setopt prompt_subst

PS1="%F{cyan}%n%f@%F{yellow}%m%f: %F{green}%~\$(nix-shell-info)%f %F{5}\$(__git_ps1 \"(%s)\")%f
$ "
