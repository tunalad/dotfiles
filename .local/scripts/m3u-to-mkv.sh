#!/bin/bash

# Usage: ./m3u-to-video.sh COVER_IMAGE PLAYLIST [OUTPUT]

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 COVER_IMAGE PLAYLIST [OUTPUT]"
    echo ""
    echo "Example: $0 cover.png album.m3u output.mkv"
    exit 1
fi

COVER="$1"
PLAYLIST="$2"
OUTPUT="${3:-output.mkv}"

if [[ ! -f $COVER ]]; then
    echo "Error: Cover image not found: $COVER"
    exit 1
fi

if [[ ! -f $PLAYLIST ]]; then
    echo "Error: Playlist not found: $PLAYLIST"
    exit 1
fi

CONCAT_FILE=$(mktemp)
PLAYLIST_DIR=$(cd "$(dirname "$PLAYLIST")" && pwd)

while IFS= read -r line || [[ -n $line ]]; do
    [[ $line =~ ^# || -z $line ]] && continue

    [[ $line == /* ]] && AUDIO_PATH="$line" || AUDIO_PATH="$PLAYLIST_DIR/$line"

    if [[ ! -f $AUDIO_PATH ]]; then
        echo "Warning: Audio file not found: $AUDIO_PATH (skipping)"
        continue
    fi

    echo "file '$(realpath "$AUDIO_PATH")'" >>"$CONCAT_FILE"
done <"$PLAYLIST"

if [[ ! -s $CONCAT_FILE ]]; then
    echo "Error: No valid audio files found in playlist"
    rm "$CONCAT_FILE"
    exit 1
fi

WIDTH=$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "$COVER")
HEIGHT=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$COVER")

# battling youtube forcing shorts
if [[ "$WIDTH" -eq "$HEIGHT" ]]; then
    VF="scale=722:720"
else
    VF="scale=-2:720"
fi

echo "Creating video from playlist..."
ffmpeg -loop 1 -r 1 -i "$COVER" -f concat -safe 0 -i "$CONCAT_FILE" \
    -vf "$VF" \
    -c:v libx264 -preset fast -tune stillimage -c:a copy -pix_fmt yuv420p \
    -shortest "$OUTPUT"

FFMPEG_EXIT=$?
rm "$CONCAT_FILE"

if [[ $FFMPEG_EXIT -eq 0 ]]; then
    echo "Success! Video created: $OUTPUT"
else
    echo "Error: ffmpeg failed"
    exit 1
fi
