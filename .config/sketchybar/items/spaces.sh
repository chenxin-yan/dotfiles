#!/bin/bash

SPACE_ICONS=("~" "1:DEV" "2:WEB" "3:TODO" "4:NOTE" "5:CHAT" "6:WIP")

SPACE=(
  icon.padding_left=18
  icon.padding_right=18
  label.padding_right=33
  icon.color=$WHITE
  icon.font="$FONT:ExtraBold:14.0"
  icon.highlight_color=$SKY
  icon.background.draw=on
  background.padding_left=-8
  background.padding_right=-8
  background.color=$BG_SEC_COLR
  background.corner_radius=10
  background.drawing=on
  label.drawing=off
)

sketchybar --add event aerospace_workspace_change

sid=0
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i))
  sketchybar --add item space.$sid left \
             --subscribe space.$sid aerospace_workspace_change \
             --set space.$sid "${SPACE[@]}" \
                  script="$PLUGIN_DIR/space.sh $sid" \
                  click_script="aerospace workspace $sid" \
             --set space.$sid icon=${SPACE_ICONS[i]}
done

sketchybar --add item space_separator_left left \
           --set space_separator_left icon= \
                                 icon.font="$FONT:Bold:16.0" \
                                 background.padding_left=16 \
                                 background.padding_right=10 \
                                 label.drawing=off \
                                 icon.color=$DARK_WHITE
