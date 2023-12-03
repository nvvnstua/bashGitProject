#!/bin/bash

StudentFile=$(bash ~/workspace/evenOrOdd.sh)
source ~/workspace/evenOrOdd.sh > /dev/null

echo "Now Testing..."

# Have odd and even variables been set?
if [[ -v odd ]]
then
  echo "odd variable is set"
else
  echo "odd is not set"
fi

if [[ -v even ]]
then
  echo "even variable is set"
else
  echo "even is not set"
fi

# Are odd and even variables arrays?
if declare -p odd 2>/dev/null | grep -q 'declare -a'; then
  echo odd is array variable
else 
  echo odd is not an array
fi

if declare -p even 2>/dev/null | grep -q 'declare -a'; then
  echo even is array variable
else 
  echo even is not an array
fi

#Check for first test statement
doesExist=0
while read -r line; do
    if [[ $line == *'[ ${even[2]} -gt ${odd[2]} ]'* ]]
    then
      echo "I found it!"
      echo $line
      ((doesExist=doesExist+1))
    fi
done <~/workspace/evenOrOdd.sh

if [[ $doesExist -eq 1 ]]
then
  echo "First comparison test statement found"
else
  echo "First comparison test statement not found"
  exit 1
fi

# $?
if [[ "$(grep -w 'echo' ~/workspace/evenOrOdd.sh)" == *'echo $?'* ]]; then
  echo 'Test Result Returned Correctly'
else 
  echo 'Test Result Returned Incorrectly'
  exit 1
fi

# CHECK FOR USE OF COMMANDS
# echo
if [[ "$(grep -w '&&' ~/workspace/evenOrOdd.sh)" == *' $((${even[4]} + ${odd[3]})) -gt 10 ] && echo "This is larger than 10"'* ]]; then
  echo 'Extended test statement found'
else 
  echo 'extended test statement missing'
  exit 1
fi

echo
echo "Awesome Work!!"
exit 0




