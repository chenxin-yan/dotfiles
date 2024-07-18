#!/bin/bash

# Use fd to select a file
SELECTED_FILE=$(fd --type f . "$VAULT_PATH" | fzf)

# Check if a file was selected
if [ -n "$SELECTED_FILE" ]; then
  # Open the selected file in the default editor
  ${EDITOR} "$SELECTED_FILE"
else
  echo "No file selected."
fi
