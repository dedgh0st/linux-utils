#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Error: Log in as root first before running this script."
  exit 1
fi

if [ "$#" -ne 2 ]; then
  echo "Usage: ./change_username.sh <old_username> <new_username>"
  exit 1
fi

OLD_USER="$1"
NEW_USER="$2"

if ! id "$OLD_USER" &>/dev/null; then
  echo "Error: User '$OLD_USER' does not exist."
  exit 1
fi

if pgrep -u "$OLD_USER" > /dev/null; then
  killall -u "$OLD_USER"
  sleep 2
fi

echo "Renaming user '$OLD_USER' to '$NEW_USER'..."
usermod -l "$NEW_USER" -d "/home/$NEW_USER" -m "$OLD_USER"
groupmod -n "$NEW_USER" "$OLD_USER"

passwd -l root
echo "Done! Rebooting in 5 seconds..."
sleep 5
reboot

