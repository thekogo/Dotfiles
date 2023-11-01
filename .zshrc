export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bira"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/snap/bin
export PATH=$PATH:/home/thekogo/go/bin
export JAVA_HOME=/home/thekogo/bin/jdk-21
export PATH=$PATH:/home/thekogo/.local/bin

export TERM=xterm-256color
# fnm
export PATH="/home/thekogo/.local/share/fnm:$PATH"
eval "`fnm env`"

eval "$(direnv hook zsh)"

alias tmux="TERM=screen-256color-bce tmux"
