#!/bin/bash

output=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage:)
output=${output//"percentage:"/}

# trim whitespaces
battery_percentage=$(echo "$output" | xargs)
battery_percentage="${battery_percentage%%%}"

echo $battery_percentage
