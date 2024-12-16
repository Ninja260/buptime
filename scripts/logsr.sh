#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"
# create flock to make sure that two instances of the logsr script
# wont run at the same time.
exec 100>$CWD/buptime.lock || exit 1
flock 100 || exit 1

# log unixtimestamps and battery percent on suspend and resume

logfile="/var/log/buptime/on_suspend_and_resume.log"

timestamp=$(date +%s)

## sleep for 12 seconds if it is resume log
if [[ "$1" == resume ]]; then
  sleep 25
fi

current_battery_percentage=$(bash "$CWD/current_battery_percentage.sh")

case "$1" in
suspend)
  echo "S $timestamp $current_battery_percentage" >>"$logfile"
  ;;
resume)
  echo "R $timestamp $current_battery_percentage" >>"$logfile"
  ;;
*)
  # nothing
  ;;
esac
