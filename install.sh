#!/bin/bash

CWD="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

# move script files to /etc/scripts/buptime
[ -e /etc/scripts/buptime ] || sudo mkdir -p /etc/scripts/buptime
sudo cp $CWD/scripts/*.sh /etc/scripts/buptime

# move on_unplugged.rules file to /etc/udev/rules.d/
sudo cp $CWD/scripts/power_unplugged.rules /etc/udev/rules.d/power_unplugged.rules

# make symmetric link of buptime.sh to /usr/bin/buptime
sudo ln -s /etc/scripts/buptime/buptime.sh /usr/bin/buptime
