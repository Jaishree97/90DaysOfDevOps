#!/bin/bash


check_disk() {
	usage=$(df / | awk 'NR ==2 { print $5}' | tr -d '%')

	echo "Disk usage: ${usage}%"
	
	if [ "$usage" -gt 80 ]; then
		return 1
	else
		return 0
	fi
}

check_memory() {
	free_mem=$(free -m | awk 'NR == 2 { print $7}')

	echo "Free memory: ${free_mem} MB"

	if [ "$free_mem" -lt 500 ]; then
		return 1
	else
		return 0
	fi
}

main() {
	echo "==== System Report ===="

	if check_disk; then
		echo "Disk status: Healthy"
	else
		echo "Disk Status : Critical"
	fi

	echo ""

	if check_memory; then
		echo "Memory Status : Healthy"
	else
		echo "Memory Status : Low Memory"
	fi
}

main

	 
		  




