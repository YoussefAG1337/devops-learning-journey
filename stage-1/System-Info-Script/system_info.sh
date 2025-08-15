#!/bin/bash
set -euo pipefail
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
output_file="/home/youssef/Desktop/System_Report/system_report_$timestamp.log"


echo "Hostname: $(hostname)" >> $output_file
echo "Uptime: $(uptime -p)" >> $output_file # Shows how long the system has been running in a human-readable form
echo "OS Info: $(uname -a)" >> $output_file # Outputs kernel name, version, and system architecture
echo "IP Address: $(hostname -I | awk '{print $1}')" >> $output_file

echo "CPU Load: $(top -bn1 | grep "load average" | awk '{print $(NF-2), $(NF-1), $NF}')" >> $output_file
# top -bn1: Runs top once in batch mode (non-interactive).
# awk '{print $(NF-2), $(NF-1), $NF}': Extracts the last 3 values.

echo "Memory Usage:" >> $output_file
free -h >> $output_file


echo "Disk Usage:" >> $output_file
df -h >> $output_file


echo "Top 5 Processes by Memory Usage:" >> $output_file
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 >> $output_file
# ps -e : Stands for every process on the system (not just your own).
# -o pid,comm,%mem : Shows PID, command name, and memory use.
# --sort=-%mem: Sorts by memory usage (descending).
# head -n 6: Gets top 5 + header.