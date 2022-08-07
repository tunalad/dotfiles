#!/bin/bash

readonly MUSIC_DIR="${HOME}/Music"
readonly SONG_DIR="$(dirname "$(mpc --format '%file%' current)")"
readonly ALBUM_ART_PATH="${MUSIC_DIR}/${SONG_DIR}/cover.jpg"

DOMINANT_COLORS=$(convert "${ALBUM_ART_PATH}" -scale 50x50! -depth 8 +dither -colors 8 -format "%c" histogram:info: |\
    sed -n 's/^[ ]*\(.*\):.*[#]\([0-9a-fA-F]*\) .*$/\1,#\2/p')
BACKGROUND_COLOR=($DOMINANT_COLORS)


dunstify -h string:bgcolor:#"${BACKGROUND_COLOR: -6}" -r 9993 -t 10000 -i "${ALBUM_ART_PATH}" "Now Playing" "$(mpc --format '%title% - %artist%' current)"
#dunstify -r 9993 -t 10000 -i "${ALBUM_ART_PATH}" "Now Playing" "$(mpc --format '%title% - %artist%' current)"
