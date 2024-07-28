#!/bin/bash

# Check if the project directory exists, if not, create it
if [ ! -d "$PROJECT_DIR" ]; then
  mkdir -p "$PROJECT_DIR"
fi

# Function to clean up tmux sessions without existing folders
cleanup_sessions() {
  # List all tmux sessions
  tmux list-sessions -F "#{session_name}" | while read -r session_name; do
    session_path="$PROJECT_DIR/$session_name"
    if [ ! -d "$session_path" ]; then
      echo "Killing tmux session: $session_name (Folder does not exist)"
      tmux kill-session -t "$session_name"
    fi
  done
}

# Clean up sessions first
cleanup_sessions

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
