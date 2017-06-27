# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

export EDITOR=vim
export PYTHONSTARTUP="$HOME/.python"

if [ -f "$HOME/.bashrc.force" ]; then
    source "$HOME/.bashrc.force"

    # Add paths which are common to all systems
    add_path --prepend                \
        "/usr/local/bin"              \
        "$HOME/.bin"                  \
        "$HOME/.local/bin"            \
        "$HOME/.cabal/bin"            \
        "$HOME/.npm-packages/bin"     \
        "$HOME/.psvm/current/bin"     \
        "$HOME/.rbenv/bin"

    if [ -f "$HOME/.profile.local" ]; then
        source "$HOME/.profile.local"
    fi
fi

# Auto-start GNU screen
if [ -z "$STY" ] && [ -f "~/.screen-autostart" ]; then
    screen -dRR
fi

# Nix
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
