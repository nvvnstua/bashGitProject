#!/bin/bash
. ~/workspace/.guides/bashtests/function.sh


bash_history=~/.bash_history  # Set the history file.
BASHDIR=/home/codio/workspace/.guides
check_file=echo_checkfile
hist_file="$BASHDIR/bashtests/$check_file"

set -o history            # Enable the history.

echo "$check_file" >> $bash_history

grep -A2000 -e "^$check_file" $bash_history > "$BASHDIR/bashtests/${check_file}"
find "$hist_file" -type f -exec sed -i "s@~@$HOME@g" {} \; 

##

# if [[ "$(grep -w 'echo' .guides/bashtests/echo_checkfile)" == *'echo'* ]]; then
#   echo 'Nice command substitution!'
# else 
#   echo 'Check your command substitution'
#   exit 1
# fi

# Must match for erasing history
RES_HIST=0
COUNT=0
QCOUNT=1

function test_command {
	(( COUNT ++ ))
	if [[ $COUNT -le $QCOUNT ]]; then
		case $COUNT in
			1 )
				expect_command 'echo -n Success is not final , ;echo -n failure is not fatal: ;echo it is the courage to continue that counts.' "Check your echo statement, punctuation, spaces, and spelling."
				;;		
		esac
  else
    echo "Great Job!"
    cat /dev/null > ~/.bash_history && history -c
    return 0
	fi
}

test_command