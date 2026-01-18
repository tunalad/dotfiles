#!/bin/sh

#setkb=$(setxkbmap -query | grep -q "layout:\s\+us") && setxkbmap "rs" "latin" || setxkbmap "us" || setxkbmap "rs"

kblayout=$(setxkbmap -query | grep -e "layout:" | awk {'print $2'})
kbvari=$(setxkbmap -query | grep -e "variant:" | awk {'print $2'})

case "$kblayout $kbvari" in
"rs latin") setxkbmap us ;;
"us ") setxkbmap rs ;;
"rs ") setxkbmap rs latin ;;
*) echo "$kblayout$kbvari" ;;
esac

notify-send --icon=NONE -r 9993 "Keyboard layout changed:" "$(setxkbmap -query | grep -e 'layout:\|variant:')"
