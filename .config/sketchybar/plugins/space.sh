#!/bin/bash

WIDTH="dynamic"
SELECTED="false"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    WIDTH="0"
    SELECTED="true"
fi

sketchybar --animate tanh 10 --set $NAME \
icon.highlight=$SELECTED \
background.highlight=$SELECTED \
label.width=$WIDTH
