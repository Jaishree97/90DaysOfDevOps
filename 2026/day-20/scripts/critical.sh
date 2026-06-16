#!/bin/bash

log_file="$1"

if [ $# -eq 0 ]; then
    echo "Error: No log file path provided."
    exit 1
fi

if [ ! -f "$log_file" ]; then
    echo "Error: File does not exist: $log_file"
    exit 1
fi

echo "--- Critical Events ---"

grep -n "CRITICAL" "$log_file" | while IFS=: read -r line_num log_entry
do
    echo "Line $line_num: $log_entry"
done
