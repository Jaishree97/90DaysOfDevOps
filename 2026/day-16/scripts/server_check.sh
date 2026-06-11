#!/bin/bash




read -p "Enter the service name: " service

read -p "Do you want to check the status? (y/n): " choice

if [ $choice="y" ]; then
	if systemctl is-active $service > /dev/null; then
		echo "The service $service is active"
	else
		echo "The service $service is not active"
	fi
elif [ $choice="n" ]; then
	echo "Skipped"
	exit 1
fi
	     

	 
