#!/bin/bash

readonly MUSIC_DIR="${HOME}/Music"
readonly SONG_DIR="$(dirname "$(mpc --format '%file%' current)")"
readonly CURRENT_SONG="${MUSIC_DIR}/$(mpc --format '%file%' current)"
readonly TEMP_COVER="/tmp/mpd_cover.jpg"

# extract embedded artwork (if it exists)
if ffmpegthumbnailer -i "${CURRENT_SONG}" -o "${TEMP_COVER}" -s 100 -q 5 2>/dev/null; then
    ALBUM_ART_PATH="${TEMP_COVER}"
else
    # use cover file
    ALBUM_ART_PATH=$(find "${MUSIC_DIR}/${SONG_DIR}" -type f -iname 'cover.*' -print -quit)

    # fallback cover file
    [[ ! -f $ALBUM_ART_PATH ]] && ALBUM_ART_PATH="$MUSIC_DIR/fallback.png"
fi

# background color based on artwork
DOMINANT_COLORS=$(magick "${ALBUM_ART_PATH}" \
    -scale 50x50! -depth 8 +dither -colors 8 -format "%c" histogram:info: |
    sed -n 's/^[ ]*\(.*\):.*[#]\([0-9a-fA-F]*\) .*$/\1,#\2/p')

BACKGROUND_COLOR=$(echo "$DOMINANT_COLORS" | head -n 1 | cut -d',' -f2)

notify-send -h string:bgcolor:"$BACKGROUND_COLOR" -r 9393 -t 10000 -i "$ALBUM_ART_PATH" "Now Playing..." "$(mpc --format '%title%\n%artist%\n%album%' current)"
