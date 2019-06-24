#!/bin/bash

git_print_result() 
{
	if [ "$?" = "0" ]; then
		echo -e "git ${1} branch ${2} \033[32m SUCCESS \033[0m";
	else
		echo -e "git ${1} branch ${2} \033[31m Failed \033[0m";
	fi
}

git_add_to_remote_branch()
{		
	local curr_branch=$(git symbolic-ref --short -q HEAD)
	
	git push origin ${curr_branch}:${1}
	
	git_print_result add origin/$1
	
	# 关联远程分支
	git branch --set-upstream-to=origin/$1
		
	git_print_result relevance origin/$1	
}

git_add_to_remote_branch debug