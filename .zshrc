PROMPT='[%~] @%n $ '
alias ll='ls -lFG'
export LSCOLORS=gxfxcxdxbxegedabagacad

alias grep='grep --color=auto'

#alias sed='gsed'
alias hig='history | grep --color=auto'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/sbin:$PATH"


[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

export PATH="/Users/hiroaki_kitai/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

export PATH="/Users/hiroaki_kitai/Library/Python/3.9/bin:$PATH"

export GOROOT=$(./go/bin/go1.21.0 env GOROOT)
export PATH=$GOROOT/bin:$PATH
