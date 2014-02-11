# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

BASH_CONFIG_FILES=~/.bash/*.bash

# Load all of the config files in ~/.bash that end in .bash
for config_file in $BASH_CONFIG_FILES; do
    source "$config_file"
done
