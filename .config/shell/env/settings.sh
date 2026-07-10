# other
export SUDO_PROMPT=$'\a'"[sudo] password for %p: "
export CLIPBOARD_NOAUDIO=1
export HISTSIZE=20000
export HISTFILESIZE=20000

# theming
export GTK_THEME="Windows-10-Dark"
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
# moving `~/.themes` to `$XDG_DATA_HOME/themes` breaks gtk2 theming, so it must be set this way:
#   - export GTK2_RC_FILES="$XDG_DATA_HOME/themes/$GTK_THEME/gtk-2.0/gtkrc":"$XDG_CONFIG_HOME/gtk-2.0/gtkrc.mine"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc":"$XDG_CONFIG_HOME/gtk-2.0/gtkrc.mine"
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
#export QT_QPA_PLATFORMTHEME="gtk2"
export QT_QPA_PLATFORMTHEME="qt6ct"
# moving `~/.icons` to "$XDG_DATA_HOME/icons/" breaks gtk2 icons as well
# idk how to fix that xd
# also ROX LOVES making .icons in the home, so don't even bother

# Wayland keyboard stuff setup
export XKB_DEFAULT_LAYOUT="rs,us,rs"
export XKB_DEFAULT_VARIANT="latin,,"
#export XKB_DEFAULT_OPTIONS="grp:alt_shift_toggle"
