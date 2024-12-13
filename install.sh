#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

# make empty /var/log/on_unplugged.log file
sudo touch /var/log/on_unplugged.log
sudo chmod 777 /var/log/on_unplugged.log

# move script files to /etc/scripts/buptime
[ -e /etc/scripts/buptime ] || sudo mkdir -p /etc/scripts/buptime
sudo cp $CWD/scripts/*.sh /etc/scripts/buptime

# move on_unplugged.rules file to /etc/udev/rules.d/
sudo cp $CWD/scripts/power_unplugged.rules /etc/udev/rules.d/power_unplugged.rules

# make symmetric links
sudo ln -s /etc/scripts/buptime/buptime.sh /usr/bin/buptime
sudo ln -s /etc/scripts/buptime/on_unplugged.sh /usr/bin/on_unplugged.sh

# Add auto start on frist login file
sudo cp $CWD/scripts/buptime.desktop ~/.config/autostart/buptime.desktop

echo "Installation successful!"
