
function extract --desc "Extract pretty much any archive format based on filename"
  if test -f "$1"
      switch "$1"
        case '*.tar.bz2'
          tar xvjf "$1"
        case '*.tar.gz'
          tar xvzf "$1"
        case '*.tar.xz'
          tar xvJf "$1"
        case '*.bz2'
          bunzip2 "$1"
        case '*.rar'
          unrar x "$1"
        case '*.gz'
          gunzip "$1"
        case '*.tar'
          tar xvf "$1"
        case '*.tbz2'
          tar xvjf "$1"
        case '*.tgz'
          tar xvzf "$1"
        case '*.zip'
          unzip "$1"
        case '*.Z'
          uncompress "$1"
        case '*.7z'
          7z x "$1"
        case '*.xz'
          unxz "$1"
        case '*.exe'
          cabextract "$1"
        case '*'
          echo >&2 "extract: '$1': unrecognized archive format"
          return 1
      end
  else
      echo >&2 "extract: '$1' is not a regular file"
      return 1
  fi
end
