#!/bin/bash

xrandr --output LVDS-1 --set "scaling mode" "Full"

if zenity --timeout 8 --question --text="Autostart programs?" --no-wrap --ok-label "No" --cancel-label "Yes"; then
	exit 0
else
	megasync &
	cadence --minimized &
	~/.local/bin/./Buttercup-linux-x64.AppImage --no-window &
	#ferdi &
        Ripcord-0.4.29.AppImage &
fi
