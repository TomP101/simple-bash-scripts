#!/bin/bash

set -f #disable globbing in order to not have to escape * 

func="$1"
database=$2

create_db(){
	if [ -z "$1" ] ;then
		echo "no name provided"
		echo "use: ./database.sh create_db <database_name>"
		exit 1
	fi
	touch $1.txt
}

create_table(){
	if [ ! -f "$1.txt" ]; then
		echo "$1 database does not exist"
		echo "create $1 database with ./database.sh create_db $1 "
		exit 1
	fi
	if [ -z "$2" ] ;then
		echo "at least 1 table name has to be given"
		echo "use: ./database.sh create_table $1 <table_name>"
		exit 1
	fi


	echo -n "** " >> "$database".txt 


	for name in ${@:2}; do
		echo -n "$name "  >> "$database".txt
	done
	
	echo -n "** " >> "$database".txt 

	echo "" >> "$database".txt

}

insert_data(){

	
	args=${@:2}
	len=${#args}
	if [ "$len" -gt 38 ]; then
		echo -n "line length is: "
		echo "$len"
	
		echo "line cannot be longer than 38 characters"
		exit 1
	fi
	
	for arg in $args; do
		if [ ${#arg} -gt 8 ]; then
			echo "value cannot be longer than 8 characters"
			exit 1
		fi
	done

	echo -n "** " >> "$database".txt 

		
	for name in $args; do
		echo -n "$name "  >> "$database".txt
		
	done

	echo -n " **" >> "$database".txt 
		
	echo "" >> "$database".txt
	
}

#gets index of the table, if table cannot be found returns -1
get_index(){
	tables=($(head -n 1 "$database".txt))
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
			get_index "$table"
			index=$?
			
			if [ "$index" -le "${#tablica[@]}" ]; then
				out+="${tablica[$index]} "
			fi
		done
		echo "${out[@]}"
	done < "$database".txt
}

delete_data(){
	input=$(echo $@ | tr "=" " ")
	read -r -a array <<< "$input"
	table=${array[1]}
	value=${array[2]}
	while read -r linia; do
		out=()
		read -r -a tablica <<< "$linia"
		get_index "$table"
		index=$?
		if [ "$index" -le "${#tablica[@]}" ] && [ ! "$value" == "${tablica[$index]}" ]; then
				echo "$linia" >> new_"$database".txt
		fi
	done < "$database".txt
	
	mv -f new_"$database".txt "$database".txt

}

command_not_found_handle() {
	echo "no $1 commands"
	echo "available command: create_db create_table insert_data select_data delete_data"
}


$func "$database" ${@:3}

