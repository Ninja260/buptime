#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

# create log files
sudo mkdir /var/log/buptime
sudo touch /var/log/buptime/on_unplugged.log
sudo chmod 777 /var/log/buptime/on_unplugged.log
sudo touch /var/log/buptime/on_suspend_and_resume.log
sudo chmod 777 /var/log/buptime/on_suspend_and_resume.log

# move script files to /etc/scripts/buptime
[ -e /etc/scripts/buptime ] || sudo mkdir -p /etc/scripts/buptime
sudo cp $CWD/scripts/*.sh /etc/scripts/buptime
sudo touch /etc/scripts/buptime/buptime.lock
sudo chmod 777 /etc/scripts/buptime/buptime.lock

# move power_unplugged.rules file to /etc/udev/rules.d/
sudo cp $CWD/scripts/power_unplugged.rules /etc/udev/rules.d/power_unplugged.rules

# move on_suspend_and_resume.sh file to /lib/systemd/system-sleep/
sudo cp $CWD/scripts/on_suspend_and_resume.sh /lib/systemd/system-sleep/on_suspend_and_resume

# make symmetric links
sudo ln -s /etc/scripts/buptime/buptime.sh /usr/bin/buptime
sudo ln -s /etc/scripts/buptime/on_unplugged.sh /usr/bin/on_unplugged.sh

# Add auto start on frist login file
sudo cp $CWD/scripts/buptime.desktop ~/.config/autostart/buptime.desktop

# run on_unplugged.sh on first install to make sure file are in place
sudo $CWD/scripts/on_unplugged.sh

echo "Installation successful!"
