#!/bin/bash

echo "===== Demo 1 : set -u ====="

(
    set -u
    echo "$name"
)

echo ""

echo "===== Demo 2 : set -e ====="

(
    set -e
    mkdir testdir
    mkdir testdir
)

echo ""

echo "===== Demo 3 : set -o pipefail ====="

(
    set -o pipefail
    cat test.txt | grep "Hello"
)

echo ""
echo "All demos completed"
