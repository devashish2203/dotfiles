# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
»   alias ls='ls --color=auto -h'

    alias grep='grep -E --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll="ls -alF"
alias ls="ls -G"

# make commands verbose
alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'
alias mkdir='mkdir -p -v'
alias rmdir='rmdir -p -v'
