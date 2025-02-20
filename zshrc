# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source ~/.zshrc.force

# Activate `direnv`: https://direnv.net/
if command -v direnv >/dev/null; then
    eval "$(direnv hook zsh)"
fi
