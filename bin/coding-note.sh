#!/bin/zsh

file_name="$1.md"
cd "$HOME/Documents/my-obs-vault/inbox/" || exit
touch "${file_name}"
nvim "${file_name}"
