#!/bin/zsh

# Directory containing markdown files
VAULT_DIR="/Users/dimitrikaragiannakis/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian-root"
SOURCE_DIR="zettelkasten"
DEST_DIR="notes"

# Iterate through all markdown files in the source directory
find "$VAULT_DIR/$SOURCE_DIR" -type f -name "*.md" | while read -r file; do
  echo "Processing $file"

  # Extract all tags under 'tags:'
  tags=$(awk '/tags:/{flag=1;next}/^$/{flag=0}flag' "$file" | sed -e 's/^ *- *//')

  echo "Found tags: $tags"

  if [ -n "$tags" ]; then
    # Turn the tags into a slash-separated path (in order)
    tag_path=$(echo "$tags" | tr '\n' '/' | sed 's:/$::')

    TARGET_DIR="$VAULT_DIR/$DEST_DIR/$tag_path"
    # Make a dir if it doesn't exist if it does -p ignores the error caused by mkdir
    mkdir -p "$TARGET_DIR"

    mv "$file" "$TARGET_DIR/"
    echo "Moved $file → $TARGET_DIR"
  else
    echo "No tag found for $file"
  fi
done
echo "Done 🪷"

