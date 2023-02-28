#   ▄▄▄▄·  ▄▄▄· .▄▄ ·  ▄ .▄▄▄▄   ▄▄·
#   ▐█ ▀█▪▐█ ▀█ ▐█ ▀. ██▪▐█▀▄ █·▐█ ▌▪
#   ▐█▀▀█▄▄█▀▀█ ▄▀▀▀█▄██▀▐█▐▀▀▄ ██ ▄▄
#   ██▄▪▐█▐█ ▪▐▌▐█▄▪▐███▌▐▀▐█•█▌▐███▌
#   ·▀▀▀▀  ▀  ▀  ▀▀▀▀ ▀▀▀ ·.▀  ▀·▀▀▀

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

#pretty stuff
export PS1="\[$(tput bold)\]\[\033[38;5;9m\][\[$(tput sgr0)\]\[\033[38;5;39m\]\u\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;2m\]@\[$(tput sgr0)\]\[\033[38;5;45m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;69m\]\W\[$(tput sgr0)\]\[\033[38;5;9m\]]\[$(tput sgr0)\]\[\033[38;5;11m\]\\$\[$(tput sgr0)\]"

export DOAS_PROMPT="$'\a'[doas] password for %u: "
#export DOAS_PROMPT=$'\a'"[doas] password for %p: "

complete -cf doas

# aliases
alias open="xdg-open"
alias py="python"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nano='nano -l '
alias cal="cal -m"
alias rm="trash-put"
#alias sudo="doas"
alias less='less -R'
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

alias ramfetch='dmidecode -t 17'
alias resrs='xrandr -s 1366x768'

alias tint="tint -s -n -d"
alias my-ip="curl ifconfig.me/ip; echo ''"
alias weather="curl wttr.in/rs"

alias dosbox="dosbox -conf $XDG_CONFIG_HOME/dosbox/dosbox.conf"
alias xbindkeys="xbindkeys -f $XDG_CONFIG_HOME/xbindkeys/config"
alias mbsync="mbsync -c $XDG_CONFIG_HOME/isync/mbsyncrc"
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"
alias pidgin="pidgin --config=$XDG_DATA_HOME/purple"
#alias lmms="lmms-1.3.0-alpha.1.102 -c $XDG_CONFIG_HOME/lmms/lmmsrc.xml"

export NVM_DIR="$HOME/.local/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Autocompletions
source /usr/share/bash-completion/completions/git

export NIX_PAT="~/.nix-profile/bin"

