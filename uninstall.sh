#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

# remove auto start on first login file
sudo rm ~/.config/autostart/buptime.desktop

# remove symmetric link of /usr/bin/buptime
sudo rm /usr/bin/buptime
sudo rm /usr/bin/on_unplugged.sh

# remove on_suspend_and_resume.sh file from /lib/systemd/system-sleep/
sudo rm /lib/systemd/system-sleep/on_suspend_and_resume

# remove on_unplugged.rules files from /etc/udev/rules.d/
sudo rm /etc/udev/rules.d/power_unplugged.rules

# remove "buptime" folder from /etc/scripts folder
sudo rm -r /etc/scripts/buptime/

# remove "buptime" folder from /var/log folder
sudo rm -r /var/log/buptime/

echo "Uninstallation successful!"
