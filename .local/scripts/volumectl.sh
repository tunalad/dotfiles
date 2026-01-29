#!/bin/sh
# at this point I should probably just write my own program that handles volume

# get audio system
if command -v wpctl >/dev/null 2>&1 && wpctl status >/dev/null 2>&1; then
    AUDIO_SYSTEM="pipewire"
elif command -v pactl >/dev/null 2>&1 && pactl info >/dev/null 2>&1; then
    AUDIO_SYSTEM="pulseaudio"
    DEFAULT_SINK=$(pactl list sinks | awk '/^Sink/{getline; getline; sub(/^[ \t]+Name: /, ""); print}' | sort | head -n 1)
else
    AUDIO_SYSTEM="alsa"
    CARD="default"
    MIXER="Master"
fi

getVolume() {
    if [ "$AUDIO_SYSTEM" = "pipewire" ]; then
        volInfo=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
        if echo "$volInfo" | grep -q "MUTED"; then
            echo "0|muted"
        else
            volDecimal=$(echo "$volInfo" | awk '{print $2}')
            volPercent=$(echo "$volDecimal" | awk '{printf "%d", $1 * 100}')
            echo "$volPercent|unmuted"
        fi
    elif [ "$AUDIO_SYSTEM" = "pulseaudio" ]; then
        muteStatus=$(pactl get-sink-mute $DEFAULT_SINK)
        volPercent=$(pactl get-sink-volume $DEFAULT_SINK | awk '{print $5}' | sed 's/%$//')
        if echo "$muteStatus" | grep -q "yes"; then
            echo "$volPercent|muted"
        else
            echo "$volPercent|unmuted"
        fi
    else
        muteStatus=$(amixer -D $CARD sget $MIXER | grep -o '\[on\]\|\[off\]' | head -n 1)
        volPercent=$(amixer -D $CARD sget $MIXER | grep -o '[0-9]*%' | head -n 1 | sed 's/%$//')
        if [ "$muteStatus" = "[off]" ]; then
            echo "$volPercent|muted"
        else
            echo "$volPercent|unmuted"
        fi
    fi
}

setVolume() {
    vol=$1

    if [ "$AUDIO_SYSTEM" = "pipewire" ]; then
        volDecimal=$(echo "$vol" | awk '{printf "%.2f", $1 / 100}')
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        wpctl set-volume @DEFAULT_AUDIO_SINK@ $volDecimal
    elif [ "$AUDIO_SYSTEM" = "pulseaudio" ]; then
        pactl set-sink-mute $DEFAULT_SINK no
        pactl set-sink-volume $DEFAULT_SINK $vol%
    else
        amixer -D $CARD sset $MIXER unmute >/dev/null 2>&1
        amixer -D $CARD sset $MIXER $vol% >/dev/null
    fi
}

adjustVolume() {
    amount=$1
    direction=$2 # +/-

    if [ "$AUDIO_SYSTEM" = "pipewire" ]; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        wpctl set-volume @DEFAULT_AUDIO_SINK@ ${amount}%${direction}
    elif [ "$AUDIO_SYSTEM" = "pulseaudio" ]; then
        pactl set-sink-mute $DEFAULT_SINK no
        if [ "$direction" = "+" ]; then
            pactl set-sink-volume $DEFAULT_SINK +${amount}%
        else
            pactl set-sink-volume $DEFAULT_SINK -${amount}%
        fi
    else
        amixer -D $CARD sset $MIXER unmute >/dev/null 2>&1
        amixer -D $CARD sset $MIXER ${amount}%${direction} >/dev/null
    fi
}

toggleMute() {
    if [ "$AUDIO_SYSTEM" = "pipewire" ]; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    elif [ "$AUDIO_SYSTEM" = "pulseaudio" ]; then
        pactl set-sink-mute $DEFAULT_SINK toggle
    else
        amixer -D $CARD sset $MIXER toggle >/dev/null
    fi
}

drawVol() {
    volData=$(getVolume)
    getVolTrim=$(echo "$volData" | cut -d'|' -f1)
    muteState=$(echo "$volData" | cut -d'|' -f2)

    icon=NONE
    if [ "$muteState" = "muted" ]; then
        getVol="Mute"
        icon=audio-off
        echo "🔇MUTE"
    else
        getVol="${getVolTrim}%"
        echo "$getVolTrim%"
    fi

    [ "$1" = "quiet" ] || notify-send --icon=$icon -u low -r 9993 -h int:value:"$getVolTrim" "Volume: ${getVol}" -t 2000
}

drawHelp() {
    echo "Usage: volumectl.sh [OPTION]"
    echo "      -h, --help,                 Help message"
    echo "      -s, --set VOLUME            Set volume"
    echo "      -dec, --decrease [AMOUNT]   Decrease volume (default: 2%)"
    echo "      -inc, --increase [AMOUNT]   Increase volume (default: 2%)"
    echo "      -rs, --restart              Restart volume (sets it to 100%)"
    echo "      -t, --toggle                Toggle mute"
    echo ""
    echo "Detected audio system: $AUDIO_SYSTEM"
}

case $1 in
"-h" | "--help")
    drawHelp
    ;;
"-s" | "--set")
    if [ -n "$2" ] && [ "$2" -ge 0 ]; then
        setVolume $2
        drawVol
    else
        echo "Error: Invalid volume level. It must be a number greater than 0."
        exit 1
    fi
    shift 2
    ;;
"-dec" | "--decrease")
    amount=${2:-2}
    adjustVolume $amount "-"
    drawVol
    ;;
"-inc" | "--increase")
    amount=${2:-2}
    adjustVolume $amount "+"
    drawVol
    ;;
"-rs" | "-res" | "--restart")
    setVolume 100
    drawVol
    ;;
"-t" | "--toggle")
    toggleMute
    drawVol
    ;;
*)
    drawVol quiet
    ;;
esac
