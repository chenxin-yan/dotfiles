#!/bin/bash

cd ~/Documents/Ideaverse/+\ Inbox
if [[ $# -eq 0 ]]; then
  echo "Please enter note title"
else
  FILE_NAME=$1
  for WORD in "${@:2}"
  do
    FILE_NAME+=" $WORD"
  done
  $EDITOR "$FILE_NAME.md"
fi
