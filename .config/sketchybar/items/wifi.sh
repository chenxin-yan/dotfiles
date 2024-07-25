#!/bin/bash
  WIFI=(
  update_freq=10
  icon=$WIFI_CONN_ICON
  icon.color=$PEACH
  background.color=$BG_SEC_COLR
  script="$PLUGIN_DIR/wifi.sh"
)

sketchybar --add item wifi right   \
           --set wifi "${WIFI[@]}" \
           --subscribe wifi wifi_change
