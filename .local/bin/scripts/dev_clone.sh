#!/bin/bash

# Check if the first argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <github_repo_url>"
  exit 1
fi

# Get the repository URL from the first argument
REPO_URL=$1

# Check if the project directory exists, if not, create it
if [ ! -d "$PROJECT_DIR" ]; then
  mkdir -p "$PROJECT_DIR"
fi

# Change to the project directory
cd "$PROJECT_DIR"

# Clone the repository
git clone "$REPO_URL"

# Check if the clone was successful
if [ $? -eq 0 ]; then
  echo "Repository cloned successfully into $PROJECT_DIR"
else
  echo "Failed to clone the repository"
  exit 1
fi
