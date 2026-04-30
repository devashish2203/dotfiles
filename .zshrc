# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 2 not-numeric
zstyle ':completion:*' menu select
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt '[%e] '
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '~/.zshrc'

# From fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
# zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 -G $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2
autoload -Uz compinit
compinit
autoload -Uz +X bashcompinit && bashcompinit
# End of lines added by compinstall

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt sharehistory autocd extendedglob nomatch

# Setup vim bindings
EDITOR="nvim"
# Load the built-in Zsh widget
autoload -Uz edit-command-line

# Create a new named widget for use in the key binding
zle -N edit-command-line

# Bind 'v' in vi command mode (vicmd) to the widget
bindkey -M vicmd v edit-command-line

# Optional: Enable full vi-mode bindings in the Zsh line editor
bindkey -v


eval "$(~/.local/bin/mise activate zsh)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
eval "$(starship init zsh)"
# Plugins
source ~/.config/zsh/custom/fzf-tab/fzf-tab.plugin.zsh

# Environment Vars
source ~/.config/zsh/custom/env.zsh

# Completions
source ~/.config/zsh/custom/starship-completion.zsh
source ~/.config/zsh/custom/mise-completion
source ~/.config/zsh/custom/docker-completion.zsh
source ~/.config/zsh/custom/uv-completion.zsh
source ~/.config/zsh/custom/aws-sso-completion.sh
complete -C $(mise which aws_completer) aws
source $(mise where gcloud)/completion.zsh.inc
eval "$(op completion zsh)"; compdef _op op
source ~/.config/zsh/custom/gh-completion.zsh
source ~/.config/zsh/custom/wt-completion.zsh
source ~/.config/zsh/datahub/datahub-apps-completion.sh
# Aliases and functions
source ~/.config/zsh/custom/aliases.zsh

# Datahub Specific
source ~/.config/zsh/datahub/aws.sh
source ~/.config/zsh/datahub/datahub.sh

