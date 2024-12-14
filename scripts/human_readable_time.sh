#!/bin/bash

if [[ "$1" == "0" ]]; then
  echo "-"
  exit 0
fi

hours=$(($1 / 3600))
minutes=$((($1 % 3600) / 60))
seconds=$(($1 % 60))

result=""

if [[ "$hours" != "0" ]]; then
  result="$hours hours"
fi

if [[ "$minutes" != "0" ]]; then
  if [[ $result != "" ]]; then
    result="$result, "
  fi
  result="$result$minutes minutes"
fi

if [[ "$seconds" != "0" ]]; then
  if [[ $result != "" ]]; then
    result="$result, "
  fi
  result="$result$seconds seconds"
fi

echo $result
