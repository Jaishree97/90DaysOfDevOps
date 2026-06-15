#!/bin/bash

set -eu

usage() {
	echo "Usage: ./log_rotate.sh /var/log/app_name"
	echo "Example: ./log_rotate.sh /var/log/apache2"
	exit 1
}

if [ "$#" -eq 0 ]; then
	usage
fi

dir=$1

check_dir() {
	[ -d "$dir" ] || {
		echo "Directory $dir does not exists"
	        exit 1
}
}

gzip_count=0
delete_count=0

compress() {
	file_list=$(find "$dir" -type f -name "*.log" -mtime +7)

	for file in $file_list; do
		gzip "$file"
		gzip_count=$((gzip_count + 1))
	done
}

delete_log() {
	zip_files=$(find "$dir" -type f -name "*.gz" -mtime +30)

	for file in $zip_files; do
		rm "$file"
		delete_count=$((delete_count + 1))
	done
}

check_dir
compress
delete_log

echo "Total log files zipped : $gzip_count"
echo "total zip files deleted : $delete_count"

