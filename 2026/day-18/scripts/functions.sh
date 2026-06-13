#!/bin/bash


set -euo pipefail

greet() {
	echo "Hello, $1!"
}


add() {
	local sum=$(($1 + $2))
	echo "Sum = $sum"
}

read -p "Enter your name: "  name
greet "$name"

read -p "Enter any two numbers:" a b

if [ "$a" -eq "$a" ] 2>/dev/null && [ "$b" -eq "$b" ] 2>/dev/null; then
	add "$a" "$b"
else
	echo "Please enter valid numbers."
        exit 1
fi


