case "$DISTRO" in void) ;; *) return ;; esac

if ! pgrep -f "runsvdir.*$HOME/.config/service" >/dev/null 2>&1; then
    setsid runsvdir -P "$HOME/.config/service" &
    disown 2>/dev/null
fi
