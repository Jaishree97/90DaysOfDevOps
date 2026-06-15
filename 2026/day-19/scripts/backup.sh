#!/bin/bash

set -eu

usage() {
    echo "Usage : backup.sh source/path destination/path"
    echo "Example : backup.sh /home/ubuntu/practice_sh /home/ubuntu/backup"
    echo "Please provide source and destination"
    exit 1
}

check_source() {
    [ -d "$src" ] || {
        echo "Source directory doesn't exist"
        exit 1
    }

    [ -d "$dest" ] || {
        echo "Destination directory doesn't exist"
        exit 1
    }
}

timestamp=$(date +%Y-%m-%d-%H-%M-%S)
archive="backup-${timestamp}.tar.gz"

backup() {

    echo "======Taking BackUp======"

    tar -czf "$dest/$archive" "$src" &>/dev/null

    echo "Back Up Complete"
    echo
}

print_file() {

    echo "======Backup Taken======"

    size=$(du -sh "$dest/$archive" | awk '{print $1}')

    echo "Archive Name : $archive        Size : $size"
    echo
}

delete_old_archives() {

    archives=$(find "$dest" -name "*.tar.gz" -mtime +14)

    if [ -n "$archives" ]; then

        echo "======Removing archives older than 14 days======"

        for file in $archives
        do
            rm "$file"
            echo "Removed Archive : $file"
        done
    fi
}

if [ $# -lt 2 ]; then
    usage
fi

src=$1
dest=$2

check_source
backup
print_file
delete_old_archives
