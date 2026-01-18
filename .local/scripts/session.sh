#!/bin/sh

#pick=$(printf "Power off\nReboot\nLock\nLogout" | rofi -dmenu -i)
pick=$(echo " Power off\n Reboot\n Lock\n" | dmenu -i -l 5)
#pick=$(echo -e " Lock\n Power off\n Reboot" | dmenu -i -l 5)

case $pick in
" Power off") shutdown now ;;
" Reboot") reboot ;;
" Lock") slock ;;
" Logout") killall dwm ;;
*) exit 1 ;;
esac
