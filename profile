# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

export EDITOR=vim

# function for adding dirs to $PATH
# note that this fails silently if arg doesn't exist
add_path() {
    local PREPEND="false"

    # basic arg parsing
    if [ "$1" = "--prepend" ]; then
        PREPEND="true"
        shift
    fi

    for ARG in $*; do
        if [ -d $ARG ]; then
            if [ "$PREPEND" = "true" ]; then
                export PATH="$ARG:$PATH"
            else
                export PATH="$PATH:$ARG"
            fi
        fi
    done
}

add_path --prepend "$HOME/.bin"
add_path --prepend "$HOME/.local/bin"
add_path --prepend "$HOME/.cabal/bin"

# Auto-start GNU screen
if [ -z "$STY" ] && [ -f ~/.screen-autostart ]; then
    screen -dRR
fi
