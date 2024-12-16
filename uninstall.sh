#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

# uninstall buptime service
sudo systemctl stop buptime.service
sudo systemctl disable buptime.service
sudo rm /etc/systemd/system/buptime.service
sudo systemctl daemon-reload
sudo systemctl reset-failed

# remove symmetric link of /usr/bin/buptime
sudo rm /usr/bin/buptime
sudo rm /usr/bin/on_unplugged.sh

# remove on_suspend_and_resume.sh file from /lib/systemd/system-sleep/
sudo rm /lib/systemd/system-sleep/on_suspend_and_resume

# remove on_unplugged.rules files from /etc/udev/rules.d/
sudo rm /etc/udev/rules.d/power_unplugged.rules

# remove "buptime" folder from /etc/scripts folder
sudo rm -r /etc/scripts/buptime/

# remove log files
sudo rm -r /var/log/buptime/

echo "Uninstallation successful!"
