#!/bin/bash

tmux list-sessions -F "#{session_name}" | while read -r session_name; do
  DEV_PATH="$DEV_DIR/$(echo "$session_name" | tr '_' '.')"
  PROJECT_PATH="$PROJECT_DIR/$(echo "$session_name" | tr '_' '.')"
  if [ ! -d "$DEV_PATH" ] && [ ! -L "$DEV_PATH" ] && [ ! -d "$PROJECT_PATH" ] && [ ! -L "$PROJECT_PATH" ]; then
    echo "Killing tmux session: $session_name (Folder does not exist)"
    tmux kill-session -t "$session_name"
  fi
done
