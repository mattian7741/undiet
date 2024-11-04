#!/bin/bash

# Directory to scan, default to current if not provided
dir="${1:-.}"

# Function to process each directory
process_directory() {
    # Resolve the full path to handle cases where the directory is specified as '.'
    local full_path=$(cd "$dir" && pwd)
    local dir_name=$(basename "$full_path")

    # Markdown friendly prompt at the top of the output
    echo "Project: '$dir_name'"
    echo ""
    find "$full_path" -type f \( \
        -name '*.py' -o -name '*.html' -o -name '*.js' -o -name '*.css' -o \
        -name '*.yaml' -o -name '*.md' -o -name '*.txt' -o -name '*.sql' \) \
        -exec echo "" \; \
        -exec echo "" \; \
        -exec echo "### File: {}" \; \
        -exec echo '```' \; \
        -exec cat "{}" \; \
        -exec echo "" \; \
        -exec echo '```' \; \
        -exec echo "" \; \
        -exec echo "" \;
}

# Export results to clipboard
process_directory "$dir" | pbcopy

echo "File listings have been copied to the clipboard."
