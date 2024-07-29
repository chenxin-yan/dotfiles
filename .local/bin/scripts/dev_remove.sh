#!/bin/bash


# Check if the project directory exists
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Project directory does not exist: $PROJECT_DIR"
  exit 1
fi

# Use fd to select a top-level directory
SELECTED_DIR=$(fd --type d --max-depth 1 . "$PROJECT_DIR" | fzf --prompt="Select a project to delete: ")

# Check if a directory was selected
if [ -n "$SELECTED_DIR" ]; then
  # Extract the directory name
  DIR_NAME=$(basename "$SELECTED_DIR")
  
  # Confirm deletion
  echo "Are you sure you want to delete the directory: $SELECTED_DIR? (y/n)"
  read -r CONFIRMATION
  if [ "$CONFIRMATION" = "y" ]; then
    # Delete the selected directory
    sudo rm -rf "$SELECTED_DIR"
    echo "Directory deleted: $SELECTED_DIR"
    
    # Check for and clean up associated tmux sessions
    if tmux has-session -t "$DIR_NAME" 2>/dev/null; then
      echo "Killing tmux session: $DIR_NAME"
      tmux kill-session -t "$DIR_NAME"
    fi
  else
    echo "Deletion aborted."
  fi
else
  echo "No directory selected."
fi

