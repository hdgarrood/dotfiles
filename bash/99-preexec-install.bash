# Sets up preexec and precmd
# see 00-preexec.bash for more info

preexec() {
    bash-notify-preexec-hook "$1"
}

precmd() {
    bash-notify-precmd-hook
}

preexec_install
