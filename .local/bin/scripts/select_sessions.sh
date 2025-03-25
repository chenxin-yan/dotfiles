#!/usr/bin/env bash

# Ensure directories exist
mkdir -p "$PROJECT_DIR" "$DEV_DIR"

~/.local/bin/scripts/cleanup_sessions.sh

# Use fd to select a top-level directory in both dirs
SELECTED_DIR=$(
  fd --type d -L --max-depth 1 . "$PROJECT_DIR" "$DEV_DIR" \
  | fzf --prompt="Select a project to open: "
)

# Check if a directory was actually selected
if [[ -z "$SELECTED_DIR" ]]; then
  echo "No directory selected."
  return
fi

# Derive zellij session name from the directory name
DIR_NAME=$(basename "$SELECTED_DIR")
SESSION_NAME="${DIR_NAME//./_}"  # replaces '.' with '_'

# With attach_to_session=true, zellij will automatically attach to an existing session
# or create a new one if it doesn't exist
echo "Opening zellij session: $SESSION_NAME"
(cd "$SELECTED_DIR" && zellij attach --create "$SESSION_NAME")
