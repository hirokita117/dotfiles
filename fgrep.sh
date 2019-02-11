#!/bin/bash

### set alias ########################################################################################
shopt -s expand_aliases
alias grep='grep --color=auto'
######################################################################################################


### check arguments ##################################################################################
if [[ $# != 3 || ! -e $1 || ! $2 =~ [0-9]+ || ! $3 =~ [0-9]+ ]]; then
	printf "\033[1;31mPlease set 3 arguments.\033[m\n"
	printf "\033[1;31mThe first argument is the file name.\033[m\n"
	printf "\033[1;31mThe second and third are integer.\033[m\n"
	printf "These integers are the threshold values​​ of the search result of class name and function name, respectively.\n"
	printf "That is, if the number of search results is larger than the set number, the search is interrupted.\n"
	exit 1
fi
######################################################################################################


### prepare variables for use within functions #######################################################
check_class=$2
check_function=$3

file_name=`echo $1 | awk -F '/' '{print $NF}'`
class_name=`echo $file_name | awk -F '.' '{print $1}'`
function_list=`grep -o 'function [a-z|A-Z]*' $1 | cut -f 2 -d ' '`
######################################################################################################


function functionInClassExists ()
{
	for search_function_existence in $function_list
	do
		grep -nr $search_function_existence ./ --exclude=$file_name
	done
}

function numberOfUsedFunction ()
{
	for search_function_num in $function_list
	do
	number_of_used_function=`grep -nr $search_function_num ./ --exclude=$file_name | wc -l`
	let $((number_of_used_function+=number_of_used_function))
		if [ $number_of_used_function -gt $check_function ]; then
			printf "\033[1;31mFunction:\033[m Danger! Too many search results!\n"
			printf "\033[1msearch results ->\033[m $number_of_used_function\n"
			exit 1
		fi
	done

	functionInClassExists
}

function classExists ()
{
	grep -nr $class_name ./ --exclude=$file_name
	numberOfUsedFunction
}

function numberOfInheritedClass ()
{
	number_of_inherited_class=`grep -nr $class_name ./ --exclude=$file_name | wc -l`
	if [ $number_of_inherited_class -gt $check_class ]; then
		printf "\033[1;31mClass:\033[m Danger! Too many search results!\n"
		printf "\033[1msearch results ->\033[m $((number_of_inherited_class))\n"
		exit 1
	else
		classExists
	fi
}

numberOfInheritedClass | awk '{print length();}'

