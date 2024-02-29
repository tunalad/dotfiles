#!/bin/bash

readonly MUSIC_DIR="${HOME}/Music"
readonly SONG_DIR="$(dirname "$(mpc --format '%file%' current)")"

ALBUM_ART_PATH=$(find "${MUSIC_DIR}/${SONG_DIR}" -type f -iname 'cover.*' -print -quit)

[[ ! -f $ALBUM_ART_PATH ]] && ALBUM_ART_PATH="$MUSIC_DIR/fallback.png"

DOMINANT_COLORS=$(convert "${ALBUM_ART_PATH}" \
    -scale 50x50! -depth 8 +dither -colors 8 -format "%c" histogram:info: |\
    sed -n 's/^[ ]*\(.*\):.*[#]\([0-9a-fA-F]*\) .*$/\1,#\2/p')

# Assuming the first dominant color is the most relevant for the background
BACKGROUND_COLOR=$(echo "$DOMINANT_COLORS" | head -n 1 | cut -d',' -f2)

dunstify -h string:bgcolor:"$BACKGROUND_COLOR" -r 9993 -t 10000 -i "$ALBUM_ART_PATH" "Now Playing..." "$(mpc --format '%title%\n%artist%\n%album%' current)"
