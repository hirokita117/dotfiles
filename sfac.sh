#!/bin/bash

### set alias ########################################################################################
shopt -s expand_aliases
alias grep='grep --color=auto'
######################################################################################################

<<test
### check arguments ##################################################################################
if [[ ! -e $1 || $2 =~ [^0-9]+ ]]; then
	printf "\033[1;31mPlease set 3 arguments.\033[m\n"
	printf "\033[1;31mThe first argument is the file name.\033[m\n"
	printf "\033[1;31mThe second and third are integer.\033[m\n"
	printf "These integers are the threshold valuesâ€‹â€‹ of the search result of class name and function name, respectively.\n"
	printf "That is, if the number of search results is larger than the set number, the search is interrupted.\n"
	exit 1
fi
######################################################################################################
test

### prepare variables for use within functions #######################################################
#check_function=$2
#check_class=$3
check_function_num=0

file_name=`echo $1 | awk -F '/' '{print $NF}'`
#class_name=`echo $file_name | awk -F '.' '{print $1}'`
function_list=`grep -o 'function [a-z|A-Z]*' $1 | cut -f 2 -d ' '`
######################################################################################################


function functionInClassExists ()
{
	for search_function_existence in $function_list
	do
		grep -nr $search_function_existence ./ --exclude=$file_name
	done
}

function onlyListFunctionInClassExists ()
{
	for search_function_existence in $function_list
	do
		grep -lr $search_function_existence ./ --exclude=$file_name
	done
}

function minimumSearchResult ()
{
	for search_function_existence in $function_list
	do
		grep -nr $search_function_existence ./ --exclude=$file_name | awk '{print length() $0}' | awk -F '.' '{if($1<=300) print $0}'
	done
}

function numberOfUsedFunction ()
{
	for search_function_num in $function_list
	do
	number_of_used_function=`grep -nr $search_function_num ./ --exclude=$file_name | wc -l`
	let $((number_of_used_function+=number_of_used_function))
		if [ $number_of_used_function -gt $check_function_num ]; then
			printf "\033[1;31mFunction:\033[m Danger! Too many search results!\n"
			printf "\n"
			printf "\033[1msearch results ->\033[m $number_of_used_function\n"
			printf "\n"
			exit 1
		fi
	done
<<test
	functionInClassExists
	printf "\n"
	printf "\033[1msearch results ->\033[m $number_of_used_function\n"
	printf "\n"
test
}

<<test
if [ -z $check_function ]; then
	functionInClassExists
else
	numberOfUsedFunction
fi
test

for OPT in "$@"
do
	case "$OPT" in
		*.* )
		if [ -z $2 ]; then
			functionInClassExists
		fi
		shift 1
		;;
		-c | --cut )
		minimumSearchResult
		shift 1
		;;
		-l | --list )
		if [ -z $2 ]; then
			onlyListFunctionInClassExists
		elif [[ $2 =~ [0-9]+ ]]; then
			FLG_LIST="TRUE"
			list_argument=$2
		else
			printf "Error!\n"
		fi
		shift 2
		;;
	esac
done

if [ FLG_LIST="TRUE" ]; then
	check_function_num=$((check_function_num+list_argument))
	numberOfUsedFunction
	functionInClassExists
fi

<<test
if [  ]; then
		[0-9]* )
		numberOfUsedFunction
		functionInClassExists
		printf "\n"
		printf "\033[1msearch results ->\033[m $number_of_used_function\n"
		printf "\n"
		shift 1
		;;

fi
test


