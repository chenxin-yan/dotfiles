#!/bin/bash

# Define the project directory to search in
PROJECT_DIR=~/dev/

# Use fd to select a top-level directory
SELECTED_DIR=$(fd --type d --max-depth 1 . "$PROJECT_DIR" | fzf)

# Check if a directory was selected
if [ -n "$SELECTED_DIR" ]; then
  # Extract the directory name
  DIR_NAME=$(basename "$SELECTED_DIR")

  # Check if a tmux session with the directory name already exists
  if tmux has-session -t "$DIR_NAME" 2>/dev/null; then
    echo "Attaching to existing tmux session: $DIR_NAME"
    tmux attach-session -t "$DIR_NAME"
  else
    echo "Creating new tmux session: $DIR_NAME"
    tmux new-session -s "$DIR_NAME" -c "$SELECTED_DIR"
  fi
else
  echo "No directory selected."
fi
