#!/bin/sh

# inspired by zellij's random session names
WORDS_PATH=/usr/share/dict/*
if [ WORDS_PATH -lt 1 ]; then
    return
fi

two_words=$(shuf -n2 $WORDS_PATH | paste -sd'-')

original_name=$(tmux display-message -p '#{session_name}')

if echo "$original_name" | grep -q '^[0-9]\+$'; then
    tmux rename-session "$two_words"
fi
