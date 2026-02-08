#!/bin/bash

autorun=(
    "megasync &"
    # "cadence --minimized &" # JACK (alsa/pulse)
    #"~./local/appimage/Buttercup-linux-x86_64.AppImage --no-window &"
    #"ferdi &"
    #"Ripcord-0.4.29.AppImage &"
    #"dissent &"
    #"abaddon &"
    #"qpwgraph -m &"
    #"conky &"
    #"gajim &"
    #"activate-linux -s 0.8 -d"
)

[ ${#autorun[@]} -eq 0 ] && exit 0

if zenity --timeout 8 --question --text="Autostart programs?" --no-wrap --ok-label "No" --cancel-label "Yes"; then
    exit 0
else
    for app in "${autorun[@]}"; do
        eval "$app"
    done
fi
