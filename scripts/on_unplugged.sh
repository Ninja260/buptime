#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

## Start: record unplugged time

battery_percentage=$(bash $CWD/current_battery_percentage.sh)
timestamp=$(date +%s)

logfile="/var/log/buptime/on_unplugged.log"

echo "$battery_percentage" >"$logfile"
echo "$timestamp" >>"$logfile"

## End: record unplugged time

## Start: carry the last line of the on_suspend_and_resume.log file with new timestamp and current_battery_percentage,
## if the last line is a suspend timestamp record.
## Otherwise, clear up the file

srlogfile="/var/log/buptime/on_suspend_and_resume.log"

last_line=$(tail -n 1 "$srlogfile")

if [[ "$last_line" != "" && "$last_line" =~ ^S ]]; then
  echo "S $timestamp $battery_percentage" >"$srlogfile"
else
  truncate -s 0 "$srlogfile"
fi

## End: carry the last line
