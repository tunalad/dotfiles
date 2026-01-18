#!/bin/sh
# packages needed:
#  for wayland:
#      grim - screenshot tool for wayland
#      slurp - selection tool for wayland
#      wl-clipboard - clipboard for wayland
#  for x11:
#      maim - screenshot tool for x11
#      xclip - clipboard for x11
#  libnotify - sends notifications

SS_DIR="$HOME/Pictures/screenshots"
SS_PATH="$SS_DIR/Screenshots_$(date +%Y-%m-%d_%H:%M:%S).png"

GRIM_OPTIONS="-c"
MAIM_OPTIONS=""
SLURP=0

# store the options in an array

# process the sorted options
for option in "$@"; do
    case "$option" in
    "--help" | "-h")
        printf "Usage: screenshot.sh [OPTIONS]\n\n"
        printf "OPTIONS\n"

        printf "\t-h, --help\n\t\tPrints this help message and exits.\n"
        printf "\t-nc, --nocursor\n\t\tScreenshots don't capture the cursor.\n"
        printf "\t-r, --region\n\t\tLets you select a region to screenshot.\n"
        exit
        ;;
    "--nocursor" | "-nc")
        GRIM_OPTIONS=""
        MAIM_OPTIONS="--hidecursor $MAIM_OPTIONS"
        ;;
    "--region" | "-r")
        GRIM_OPTIONS="-g - "
        MAIM_OPTIONS="-s "
        SLURP=1
        ;;
    *) ;;
    esac
done

# make screenshots dir if it doesn't exits
mkdir -p "$SS_DIR"

# for wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    if [ $SLURP -eq 0 ]; then
        grim $GRIM_OPTIONS "$SS_PATH" || exit
    elif [ $SLURP -gt 0 ]; then
        slurp | grim $GRIM_OPTIONS "$SS_PATH" || exit
        # but if we only click and not drag, ss the whole window
    fi

    wl-copy <"$SS_PATH"
else
    # for x11
    maim $MAIM_OPTIONS "$SS_PATH" || exit

    xclip -selection clipboard -t image/png <"$SS_PATH"
fi

notify-send --icon "$SS_PATH" "Screenshot captured..." "$SS_PATH"
