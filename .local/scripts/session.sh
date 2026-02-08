#!/bin/sh

INIT=$(basename $(cat /proc/1/comm))

auth_required() {
    notify-send "Authentication Required" "Power management requires password. Please check polkit rules."
    pass=$(zenity --password --title="Authentication Required")
    echo "$pass"
}

call_shutdown() {
    if [ "$INIT" = "systemd" ]; then
        systemctl poweroff || {
            pass=$(auth_required)
            echo "$pass" | sudo -S systemctl poweroff
        }
    else
        loginctl poweroff || {
            pass=$(auth_required)
            echo "$pass" | sudo -S loginctl poweroff
        }
    fi
}

call_reboot() {
    if [ "$INIT" = "systemd" ]; then
        systemctl reboot || {
            pass=$(auth_required)
            echo "$pass" | sudo -S systemctl reboot
        }
    else
        loginctl reboot || {
            pass=$(auth_required)
            echo "$pass" | sudo -S loginctl reboot
        }
    fi
}

#pick=$(echo " Power off\n Reboot\n Lock\n Logout" | dmenu -i -l 5)
pick=$(echo " Power off\n Reboot\n Lock" | dmenu -i -l 5)

case $pick in
" Power off") call_shutdown ;;
" Reboot") call_reboot ;;
" Lock") slock ;;
" Logout") killall dwm ;;
*) exit 1 ;;
esac
