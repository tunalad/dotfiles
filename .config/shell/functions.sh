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

curl_img() {
    # helps with those data hungry websites links
    url=$(echo "$1" | sed 's/&amp;/\&/g')
    curl --compressed -O "$url"
}

nvm() {
    # lazyload nvm
    unset -f nvm
    . /usr/share/nvm/init-nvm.sh
    nvm "$@"
}

lazy_load_completion() {
    [ -n "$BASH_VERSION" ] || return 0
    local cmd="$1"
    local path="$2"

    eval "_${cmd}_load() {
        . $path
        unset -f _${cmd}_load
        complete -r $cmd
        complete -F _${cmd}_completion $cmd
    }"

    complete -F "_${cmd}_load" "$cmd"
}

if [ -n "$BASH_VERSION" ]; then
eval '
fzf_history() {
    # overengineering the fzf history
    # because fukin void maintainers won'\''t add mcfly to the repo
    # (no apparent reason, they just forgot and the github bot closed it bruhh)
    local selected key

    HISTCONTROL=ignoredups:erasedups
    shopt -s histappend

    selected=$(
        history | sed '\''s/^ *[0-9]\+ *//'\'' | sed '\''s/[[:space:]]\+$//'\'' | tac | awk '\''!seen[$0]++'\'' | fzf \
            --height 100% \
            --reverse \
            --scheme=history \
            --prompt='\''$ '\'' \
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
'
fi
