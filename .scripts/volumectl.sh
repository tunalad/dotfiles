#!/usr/bin/bash

drawVol(){
	getVol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
	getVolTrim=${getVol::-1}
	dunstify -u low -r 9993 -h int:value:"$getVolTrim" "Volume: ${getVol}" -t 2000
}

case $1 in
	"-h" | "--help") echo "help stuff idk" ;;
	"-dec") pactl set-sink-mute @DEFAULT_SINK@ no; pactl set-sink-volume @DEFAULT_SINK@ -2%; drawVol ;;
	"-inc") pactl set-sink-mute @DEFAULT_SINK@ no; pactl set-sink-volume @DEFAULT_SINK@ +2%; drawVol ;;
	"-rs" | "-res") pactl set-sink-volume @DEFAULT_SINK@ 100%; drawVol ;;
	"-toggle" | "-t") pactl set-sink-mute @DEFAULT_SINK@ toggle; drawVol ;;
	#$1 =~ ^[0-9]+$) pactl set-sink-mute @DEFAULT_SINK@ $1 ;;
	*) pactl get-sink-volume @DEFAULT_SINK@; drawVol ;;
esac
