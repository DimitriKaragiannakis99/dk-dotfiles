#!/bin/zsh

# Looks for an argument, if none is provided -> error
if [ -z "$1" ]; then
  echo "Error: A file name must be set, e.g. on \"the wonderful thing about tiggers\"."
  exit 1
fi

file_name=$(echo "$1" | tr ' ' '-')
formatted_file_name=${file_name}.md
cd "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian-root" || exit
touch "inbox/${formatted_file_name}"
nvim "inbox/${formatted_file_name}"
