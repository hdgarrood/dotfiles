export EDITOR=nvim

# Activate nix
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# Activate homebrew
if [ -d "/opt/homebrew/bin" ]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi
if [ -d "/usr/local/bin" ]; then
    export PATH="/usr/local/bin:$PATH"
fi

# Activate `fnm`: https://github.com/Schniz/fnm
if [ -d "$HOME/.local/share/fnm" ]; then
    export PATH="$HOME/.local/share/fnm:$PATH"
fi
if command -v fnm >/dev/null; then
    eval "$(fnm env --use-on-cd)"
fi

# Activate `direnv`: https://direnv.net/
if command -v direnv >/dev/null; then
    eval "$(direnv hook zsh)"
fi

