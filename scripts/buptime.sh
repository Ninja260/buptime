#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

capitalize_first() {
  local string="$1"
  local first_char="${string:0:1}"
  local rest_of_string="${string:1}"
  echo "${first_char^^}${rest_of_string}"
}

charging_state=$(bash $CWD/current_battery_state.sh)

if [[ "$charging_state" == "charging" ]]; then
  echo "Battery is currently charging, cannot evaluate battery up-time."
  exit 0 # Exit the script
fi

if [[ "$charging_state" != "discharging" ]]; then
  echo "Battery is not discharging.
Cannot evaluate battery up-time. [ $(capitalize_first $charging_state) ]"
  exit 0 # Exit the script
fi

logfile='/var/log/on_unplugged.log'

# Assign unplugged_time variable
unplugged_time=$(tail -n +2 "$logfile" | head -n 1)

# Assign last_charged_percentage variable
last_charged_percentage=$(head -n 1 "$logfile")

current_time=$(date +%s)

battery_uptime=$(bash $CWD/time_difference.sh $unplugged_time $current_time)

current_battery_percentage=$(bash $CWD/current_battery_percentage.sh)

# Get the current date and time
unplugged_time_str=$(date -d @$unplugged_time +"%Y-%m-%d %H:%M:%S")

# Print the formatted output
echo "Battery Up-time: $battery_uptime

Charged Percentage: $last_charged_percentage
Current Battery Percentage: $current_battery_percentage
Unplugged Time: $unplugged_time_str"
