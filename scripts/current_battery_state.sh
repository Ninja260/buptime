#!/bin/bash

output=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state:)
output=${output//"state:"/}

# trim whitespaces
charging_state=$(echo "$output" | xargs)

echo $charging_state
