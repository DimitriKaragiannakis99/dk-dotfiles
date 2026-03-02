#!/bin/zsh

# Looks for an argument, if none is provided -> error
if [ -z "$1" ]; then
  echo "Error: A file name must be set, e.g. on \"the wonderful thing about tiggers\"."
  exit 1
fi

file_name=$(echo "$1" | tr ' ' '-')
formatted_file_name=${file_name}.md
cd "$HOME/Documents/my-obs-vault/inbox/" || exit
touch "${formatted_file_name}"
nvim "${formatted_file_name}"
