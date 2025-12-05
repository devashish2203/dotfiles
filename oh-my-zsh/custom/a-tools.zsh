# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)


# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Mise
eval "$(/Users/devashish.chandra/.local/bin/mise activate zsh)"

