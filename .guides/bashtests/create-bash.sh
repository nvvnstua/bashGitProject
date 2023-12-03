#!/bin/bash
# bash_history edit
. ~/workspace/.guides/bashtests/function.sh  #import functions from function.sh

bash_history=~/.bash_history
check_file=create-bash
hist_file="/home/codio/workspace/.guides/bashtests/$check_file.txt"

echo "$check_file" >> $bash_history
grep -A2000 -e "^$check_file" $bash_history > "/home/codio/workspace/.guides/bashtests/${check_file}.txt"

# Must match for erasing history
RES_HIST=0
COUNT=0
QCOUNT=2  #  How many requirements/test cases there are

function test_command {  #  Add test cases for lines you expect to have been run by this point
	(( COUNT ++ ))
	if [[ $COUNT -le $QCOUNT ]]; then
		case $COUNT in
			1 )
				expect_command "chmod +x newbash" "Make newbash an Execuable"
				;;
			2 )
				expect_command "./newbash" "Run newbash Executable"
				;;			
		esac
	else 
    echo "Well done!"
    return 0
	fi
}


test_command
