alias vim=nvim
alias zshrc="$EDITOR ~/.zshrc"

alias ll="ls -alF"
alias ls="ls -G"

# make commands verbose
alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'
alias mkdir='mkdir -p -v'
alias rmdir='rmdir -p -v'

# Git
#alias gprune-dry="git branch -vv | grep ': gone]' | awk '{print \$1}' | xargs -r echo git branch -D"
#alias gprune="git branch -vv | grep ': gone]' | awk '{print \$1}' | xargs -r git branch -D"

# Delete all local git branches except a protected branch
# Usage: git-clean-branches [<exclude>] [-y]
#   <exclude>  Branch to protect from deletion (default: main)
#   -y         Skip confirmation prompts
function gprune() {
  local force=1

  if [[ "$1" == "-d" ]]; then
    force=0
  fi

  if [[ $force -eq 1 ]]; then
    git branch | grep -v "main\|master\|releases/\|hotfix" | xargs -IX git branch -D X
  else
    git branch | grep -v "main\|master\|releases/\|hotfix" | xargs -IX echo git branch -D X
  fi
}

alias gprune-dry='gprune -d' 
alias groot='cd $(git rev-parse --show-toplevel)'

# Select Virtual Environments
function avenv() {
  local selected_env
  selected_env=$(ls ~/.virtualenvs/ | fzf)

  if [ -n "$selected_env" ]; then
    if [ -n "${VIRTUAL_ENV}" ]; then
        deactivate
    fi
    source "$HOME/.virtualenvs/$selected_env/bin/activate"
  fi
}

#Change repo
function rc() {
  local repo
  selected_repo=$(fd --type d -H "^.git$" ~/datahub/repos/ | sed 's/.git\/$//' | fzf)

  if [ -n "$selected_repo" ]; then
      cd $selected_repo
  fi
}

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

function loadEnv() {
  export $(cat $1 | xargs)
}

alias gitroot='cd "$(git rev-parse --show-toplevel)"'
