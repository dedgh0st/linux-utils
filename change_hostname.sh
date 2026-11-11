#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: sudo ./change_hostname.sh <new_hostname>"
  exit 1
fi

NEW_HOST="$1"
OLD_HOST=$(hostname)

echo "Changing hostname from '$OLD_HOST' to '$NEW_HOST'..."
sudo hostnamectl set-hostname "$NEW_HOST"
sudo sed -i "s/\b$OLD_HOST\b/$NEW_HOST/g" /etc/hosts

echo "Done! Hostname is now '$NEW_HOST'. Restart your terminal to see it."

