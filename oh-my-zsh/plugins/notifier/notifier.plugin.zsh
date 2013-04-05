seconds-to-hms() {
    echo $1 | awk '
        function join(array, start, end, sep, result, i)
        {
            if (sep == "")
                sep = " "
            else if (sep == SUBSEP) # magic value
                sep = ""
            result = array[start]
            for (i = start + 1; i <= end; i++)
                result = result sep array[i]
            return result
        }

        function hms(s)
        {
            h = int(s/3600)
            s = s-(h*3600)
            m = int(s/60)
            s = s-(m*60)

            i = 0

            if (h > 0) { result[i] = sprintf("%d hours",   h); i++; }
            if (m > 0) { result[i] = sprintf("%d minutes", m); i++; }
            if (s > 0) { result[i] = sprintf("%d seconds", s); i++; }

            print(join(result, 0, i-1, ", "));
        }
        { hms($0); }'
}

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
                msg="'$zsh_notifier_cmd' exited with status $? after `seconds-to-hms $time_taken`"
                notify-send "task finished" "$msg"
            fi
        fi
        zsh_notifier_cmd=
    }
fi

[[ -z $preexec_functions ]] && preexec_functions=()
preexec_functions=($preexec_functions notify-preexec-hook)

[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions notify-precmd-hook)
