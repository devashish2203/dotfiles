#!/usr/bin/env bash
# fzf over worktrunk branches; existing → wt switch, new name → wt switch --create.
# Opens the checkout as a herdr-app space. $1: "current" bases new branches on HEAD.
source "$(dirname "$0")/lib.sh"
trap close_self EXIT

base=() label="default branch"
if [[ ${1:-} == current ]]; then
  base=(--base @)
  if b=$(git branch --show-current 2>/dev/null) && [[ -n $b ]]; then
    label="current branch ($b)"
  elif c=$(git rev-parse --short HEAD 2>/dev/null); then
    label="current HEAD ($c)"
  else
    label="current branch"
  fi
fi

if command -v fzf >/dev/null; then
  choice=$(
    { wt list --format=json 2>/dev/null | jq -r '.items[] | select(.branch != null) | .branch'
      git for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null
    } | LC_ALL=C sort -u \
      | fzf --print-query --reverse --info=inline --border=rounded --prompt='worktree ❯ ' \
            --header="↵ match → switch · new name + ↵ → create from $label · esc → cancel"
  )
  [[ $? -gt 1 ]] && exit 0
  name=${choice##*$'\n'}
else
  read -rp "Branch (existing → switch · new → create from $label): " name
fi
[[ -z $name ]] && exit 0

# Shortcuts (^, -, pr:N, URLs) and existing local or remote refs switch; anything else creates.
if [[ $name == '^' || $name == '-' || $name == *:* ]] \
   || git show-ref --quiet --verify "refs/heads/$name" \
   || git show-ref --quiet --verify "refs/remotes/$name"; then
  args=(switch "$name")
else
  args=(switch --create "$name" "${base[@]}")
fi

if ! result=$(wt "${args[@]}" --no-cd --format=json); then
  printf '\n\033[31mwt switch failed (see above).\033[0m press any key'; read -rn1; exit 1
fi
path=$(jq -r '.path // .worktree.path // empty' <<<"$result")
[[ -z $path ]] && path=$(wt list --format=json | jq -r --arg b "$name" '.items[] | select(.branch == $b) | .worktree.path // empty' | head -1)
[[ -z $path ]] && { echo "worktrunk returned no path for $name"; sleep 2; exit 1; }
focus_or_new_space "$path" "$name"
