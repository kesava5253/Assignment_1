#! /bin/bash

if [[ $# -lt 1 ]];
then       
	echo "usage:$0 <missing argument>"
	echo "input time period in secs"
	exit 102
fi

printf "Memory\t\tDisk\t\tCPU\n"
	end=$((SECONDS+$1))
	while [ $SECONDS -le $end ]; do
		MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t",$3*100/$2 }')
		DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
		CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
		echo "$MEMORY$DISK$CPU"
		sleep 5
done





#grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'


