__bash_prompt() {
    local RESETCOLOUR="\[\033[0m\]"
    local CYAN="\[\033[0;36m\]"
    local BROWN="\[\033[0;33m\]"
    local GREEN="\[\033[0;32m\]"

    if [[ -n "$?" && "$?" -gt 0 ]]; then
        echo "exit code was $?"
    fi

    echo "${CYAN}${USER}${RESETCOLOUR}@${BROWN}${HOSTNAME}${RESETCOLOUR}: ${GREEN}${PWD/$HOME/~}${RESETCOLOUR} $(__git_ps1 "(%s)")"
    echo -n "$ "
}

PS1="$(__bash_prompt)"
