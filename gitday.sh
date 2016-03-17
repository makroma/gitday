#!/bin/bash

function gitday {
  function logger {
    printf "${ORANGE}YOUR GITDAY FOR $DAY.$MONTH.$YEAR LOOKS LIKE THIS${NC}:\n"
    git log --first-parent --pretty="%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=format:'%H:%M' --after="$YEAR-$MONTH-$DAY 00:00" --before="$YEAR-$MONTH-$DAY 23:59" | cat
    printf "${ORANGE}Hit enter for next day${NC}:\n"
  }

  STR=$1
  DAY=$(echo $STR | cut -f1 -d-)
  MONTH=$(echo $STR | cut -f2 -d-)
  YEAR=$(echo $STR | cut -f3 -d-)
  ORANGE='\033[0;33m'
  NC='\033[0m'

  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
      echo "Date param: dd-mm-yyyy"
      return
  else
    logger
  fi

  while IFS= read -r -s ; do
    if [[ $REPLY = "" ]]; then
      if [[ $DAY -lt 31 ]]; then
        ((DAY=DAY+1))
        logger
      elif [[ $DAY -eq 31 ]]; then
        DAY=1
        ((MONTH=MONTH+1))
        logger
      elif [[ $DAY -eq 31 && $MONTH -eq 12 ]]; then
        DAY=1
        MONTH=1
        ((YEAR=YEAR+1))
        logger
      fi
    fi
  done
}
