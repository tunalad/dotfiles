#!/usr/bin/bash

#pick=$(printf "Power off\nReboot\nLock\nLogout" | rofi -dmenu -i)
pick=$(echo -e " Power off\n Reboot\n Lock\n Logout" | dmenu -i -l 5)

case $pick in
	" Power off") shutdown now ;;
	" Reboot") reboot ;;
	" Lock") slock ;;
	" Logout") killall dwm ;;
	*) exit 1 ;;
esac
