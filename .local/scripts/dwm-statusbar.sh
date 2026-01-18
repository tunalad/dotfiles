#!/bin/sh

battery() {
    for battery in /sys/class/power_supply/BAT?*; do
        [ -n "${capacity+x}" ] && printf " "

        case "$(cat "$battery/status" 2>&1)" in
        "Full") status="" ;;
        "Discharging") status="" ;;
        "Charging") status="" ;;
        "Not charging") status="🛑" ;;
        "Unknown") status="" ;;
        *) exit 1 ;;
        esac

        capacity="$(cat "$battery/capacity" 2>&1)"

        if [ "$status" = "" ] && [ "$capacity" -le 25 ]; then
            warn=""
        fi

        printf "%s%s%d%%" "$status" "$warn" "$capacity"
        unset warn
    done && printf '\n'
}

clock() {
    clock=$(date '+%R')
    clockH=$(echo "$clock" | cut -c1-2)
    case "$clockH" in
    "00" | "12") icon="󱑖" ;;
    "01" | "13") icon="󱑋" ;;
    "02" | "14") icon="󱑌" ;;
    "03" | "15") icon="󱑍" ;;
    "04" | "16") icon="󱑎" ;;
    "05" | "17") icon="󱑏" ;;
    "06" | "18") icon="󱑐" ;;
    "07" | "19") icon="󱑑" ;;
    "08" | "20") icon="󱑒" ;;
    "09" | "21") icon="󱑓" ;;
    "10" | "22") icon="󱑔" ;;
    "11" | "23") icon="󱑕" ;;
    esac
    date "+%d %b %Y|$icon%R:%S"
}

volume() {
    DEFAULT_SINK=$(pactl info | awk -F': ' '/Default Sink:/{print $2}')
    if [ "$(pactl get-sink-mute "$DEFAULT_SINK" | awk '{print $2}')" = "yes" ]; then
        echo "🔇MUTE"
        exit
    fi

    vol=$(pactl get-sink-volume "$DEFAULT_SINK" | awk '{print $5}')
    vol=${vol%?}

    if pactl list sinks | grep -q "Active Port: analog-output-headphones"; then
        icon="🎧"
    elif [ "$vol" -gt 70 ]; then
        icon="🔊"
    elif [ "$vol" -lt 30 ]; then
        icon="🔈"
    else
        icon="🔉"
    fi

    echo "$icon$vol%"
}

cputemp() {
    icon=""
    [ "$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)" = "powersave" ] && icon=""
    echo -n "$icon" && (sensors | awk '/Core 0/ {print $3}')
}

kblayout() {
    lv=$(setxkbmap -query | grep -e "layout" | awk '{print $2}')$(setxkbmap -query | grep -e "variant" | awk '{print $2}')

    case "$lv" in
    "rslatin") echo " SRB" ;;
    "us") echo " EN-US" ;;
    "rs") echo " СРБ" ;;
    *) echo " ERROR" ;;
    esac
}

jack_status() {
    status=$(jack_control status | sed -n 2p)
    [ $status = "started" ] && echo "JACK  |"
}

mailbox() {
    MAILBOXES=$(ls ~/.local/share/mail)
    mail_sum=0

    for mail in $MAILBOXES; do
        count=$(ls ~/.local/share/mail/"$mail"/INBOX/new 2>/dev/null | wc -l)
        mail_sum=$((mail_sum + count))
    done

    [ $mail_sum != 0 ] && echo " $mail_sum|"
}

ncs() {
    lockStatus=$(xset q | awk '/Caps/ {print $4, $8, $12}')

    counter=0
    anyLockOn=false

    for i in $lockStatus; do
        if [ $i = "on" ]; then
            anyLockOn=true
            case $counter in
            0) echo -n "[CAP]" ;;
            1) echo -n "[NUM]" ;;
            2) echo -n "[SCR]" ;;
            esac
        fi
        counter=$((counter + 1))
    done

    if $anyLockOn; then
        echo -n "|"
    fi
}

newsboat() {
    # newsboat -x print-unread is too slow
    # so we're taking count directly from the cache file
    CACHE_PATH="$HOME/.local/share/newsboat/cache.db"
    articles=$(sqlite3 $CACHE_PATH "SELECT COUNT(*) FROM rss_item WHERE unread = TRUE")

    if [ $articles -gt "0" ]; then
        echo -n " $articles|"
    fi
}

tmux_sessions() {
    sessions=$(tmux list-sessions 2>/dev/null | wc -l)

    if [ $sessions -gt "0" ]; then
        echo " $sessions|"
    fi
}

while :; do
    #xsetroot -name "$(mailbox)$(ncs)$(clock)|$(volume)|$(battery)|$(cputemp)|$(kblayout)"
    dwm -s "$(newsboat)$(mailbox)$(tmux_sessions)$(ncs)$(clock)|$(volume)|$(battery)|$(cputemp)|$(kblayout)"
    sleep 0.5
done
