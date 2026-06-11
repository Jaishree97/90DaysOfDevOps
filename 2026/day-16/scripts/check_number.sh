#!/bin/bash

read -p "Enter a number: " number


if [ $number -gt 0 ]; then
	echo "The number is Positive."
elif [ $number -lt 0 ]; then
	echo "The number is Negative."
else
	echo "The number is Zero."
fi
