


ARCHITECTURE=$(uname -a)
CPU_PHYSICAL=$(lscpu | head -n 5 | tail -n 1 | awk '{print $NF}')
CPU_VIRTUAL=$(nproc)

RAM_TOTAL=$(free -m | head -n 2 | tail -n 1 | awk '{print $2}')
RAM_USED=$(free -m | head -n 2 | tail -n 1 | awk '{print $3}')
RAM_PERCENT=$(echo "scale=1; $RAM_USED / $RAM_TOTAL * 100" | bc)

DISK_TOTAL_root=$(df | head -n 4 | tail -n 1 | awk '{print $3+$4}')
DIST_TOTAL_home=$(df | head -n 7 | tail -n 1 | awk '{print $3+$4}')
DISK_TOTAL=$(echo "$DISK_TOTAL_root + $DISK_TOTAL_home" | bc)
DISK_USED=$(df | head -n 4 | tail -n 1 | awk '{print $3}')
DISK_PERCENT=$(echo "scale=1; $DISK_USED / $DISK_TOTAL * 100" | bc)
DISK_TOTAL=$(echo "$DISK_TOTAL" | numfmt --to=iec-i --suffix=B)
DISK_USED=$(echo "$DISK_USED" | numfmt --to=iec-i --suffix=B)

CPU_LOAD=$(top -bn2 | grep "Cpu(s)" | tail -n 1 | awk '{print 100-($8+$16)}')

LAST_BOOT=$(who -b | awk '{print $3 " " $4}')

LVM=$(lsblk | grep "lvm" | wc -l)
LVM=$(if [ $LVM -eq 0 ]; then echo no; else echo yes; fi)

TCP_CONN=$(echo "`ss -tunlp | wc -l` - 1" | bc)

USER_LOG=$(who | wc -l)

# IP=$(hostname -I awk '{print $1}')
IP=""
# MAC=$(ip a | grep "ether" | awk '{print $2}')
MAC=""

#SUDO_CMD=$(cat /var/log/sudo/sudo.log | wc -l)
SUDO_CMD=""


printf "\t#Architecture: $ARCHITECTURE\n"
printf "\t#CPU physical: $CPU_PHYSICAL\n"
printf "\t#vCPU: $CPU_VIRTUAL\n"
printf "\t#RAM: $RAM_USED/$RAM_TOTAL MB ($RAM_PERCENT%%)\n"
printf "\t#Disk: $DISK_USED/$DISK_TOTAL ($DISK_PERCENT%%)\n"
printf "\t#CPU load: $CPU_LOAD%%\n"
printf "\t#Last boot: $LAST_BOOT\n"
printf "\t#LVM: $LVM\n"
printf "\t#Connexions TCP: $TCP_CONN ESTABLISHED\n"
printf "\t#User log: $USER_LOG\n"
printf "\t#Network: IP $IP ($MAC)\n"
printf "\t#Sudo: $SUDO_CMD cmd\n"
