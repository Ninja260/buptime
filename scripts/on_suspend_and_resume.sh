#!/bin/bash

# log unixtimestamps and battery percent on suspend and resume

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

logfile="/var/log/on_suspend_and_resume.log"

timestamp=$(date +%s)

current_battery_percent=$(bash $CWD/current_battery_percent.sh)

case "$1" in
pre)
  echo "S $timestamp $current_battery_percent" >>"$logfile"
  ;;
post)
  echo "R $timestamp $current_battery_percent" >>"$logfile"
  ;;
*)
  # nothing
  ;;
esac
