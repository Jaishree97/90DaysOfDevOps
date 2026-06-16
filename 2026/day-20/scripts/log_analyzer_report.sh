#!/bin/bash

set -euo pipefail

# Validate input
if [ $# -eq 0 ]; then
    echo "Error: No log file path provided."
    exit 1
fi

log_file="$1"

if [ ! -f "$log_file" ]; then
    echo "Error: File does not exist: $log_file"
    exit 1
fi

# Create archive directory if it doesn't exist
mkdir -p archive

# Date
analysis_date=$(date)

# Total lines
total_lines_processed=$(wc -l < "$log_file")

# Total errors
total_errors_count=$(grep -Ei "ERROR|Failed" "$log_file" | wc -l)

# Top 5 error messages
top_errors=$(grep "ERROR" "$log_file" \
| awk '{$1=$2=$3=""; print}' \
| sort \
| uniq -c \
| sort -rn \
| head -5)

# Critical events with line numbers
critical_events=$(grep -n "CRITICAL" "$log_file" | while IFS=: read -r line_num log_entry
do
    echo "Line $line_num: $log_entry"
done)

# Report file (inside archive folder)
report_file="archive/log_report_$(date +%F).txt"

{
    echo "========== LOG ANALYSIS REPORT =========="
    echo
    echo "Date of analysis: $analysis_date"
    echo "Log file name: $log_file"
    echo "Total lines processed: $total_lines_processed"
    echo "Total error count: $total_errors_count"
    echo

    echo "---------- Top 5 Error Messages ----------"
    echo "$top_errors"
    echo

    echo "---------- Critical Events ----------"
    echo "$critical_events"
    echo

} > "$report_file"

echo "Summary report generated: $report_file"

# Move processed log file to archive
mv "$log_file" archive/

echo "Moved $log_file to archive/"
echo "Log analysis completed."
