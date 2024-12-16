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

# show Still calculating message
function need_wait {
  value=$(cat $CWD/resumed)
  echo $value
}

wait=$(need_wait)
calculating=0

if [[ "$wait" == 1 ]]; then
  calculating=1
  echo "Calculation in progress..."
fi

while [[ "$wait" == 1 ]]; do
  sleep 1
  wait=$(need_wait)

  if [[ "$wait" != 1 ]]; then
    # clear the progress message
    tput cuu1
    tput el
  fi
done

## Calcualte battery_uptime, last_charged_percentage,
## current_battery_percentage, unplugged_time_str

logfile='/var/log/buptime/on_unplugged.log'

unplugged_time=$(tail -n +2 "$logfile" | head -n 1) # read the second line

last_charged_percentage=$(head -n 1 "$logfile") # read the first line
last_charged_percentage="${last_charged_percentage%%%}"

current_time=$(date +%s)

battery_uptime=$(($current_time - $unplugged_time))

current_battery_percentage=$(bash $CWD/current_battery_percentage.sh)

unplugged_time_str=$(date -d @$unplugged_time +"%Y-%m-%d %H:%M:%S")

# Calculate used_percentage since unplugged
used_percentage=$(($last_charged_percentage - $current_battery_percentage))

# Calculate total_active_time, total_suspend_time
# Calculate used_percent_in_active, used_percent_in_suspend

total_suspend_time=0
used_percentage_in_suspend=0
declare -i suspend_time
declare -i resume_time
declare -i suspend_percentage
declare -i resume_percentage

while IFS= read -r line; do
  if [[ "$line" =~ ^S ]]; then
    temp_line=${line#S } # remove "S " prefix

    IFS=' ' read -r suspend_time suspend_percentage <<<"$temp_line"
  fi
  if [[ "$line" =~ ^R ]]; then
    temp_line=${line#R } # remove "R " prefix

    IFS=' ' read -r resume_time resume_percentage <<<"$temp_line"

    total_suspend_time=$(($total_suspend_time + $resume_time - $suspend_time))
    used_percentage_in_suspend=$(($used_percentage_in_suspend + $suspend_percentage - $resume_percentage))
  fi
done <"/var/log/buptime/on_suspend_and_resume.log"

total_active_time=$(($battery_uptime - $total_suspend_time))
used_percentage_in_active=$(($used_percentage - $used_percentage_in_suspend))

# Print the formatted output
echo "
Battery Up-time: $(bash $CWD/human_readable_time.sh $battery_uptime)
Active Time: $(bash $CWD/human_readable_time.sh $total_active_time)
Suspend Time: $(bash $CWD/human_readable_time.sh $total_suspend_time)

Charged Percentage: $last_charged_percentage%
Current Battery Percentage: $current_battery_percentage%
Unplugged Time: $unplugged_time_str

Used Percentage: $used_percentage%
Used Percentage in Active Mode: $used_percentage_in_active%
Used Percentage in Suspend Mode: $used_percentage_in_suspend%

"
