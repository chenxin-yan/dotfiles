#!/bin/bash

# posting_load.sh - Load or create posting collections for dev projects

# Get current working directory
CWD=$(pwd)

# Check if we're in a dev directory project
# Assuming dev directory is ~/dev - adjust this path as needed
DEV_DIR="$HOME/dev"

# Check if current directory is under dev directory
if [[ "$CWD" == "$DEV_DIR"/* ]]; then
    # Extract project name (directory name under dev)
    PROJECT_NAME=$(basename "$CWD")
    
    # Collections directory
    COLLECTIONS_DIR="$HOME/.local/share/posting/collections"
    COLLECTION_PATH="$COLLECTIONS_DIR/$PROJECT_NAME"
    
    # Create collections directory if it doesn't exist
    mkdir -p "$COLLECTIONS_DIR"
    
    # Check if collection already exists
    if [ -d "$COLLECTION_PATH" ]; then
        echo "Loading existing collection for project: $PROJECT_NAME"
        posting --collection "$COLLECTION_PATH"
    else
        echo "Creating new collection for project: $PROJECT_NAME"
        # Create the collection directory
        mkdir -p "$COLLECTION_PATH"
        echo "Collection created at: $COLLECTION_PATH"
        # Load the new collection
        posting --collection "$COLLECTION_PATH"
    fi
else
    echo "Not in a dev project directory. Current path: $CWD"
    echo "Expected to be under: $DEV_DIR"
    exit 1
fi