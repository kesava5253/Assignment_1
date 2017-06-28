#! bin/bash

if [ $# -lt 1 ];
then       
	echo "usage:$0 <missing argument> [optional]"
	echo "type command as argument"
	exit 102
fi
if [ $# -gt 3 ];
then
echo "Usage $0 : <command> [extension command] [directory]"
echo "maximum 3 commands arguments allowed"
exit 1
fi

echo "Username"
read user_name

echo "hostname"
read Host

if [ $# -eq 1 ];
then
script=$1

ssh -X $user_name@$Host "${script}"

elif [ $# -eq 2 ];
then
script=$1" "$2

ssh -X $user_name@$Host "${script}"

else
direc="/home/rihu/"$3
script=$1" "$direc"/"

ssh -X $user_name@$Host "${script}"

fi


#password as input pending

