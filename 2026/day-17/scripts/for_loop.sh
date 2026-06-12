#!/bin/bash

fruits=("Apple" "Banana" "Kiwi" "Jackfruit" "Blackberry")

echo "Available Fruits:"

for fruit in "${fruits[@]}"
do
    echo "- $fruit"
done
