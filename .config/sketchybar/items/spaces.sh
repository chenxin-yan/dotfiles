#!/bin/bash

SPACE_ICONS=("~" "1" "2" "3" "4" "5" "6" "7" "8" "9")

SPACE=(
  icon.padding_left=22
  icon.padding_right=22
  label.padding_right=33
  icon.color=$WHITE
  icon.font="$FONT:Bold:14.0"
  icon.highlight_color=$ACCENT
  background.padding_left=-8
  background.padding_right=-8
  background.color=$BG_SEC_COLR
  background.drawing=on
  label.background.height=26
  label.background.drawing=on
  label.background.color=$BG_SEC_COLR
  label.background.corner_radius=10
  label.drawing=off
  script="$PLUGIN_DIR/space.sh"
)

sid=0
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space space.$sid left
  sketchybar --set space.$sid associated_space=$sid
  sketchybar --set space.$sid icon=${SPACE_ICONS[i]}
  sketchybar --set space.$sid "${SPACE[@]}"
done

