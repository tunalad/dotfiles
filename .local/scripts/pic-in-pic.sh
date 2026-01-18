#!/bin/bash

WINDOW_ID=$(xwininfo | grep "Window id:" | awk '{print $4}')

if [ -z "$WINDOW_ID" ]; then
    echo "No window selected"
    exit 1
fi

# get window title
WINDOW_TITLE=$(xdotool getwindowname "$WINDOW_ID" 2>/dev/null || echo "Window Preview")

# get dimensions
SCREEN_WIDTH=$(xrandr | grep primary | grep -oP '\d+x\d+' | cut -d'x' -f1)
SCREEN_HEIGHT=$(xrandr | grep primary | grep -oP '\d+x\d+' | cut -d'x' -f2)

# If no primary display, get first connected display
if [ -z "$SCREEN_WIDTH" ]; then
    SCREEN_WIDTH=$(xrandr | grep " connected" | head -1 | grep -oP '\d+x\d+' | cut -d'x' -f1)
    SCREEN_HEIGHT=$(xrandr | grep " connected" | head -1 | grep -oP '\d+x\d+' | cut -d'x' -f2)
fi

# calc preview size (25% of screen)
PREVIEW_WIDTH=$((SCREEN_WIDTH * 25 / 100))
PREVIEW_HEIGHT=$((SCREEN_HEIGHT * 25 / 100))

# display with ffplay
ffplay -f x11grab \
    -window_id "$WINDOW_ID" \
    -framerate 10 \
    -i :0.0 \
    -vf "scale=${PREVIEW_WIDTH}:${PREVIEW_HEIGHT}:flags=lanczos" \
    -window_title "PiP: $WINDOW_TITLE" \
    -fflags nobuffer \
    -flags low_delay \
    -probesize 32 \
    -analyzeduration 0
