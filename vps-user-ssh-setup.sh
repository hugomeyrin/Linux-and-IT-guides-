#!/bin/bash

# Variables
USERNAME="myuser"
SSH_PORT=22
EDIT_SSH_PORT=false
SSHD_CONFIG="/etc/ssh/sshd_config"
BACKUP_CONFIG="${SSHD_CONFIG}.bak_$(date +%Y%m%d%H%M%S)"

# Args parsing
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --username)
      USERNAME="$2"
      ;;
    --ssh-port)
      EDIT_SSH_PORT=true
      SSH_PORT="$2"
      shift
      ;;
    *)
      echo "Unknowned option : $1"
      echo "Usage : $0 [--username] [--ssh-port <port>]"
      exit 1
      ;;
  esac
  shift
done

# Check if user already exixts
if id "$USERNAME" &>/dev/null; then
  echo "ℹ️ User $USERNAME already exists."
else
  # Create new user and add it to sudo group
  adduser "$USERNAME"
  usermod -aG sudo "$USERNAME"
  echo "✅ The user $USERNAME has been created and added to sudo group."
fi

# Save SSHD file as backup in case something goes wrong
cp "$SSHD_CONFIG" "$BACKUP_CONFIG"
echo "📦 Backup of $SSHD_CONFIG done : $BACKUP_CONFIG"

# Secure SSH

# Disable root login
sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' "$SSHD_CONFIG"

# Disable password authentication
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' "$SSHD_CONFIG"
sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' "$SSHD_CONFIG"
sed -i 's/^#UsePAM yes/UsePAM no/' "$SSHD_CONFIG"
sed -i 's/^UsePAM yes/UsePAM no/' "$SSHD_CONFIG"

# change SSH PORT if needed
if [ "$EDIT_SSH_PORT" = true ]; then
  sed -i -E 's/^#?Port[[:space:]]+[0-9]+/Port $SSH_PORT/' "$SSH_CONFIG"
fi

# Check SSHD config before applying it
sshd -t
if [ $? -eq 0 ]; then
  # Restart SSH service
  systemctl restart sshd
  echo "🔐 Secure SSH access: root disabled, password disabled."
else
  echo "❌ Syntax error in $SSHD_CONFIG. Restoring backup."
  cp "$BACKUP_CONFIG" "$SSHD_CONFIG"
  systemctl restart sshd
fi
