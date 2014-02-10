# Git prompt info settings
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=auto

__bash_prompt() {
    local RESETCOLOUR="\033[0m"
    local CYAN="\033[0;36m"
    local BROWN="\033[0;33m"
    local GREEN="\033[0;32m"
    local PURPLE="\033[0;35m"

    if [[ -n "$?" && "$?" -gt 0 ]]; then
        echo "exit code was $?"
    fi

    # user@host
    echo -en "${CYAN}${USER}${RESETCOLOUR}@${BROWN}${HOSTNAME}${RESETCOLOUR}: "
    # cwd
    echo -en "${GREEN}${PWD/#$HOME/~}${RESETCOLOUR} "
    # git stuff
    echo -e "${PURPLE}$(__git_ps1 "(%s)")${RESETCOLOUR}"
}

PS1="$ "
export PROMPT_COMMAND="__bash_prompt"
