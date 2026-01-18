#!/bin/sh
#
# Start a composition manager.
# (xcompmgr in this case)

comphelp() {
    echo "Composition Manager:"
    echo "   (re)start: COMP"
    echo "   toggle:    COMP -t"
    echo "   stop:      COMP -s"
    echo "   query:     COMP -q"
    echo "              returns 0 if composition manager is running, else 1"
    exit
}

checkcomp() {
    pgrep xcompmgr >/dev/null 2>&1
}

stopcomp() {
    checkcomp && killall xcompmgr
}

startcomp() {
    stopcomp
    # Example settings only. Replace with your own.
    xcompmgr &
    exit
}

togglecomp() {
    compstat=$(pidof xcompmgr)
    if [ -z $compstat ]; then
        notify-send -r 9993 -i ~/Pictures/xorg-logo.png "Xcompmgr" "started" && startcomp
    else
        notify-send -r 9993 -i ~/Pictures/xorg-logo.png "Xcompmgr" "stopped" && stopcomp
    fi
}

case "$1" in
"") startcomp ;;
"-q") checkcomp ;;
"-s")
    stopcomp
    exit
    ;;
"-t") togglecomp ;;
*) comphelp ;;
esac
