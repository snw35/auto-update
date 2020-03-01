#!/bin/bash
set -Eeuo pipefail

# Allow machine to start up and be ready
sleep 120

# Try for dpkg lock
exec {lock_fd}>/var/lib/dpkg/lock || exit 1
flock -n "$lock_fd" || { su - "$USER" -c 'notify-send "Auto-Updater" "Unable to aquire dpkg lock"'; exit 1; }

# Upgrade everything automatically
DEBIAN_FRONTEND=noninteractive \
apt-get update \
&& apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" full-upgrade \
&& apt-get autoremove -y \
&& apt-get autoclean -y

# Release dpkg lock
flock -u "$lock_fd"

# Automatically restart services that need it
needrestart -r a

# Check for kernel upgrades
if [ "$(needrestart -b |grep NEEDRESTART-KSTA | awk '{print $2}')" -eq 1 ]; then
  exit 0
else
  su - "$USER" -c 'notify-send "Auto-Updater" "New kernel installed, reboot required"'
fi
