#!/bin/bash


set -e
# set -o noclobber

mkdir /tmp/devops-test 2>/dev/null || {
	echo "Directory already exists"
}

cd /tmp/devops-test || {
	echo "Failed to enter directory"
        exit 1

}

echo "Creating file..."

> demo.txt 2>/dev/null || {
	echo "demo.txt already exists"
}

echo "Script completed successfully"



