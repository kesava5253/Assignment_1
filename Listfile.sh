#! bin/bash

echo "Username"
read user_name

echo "hostname"
read Host

script="ls"

ssh -X $user_name@$Host "${script}"


done

