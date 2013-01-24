autoload colors; colors

if [ "x$OH_MY_ZSH_HG" = "x" ]; then
    OH_MY_ZSH_HG="hg"
fi

function virtualenv_info {
    if [ -n "$VIRTUAL_ENV" ]; then 
        _PROSE_VENV_INFO=`basename $VIRTUAL_ENV`
        echo "in %{$fg_bold[red]%}$_PROSE_VENV_INFO%{$reset_color%}"
    fi
}

function hg_prompt_info {
    if [[ -f ~/.hgrc ]]; then
        $OH_MY_ZSH_HG prompt --angle-brackets " (hg)\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
    fi
}

function box_name {
    echo $HOST
}

PROMPT='%(?,,%{${fg[base03]}%}exit code was %?%{$reset_color%}
)%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[yellow]%}$(box_name)%{$reset_color%}: %{$fg[green]%}${PWD/#$HOME/~}%{$reset_color%}$(hg_prompt_info)$(git_prompt_info) $(virtualenv_info)
$ '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
