#!/bin/bash

helpmenu(){
	echo "help: 		-h"
	echo "toggle: 	-t"
	echo "current mode: 	-m"
	echo "performance: 	-p"
	echo "power save: 	-s"
}

performance(){
	sudo cpupower frequency-set -g performance
}

powersave(){
	sudo cpupower frequency-set -g powersave
}

cpustatus(){
	local status=$(cpupower frequency-info | awk '/The governor/ {print $3}')
	echo $status
}

toggle(){
	if [[ $(cpustatus) == '"powersave"' ]]; then
		notify-send "cpupower" "performance mode" && performance
	else
		notify-send "cpupower" "powersave mode" && powersave
	fi
}

case "$1" in
	"-t") toggle ;;
	"-m") cpustatus ;;
	"-p") performance ;;
	"-s") powersave ;;
	*) helpmenu ;;
esac
