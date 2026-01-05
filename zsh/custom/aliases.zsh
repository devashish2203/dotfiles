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
