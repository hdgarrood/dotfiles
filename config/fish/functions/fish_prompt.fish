
function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color --reset)
    set -l last_cmd_duration $CMD_DURATION

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    # Last command duration
    if test $last_cmd_duration -gt 0
      set -f duration_string (printf '[%s]' (ms_to_human $last_cmd_duration))
    end

    echo $prompt_status $duration_string
    echo -s (prompt_login)' ' \
      (set_color $color_cwd) (prompt_pwd) $normal \
      (set_color blue) ' '(nix-shell-info) $normal \
      (set_color purple) (jj-prompt-info " (%s)") $normal
    echo -s -n $suffix ' '
end
