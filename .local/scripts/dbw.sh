#!/bin/sh

# dependencies:
#   - rbw (rust bitwarden client)
#   - dmenu (menu)
#   - xclip (clipboard manager)
#   - zenity (for password input)

# function to check if rbw is unlocked
is_rbw_unlocked() {
    rbw list >/dev/null 2>&1
}

# check if rbw is unlocked
if ! is_rbw_unlocked; then
    # unlock rbw with zenity
    pass=$(zenity --password --title="Unlock Bitwarden")
    [ -z "$pass" ] && exit 1

    if ! echo "$pass" | rbw unlock; then
        zenity --error --text="Failed to unlock vault"
        exit 1
    fi
fi

# show main menu
action=$(printf "get login\nsync vault\ngenerate password\nlock vault" | dmenu -i -p "Bitwarden:")
[ -z "$action" ] && exit 0

case "$action" in
"get login")
    # get items and show in dmenu
    choice=$(rbw list | dmenu -i -l 20)
    [ -z "$choice" ] && exit 0

    # ask what to copy
    copy_choice=$(printf "username\npassword\nshow details" | dmenu -i -p "Copy:")
    [ -z "$copy_choice" ] && exit 0

    case "$copy_choice" in
    username)
        if username=$(rbw get --username "$choice" 2>/dev/null); then
            echo -n "$username" | xclip -selection c
            notify-send "Copied" "Username copied to clipboard"
        else
            notify-send "Error" "Could not retrieve username"
        fi
        ;;
    password)
        if password=$(rbw get "$choice" 2>/dev/null); then
            echo -n "$password" | xclip -selection c
            notify-send "Copied" "Password copied to clipboard"
        else
            notify-send "Error" "Could not retrieve password"
        fi
        ;;
    "show details")
        if item_details=$(rbw get --full "$choice" 2>/dev/null); then
            # Parse the output (rbw --full gives key=value pairs)
            echo "$item_details" | zenity --text-info --title="$choice Details" --width=400 --height=200
        else
            notify-send "Error" "Could not retrieve item details"
        fi
        ;;
    esac
    ;;

"sync vault")
    if rbw sync; then
        notify-send "Bitwarden" "Vault synced successfully"
    else
        notify-send "Bitwarden" "Sync failed"
    fi
    ;;

"generate password")
    # ask for password options
    type=$(printf "strong\nweak\nmemorable" | dmenu -i -p "Password type:")
    [ -z "$type" ] && exit 0

    case "$type" in
    "strong")
        # rbw generate with strong options
        if pwd=$(rbw generate 16 2>/dev/null); then
            echo -n "$pwd" | xclip -selection c
            notify-send "Generated" "Password copied to clipboard"
        else
            notify-send "Error" "Failed to generate password"
        fi
        ;;
    "weak")
        if pwd=$(rbw generate 8 --no-symbols 2>/dev/null); then
            echo -n "$pwd" | xclip -selection c
            notify-send "Generated" "Password copied to clipboard"
        else
            notify-send "Error" "Failed to generate password"
        fi
        ;;
    "memorable")
        # rbw doesn't have word-based generation like bw, so create a longer alphanumeric
        if pwd=$(rbw generate 12 --no-symbols 2>/dev/null); then
            echo -n "$pwd" | xclip -selection c
            notify-send "Generated" "Password copied to clipboard"
        else
            notify-send "Error" "Failed to generate password"
        fi
        ;;
    esac
    ;;

"lock vault")
    if rbw lock; then
        notify-send "Bitwarden" "Vault locked"
    else
        notify-send "Bitwarden" "Failed to lock vault"
    fi
    ;;
esac
