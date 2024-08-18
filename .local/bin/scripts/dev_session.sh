#!/bin/bash

# Check if the project directory exists, if not, create it
if [ ! -d "$DEV_DIR" ]; then
  mkdir -p "$DEV_DIR"
fi

# Function to clean up tmux sessions without existing folders
cleanup_sessions() {
  # List all tmux sessions
  tmux list-sessions -F "#{session_name}" | while read -r session_name; do
    session_path="$DEV_DIR/$(echo "$session_name" | tr '_' '.')"
    if [ ! -d "$session_path" ] && [ ! -L "$session_path" ]; then
      echo "Killing tmux session: $session_name (Folder does not exist)"
      tmux kill-session -t "$session_name"
    fi
  done
}

# Clean up sessions first
cleanup_sessions

# Use fd to select a top-level directory
SELECTED_DIR=$(fd --type d -L --max-depth 1 . "$DEV_DIR" | fzf)

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
