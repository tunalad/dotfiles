#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

PATH=$PATH:~/.local/bin/:~/.local/share/npm/bin/:~/.local/share/cargo/bin/:~/.local/scripts/:~/.local/appimage/:~/.local/share/gem/ruby/3.0.0/bin/:~/.local/share/go/bin/:

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/1000"

# Theming
export GTK_THEME="Windows-10-Dark"
#export GTK_THEME="Windows XP Luna"
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
# moving `~/.themes` to `$XDG_DATA_HOME/themes` breaks gtk2 theming, so it must be set this way:
#   - export GTK2_RC_FILES="$XDG_DATA_HOME/themes/$GTK_THEME/gtk-2.0/gtkrc":"$XDG_CONFIG_HOME/gtk-2.0/gtkrc.mine"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc":"$XDG_CONFIG_HOME/gtk-2.0/gtkrc.mine"
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME="gtk2"
# moving `~/.icons` to "$XDG_DATA_HOME/icons/" breaks gtk2 icons as well
# idk how to fix that xd
# also ROX LOVES making .icons in the home, so don't even bother

# Wayland keyboard stuff setup
export XKB_DEFAULT_LAYOUT="rs,us,rs"
export XKB_DEFAULT_VARIANT="latin,,"
#export XKB_DEFAULT_OPTIONS="grp:alt_shift_toggle"

# default apps
#xdg-settings set default-web-browser firefox.desktop
export BROWSER=zen-generic.AppImage
export EDITOR=nvim
export FILE_MANAGER="pcmanfm"
export TERMINAL=alacritty

# other setup exports
#export vblank_mode=0
export SUDO_PROMPT=$'\a'"[sudo] password for %p: "
#export GTK_USE_PORTAL=1
#export XDG_CURRENT_DESKTOP=GTK
export DOOMWADDIR="$XDG_CONFIG_HOME/zandronum"
export CLIPBOARD_NOAUDIO=1

export HISTSIZE=2000
export HISTFILESIZE=2000

# ~/ junk cleaning
export ALSA_CONFIG_PATH="$HOME/.config/alsa/asoundrc"
export LEIN_HOME="$XDG_DATA_HOME/lein"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # COMMENT THIS LINE OUT IF USING LightDM
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
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export _JAVA_AWT_WM_NONREPARENTING=1
export LESSHISTFILE=-
export HISTFILE="${XDG_STATE_HOME}/bash/history"
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export SQLITE_HISTORY="$XDG_CACHE_HOME/sqlite_history"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export ELINKS_CONFDIR="$XDG_CONFIG_HOME/elinks"
export XCURSOR_PATH="/usr/share/icons:${XDG_DATA_HOME}/icons"
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export MINETEST_USER_PATH="$XDG_DATA_HOME"/minetest
export PKG_CACHE_PATH="$XDG_CACHE_HOME"/pkg-cache
export NVM_DIR="$HOME/.local/share/nvm"
export LYNX_CFG="$XDG_CONFIG_HOME"/lynx.cfg
export W3M_DIR="$XDG_STATE_HOME/w3m"
export MIX_XDG="true"

# GUI on login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    #if command -v river >/dev/null 2>&1; then
    #    exec river
    #else
    exec startx
    #fi
fi
