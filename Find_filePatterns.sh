#! /bin/bash
if [[ $# -ne 2 ]];
then       
	echo "usage:$0 <file type> <pattern>"
	exit 102
fi 
find *.$1|xargs grep $2
