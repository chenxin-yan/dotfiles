#!/bin/bash

SOUND=(
  icon.color=$GREEN
  background.color=$BG_SEC_COLR
  script="$PLUGIN_DIR/sound.sh"
)

sketchybar --add item sound right \
 --set sound "${SOUND[@]}" \
 --subscribe sound volume_change 

