#!/usr/bin/bash

DEFAULT_SINK="alsa_output.pci-0000_00_1b.0.analog-stereo"

drawVol(){
	getVol=$(pactl get-sink-volume $DEFAULT_SINK | awk '{print $5}')
	getVolTrim=${getVol::-1}
	dunstify -u low -r 9993 -h int:value:"$getVolTrim" "Volume: ${getVol}" -t 2000
}

drawHelp(){
    echo "Usage: volumectl.sh [OPTION]"
    echo "      -h, --help,                 Help message"
    echo "      -dec, --decrease            Decrease volume"
    echo "      -inc, --increase,           Increase volume"
    echo "      -rs, --restart              Restart volume (sets it on 100%)"
    echo "      -t, --toggle                Toggle mute"
}

case $1 in
	"-h" | "--help") drawHelp ;;
	"-dec" | "--decrease")           pactl set-sink-mute $DEFAULT_SINK no; pactl set-sink-volume $DEFAULT_SINK -2%; drawVol ;;
	"-inc" | "--increase")           pactl set-sink-mute $DEFAULT_SINK no; pactl set-sink-volume $DEFAULT_SINK +2%; drawVol ;;
	"-rs" | "-res" | "--restart")    pactl set-sink-mute $DEFAULT_SINK no; pactl set-sink-volume $DEFAULT_SINK 100%; drawVol ;;
	"--toggle" | "-t")               pactl set-sink-mute $DEFAULT_SINK toggle; drawVol ;;
	#$1 =~ ^[0-9]+$) pactl set-sink-mute @DEFAULT_SINK@ $1 ;;
	*) pactl get-sink-volume $DEFAULT_SINK; drawVol ;;
esac
