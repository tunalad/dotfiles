#!/bin/bash
# packages needed:
# 	maim - screenshot tool
# 	xclip - copying ss to clipboard
# 	mpv - media player, used here to play a sound

SS_PATH="$HOME/Pictures/screenshots/Screenshots_$(date +%Y-%m-%d_%H:%M:%S).png"

case "$1" in
	"--region") maim -s "$SS_PATH" || exit ;;
	*) maim "$SS_PATH" || exit ;;
esac

# copy screenshot to clipboard
xclip -selection clipboard -t image/png -i "$SS_PATH"

# play a funny sound
mpv ~/.scripts/sfx/camera-shutter-click-01.mp3
