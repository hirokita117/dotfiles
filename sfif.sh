#!/bin/bash

### set arguments #############################################################################################
cut_number=$2
i=0
declare -a array=()

######################################################################################################

### help #############################################################################################
function usage ()
{
	echo "Hello!"
}

######################################################################################################

### check arguments #############################################################################################
for OPT in "$@"
do
	case "$OPT" in
		-h | --help )
			usage
			exit 1
		;;
		*.* )
			if [ ! -e $1 ]; then
				echo "このファイルはありません"
			fi
			FLAG_A="TRUE"
			check_file=$1
			shift 1
		;;
		[1-9] | [1-9][0-9] | [1-9][0-9][0-9] )
			if [ -z $FLAG_A ]; then
				echo "Error"
				exit 1
			fi
			FLAG_B="TRUE"
			shift 1
		;;
		* )
			echo "てすと"
			exit 1
		;;
	esac
done

######################################################################################################

function_list_number=`grep -o 'function [^_][a-z|A-Z|_|0-9]*' $check_file | awk '{if(gsub(/function /, "")) print}' | wc -l`

while [ "$i" -le "$function_list_number" ]
do
	cut_function_in_list=`grep -o 'function [^_][a-z|A-Z|_|0-9]*' $check_file | awk -v i="$i" 'NR==i {if(gsub(/function /, "")) print}'`
	array+=("$cut_function_in_list")
	if [ "$i" -gt 0 ]; then
		echo "$i) "${array[$i]}
	fi
	((i++))
done

read -p "please select number: " key

if [[ $key =~ [^0-9]+ || -z ${array[$key]} ]]; then
	echo "Error"
	exit 2
fi

search_thing=${array[$key]}

if [ "$FLAG_B" = "TRUE" ]; then
	grep -nrw "$search_thing" | awk -v cutNum="$cut_number" 'num=substr($0, 1, cutNum) {print num}'
elif [ "$FLAG_A" = "TRUE" ]; then
	grep -nrw "$search_thing" --color=auto
fi
