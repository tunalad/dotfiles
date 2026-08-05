# bin paths
for p in \
    "$HOME/.local/bin" \
    "$HOME/.local/scripts" \
    "$HOME/.local/appimage" \
    "$HOME/.local/share/go/bin" \
    "$HOME/.local/share/npm/bin" \
    "$HOME/.local/share/cargo/bin"; do
    PATH="$p:$PATH"
done
export PATH

# xdg base dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# initializing env
. "$SHELL_DIR/env/apps.sh"
. "$SHELL_DIR/env/settings.sh"
. "$SHELL_DIR/env/sprucing.sh"

# other envs
export DOOMWADDIR="$HOME/.local/games/zandronum"

export FAUSTINC="/usr/include/faust"
export FAUSTLIB="/usr/share/faust"

# distro specifics
[ -f "$SHELL_DIR/distro/${DISTRO}_profile.sh" ] && . "$SHELL_DIR/distro/${DISTRO}_profile.sh"
