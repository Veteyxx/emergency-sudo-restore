#!/bin/bash
# Emergency sudo restore for Linux Mint 22.2

set -e  # Stop on errors

echo "Detecting all ext4 partitions..."
lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT | grep ext4

echo
read -p "Enter the full device name of your installed root partition (e.g., /dev/sdb2): " ROOT_PART

# Verify the device exists
if [ ! -b "$ROOT_PART" ]; then
    echo "Error: $ROOT_PART is not a valid block device. Exiting."
    exit 1
fi

echo "You selected: $ROOT_PART"
read -p "Are you sure you want to proceed? [yes/NO]: " CONFIRM
if [[ "$CONFIRM" != "yes" ]]; then
    echo "Aborted by user."
    exit 0
fi

echo "Mounting installed system..."
mount $ROOT_PART /mnt || { echo "Failed to mount $ROOT_PART"; exit 1; }

cleanup() {
    echo "Unmounting all bound directories..."
    umount -lf /mnt/dev/pts || true
    umount -lf /mnt/dev || true
    umount -lf /mnt/proc || true
    umount -lf /mnt/sys || true
    umount -lf /mnt || true
}
trap cleanup EXIT

echo "Binding system directories..."
mount --bind /dev /mnt/dev
mount --bind /dev/pts /mnt/dev/pts
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys

echo "Entering chroot and reinstalling sudo..."
chroot /mnt /bin/bash <<'EOF'
set -e
echo "Reinstalling sudo..."
apt update
apt install --reinstall sudo -y

echo "Fixing sudo permissions..."
chmod 4755 /usr/bin/sudo
chown root:root /usr/bin/sudo

echo "Verifying sudo..."
sudo whoami
EOF

echo "Sudo restoration complete! You can now reboot your system."

