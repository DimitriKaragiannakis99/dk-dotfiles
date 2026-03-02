#!/bin/zsh

# Create file name with current date
export DATE="${1:-$(date "+%Y-%m-%d")}"

# Format file name with date and add to obsidian daily folder
formatted_file_name=journal-${DATE}.md
cd "$HOME/Documents/my-obs-vault/notes/journal" || exit
touch "${formatted_file_name}"
nvim "${formatted_file_name}"
