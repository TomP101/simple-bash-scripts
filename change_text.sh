#!/bin/bash

OPTSTRING=":v:s:r:l:u:"

while getopts ${OPTSTRING} opt; do
	case ${opt} in
	v) echo "$OPTARG" | tr '[:upper:][:lower:]' '[:lower:][:upper:]' ;;
	s) read -p "Enter replaced word : " curr_word
 	 read -p "Enter word to replace it with : " new_word
	echo $(sed "s/$curr_word/$new_word/g" <<< "$OPTARG") ;;
	r) echo "$OPTARG" | rev ;;
	l) echo "$OPTARG" | tr '[:upper:]' '[:lower:]' ;;
	u)  echo "$OPTARG" | tr '[:lower:]' '[:upper:]' ;;
	?) echo "Invalid Option"
	  exit 1 ;;
	esac
done

