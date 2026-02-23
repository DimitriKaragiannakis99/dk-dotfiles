#!/bin/zsh

# Create file name with current date
export DATE="${1:-$(date "+%Y-%m-%d")}"

# Format file name with date and add to obsidian daily folder
formatted_file_name=${DATE}-td.md
cd "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian-root" || exit
touch "notes/daily/${formatted_file_name}"
nvim "notes/daily/${formatted_file_name}"
