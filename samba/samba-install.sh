#!/bin/bash
# Installs and configures Samba
set -euo pipefail

SAMBA_USER="mdelgert"

# Update package lists and install required packages
sudo apt update
sudo apt-get install -y samba

# Backup original Samba config if not already backed up
if [ ! -f /etc/samba/smb.original ]; then
    sudo cp /etc/samba/smb.conf /etc/samba/smb.original
fi

# Copy simplified Samba config
sudo cp smb.conf.simple /etc/samba/smb.conf

# Restart and enable Samba
sudo systemctl restart smbd
sudo systemctl enable smbd

# Show installed versions
samba --version

# Add Samba user (will prompt for password if not set)
sudo smbpasswd -a "$SAMBA_USER"

exit 0