

#! /bin/bash

AvgMemory(){

avg=`echo "scale = 2; $1/$2" | bc`

echo "Avg memory : $avg"
}

AvgCpu(){

avg1=`echo "scale = 2; $1/$2" | bc`
echo "Avg cpu : $avg1"
}

AvgDisk(){
avg2=`echo "scale = 2; $1/$2" | bc`
echo "Avg disk : $avg2"
}

let count=max=max1=max2=mem=DiskUsage=CpuUsage=0



if [[ $# -lt 1 ]];
then       
	echo "usage:$0 <missing argument> [cpu/disk/mem]"
	echo "Argument time period in secs"
	exit 102
elif [ $# -eq 2 ];
then

end=$((SECONDS+$1))

	if [ "$2" == "mem" ];
	then
	printf "Memory\n"
	while [ $SECONDS -le $end ]; do
	MEMORY=$(free -m | awk 'NR==2{printf "%.2f\t\t",$3*100/$2 }')
	echo "$MEMORY"

	 if [[ "$MEMORY" > "$max" ]]; then
	 max="$MEMORY"
  	fi
	mem=`echo  $mem + $MEMORY | bc`
	count=`echo $count + 1 | bc`
	sleep 5
	done
	AvgMemory $mem $count
	echo "Maximum memory :$max "
	fi

	if [ "$2" == "cpu" ];
	then
	printf "Cpu\n"
	while [ $SECONDS -le $end ]; do
 	CPU=$(top -bn1 | grep load | awk '{printf "%.2f\t\t\n", $(NF-2)}')
	echo "$CPU"

	if [[ "$CPU" > "$max1" ]]; then
	 max1="$CPU"
  	fi
	CpuUsage=`echo $CpuUsage + $CPU | bc`
	count=`echo $count + 1 | bc`

	sleep 5
	done
	AvgCpu $CpuUsage $count
	echo "Maximum CPU :$max1 "
	fi
	
	if [ "$2" == "disk" ];
	then
	printf "Disk\n"
	while [ $SECONDS -le $end ]; do
	DISK=$(df -h | awk '$NF=="/"{printf "%.2f\t\t", $5}')
	echo "$DISK"

	if [[ "$DISK" > "$max2" ]]; then
        max2="$DISK"
  	fi
	count=`echo $count + 1 | bc`
	DiskUsage=`echo $DiskUsage + $DISK | bc`

	sleep 5
	done
	AvgDisk $DiskUsage $count
	echo "Maximum DISK :$max2 "
	fi
else 

end=$((SECONDS+$1))
      printf "Memory\t\tDisk\t\tCPU\n"
	while [ $SECONDS -le $end ]; do
		MEMORY=$(free -m | awk 'NR==2{printf "%.2f\t\t",$3*100/$2 }')
		DISK=$(df -h | awk '$NF=="/"{printf "%.2f\t\t", $5}')
		CPU=$(top -bn1 | grep load | awk '{printf "%.2f\t\t\n", $(NF-2)}')
		echo "$MEMORY$DISK$CPU"
		
		
	mem=`echo  $mem + $MEMORY | bc`
	DiskUsage=`echo $DiskUsage + $DISK | bc`
	CpuUsage=`echo $CpuUsage + $CPU | bc`
	count=`echo $count + 1 | bc`


  if [[ "$MEMORY" > "$max" ]]; then
     max="$MEMORY"
  fi
 if [[ "$CPU" > "$max1" ]]; then
     max1="$CPU"
  fi
 if [[ "$DISK" > "$max2" ]]; then
     max2="$DISK"
  fi

	sleep 5
done


AvgMemory $mem $count

AvgDisk $DiskUsage $count

AvgCpu $CpuUsage $count


echo "Maximum memory :$max "
echo "Maximum CPU :$max1 "
echo "Maximum DISK :$max2 "

fi

#grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'

