#!/bin/zsh

# What we print for the progress bar
progress-bar() {
	local curr=$1 # current process
	local len=$2 # total processes
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

	echo -ne "$s $curr/$len ($pct%)\r" # move the cursor to the front of the line without overidding it
}

shopt -s globstar nullglob # Adds glob matching packages + null return if glob search returns nothing

echo "Finding Files"
files=(./**/*cache)
len=${#files[@]} # Get the length of an array
echo "$len files found."

i=0
for file in "${files[@]}"; do
	progress-bar "$((i+1))" "$len"
	sleep 0.01 # so we can animate the bar
	((i++))
done
echo # essentially new line
