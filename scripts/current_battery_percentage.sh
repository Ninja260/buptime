#!/bin/bash

output=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage:)
output=${output//"percentage:"/}

# trim whitespaces
battery_percentage=$(echo "$output" | xargs)

echo $battery_percentage
