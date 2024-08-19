#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Safari Window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🧭
# @raycast.packageName New Window Command

# Documentation:
# @raycast.description Create new Safari window
# @raycast.author chenxin_yan
# @raycast.authorURL https://raycast.com/chenxin_yan

tell application "Safari"
    make new document
    activate
end tell
