export EDITOR=nvim

# Activate nix
if [ -x /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Activate homebrew
if [ -d "/opt/homebrew/bin" ]; then
    export PATH="$PATH:/opt/homebrew/bin"
fi

# Activate local bins
if [ -d "$HOME/.bin" ]; then
    export PATH="$PATH:$HOME/.bin"
fi
