#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

# remove auto start on first login file
sudo rm ~/.config/autostart/buptime.desktop

# remove symmetric link of /usr/bin/buptime
sudo rm /usr/bin/buptime
sudo rm /usr/bin/on_unplugged.sh

# remove on_unplugged.rules files from /etc/udev/rules.d/
sudo rm /etc/udev/rules.d/power_unplugged.rules

# remove "buptime" folder from /etc/scripts folder
sudo rm -r /etc/scripts/buptime/

# remove /var/log/on_unplugged.log file
sudo rm /var/log/on_unplugged.log

echo "Uninstallation successful!"
