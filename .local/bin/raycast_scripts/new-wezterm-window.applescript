#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Wezterm Window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 👾
# @raycast.packageName New Window Command

# Documentation:
# @raycast.description Create new Wezterm window
# @raycast.author chenxin_yan
# @raycast.authorURL https://raycast.com/chenxin_yan

set appName to "WezTerm"

if application appName is running then
  Do Shell Script "/Applications/WezTerm.app/Contents/MacOS/wezterm-gui"
else
  tell application appName to activate
end if
