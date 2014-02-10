# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

BASH_CONFIG_FILES=~/.bash/*.bash

# Load all of the config files in ~/oh-my-zsh that end in .zsh
for config_file in $BASH_CONFIG_FILES; do
    source "$config_file"
done
