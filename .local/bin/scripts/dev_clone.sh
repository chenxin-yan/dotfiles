#!/bin/bash

# Check if the first argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <github_repo_url>"
  exit 1
fi

# Get the repository URL from the first argument
REPO_URL=$1

# Check if the project directory exists, if not, create it
if [ ! -d "$DEV_DIR" ]; then
  mkdir -p "$DEV_DIR"
fi

# Get the repository name from the URL
REPO_NAME=$(basename -s .git "$REPO_URL")

# Prompt the user for symlink creation
read -p "Do you want to create a symlink in $DEV_DIR and clone to the current directory? [y/N]: " CREATE_SYMLINK
if [ "$CREATE_SYMLINK" == "y" ]; then
  # Clone the repository into the current directory
  git clone "$REPO_URL" "$REPO_NAME"

  # Check if the clone was successful
  if [ $? -eq 0 ]; then
    # Create the symlink in the project directory
    ln -s "$(pwd)/$REPO_NAME" "$DEV_DIR/$REPO_NAME"
    echo "Repository cloned to the current directory and symlink created in $DEV_DIR"
  else
    echo "Failed to clone the repository"
    exit 1
  fi
else
  # Clone the repository into the project directory
  cd "$DEV_DIR"
  git clone "$REPO_URL"

  # Check if the clone was successful
  if [ $? -eq 0 ]; then
    echo "Repository cloned successfully into $DEV_DIR"
  else
    echo "Failed to clone the repository"
    exit 1
  fi
fi

