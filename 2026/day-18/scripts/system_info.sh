#!/bin/bash

set -euo pipefail

sys_info() {
    echo "=============== HOST NAME & SYS INFO =================="
    echo "HostName : $(hostname)"
    echo "Kernel   : $(uname -r)"
    echo "OS       : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
}

sys_uptime() {
    echo -e "\n=============== SYSTEM UPTIME ========================="
    uptime -p
}

disk_usage() {
    echo -e "\n=============== DISK USAGE ============================"
    df -h | awk 'NR==1'
    df -h | sort -hr -k2 | head -5
}

mem_usage() {
    echo -e "\n=============== MEMORY USAGE =========================="
    free -h | awk 'NR==2{print "Total : "$2,"\tUsed : "$3,"\tAvailable : "$7}'
}

cpu_consuming_processes() {
    echo -e "\n=============== CPU-CONSUMING PROCESSES ==============="
    ps -eo pid,user,comm,%cpu,%mem --sort=-%cpu | head -n 6
}

main() {
    sys_info
    sys_uptime
    disk_usage
    mem_usage
    cpu_consuming_processes
}

main
