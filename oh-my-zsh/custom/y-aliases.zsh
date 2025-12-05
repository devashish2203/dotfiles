alias gprune='git remote prune origin | grep pruned | cut -d" " -f4 | sed -e "s/origin\///" | xargs -IX -t git branch -D X'
alias gcl='gitlab-ci-local'


# last command - change the last arg
lc() {
  # Find the most recent non-'lc' command from shell history
  local last_cmd=$(history | grep -v '^[[:space:]]*[0-9]\+[[:space:]]\+lc ' | tail -n 1 | sed 's/^[[:space:]]*[0-9]\+[[:space:]]\+//')

  if [[ -z "$last_cmd" ]]; then
    echo "Could not find a suitable previous command."
    return 1
  fi

  if [[ $# -eq 0 ]]; then
    echo "Last command used was: ${last_cmd% *} "
    return 0
  fi

  local new_cmd="${last_cmd% *} $*"
  echo "+ $new_cmd"
  eval "$new_cmd"
}

gclone() {
  local url="$1"
  local REPO_ROOT="${HOME}/repo"

  # Extract the path after the colon (:) in the URL
  local repo_path="${url#*:}"
  # Remove the .git suffix if present
  repo_path="${repo_path%.git}"

  # Get the directory path (everything except the last component)
  local dir_path
  dir_path=$(dirname "$repo_path")

  # Create the target directory if it doesn't exist
  mkdir -p "${REPO_ROOT}/${dir_path}"

  # Clone the repo into the correct location
  git clone "$url" "${REPO_ROOT}/${repo_path}"
  cd ${REPO_ROOT}/${repo_path}
}

b64d() {
    echo -e "$1" | base64 -d
}
