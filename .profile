#
# ~/.profile
#

export SHELL_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/shell"

. "$SHELL_DIR/env/init.sh"
. "$SHELL_DIR/login.sh"

[ -f ~/.shellrc ] && . ~/.shellrc

# GUI on login
if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
    #if command -v river >/dev/null 2>&1; then
    #    exec river
    #else
    exec startx
    #fi
fi
