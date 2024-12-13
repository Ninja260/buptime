#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

battery_percentage=$(bash $CWD/current_battery_percentage.sh)
timestamp=$(date +%s)

logfile="/var/log/on_unplugged.log"

echo "$battery_percentage" >"$logfile"
echo "$timestamp" >>"$logfile"
