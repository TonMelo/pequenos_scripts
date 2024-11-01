#!/bin/bash

#Usage CPU 
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "CPU Usada: ${cpu_usage}%"

#capturing the ram memory info
memory_info=$(free -m)

#Capturing Ram Memory info
memory_info=$(free -m)

#Extract values from ram memory
total_mem=$(echo "$memory_info" | awk 'NR==2{print $2}')
used_mem=$(echo "$memory_info" | awk 'NR==2{print $3}')
free_mem=$(echo "$memory_info" | awk 'NR==2{print $4}')

#Calculating the percent of ram memory 
used_percent=$(echo "scale=2; ($used_mem / $total_mem) * 100" | bc)

#Printing the results
echo "Total de Memória: ${total_mem} MB"
echo "Memória Usada: ${used_mem} MB"
echo "Memória Livre: ${free_mem} MB"
echo "Porcentagem de Memória Usada: ${used_percent}%"

#Capturing disc info

disk_info=$(df -h /)

#Extract the values from disc
total_disk=$(echo "$disk_info" | awk 'NR==2{print $2}')
used_disk=$(echo "$disk_info" | awk 'NR==2{print $3}')
free_disk=$(echo "$disk_info" | awk 'NR==2{print $4}')
used_percent=$(echo "$disk_info" | awk 'NR==2{print $5}')

#print the results
echo "Capacidade Total do disco: ${total_disk}"
echo "Disco Usado: ${used_disk}"
echo "Disco Livre: ${free_disk}"
echo "Porcentagem de disco usada: ${used_percent}"

echo "Top 5 processes by CPU usage"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo "Top 5 processes by memory usage"
top -b -n 1 | head -n 12 | tail -n 5
