#!/bin/bash

# What we print for the progress bar
progress-bar() {
	local curr=$1 # current process
	local len=$2 # total processes
	local filename=$3 
	local pct=$((curr * 100 / len)) # we do it in this order bcs bash doesn't process floats (we cant reach 0)

	local length=70 # Size of terminal buffer
	local num_bars=$((pct * length / 100)) # Will give us the right amount of bars to fit in the buffer

	local bar_char="#"
	local empty_char='.'
	local i
	local s='['
	for ((i = 0; i < num_bars; i++ )); do
		s+=$'\e[0;95m'$bar_char$'\e[0m' # add a vertical pipe for every percent complete + ANSI color
	done
	for ((i = num_bars; i < length; i++)); do
		s+=$'\e[0;33m'$empty_char  # Add empty space for all the incomplete percentages
	done
	s+=']'

	if (( pct == 100 )); then
		echo -ne "$s $curr/$len ($pct%) of files transferred 🪷\r"
	else
		echo -ne "$s  $filename $curr/$len ($pct%)\r" # move the cursor to the front of the line without overidding it
	fi
}


# Directory containing markdown files
VAULT_DIR="$HOME/Documents/my-obs-vault/"
SOURCE_DIR="zettelkasten"
DEST_DIR="notes"

# Make sure globbing doesn't break if no matches
shopt -s nullglob

# Collect all markdown files 
files=("$VAULT_DIR/$SOURCE_DIR"/*.md)
len=${#files[@]}

# Check if empty
if (( len == 0 )); then
    echo "No files in $SOURCE_DIR"
    exit 0
fi

i=0
for file in "${files[@]}"; do
	# Extract all tags under 'tags:'	
	tags=$(awk '/^tags:/{flag=1;next} /^[a-zA-Z]+:/{flag=0} flag' "$file" | sed -e 's/^ *- *//')
	if [ -n "$tags" ]; then
		# Turn the tags into a slash-separated path
		# replaces /n with /, removes trailing / and whitespace
		tag_path=$(echo "$tags" \
			| sed -e 's/^[[:space:]]*-[[:space:]]*//' -e 's/[[:space:]]*$//' -e '/^$/d' \
			| paste -sd '/' -)
		TARGET_DIR="$VAULT_DIR/$DEST_DIR/$tag_path"
		# Make a dir if it doesn't exist if it does -p ignores the error caused by mkdir
		mkdir -p "$TARGET_DIR"

		mv "$file" "$TARGET_DIR/"
		progress-bar "$((i+1))" "$len" "Moving $(basename "$file")"
		sleep 0.5
		((i++))
  fi
done
echo # new line 
