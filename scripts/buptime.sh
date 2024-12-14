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

## Calcualte battery_uptime, last_charged_percentage,
## current_battery_percent, unplugged_time_str

logfile='/var/log/on_unplugged.log'

unplugged_time=$(tail -n +2 "$logfile" | head -n 1) # read the second line

last_charged_percentage=$(head -n 1 "$logfile") # read the first line

current_time=$(date +%s)

battery_uptime=$(($current_time - $unplugged_time))

current_battery_percentage=$(bash $CWD/current_battery_percentage.sh)

unplugged_time_str=$(date -d @$unplugged_time +"%Y-%m-%d %H:%M:%S")

## Calcuate total_active_time, total_suspend_time

total_suspend_time=0
declare -i suspend_time
declare -i resume_time

while IFS= read -r line; do
  if [[ "$line" =~ ^S ]]; then
    # remove "S "
    suspend_time=${line#S }
  fi
  if [[ "$line" =~ ^R ]]; then
    resume_time=${line#R }

    total_suspend_time=$(($total_suspend_time + $resume_time - $suspend_time))
  fi
done <"/var/log/on_suspend_and_resume.log"

total_active_time=$(($battery_uptime - $total_suspend_time))
# Print the formatted output
echo "Battery Up-time: $(bash $CWD/human_readable_time.sh $battery_uptime)
Active Time: $(bash $CWD/human_readable_time.sh $total_active_time)
Suspend Time: $(bash $CWD/human_readable_time.sh $total_suspend_time)

Charged Percentage: $last_charged_percentage
Current Battery Percentage: $current_battery_percentage
Unplugged Time: $unplugged_time_str"
