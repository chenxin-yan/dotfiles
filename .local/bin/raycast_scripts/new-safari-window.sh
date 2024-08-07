#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Safari Window
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🧭
# @raycast.packageName NewWindow

# Documentation:
# @raycast.description Create a new safari window
# @raycast.author chenxin_yan
# @raycast.authorURL https://raycast.com/chenxin_yan

osascript <<EOF
tell application "Safari"
    make new document
    activate
end tell
EOF
