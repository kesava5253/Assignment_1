#! /bin/bash


if [ $# -lt 2 ];
then       
	echo "usage:$0 <file type> <'pattern\|pattern'>"
	exit 102
fi

if [ $# -eq 2 ];
then
find *.$1|xargs grep $2

else

find *.$1 |xargs grep -i $2
fi
