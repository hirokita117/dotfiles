PROMPT='[%~] @%n $ '
alias ll='ls -lFG'
export LSCOLORS=gxfxcxdxbxegedabagacad

alias grep='grep --color=auto'

#alias sed='gsed'
alias hig='history | grep --color=auto'

alias shinse-summary='cat ~/shinse_summary.txt'
alias shinse='aws-vault exec ChangeManagerExecution-760615286099 -- ~/Developer/shinse/main request'
alias get-db-pass='aws-vault exec torana-dev-AdministratorAccess -- ~/Developer/shinse/main get-db-cred'
alias portforward-prd='aws-vault exec torana-dev-AdministratorAccess -- ~/Developer/portforward/main madras db'
alias portforward-stg='aws-vault exec AdministratorAccess-413046581984 -- ~/Developer/portforward/main madras db'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
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
