#!/bin/bash


# Check if the project directory exists
if [ ! -d "$DEV_DIR" ]; then
  echo "Project directory does not exist: $DEV_DIR"
  exit 1
fi

# Use fd to select a top-level directory
SELECTED_DIR=$(fd --type d -L --max-depth 1 . "$DEV_DIR" | fzf --prompt="Select a project to delete: ")

# Check if a directory was selected
if [ -n "$SELECTED_DIR" ]; then
  # Extract the directory name
  DIR_NAME=$(basename "$SELECTED_DIR")
  # Sanitize the directory name for tmux session
  SESSION_NAME=$(echo "$DIR_NAME" | tr '.' '_')
  
  # Confirm deletion
  echo "Are you sure you want to delete the directory: $SELECTED_DIR? (y/n)"
  read -r CONFIRMATION
  if [ "$CONFIRMATION" = "y" ]; then
    # Delete the selected directory
    sudo rm -rf "$SELECTED_DIR"
    echo "Directory deleted: $SELECTED_DIR"
    
    # Check for and clean up associated tmux sessions
    if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
      echo "Killing tmux session: $SESSION_NAME"
      tmux kill-session -t "$SESSION_NAME"
    fi
  else
    echo "Deletion aborted."
  fi
else
  echo "No directory selected."
fi

