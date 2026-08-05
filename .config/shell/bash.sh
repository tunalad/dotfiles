# bash specific

# history
export HISTFILE="${XDG_STATE_HOME}/bash/history"

# functions
lazy_load_completion() {
    local cmd="$1"
    local path="$2"

    eval "_${cmd}_load() {
        . $path
        unset -f _${cmd}_load
        complete -r $cmd
    }"

    complete -F "_${cmd}_load" "$cmd"
}

fzf_history() {
    local selected key

    HISTCONTROL=ignoredups:erasedups
    shopt -s histappend

    selected=$(
        history | sed 's/^ *[0-9]\+ *//' | sed 's/[[:space:]]\+$//' | tac | awk '!seen[$0]++' | fzf \
            --height 100% \
            --reverse \
            --scheme=history \
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

# completions
lazy_load_completion yt-dlp /usr/share/bash-completion/completions/yt-dlp
lazy_load_completion tmux /usr/share/bash-completion/completions/tmux
lazy_load_completion git /usr/share/bash-completion/completions/git
complete -cf doas

# binds
bind "set colored-completion-prefix on"
bind "set colored-stats on"
bind -x '"\C-r": fzf_history'
