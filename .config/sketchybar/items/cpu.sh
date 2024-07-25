#!/bin/bash
CPU=(
  update_freq=2
  icon.font="$FONT:Regular:16.0"
  icon=
  script="$PLUGIN_DIR/cpu.sh"
)

sketchybar --add item cpu right \
           --set cpu "${CPU[@]}" 
