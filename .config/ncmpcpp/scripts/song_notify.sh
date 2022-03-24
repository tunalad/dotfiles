#!/bin/bash

readonly MUSIC_DIR="${HOME}/Music"
readonly SONG_DIR="$(dirname "$(mpc --format '%file%' current)")"
readonly ALBUM_ART_PATH="${MUSIC_DIR}/${SONG_DIR}/cover.png"

notify-send -t 10000 -i "${ALBUM_ART_PATH}" "Now Playing" "$(mpc --format '%title% - %artist%' current)"
