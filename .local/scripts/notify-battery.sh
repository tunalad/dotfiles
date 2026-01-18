#!/bin/bash

DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export XDG_RUNTIME_DIR="/run/user/1000"
HOSTNAME=$(uname -n)
NTFY_TOPIC="a9ef9f905286e6d16d60aecaa4b034a2"

acpi -b | awk -F'[,%]' '{print $2, $4, $5}' | {
    read -r capacity timeleft status

    [ "$capacity" -lt 25 ] && [ "$status" = "remaining" ] && {
        notify-send --icon=NONE -r 9993 -t 10000 -u critical "Battery low" "$capacity% of battery left.\nTime left: $timeleft."
        [ $NTFY_TOPIC ] &&
            curl \
                -H "Title: [$HOSTNAME] Battery low" \
                -H "Priority: urgent" \
                -H "Tags: rotating_light" \
                -d "$capacity% of battery left. Time left: $timeleft." ntfy.sh/$NTFY_TOPIC
    }
}
