#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Terminal Window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 👾
# @raycast.packageName New Window Command

# Documentation:
# @raycast.description Create new Wezterm window
# @raycast.author chenxin_yan
# @raycast.authorURL https://raycast.com/chenxin_yan

/Applications/kitty.app/Contents/MacOS/kitty --single-instance --directory="$HOME"
