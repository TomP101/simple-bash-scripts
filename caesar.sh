#!/bin/bash

: ${3?"Usage: $1 SHIFT; $2 INPUT_FILE ; $3 OUTPUT_FILE "}

shift=$(($1 % 26))
input=$2
output=$3

if [ ! -e "$input" ];then
	echo "input file does not exist"
	exit 1
fi

lowercase=$(echo {a..z} | tr -d ' ')
uppercase=$(echo {A..Z} | tr -d ' ')

shift_lower=$(echo "$lowercase" | cut -c$((shift + 1))-26)
shift_lower_over=$(echo "$lowercase" | cut -c1-$((shift + 1))) 

shift_upper=$(echo "$uppercase" | cut -c$((shift + 1 ))-26) 
shift_upper_over=$(echo "$uppercase" | cut -c1-$((shift + 1 ))) 


while read  line; do
	#echo "$line" | tr "$lowercase$uppercase" "$shift_lower$shift_lower_over$shift_upper$shift_upper_over"
	new_line=$(echo "$line" | tr "$lowercase" "$shift_lower$shift_lower_over")
	new_line=$(echo "$new_line" | tr "$uppercase" "$shift_upper$shift_upper_over")
	
	echo $new_line >> $output	

done < $input
