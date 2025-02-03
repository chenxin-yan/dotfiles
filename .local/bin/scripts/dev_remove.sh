#!/bin/bash

# Make sure both directories exist. Adjust as needed.
# [ ! -d "$PROJECT_DIR" ] && mkdir -p "$PROJECT_DIR"
[ ! -d "$DEV_DIR" ] && mkdir -p "$DEV_DIR"

# Prompt to select a directory to remove
# SELECTED_DIR=$(fd --type d -L --max-depth 1 . "$PROJECT_DIR" "$DEV_DIR" \
#   | fzf --prompt="Select a project to delete: ")
SELECTED_DIR=$(fd --type d -L --max-depth 1 . "$DEV_DIR" \
  | fzf --prompt="Select a project to delete: ")

# Check if the user actually selected something
if [ -z "$SELECTED_DIR" ]; then
  echo "No project selected."
  exit 0
fi

echo "You selected: $SELECTED_DIR"

# Optional confirmation prompt
read -rp "Are you sure you want to delete '$SELECTED_DIR'? [y/N] " confirm
if [[ "$confirm" != [yY] ]]; then
  echo "Deletion cancelled."
  exit 0
fi

# Convert directory name to a valid tmux session name
SESSION_NAME=$(basename "$SELECTED_DIR" | tr '.' '_')

# If a tmux session with that name is running, kill it
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  tmux kill-session -t "$SESSION_NAME"
  echo "Killed tmux session: $SESSION_NAME"
fi

# ---[ Perform the actual deletion of the directory ]---
rm -rf "$SELECTED_DIR"

if [ ! -d "$SELECTED_DIR" ]; then
  echo "Successfully deleted $SELECTED_DIR."
else
  echo "Failed to delete $SELECTED_DIR. Check permissions or file locks."
fi

exit 0
