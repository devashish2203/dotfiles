#!/bin/sh
# Smart directory segment for starship ($directory replacement).
#
#   git repo       -> <repo>/<relative path>, collapsed to <repo>/…/<last>
#                     once the in-repo nesting goes past MAXDEPTH levels
#   git worktree   -> the real repo name (worktrunk worktrees/<repo>/<wt> layout),
#                     derived from the shared .git common dir, not the worktree dir
#   not a git repo -> home-contracted path, truncated to the last MAXDEPTH levels
#
# Output is plain text; styling/padding is applied by the [custom.directory]
# format string in starship.toml.

MAXDEPTH=3
TRUNC='…/'

# One git invocation gives us everything (empty output when outside a repo):
#   line 1: --show-prefix      path within the repo (trailing slash, empty at root)
#   line 2: --show-toplevel    work-tree root
#   line 3: --git-dir          contains /worktrees/ when inside a linked worktree
#   line 4: --git-common-dir   shared .git of the owning repo (used for worktrees)
info=$(git rev-parse --show-prefix --show-toplevel --git-dir --git-common-dir 2>/dev/null)

if [ -n "$info" ]; then
    # Split the 4 rev-parse lines without forking (read is a builtin; paths may contain spaces).
    { IFS= read -r prefix; IFS= read -r toplevel; IFS= read -r gitdir; IFS= read -r commondir; } <<EOF
$info
EOF

    case "$gitdir" in
        */worktrees/*)
            # Worktree: the repo name is the dir that owns the shared .git.
            case "$commondir" in /*) ;; *) commondir="$PWD/$commondir" ;; esac
            repo=$(basename "$(dirname "$commondir")")
            ;;
        *)
            repo=$(basename "$toplevel")
            ;;
    esac

    rel=${prefix%/}
    if [ -z "$rel" ]; then
        printf '%s' "$repo"
    else
        depth=$(printf '%s' "$rel" | tr '/' '\n' | grep -c .)
        if [ "$depth" -gt "$MAXDEPTH" ]; then
            printf '%s/%s%s' "$repo" "$TRUNC" "${rel##*/}"
        else
            printf '%s/%s' "$repo" "$rel"
        fi
    fi
else
    path=$PWD
    case "$path" in
        "$HOME")   path='~' ;;
        "$HOME"/*) path="~/${path#"$HOME"/}" ;;
    esac
    depth=$(printf '%s' "$path" | tr '/' '\n' | grep -c .)
    if [ "$depth" -gt "$MAXDEPTH" ]; then
        path="$TRUNC$(printf '%s' "$path" | awk -F/ -v n="$MAXDEPTH" '{o=$(NF-n+1); for(i=NF-n+2;i<=NF;i++) o=o"/"$i; print o}')"
    fi
    # Parity with the previous [directory.substitutions] icons.
    path=$(printf '%s' "$path" | sed \
        -e 's#Documents#󰈙 #g' \
        -e 's#Downloads# #g' \
        -e 's#Music#󰝚 #g' \
        -e 's#Pictures# #g' \
        -e 's#Developer#󰲋 #g')
    printf '%s' "$path"
fi
