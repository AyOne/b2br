#!/bin/bash

# Get system information
ARCHITECTURE=$(uname -a)
CPU_PHYSICAL=$(lscpu | awk '/^CPU\(s\):/ {print $NF}')
CPU_VIRTUAL=$(nproc)

# Get RAM information
RAM_TOTAL=$(free -m | awk '/^Mem:/ {printf "%.0f", $2*1000000}')
RAM_USED=$(free -m | awk '/^Mem:/ {printf "%.0f", $3*1000000}')
RAM_PERCENT=$(echo "scale=1; $RAM_USED / $RAM_TOTAL * 100" | bc)
RAM_TOTAL=$(echo "$RAM_TOTAL" | numfmt --to=iec-i --suffix=B)
RAM_USED=$(echo "$RAM_USED" | numfmt --to=iec-i --suffix=B)

# Get disk information
DISK_TOTAL=$(df | awk '/\/$|\/home$|\/dev$/ {sum+=$2*1000} END {printf "%.0f\n", sum}')
DISK_USED=$(df | awk '/\/$|\/home$|\/dev$/ {sum+=$3*1000} END {printf "%.0f\n", sum}')
DISK_PERCENT=$(echo "scale=1; $DISK_USED / $DISK_TOTAL * 100" | bc)
DISK_TOTAL=$(echo "$DISK_TOTAL" | numfmt --to=iec-i --suffix=B)
DISK_USED=$(echo "$DISK_USED" | numfmt --to=iec-i --suffix=B)

# Get CPU load
CPU_LOAD=$(top -bn2 | awk '/Cpu\(s\)/ {print 100-($8+$16)}')

# Get last boot time
LAST_BOOT=$(who -b | awk '{print $3 " " $4}')

# Check if LVM is enabled
LVM=$(lsblk | grep "lvm" | wc -l)
LVM=$(if [ $LVM -eq 0 ]; then echo no; else echo yes; fi)

# Get TCP connections count
TCP_CONN=$(ss -tunlp | wc -l)
TCP_CONN=$(echo "$TCP_CONN - 1" | bc)

# Get logged in users count
USER_LOG=$(who | wc -l)

# Get network information
IP=$(hostname -I | awk '{print $1}')
MAC=$(ip a | awk '/ether/ {print $2}')

# Get sudo command count
SUDO_CMD=$(cat /var/log/sudo/logs | wc -l)

# Print system information
printf "\t# Architecture: $ARCHITECTURE\n"
printf "\t# CPU physical: $CPU_PHYSICAL\n"
printf "\t# vCPU: $CPU_VIRTUAL\n"
printf "\t# RAM: $RAM_USED/$RAM_TOTAL ($RAM_PERCENT%%)\n"
printf "\t# Disk: $DISK_USED/$DISK_TOTAL ($DISK_PERCENT%%)\n"
printf "\t# CPU load: $CPU_LOAD%%\n"
printf "\t# Last boot: $LAST_BOOT\n"
printf "\t# LVM: $LVM\n"
printf "\t# Connexions TCP: $TCP_CONN ESTABLISHED\n"
printf "\t# User log: $USER_LOG\n"
printf "\t# Network: IP $IP ($MAC)\n"
printf "\t# Sudo: $SUDO_CMD cmd\n"