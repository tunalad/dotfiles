#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

awk '{print "uptime: " int($1/3600)":"int(($1%3600)/60)":"int($1%60)}' /proc/uptime

PATH=$PATH:~/.scripts:~/.local/bin/:~/.local/share/npm/bin/

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/1000"

# env_vars
export myIP=$(curl ifconfig.me/ip)
export EDITOR=nvim
#export BROWSER=firefox
xdg-settings set default-web-browser firefox.desktop
export TERMINAL=alacritty
export TERM=xterm-256color
export SUDO_PROMPT=$'\a'"[sudo] password for %p: "

export DOOMWADDIR="$XDG_CONFIG_HOME/zandronum"

# ~/ junk cleaning
export ALSA_CONFIG_PATH="$HOME/.config/alsa/asoundrc"
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export LEIN_HOME="$XDG_DATA_HOME/lein"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # COMMENT THIS LINE OUT IF YOU USE LightDM
export SSB_HOME="$XDG_DATA_HOME/zoom"
export GOPATH="$XDG_DATA_HOME/go"
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/notmuchrc"
export NMBGIT="$XDG_DATA_HOME/notmuch/nmbug"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export STACK_ROOT="$XDG_DATA_HOME/stack"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export FCEUX_HOME="$XDG_CONFIG_HOME/fceux"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export _JAVA_AWT_WM_NONREPARENTING=1
export LESSHISTFILE=-
export HISTFILE="${XDG_STATE_HOME}/bash/history"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export SQLITE_HISTORY="$XDG_CACHE_HOME/sqlite_history"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export ELINKS_CONFDIR="$XDG_CONFIG_HOME/elinks"
export XCURSOR_PATH="/usr/share/icons:${XDG_DATA_HOME}/icons"

# GUI on login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
fi

