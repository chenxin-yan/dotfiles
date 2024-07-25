#!/bin/bash

APPLE=(
  icon=$APPLE_ICON
  icon.color=$WHITE
  label.drawing=off
  background.padding_left=0
  background.padding_right=22
)

sketchybar --add item apple left \
           --set apple "${APPLE[@]}"

