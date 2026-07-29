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
