#!/bin/bash

# Check if the input file is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <markdown-file-path> [output-file-path]"
  exit 1
fi

# Get the input markdown file path
INPUT_FILE="$1"

# Determine the output file path
if [ -z "$2" ]; then
  # If no output file is specified, use the input filename with .pdf extension
  FILENAME=$(basename -- "$INPUT_FILE")
  FILENAME="${FILENAME%.*}"
  OUTPUT_FILE="${FILENAME}.pdf"
else
  # Use the provided output file path
  OUTPUT_FILE="$2"
fi

# Template selection using fzf
TEMPLATE=$(echo -e "eisvogel\nacademic" | fzf --prompt="Select template: ")

# Check if user selected a template (didn't press ESC)
if [ -z "$TEMPLATE" ]; then
    echo "No template selected. Exiting."
    exit 1
fi

# Run pandoc command based on template selection
if [ "$TEMPLATE" = "eisvogel" ]; then
    pandoc "$INPUT_FILE" -s -f markdown -o "$OUTPUT_FILE" --template eisvogel --listings
else
    pandoc "$INPUT_FILE" -V geometry:margin=1in --defaults=$HOME/.pandoc/templates/pdf.yaml -o "$OUTPUT_FILE"
fi

# Check if pandoc command succeeded
if [ $? -eq 0 ]; then
  echo "Conversion successful: $OUTPUT_FILE"
else
  echo "Conversion failed."
  exit 1
fi
