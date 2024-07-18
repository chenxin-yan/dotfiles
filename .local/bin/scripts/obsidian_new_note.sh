#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "Please enter note title"
else
  FILE_NAME=$1
  for WORD in "${@:2}"
  do
    FILE_NAME+=" $WORD"
  done
  $EDITOR "$VAULT_PATH/+ Inbox/$FILE_NAME.md"
fi
