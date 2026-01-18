#!/bin/sh

DEFAULT_SINK=$(pactl list sinks | awk '/^Sink/{getline; getline; sub(/^[ \t]+Name: /, ""); print}' | sort | head -n 1)

drawVol() {
    muteStatus=$(pactl get-sink-mute $DEFAULT_SINK toggle)
    getVol=$(pactl get-sink-volume $DEFAULT_SINK | awk '{print $5}')
    getVolTrim=$(echo "$getVol" | sed 's/%$//')
    icon=NONE

    if [ $muteStatus = "Mute: yes" ]; then
        getVol="Mute"
        icon=audio-off
    fi

    # elif condition when uncommenting the thing below:
    #if [ $getVolTrim -gt 70 ]; then
    #    icon=audio-volume-high
    #elif [  $getVolTrim -lt 30 ]; then
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
        pactl set-sink-mute $DEFAULT_SINK no
        pactl set-sink-volume $DEFAULT_SINK $vol%
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
    pactl set-sink-mute $DEFAULT_SINK no
    pactl set-sink-volume $DEFAULT_SINK -2%
    drawVol
    ;;
"-inc" | "--increase")
    pactl set-sink-mute $DEFAULT_SINK no
    pactl set-sink-volume $DEFAULT_SINK +2%
    drawVol
    ;;
"-rs" | "-res" | "--restart")
    pactl set-sink-mute $DEFAULT_SINK no
    pactl set-sink-volume $DEFAULT_SINK 100%
    drawVol
    ;;
"-t" | "--toggle")
    pactl set-sink-mute $DEFAULT_SINK toggle
    drawVol
    ;;
#$1 =~ ^[0-9]+$) pactl set-sink-mute @DEFAULT_SINK@ $1 ;;
*)
    pactl get-sink-volume $DEFAULT_SINK
    drawVol
    ;;
esac
