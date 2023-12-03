#!/bin/bash
. ~/workspace/.guides/bashtests/function.sh


bash_history=~/.bash_history  # Set the history file.
BASHDIR=/home/codio/workspace/.guides
check_file=math_checkfile
hist_file="$BASHDIR/bashtests/$check_file"

set -o history            # Enable the history.

echo "$check_file" >> $bash_history

grep -A2000 -e "^$check_file" $bash_history > "$BASHDIR/bashtests/${check_file}"
find "$hist_file" -type f -exec sed -i "s@~@$HOME@g" {} \; 

# Must match for erasing history
RES_HIST=0
COUNT=0
QCOUNT=8

function test_command {
	(( COUNT ++ ))
	if [[ $COUNT -le $QCOUNT ]]; then
		case $COUNT in
			1 )
				expect_command 'echo $(( $num1 + $num2 ))' "Make sure to perform the first calculation"
				;;
			2 )
				expect_command 'echo $(( $num1 - $num2 ))' "Make sure to perform the second calculation"
				;;
			3 )
				expect_command 'echo $(( $num1 * $num2 ))' "Make sure to perform the third calculation"
				;;
			4 )
				expect_command 'echo $(( $num1 / $num2 ))' "Make sure to perform the fourth calculation"
				;;
      5 )
				expect_command '((num1+=7))' "Make sure to perform the fifth calculation"
				;;	
      6 )
				expect_command 'echo $(( $num1-=$15 ))' "Make sure to perform the sixth calculation"
				;;	
      7 )
				expect_command 'echo $(( $num1 % $num2 ))' "Make sure to perform the seventh calculation"
				;;	
      8 )
				expect_command 'echo $(( $num1 ** $num2 ))' "Make sure to perform the eighth calculation"
				;;			
		esac
  else
    echo "Great Job!"
    cat /dev/null > ~/.bash_history && history -c
    return 0
	fi
}

test_command