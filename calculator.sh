#!/bin/bash

op=$1
result=$2

if [[ "${!#}" == "-d" ]]; then

	echo "USER: " $USER
	echo "Script: " $0
	echo "Operation: " $1
	echo "Numbers: ${@:2:$#-2}"
fi

for num in "${@:3}"; do 
		result=$(($result $op $num))
		done
echo $result

