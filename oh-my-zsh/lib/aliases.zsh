#!/bin/zsh
## ALIASES
# directories
alias ls="ls --color=auto --hide='*.pyc'"
alias lsa='ls -lAh'
alias d='dirs -v'

# shortcuts
alias dj='cd ~/code/django/ && workon django-env'
alias ra='cd ~/code/rails'

# misc
alias ack='ack-grep'
alias history='fc -l 1 | less'

# ruby
alias bake='bundle exec rake'
alias bexc='bundle exec'
