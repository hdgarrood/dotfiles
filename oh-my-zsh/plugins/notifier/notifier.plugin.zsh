if [[ -x `which notify-send` ]]; then
    notify-preexec-hook() {
        zsh_notifier_cmd="$1"
        zsh_notifier_time="`date +%s`"
    }

    notify-precmd-hook() {
        local time_taken

        if [[ "${zsh_notifier_cmd}" != "" ]]; then
            time_taken=$(( `date +%s` - ${zsh_notifier_time} ))
            if (( $time_taken > $REPORTTIME )); then
                notify-send "task finished" \
                    "'$zsh_notifier_cmd' exited with status $? after $time_taken seconds"
            fi
        fi
        zsh_notifier_cmd=
    }
fi

[[ -z $preexec_functions ]] && preexec_functions=()
preexec_functions=($preexec_functions notify-preexec-hook)

[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions notify-precmd-hook)
