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

echo "--- Top 5 Error Messages ---"

grep "ERROR" "$log_file" \
| awk -F'] ' '{print $2}' \
| awk -F' - ' '{print $1}' \
| sort \
| uniq -c \
| sort -rn \
| head -5
