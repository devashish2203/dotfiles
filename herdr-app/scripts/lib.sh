# Shared helpers for herdr-app key scripts (ported from the old herdr worktrunk plugin).
# terminal.open splits skip shell rc files, so load mise tools (fd, fzf) ourselves.
command -v mise >/dev/null && eval "$(mise env -s bash)"

# Focus the space whose folder is $1, else create one there named $2.
focus_or_new_space() {
  local id
  id=$(herdr-app ls | jq -r --arg d "$1" '.spaces[] | select(.folder == $d) | .id' | head -1)
  if [[ -n $id ]]; then
    herdr-app do space.select --id "$id" >/dev/null
  else
    herdr-app do space.new --name "$2" --folder "$1" >/dev/null
  fi
}

# Close the split this script runs in (terminal.open may leave a shell behind).
close_self() {
  local p
  p=$(herdr-app ls | jq -r --arg t "$HC_TERMINAL_ID" '.. | objects | select(.terminal? == $t) | .pane' | head -1)
  [[ -n $p ]] && herdr-app do pane.close --pane "$p" >/dev/null
}
