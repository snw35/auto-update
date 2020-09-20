#!/bin/bash
set -Eeuo pipefail

# Allow machine to start up and be ready
sleep 120

# Upgrade everything automatically
dnf update -y

# Check for kernel upgrades
RESTART=0
dnf needs-restarting -r || RESTART=$?
if [ $RESTART -eq 1 ]; then
  exit 0
else
  su - "$USER" -c 'notify-send "Auto-Updater" "New kernel installed, reboot required"'
fi
