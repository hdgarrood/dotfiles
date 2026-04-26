# Allow command substitution
setopt prompt_subst

PS1="%F{cyan}%n%f@%F{yellow}%m%f: %F{green}%~%f %F{blue}\$(nix-shell-info)%f %F{5}\$(jj-prompt-info \"(%s)\")%f
$ "
