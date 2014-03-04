# Sets up preexec and precmd
# see 00-preexec.bash for more info

preexec() {
    # bash-notify-preexec-hook "$1"
    true
}

precmd() {
    # bash-notify-precmd-hook
    true
}

preexec_install
