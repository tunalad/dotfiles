#!/bin/sh
# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=dwm

exec dwm
#exec awesome
#exec bspwm
