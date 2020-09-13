#!/bin/bash

#Add python to path
export PYTHONPATH="./Library/Python/3.7/site-packages/:$PYTHONPATH"
export PATH="/Users/devashish/Library/Python/3.7/bin/:$PATH"

# Enable Power line shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

#Update histort immediately
PROMPT_COMMAND="history -a"
if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

#Enable git-completion
source ${HOME}/tools/git-completion.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f ~/.bash_aliases ] && source  ~/.bash_aliases
[ -f ~/.bashrc ] && source ~/.bashrc

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
set -o vi
