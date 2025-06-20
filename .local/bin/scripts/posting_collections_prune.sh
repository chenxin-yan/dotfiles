#!/bin/bash

# posting_collections_prune.sh - Remove posting collections for non-existent dev projects

# Dev directory - adjust this path as needed
DEV_DIR="$HOME/dev"

# Collections directory
COLLECTIONS_DIR="$HOME/.local/share/posting/collections"

# Check if collections directory exists
if [ ! -d "$COLLECTIONS_DIR" ]; then
    echo "Collections directory does not exist: $COLLECTIONS_DIR"
    exit 0
fi

# Check if dev directory exists
if [ ! -d "$DEV_DIR" ]; then
    echo "Dev directory does not exist: $DEV_DIR"
    exit 0
fi

echo "Pruning posting collections..."

# Count of pruned collections
PRUNED_COUNT=0

# Iterate through all collections
for collection in "$COLLECTIONS_DIR"/*; do
    if [ -d "$collection" ]; then
        # Get the collection name (basename)
        collection_name=$(basename "$collection")
        
        # Check if corresponding dev project directory exists
        project_dir="$DEV_DIR/$collection_name"
        
        if [ ! -d "$project_dir" ]; then
            echo "Removing collection for non-existent project: $collection_name"
            rm -rf "$collection"
            ((PRUNED_COUNT++))
        fi
    fi
done

if [ $PRUNED_COUNT -eq 0 ]; then
    echo "No collections to prune."
else
    echo "Pruned $PRUNED_COUNT collection(s)."
fi