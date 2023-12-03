#!/bin/bash

StudentFile=$(bash ~/workspace/systemReport.sh)


###   Testing
echo "Now Testing..."

# CHECK FOR USE OF COMMANDS
# echo
if [[ "$(grep -w 'echo' ~/workspace/systemReport.sh)" == *'echo "System Report for $HOSTNAME"'* ]]; then
  echo 'echo statement is there.'
else 
  echo 'echo statement is missing'
  exit 1
fi

# echo
if [[ "$(grep -w 'echo' ~/workspace/systemReport.sh)" == *'echo "System Report for $HOSTNAME"'* ]]; then
  echo 'echo statement is there.'
else 
  echo 'echo statement is missing'
  exit 1
fi

# CHECK FOR 2 TABS IN EACH TABLE ROW
lineTabs=$(grep -o -n '\\t' systemReport.sh | cut -d : -f 1 | uniq -c | awk '{ print $1 }')
row=0

for line in $lineTabs
do
  ((row=row+1))
  # echo "$line"
  if [ "$line" -ne 2 ]
  then
    echo Incorrect number of tabs in row $row 
    exit 1
  else
    echo Correct number of tabs in row $row
  fi
  
done

# CHECK FOR CORRECT NUMBER OF ROWS IN REPORT TABLE
if [ $row -lt 6 ]
then
  echo "Not enough rows in report table"
  exit 1
elif [ $row -gt 6 ]
then
  echo "Too many rows in report table"
  exit 1
else
  echo "Correct number of rows in report table"
fi

printCount=0
## CHECK FOR PRINTF COMMANDS
while read -r line; do
    if [[ $line == *'printf'* ]]
    then
      ((printCount=printCount+1))
      # echo "This line has print"
      # echo $line
      # echo "Lines with printf = $printCount"
    fi
done <~/workspace/systemReport.sh

if [[ $printCount -ne 6 ]]
then
  echo "Incorrect number of print statements"
  exit 1
else
  echo "Correct number of print statements"
fi

# CHECK FOR CORRECT PROGRAM OUTPUT FOR EACH LINE

if [[ "$(echo "$StudentFile" | tr -d '[:space:]')" =~ "$(echo "System Report for $HOSTNAME" | tr -d '[:space:]')" ]]; then 
    echo "System report message printed"
else
    echo "System report for host displayed incorrectly"
    exit 1
fi


if [[ "$(echo -e "$StudentFile")" =~ "$(printf "\tReport Date:\t%(%Y-%m-%d)T\n")" ]]; then 
    echo "Date reported"
else
    echo "Report date displayed incorrectly"
    exit 1
fi

if [[ "$(echo -e "$StudentFile")" =~ "$(printf "\tBash Version:\t%s\n" $BASH_VERSION)" ]]; then 
    echo "Bash Version reported"
else
    echo "Bash Version Reported Incorrectly"
    exit 1
fi


if [[ "$(echo -e "$StudentFile")" =~ "$(printf "\tKernel Release:\t%s\n" $(uname -r))" ]]; then 
    echo "Kernel Release reported"
else
    echo "Kernel Release Reported Incorrectly"
    exit 1
fi


if [[ "$(echo -e "$StudentFile")" =~ "$(printf "\tAvailable Storage:\t%s\n" $(df -h / | awk 'NR==2 {print $4}'))" ]]; then 
    echo "Available Storage Reported"
else
    echo "Available Storage Reported Incorrectly"
    exit 1
fi


if [[ "$(echo -e "$StudentFile")" =~ "$(printf "\tAvailable Memory:\t%s\n" $(free -h / | awk 'NR==2 {print $4}'))" ]]; then 
    echo "Available Memory Reported"
else
    echo "Available Memory Reported Incorrectly"
    exit 1
fi


if [[ "$(echo -e "$StudentFile")" =~ "$(printf "\tFiles in Directory:\t%s\n" $(ls | wc -l))" ]]; then 
    echo "Number of Directory Files Reported"
else
    echo "Number of Directory Files Reported"
    exit 1
fi

## IF YOU MADE IT THIS FAR, CONGRATS TO YOU!
echo "Fantastic Job!!"