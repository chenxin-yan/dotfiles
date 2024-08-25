#!/bin/bash

PROJECT_DIR=$PARA_DIR/Projects

# Check if the project directory exists, if not, create it
if [ ! -d "$PROJECT_DIR" ]; then
  mkdir -p "$PROJECT_DIR"
fi

# Use fd to select a top-level directory
SELECTED_DIR=$(fd --type d --max-depth 1 . "$PROJECT_DIR" | fzf)

# Check if a directory was selected
if [ -n "$SELECTED_DIR" ]; then
    cd "$SELECTED_DIR" 
else
    echo "No directory selected."
fi
