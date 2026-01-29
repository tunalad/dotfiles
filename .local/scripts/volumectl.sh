#!/bin/sh

CARD="default"
MIXER="Master"

drawVol() {
    muteStatus=$(amixer -D $CARD sget $MIXER | grep -o '\[on\]\|\[off\]' | head -n 1)

    getVol=$(amixer -D $CARD sget $MIXER | grep -o '[0-9]*%' | head -n 1)
    getVolTrim=$(echo "$getVol" | sed 's/%$//')
    icon=NONE

    if [ "$muteStatus" = "[off]" ]; then
        getVol="Mute"
        icon=audio-off
    fi

    # elif condition when uncommenting the thing below:
    #if [ $getVolTrim -gt 70 ]; then
    #    icon=audio-volume-high
    #elif [ $getVolTrim -lt 30 ]; then
    #    icon=audio-volume-low
    #else
    #    icon=audio-volume-medium
    #fi

    notify-send --icon=$icon -u low -r 9993 -h int:value:"$getVolTrim" "Volume: ${getVol}" -t 2000
}

drawHelp() {
    echo "Usage: volumectl.sh [OPTION]"
    echo "      -h, --help,                 Help message"
    echo "      -s, --set VOLUME            Set volume"
    echo "      -dec, --decrease            Decrease volume"
    echo "      -inc, --increase,           Increase volume"
    echo "      -rs, --restart              Restart volume (sets it on 100%)"
    echo "      -t, --toggle                Toggle mute"
}

setVol() {
    vol=$1
    if [ -n "$vol" ] && [ "$vol" -ge 0 ]; then
        amixer -D $CARD sset $MIXER unmute >/dev/null
        amixer -D $CARD sset $MIXER $vol% >/dev/null
        drawVol
    else
        echo "Error: Invalid volume level. It must be a number greater than 0."
        exit 1
    fi
}

case $1 in
"-h" | "--help") drawHelp ;;
"-s" | "--set")
    setVol $2
    shift 2
    ;;
"-dec" | "--decrease")
    amixer -D $CARD sset $MIXER unmute >/dev/null
    amixer -D $CARD sset $MIXER 2%- >/dev/null
    drawVol
    ;;
"-inc" | "--increase")
    amixer -D $CARD sset $MIXER unmute >/dev/null
    amixer -D $CARD sset $MIXER 2%+ >/dev/null
    drawVol
    ;;
"-rs" | "-res" | "--restart")
    amixer -D $CARD sset $MIXER unmute >/dev/null
    amixer -D $CARD sset $MIXER 100% >/dev/null
    drawVol
    ;;
"-t" | "--toggle")
    amixer -D $CARD sset $MIXER toggle >/dev/null
    drawVol
    ;;
*)
    amixer -D $CARD sget $MIXER
    drawVol
    ;;
esac
