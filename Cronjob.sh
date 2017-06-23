#!/bin/bash
CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
THRESHOLD=1 
if [ "$CURRENT" -gt "$THRESHOLD" ] ;
 then
mail -s 'Disk Space Alert' ratnakesavareddy@gmail.com << EOF
Your root partition remaining free space is critically low. Used: $CURRENT%
EOF
echo Disk Space Alert
else
echo no problem
fi
