#!/bin/bash

time_difference=$(($2 - $1))

# Convert seconds to hours, minutes, and seconds
hours=$((time_difference / 3600))
minutes=$(((time_difference % 3600) / 60))
seconds=$((time_difference % 60))

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
