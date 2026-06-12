#!/bin/bash

read -p "Enter any number : " number

if [ "$number" -eq "$number" ] &>/dev/null; then
    :
else
    echo "Enter a valid number"
    exit 1
fi

if [ "$number" -gt 0 ]; then
    while [ "$number" -ge 0 ]; do
        echo "$number"
        ((number--))
    done

elif [ "$number" -lt 0 ]; then
    while [ "$number" -le 0 ]; do
        echo "$number"
        ((number++))
    done

else
    echo "0"
fi

echo "Done!"
