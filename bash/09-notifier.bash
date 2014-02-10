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

LONG_RUNNING_COMMAND_TIMEOUT=10

notify_when_long_running_commands_finish_install() {
    local RUNNING_COMMANDS_DIR=~/.cache/running-commands
    mkdir -p $RUNNING_COMMANDS_DIR
    for pid_file in $RUNNING_COMMANDS_DIR/*; do
        local pid=$(basename $pid_file)
        # If $pid is numeric, then check for a running bash process.
        case $pid in
        ''|*[!0-9]*) local numeric=0 ;;
        *) local numeric=1 ;;
        esac

        if [[ $numeric -eq 1 ]]; then
            local command=$(ps -o command= $pid)
            if [[ $command != $BASH ]]; then
                rm -f $pid_file
            fi
        fi
    done

    _LAST_COMMAND_STARTED_CACHE=$RUNNING_COMMANDS_DIR/$$

    function bash-notify-precmd-hook() {
        local exit_status=$?
        if [[ -r $_LAST_COMMAND_STARTED_CACHE ]]; then

            local last_command_started=$(head -1 $_LAST_COMMAND_STARTED_CACHE)
            local last_command=$(tail -n +2 $_LAST_COMMAND_STARTED_CACHE)

            if [[ -n $last_command_started ]]; then
                local now=$(date -u +%s)
                local time_taken=$(( $now - $last_command_started ))
                if [[ $time_taken -gt $LONG_RUNNING_COMMAND_TIMEOUT ]]; then
                  if [ `echo "$last_command" | egrep -c "less|more|vi|vim|man|ssh"` == 1 ] ; then
                    exit 0
                  else
                    local msg="'$last_command' exited with status $exit_status after `seconds-to-hms $time_taken`"
                    notify-send "task finished" "$msg"
                  fi
                fi
            fi
            # No command is running, so clear the cache.
            echo -n > $_LAST_COMMAND_STARTED_CACHE
        fi
    }

    function bash-notify-preexec-hook() {
        date -u +%s > $_LAST_COMMAND_STARTED_CACHE
        echo "$1" >> $_LAST_COMMAND_STARTED_CACHE
    }
}

notify_when_long_running_commands_finish_install
