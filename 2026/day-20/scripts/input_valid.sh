#!/bin/bash

# Check if argument is provided

if [ $# -eq 0 ]; then
	echo "ERROR: No log file path provided"
	echo "Usage: $0 <log_file>"
	exit 1
fi

log_file=$1

# Check if file exists

if [ ! -f "$log_file" ]; then
	echo "ERROR: File '$log_file' does not exist."
	exit 1
fi

echo "Log file found: $log_file"
