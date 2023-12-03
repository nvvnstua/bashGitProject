#!/bin/bash


cd ~/workspace

#Find firstName in Script
name1="$(grep -w 'firstName' variable.sh)"

#Find lastName in Script
name2="$(grep -w 'lastName' variable.sh)"
name2="$(echo $name2 head -n1 | awk '{print $1;}')"

#Find myAge in Script
age="$(grep -w 'myAge' variable.sh)"
age="$(echo $age head -n1 | awk '{print $1;}')"

#Pull the value of the variable
name1value=${name1#*=}
name2value=${name2#*=}
agevalue=${age#*=}

#Strip comments and whitespace from line
name1var="$(echo $name1value | cut -d# -f1)"
name1var="${name1var%"${name1var##*[![:space:]]}"}"
echo "firstName variable is $name1var"

#Strip comments and whitespace from line
name2var="$(echo $name2value | cut -d# -f1)"
name2var="${name2var%"${name2var##*[![:space:]]}"}"
echo "lastName variable is $name2var"

#Strip comments and whitespace from line
agevar="$(echo $agevalue | cut -d# -f1)"
agevar="${agevar%"${agevar##*[![:space:]]}"}"
echo "myAge variable is $agevar"

echo
#Is variable empty?
if [ -z "$name1var" ]
then
      echo "\$firstName is empty"
      exit 1
else
      echo "\$firstName is NOT empty"
fi

#Is variable empty?
if [ -z "$name2var" ]
then
      echo "\$lastName is empty"
      exit 1
else
      echo "\$lastName is NOT empty"
fi

#Is variable empty?
if [ -z "$agevar" ]
then
      echo "\$myAge is empty"
      exit 1
else
      echo "\$myAge is NOT empty"
fi

## Check for correct program output

echo
StudentFile=$(bash variable.sh)

if [[ "$(echo "$StudentFile" | tr -d '[:space:]')" =~ "$(echo "The user's full name is $name1var $name2var" | tr -d '[:space:]')" ]]; then 
    echo "Full name message displayed correctly"
else
    echo "User full name message displayed incorrectly"
    exit 1
fi

if [[ "$(echo "$StudentFile" | tr -d '[:space:]')" =~ "$(echo "They are $agevar years old" | tr -d '[:space:]')" ]]; then 
    echo "Age message displayed correctly"
else
    echo "User age message displayed incorrectly"
    exit 1
fi

echo
echo "Great Job!"
exit 0