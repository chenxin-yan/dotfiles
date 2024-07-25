#!/bin/bash

TIME=(
  update_freq=10
  icon.drawing=off

  background.padding_right=2
  background.padding_left=10
  background.color=$BG_SEC_COLR
  script="$PLUGIN_DIR/time.sh"
)

sketchybar --add item time right \
           --set time "${TIME[@]}" 

