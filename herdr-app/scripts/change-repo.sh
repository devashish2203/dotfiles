#!/usr/bin/env bash
# fzf over repos under ~/datahub/repos; focus its space or open a new one.
source "$(dirname "$0")/lib.sh"
trap close_self EXIT

root="$HOME/datahub/repos"
repo=$(cd "$root" && fd --type d -H '^\.git$' --exclude worktrees --strip-cwd-prefix \
  | sed 's#/\.git/$##' | sort | fzf --reverse --prompt 'repo> ') || exit 0
focus_or_new_space "$root/$repo" "$repo"
