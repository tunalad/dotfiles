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

# completions
lazy_load_completion yt-dlp /usr/share/bash-completion/completions/yt-dlp
lazy_load_completion tmux /usr/share/bash-completion/completions/tmux
lazy_load_completion git /usr/share/bash-completion/completions/git
complete -cf doas

# binds
bind "set colored-completion-prefix on"
bind "set colored-stats on"

# fzf
export FZF_CTRL_R_OPTS="--height 100% --reverse --prompt='$ ' --no-info --border=none --margin=3,2 --padding=2 --exact"
eval "$(fzf --bash)"
