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

# aliases
alias open="xdg-open"
alias py="python"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nano='nano -l '
alias cal="cal -m"
alias ramfetch='sudo dmidecode -t 17'
alias resrs='xrandr -s 1366x768'

alias tint="tint -s -n -d"
alias my-ip="curl ifconfig.me/ip"
alias weather="curl wttr.in/rs"

alias conv2csv="libreoffice --headless --convert-to csv "
