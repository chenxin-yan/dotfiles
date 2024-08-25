#!/bin/bash

AREA_DIR=$PARA_DIR/Areas

# Check if the project directory exists, if not, create it
if [ ! -d "$AREA_DIR" ]; then
  mkdir -p "$AREA_DIR"
fi

# Use fd to select a top-level directory
SELECTED_DIR=$(fd --type d --max-depth 1 . "$AREA_DIR" | fzf)

# Check if a directory was selected
if [ -n "$SELECTED_DIR" ]; then
    cd "$SELECTED_DIR"
else
    echo "No directory selected."
fi

