#!/bin/bash

SOUND=(
  script="$PLUGIN_DIR/sound.sh"
)

sketchybar --add item sound right \
 --set sound "${SOUND[@]}" \
 --subscribe sound volume_change 

