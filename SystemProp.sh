#! /bin/bash

AvgMemory(){

avg=`echo $1 / $2 | bc`

echo "Avg memory : $avg"
}

AvgCpu(){

avg1=`echo $1 / $2 | bc`
echo "Avg cpu : $avg1"
}

AvgDisk(){
avg2=`echo $1 / $2 | bc`
echo "Avg disk : $avg2"
}

count=0
mem=0
DiskUsage=0
CpuUsage=0



if [[ $# -lt 1 ]];
then       
	echo "usage:$0 <missing argument>"
	echo "input time period in secs"
	exit 102
fi

	printf "Memory\t\tDisk\t\tCPU\n"
end=$((SECONDS+$1))
	while [ $SECONDS -le $end ]; do
		MEMORY=$(free -m | awk 'NR==2{printf "%.2f\t\t",$3*100/$2 }')
		DISK=$(df -h | awk '$NF=="/"{printf "%.2f\t\t", $5}')
		CPU=$(top -bn1 | grep load | awk '{printf "%.2f\t\t\n", $(NF-2)}')
		echo "$MEMORY$DISK$CPU"
		
		
	mem=`echo $mem + $MEMORY | bc`
	DiskUsage=`echo $DiskUsage + $DISK | bc`
	CpuUsage=`echo $CpuUsage + $CPU | bc`
	count=$(( $count + 1))
	sleep 5
done

AvgMemory $mem $count

AvgCpu $DiskUsage $count

AvgDisk $CpuUsage $count





#grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'


