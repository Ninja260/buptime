# Battery Uptime ( Linux )

Linux CLI program to get (battery) up-time info since power supply unplugged.
The program is only compatible for Linux distros, which uses systemd.

The installer have compatibility check.So you don't need to worry if you ran
the installer by accident.

```text
$ buptime

Battery Up-time: 1 hours, 15 minutes, 35 seconds
Active Time: 45 minutes
Suspend Time: 30 minutes, 35 seconds

Charged Percentage: 100%
Current Battery Percentage: 60%
Unplugged Time: 2024-12-14 17:14:34

Used Percentage: 40%
Used Percentage in Active Mode: 35%
Used Percentage in Suspend Mode: 5%
```

## Installation

Clone the github repo and run the installation script.

```text
git clone https://github.com/Ninja260/buptime.git
cd buptime
./install.sh
```

## Uninstallation

Run the uninstallation script.

```text
./uninstall.sh
```
