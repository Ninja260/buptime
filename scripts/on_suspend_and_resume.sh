#!/bin/bash

# log unixtimestamps and battery percent on suspend and resume

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

current_battery_percentage_sh="$CWD/current_battery_percentage.sh"

if [[ "${CWD##*/}" == "system-sleep" ]]; then
  current_battery_percentage_sh="/etc/scripts/buptime/current_battery_percentage.sh"
fi

logfile="/var/log/on_suspend_and_resume.log"

timestamp=$(date +%s)

current_battery_percentage=$(bash "$current_battery_percentage_sh")

echo $current_battery_percentage

case "$1" in
pre)
  echo "S $timestamp $current_battery_percentage" >>"$logfile"
  ;;
post)
  echo "R $timestamp $current_battery_percentage" >>"$logfile"
  ;;
*)
  # nothing
  ;;
esac
