extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.tar.xz)    tar xvJf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *.xz)        unxz $1        ;;
            *.exe)       cabextract $1  ;;
            *)           echo "\`$1': unrecognized file compression" ;;
        esac
    else
        echo "\`$1' is not a valid file"
    fi
}

# a shortcut function to simplify usage of xclip
clip() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then
      # if no input, print clipboard to stdout
      xclip -o -selection c
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}

# Read text from stdin, and echo a version of the same text, just better suited
# for a filename.
sanitise-filename() {
    echo -n "$1" | tr -c -s 'a-zA-Z0-9.-' '-'
}

# Wrapper around sanitise-filename which takes a list of files and renames them
# for you. Example use:
#
#   sanitise-rename-files *
#   sanitise-rename-files *.doc
#
sanitise-rename-files() {
    local exitcode=0
    local sanitised

    for file in $*; do
        sanitised=$(sanitise-filename "$file")

        [ "$sanitised" = "$file" ] && continue

        if [ -f "$sanitised" ]; then
            echo >&2 "$0: can't rename $file, $sanitised already exists"
            exitcode=1
        else
            mv -- "$file" "$sanitised"
        fi
    done

    return $exitcode
}
