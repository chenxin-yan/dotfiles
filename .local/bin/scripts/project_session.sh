#!/bin/bash

# Check if the project directory exists, if not, create it
if [ ! -d "$PROJECT_DIR" ]; then
  mkdir -p "$PROJECT_DIR"
fi

if [ ! -d "$DEV_DIR" ]; then
  mkdir -p "$DEV_DIR"
fi

# Use fd to select a top-level directory
SELECTED_DIR=$(fd --type d -L --max-depth 1 . "$PROJECT_DIR" "$DEV_DIR" | fzf --prompt="Select a project to open: ")

# Check if a directory was selected
if [ -n "$SELECTED_DIR" ]; then
   # Extract the directory name
  DIR_NAME=$(basename "$SELECTED_DIR")
  # Sanitize the directory name for tmux session
  SESSION_NAME=$(echo "$DIR_NAME" | tr '.' '_')

  # Check if a tmux session with the sanitized directory name already exists
  if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Attaching to existing tmux session: $SESSION_NAME"
    tmux attach-session -t "$SESSION_NAME"
  else
    echo "Creating new tmux session: $SESSION_NAME"
    tmux new-session -s "$SESSION_NAME" -c "$SELECTED_DIR"
  fi
else
  echo "No directory selected."
fi

