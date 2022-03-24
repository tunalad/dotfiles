#!/usr/bin/bash
#packages you need: 
# 	dunst
#	brightnessctl


function showPerc(){
	getPerc=$(brightnessctl | grep 'Current' | awk '{print $4}' | tail -c +2 | head -c -2)
	dunstify -u low -r 9993 -h int:value:"${getPerc::-1}" "Brightness: ${getPerc}" -t 2000
}

case $1 in 
	"-dec") brightnessctl set 2%-; showPerc ;;
	"-inc") brightnessctl set +2%; showPerc ;;
	*) brightnessctl ; showPerc;;
esac
