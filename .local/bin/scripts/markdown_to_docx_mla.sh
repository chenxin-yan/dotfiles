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
  # If no output file is specified, use the input filename with .docx extension
  FILENAME=$(basename -- "$INPUT_FILE")
  FILENAME="${FILENAME%.*}"
  OUTPUT_FILE="${FILENAME}.docx"
else
  # Use the provided output file path
  OUTPUT_FILE="$2"
fi

# Run the pandoc command
pandoc -C "$INPUT_FILE" -f markdown -s -o "$OUTPUT_FILE" --reference-doc /Users/yanchenxin/.pandoc/templates/mla.docx

# Check if pandoc command succeeded
if [ $? -eq 0 ]; then
  echo "Conversion successful: $OUTPUT_FILE"
else
  echo "Conversion failed."
  exit 1
fi
