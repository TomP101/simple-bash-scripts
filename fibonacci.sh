#!/bin/bash



fibonacci(){
	n=$1	
	if [ $n -eq 0 ] ; then
		echo $n 
	elif [ $n -eq 1 ] ; then
		echo $n
	else
		fib1=$(fibonacci $((n - 1)))	
		fib2=$(fibonacci $((n - 2)))
		echo $((fib1 + fib2))
	fi
}

NUM=$(fibonacci $1)
echo $NUM 
