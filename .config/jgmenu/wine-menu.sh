#!/bin/bash

WINE_DIR="$HOME/.local/share/applications/wine/Programs"
[ ! -d "$WINE_DIR" ] && exit 0

ICON_BASE="$HOME/.local/share/icons/hicolor"

tmpdir=$(mktemp -d) || exit 1
trap 'rm -rf "$tmpdir"' EXIT

mkdir -p "$tmpdir/content" "$tmpdir/subdir" "$tmpdir/valid"

declare -A ICON_INDEX
while IFS= read -r line; do
    local_name="${line##*/}"
    local_name="${local_name%.png}"
    ICON_INDEX["$local_name"]="$line"
done < <(find "$ICON_BASE" -type f -name "*.png" 2>/dev/null | sort -t/ -k7 -n)

sanitize() {
    echo "${1//\//%}"
}

make_tag() {
    local input="$1"
    local result=""
    local i char
    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"
        case "$char" in
            [a-zA-Z0-9]) result+="$char" ;;
            *) result+="_" ;;
        esac
    done
    echo "$result"
}

csv_quote() {
    case "$1" in
        *,*) echo "\"\"\"$1\"\"\"" ;;
        *)   echo "$1" ;;
    esac
}

escape_xml() {
    echo "${1//&/&amp;}"
}

process_structure() {
    local current_dir="$1"
    local tag_prefix="$2"
    local sp
    sp=$(sanitize "$current_dir")

    local entry folder stag ssp folder_esc
    for entry in "$current_dir"/*; do
        [ -e "$entry" ] || [ -L "$entry" ] || continue
        if [ -d "$entry" ]; then
            folder="${entry##*/}"
            stag="${tag_prefix}_$(make_tag "$folder")"
            ssp=$(sanitize "$entry")

            process_structure "$entry" "$stag"

            if [ -f "$tmpdir/valid/$ssp" ]; then
                folder_esc=$(escape_xml "$folder")
                folder_esc=$(csv_quote "$folder_esc")
                printf '%s\n' "${folder_esc},^checkout(${stag}),folder" >> "$tmpdir/subdir/$sp"
                : >> "$tmpdir/valid/$sp"
            fi
        else
            case $entry in
                *.desktop)
                    local name= exec_cmd= icon=
                    local key value line

                    while IFS='=' read -r key value || [ -n "$key" ]; do
                        key="${key%"${key##*[![:space:]]}"}"
                        value="${value%"${value##*[![:space:]]}"}"
                        case "$key" in
                            Name) [ -z "$name" ] && name="$value" ;;
                            Exec) [ -z "$exec_cmd" ] && exec_cmd="${value//\\\\/\\}" ;;
                            Icon) [ -z "$icon" ] && icon="$value" ;;
                        esac
                    done < "$entry"

                    [ -z "$name" ] || [ -z "$exec_cmd" ] && continue

                    local final_icon=wine
                    if [ -n "$icon" ]; then
                        icon="${icon//\"/}"
                        icon="${icon//\\//}"
                        local lookup="${icon%.png}"
                        local resolved="${ICON_INDEX[$lookup]:-}"
                        if [ -n "$resolved" ]; then
                            final_icon="$resolved"
                        elif [ -f "$icon" ]; then
                            final_icon="$icon"
                        fi
                    fi

                    name=$(escape_xml "$name")
                    name=$(csv_quote "$name")
                    exec_cmd=$(csv_quote "$exec_cmd")

                    printf '%s\n' "${name},${exec_cmd},${final_icon}" >> "$tmpdir/content/$sp"
                    : >> "$tmpdir/valid/$sp"
                    ;;
            esac
        fi
    done
}

render_menu() {
    local current_dir="$1"
    local tag_prefix="$2"
    local sp
    sp=$(sanitize "$current_dir")

    [ -f "$tmpdir/valid/$sp" ] || return

    [ -f "$tmpdir/subdir/$sp" ] && cat "$tmpdir/subdir/$sp"
    [ -f "$tmpdir/content/$sp" ] && cat "$tmpdir/content/$sp"

    local entry esp folder stag
    for entry in "$current_dir"/*; do
        [ -e "$entry" ] || [ -L "$entry" ] || continue
        if [ -d "$entry" ]; then
            esp=$(sanitize "$entry")
            if [ -f "$tmpdir/valid/$esp" ]; then
                folder="${entry##*/}"
                stag="${tag_prefix}_$(make_tag "$folder")"
                printf '%s\n' "^tag(${stag})"
                render_menu "$entry" "$stag"
            fi
        fi
    done
}

process_structure "$WINE_DIR" "wine"
printf '%s\n' "^tag(wine_root)"
render_menu "$WINE_DIR" "wine"
