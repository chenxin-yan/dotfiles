#!/bin/bash

FRONT_APP=(
  label.padding_left=12
  script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left \
           --set front_app "${FRONT_APP[@]}" \
           --subscribe front_app front_app_switched 
