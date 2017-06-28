#!/bin/sh
if [ $# -eq 0 ];
then
echo "enter mail id"
read mailId
echo "enter threshold value"
read threshold
echo "enter when you want to get alert"
echo "enter minutes from 0-59"
read min
echo "enter hour from 0-23"
read h
echo "enter date from 1-31"
read d
echo "enter month from 1-12"
read m
echo "enter day of the week from 0-7"
read W


current=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')


	if [ "$current" -gt "$threshold" ] 
	then
 	( crontab -l ; echo "$min $h $d $m $W sh Cronjob2.sh $mailId $2 $3" ) | crontab -
	
	fi

fi

if [ $# -eq 1 ];
then

diskusage=$(df)
CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')

 mail -s 'Disk Space Alert' ratnakesavareddy@gmail.com << EOF
  Your root partition remaining free space is critically low 
    "Keshav System : Clean the Disk".
    Your System has Used: $CURRENT%

	echo ">>`date`<<" 	
EOF

    mail -s 'Disk Partition Alert' $1 << EOF

    Your root partition remaining free space is critically low 
    "Keshav System : Clean the Disk".
    Your System has Used: $CURRENT%

	echo ">>`date`<<" 	
EOF

fi

