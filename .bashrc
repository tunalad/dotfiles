#   ▄▄▄▄·  ▄▄▄· .▄▄ ·  ▄ .▄▄▄▄   ▄▄·
#   ▐█ ▀█▪▐█ ▀█ ▐█ ▀. ██▪▐█▀▄ █·▐█ ▌▪
#   ▐█▀▀█▄▄█▀▀█ ▄▀▀▀█▄██▀▐█▐▀▀▄ ██ ▄▄
#   ██▄▪▐█▐█ ▪▐▌▐█▄▪▐███▌▐▀▐█•█▌▐███▌
#   ·▀▀▀▀  ▀  ▀  ▀▀▀▀ ▀▀▀ ·.▀  ▀·▀▀▀

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# = = = = = = = = = = #
#     P R E T T Y     #
# = = = = = = = = = = #

DISTRO=$(cat /etc/os-release | awk -F= '/^ID=/{gsub(/"/, "", $2); print $2}')

if [ $DISTRO = "arch" ]; then
    PS1="\[$(tput bold)\]\[\033[38;5;9m\][\[$(tput sgr0)\]\[\033[38;5;39m\]\u\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;2m\]@\[$(tput sgr0)\]\[\033[38;5;45m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;69m\]\W\[$(tput sgr0)\]\[\033[38;5;9m\]]\[$(tput sgr0)\]\[\033[38;5;11m\]\\$\[$(tput sgr0)\] "
elif [ $DISTRO = "void" ]; then
    PS1='\[\e[38;2;0;170;0m\]\u\[\e[22m\]\[\e[38;2;255;85;255m\]@\[\e[22m\]\[\e[1m\]\[\e[38;2;50;255;90m\]\h\[\e[22m\] \[\e[1;34m\]\W\[\e[22m\]\[\e[38;5;11m\] \$ \[\e[m\]'
fi

bind "set colored-completion-prefix on"
bind "set colored-stats on"

# = = = = = = = = = = #
#    A L I A S E S    #
# = = = = = = = = = = #
alias open="xdg-open"
alias py="python"
alias ls="ls --color=auto -p"
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
alias nsxiv="nsxiv-rifle"
alias tmux="tmux -2"
alias sc-im="TERM=xterm-256color sc-im"

alias ramfetch="dmidecode -t 17"
alias resrs="xrandr -s 1366x768"

alias tint="tint -s -n -d"
alias my-ip="curl ifconfig.me/ip; echo ''"
alias weather="curl wttr.in/rs"
alias jar="java -jar"

alias dosbox="dosbox -conf $XDG_CONFIG_HOME/dosbox/dosbox.conf"
alias xbindkeys="xbindkeys -f $XDG_CONFIG_HOME/xbindkeys/config"
alias mbsync="mbsync -c $XDG_CONFIG_HOME/isync/mbsyncrc"
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"
alias pidgin="pidgin --config=$XDG_DATA_HOME/purple"

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

nvm() {
    # lazyload nvm
    unset -f nvm
    source /usr/share/nvm/init-nvm.sh
    nvm "$@"
}

# = = = = = = = = = = #
# C O M P L E T I O N #
# = = = = = = = = = = #
source /usr/share/bash-completion/completions/git
#source /usr/share/bash-completion/completions/eza
source /usr/share/bash-completion/completions/yt-dlp
source /usr/share/bash-completion/completions/tmux
complete -cf doas
#source ~/.local/share/blesh/ble.sh

#nsp -r

fzf-history() {
    # overengineering the fzf history
    # because fukin void maintainers won't add mcfly to the repo
    # (no apparent reason, they just forgot and the github bot closed it bruhh)
    local selected key

    selected=$(
        history | sed 's/^ *[0-9]\+ *//' | sed 's/[[:space:]]\+$//' | tac | awk '!seen[$0]++' | fzf \
            --height 100% \
            --reverse \
            --prompt='$ ' \
            --no-info \
            --border=none \
            --margin=3,2 \
            --padding=2 \
            --exact \
            --expect=tab,enter
    ) || return

    key=$(head -1 <<<"$selected")
    selected=$(tail -n +2 <<<"$selected")

    [[ -z $selected ]] && return

    if [[ $key == "tab" ]]; then
        READLINE_LINE="$selected"
        READLINE_POINT=${#READLINE_LINE}
    else
        echo "${PS1@P}$selected"
        eval "$selected"
        history -s "$selected"
        builtin history -a
    fi
}

bind -x '"\C-r": fzf-history'

# starting tmux when in terminal
if [[ $TERM == "alacritty" && -z $TMUX ]]; then
    #tmux attach-session || tmux new-session
    #tmux attach-session -t main || tmux new-session -s main
    tmux new-session
fi
