#   ▄▄▄▄·  ▄▄▄· .▄▄ ·  ▄ .▄▄▄▄   ▄▄·
#   ▐█ ▀█▪▐█ ▀█ ▐█ ▀. ██▪▐█▀▄ █·▐█ ▌▪
#   ▐█▀▀█▄▄█▀▀█ ▄▀▀▀█▄██▀▐█▐▀▀▄ ██ ▄▄
#   ██▄▪▐█▐█ ▪▐▌▐█▄▪▐███▌▐▀▐█•█▌▐███▌
#   ·▀▀▀▀  ▀  ▀  ▀▀▀▀ ▀▀▀ ·.▀  ▀·▀▀▀

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

#pretty stuff
export PS1="\[$(tput bold)\]\[\033[38;5;9m\][\[$(tput sgr0)\]\[\033[38;5;39m\]\u\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;2m\]@\[$(tput sgr0)\]\[\033[38;5;45m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;69m\]\W\[$(tput sgr0)\]\[\033[38;5;9m\]]\[$(tput sgr0)\]\[\033[38;5;11m\]\\$\[$(tput sgr0)\] "

# = = = = = = = = = = #
#    A L I A S E S    #
# = = = = = = = = = = #
alias open="xdg-open"
alias py="python"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip -color=auto"
alias nano="nano -l"
alias cal="cal -m"
alias rm="trash-put"
alias sudo="doas"
alias less="less -RN"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias cht.sh="curl https://cht.sh/\$1"
alias zathura="zathura --fork"
alias nnn="nnn -e"
alias pfetch="fastfetch -c ~/.config/fastfetch/pfetch.jsonc"
alias neofetch="fastfetch -c ~/.config/fastfetch/neofetch.jsonc"

alias ramfetch="dmidecode -t 17"
alias resrs="xrandr -s 1366x768"

alias tint="tint -s -n -d"
alias my-ip="curl ifconfig.me/ip; echo ''"
alias weather="curl wttr.in/rs"
alias jar="java -jar"
alias ncf="nvim ~/.config/nvim/"

alias dosbox="dosbox -conf $XDG_CONFIG_HOME/dosbox/dosbox.conf"
alias xbindkeys="xbindkeys -f $XDG_CONFIG_HOME/xbindkeys/config"
alias mbsync="mbsync -c $XDG_CONFIG_HOME/isync/mbsyncrc"
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"
alias pidgin="pidgin --config=$XDG_DATA_HOME/purple"
#alias lmms="lmms-1.3.0-alpha.1.102 -c $XDG_CONFIG_HOME/lmms/lmmsrc.xml"

# = = = = = = = = = = #
#  F U N C T I O N S  #
# = = = = = = = = = = #
lk() {
    cd "$(walk --icons "$@")"
}

lfcd() {
    # `command` is needed in case `lfcd` is aliased to `lf`
    cd "$(command lf -print-last-dir "$@")"
}

curl-img() {
    # helps with those data hungry websites links
    url=$(echo "$1" | sed 's/&amp;/\&/g')
    curl --compressed -O "$url"
}

# = = = = = = = = = = #
# C O M P L E T I O N #
# = = = = = = = = = = #
source /usr/share/bash-completion/completions/git
source /usr/share/bash-completion/completions/eza
source /usr/share/bash-completion/completions/yt-dlp
complete -cf doas
#source ~/.local/share/blesh/ble.sh

source /usr/share/nvm/init-nvm.sh

bind "set colored-completion-prefix on"
bind "set colored-stats on"

nsp -r
