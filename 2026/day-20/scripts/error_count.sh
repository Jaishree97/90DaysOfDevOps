#!/bin/bash

# Accept the path to a log file as a command-line argument
log_file="$1"

# Exit with a clear error message if no argument is provided
if [ $# -eq 0 ]; then
    echo "Error: No log file path provided."
    exit 1
fi

# Exit with a clear error message if the file doesn't exist
if [ ! -f "$log_file" ]; then
    echo "Error: File does not exist: $log_file"
    exit 1
fi

# Count lines containing ERROR or Failed
error_count=$(grep -E "ERROR|Failed" "$log_file" | wc -l)

# Print the total error count
echo "Total Error Count: $error_count"
