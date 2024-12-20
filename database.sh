#!/bin/bash

func=$1
database=$2

create_db(){
	touch $1.txt
}

create_table(){
	for name in ${@:2}; do
		echo -n "$name "  >> $database.txt
	done

}

insert_data(){

	args=${@:2}
	len=${#args}
	if [ $len -gt 38 ]; then
		echo -n "line length is: "
		echo $len
	
		echo "line cannot be longer than 38 characters"
		exit 1
	fi

	echo "" >> $database.txt 
	for name in ${@:2}; do
		echo -n "$name "  >> $database.txt
	done
	
}

#gets index of the table, if table cannot be found returns -1
get_index(){
	tables=($(head -n 1 $database.txt))
	table_chosen=$1
	table_index=-1
	temp_index=0
	for name in "${tables[@]}"; do
		if [[ $table_chosen == "${tables[$temp_index]}" ]]; then
			table_index=$temp_index      
		fi
		temp_index=$(($temp_index + 1))
 	done		
	return $table_index
}

select_data(){
	while read -r linia; do
		read -r -a tablica <<< "$linia"
		out=()
		for table in ${@:2}; do
			get_index $table
			index=$?
			
			if [ "$index" -le "${#tablica[@]}" ]; then
				out+="${tablica[$index]} "
			fi
		done
		echo "${out[*]}"
	done < $database.txt
}

delete_data(){
	input=$(echo $@ | tr "=" " ")
	read -r -a array <<< "$input"
	table=${array[1]}
	value=${array[2]}
	while read -r linia; do
		out=()
		read -r -a tablica <<< "$linia"
		get_index $table
		index=$?
		if [ "$index" -le "${#tablica[@]}" ] && [ ! $value == "${tablica[$index]}" ]; then
				echo $linia >> new_$database.txt
		fi
	done < $database.txt
	
	rm $database.txt
	mv new_$database.txt $database.txt
}

$func $database ${@:3}

