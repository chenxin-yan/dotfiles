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
  exit 0
fi

# Derive tmux session name from the directory name
DIR_NAME=$(basename "$SELECTED_DIR")
SESSION_NAME="${DIR_NAME//./_}"  # replaces '.' with '_'

# Create or attach to tmux session
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Attaching to existing tmux session: $SESSION_NAME"
  tmux attach-session -t "$SESSION_NAME"
else
  echo "Creating new tmux session: $SESSION_NAME"
  tmux new-session -s "$SESSION_NAME" -c "$SELECTED_DIR"
fi
