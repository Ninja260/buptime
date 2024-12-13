#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

# remove symmetric link of /usr/bin/buptime
sudo rm /usr/bin/buptime

# remove on_unplugged.rules files from /etc/udev/rules.d/
sudo rm /etc/udev/rules.d/power_unplugged.rules

# remove "buptime" folder from /etc/scripts folder
sudo rm -r /etc/scripts/buptime/

echo "Uninstallation successful!"
