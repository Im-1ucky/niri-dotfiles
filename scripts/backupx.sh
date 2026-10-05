#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_UUID="2b497b29-61ae-41b4-b72c-e501caeaf049"
HOME_UUID="61f17e69-74c8-4e78-b51a-93b7cee6f584"
BOOT_UUID="A323-28F7"

BASE="/run/arch-backup"
ROOT_MNT="$BASE/root"
HOME_MNT="$BASE/home"
BOOT_MNT="$BASE/boot"

cleanup() {
  sync || true
  umount "$BOOT_MNT" 2>/dev/null || true
  umount "$HOME_MNT" 2>/dev/null || true
  umount "$ROOT_MNT" 2>/dev/null || true
  rmdir "$BOOT_MNT" "$HOME_MNT" "$ROOT_MNT" "$BASE" 2>/dev/null || true
}
trap cleanup EXIT

if [[ $EUID -ne 0 ]]; then
  echo "Run with: sudo $0"
  exit 1
fi

for cmd in rsync lsblk blkid mount umount findmnt; do
  command -v "$cmd" >/dev/null || {
    echo "Missing command: $cmd"
    exit 1
  }
done

for uuid in "$ROOT_UUID" "$HOME_UUID" "$BOOT_UUID"; do
  blkid -U "$uuid" >/dev/null || {
    echo "ERROR: expected backup filesystem UUID not found: $uuid"
    echo "Refusing to continue."
    exit 1
  }
done

ROOT_DEV="$(blkid -U "$ROOT_UUID")"
HOME_DEV="$(blkid -U "$HOME_UUID")"
BOOT_DEV="$(blkid -U "$BOOT_UUID")"

# Never allow an NVMe device to be used as the backup destination.
for dev in "$ROOT_DEV" "$HOME_DEV" "$BOOT_DEV"; do
  case "$dev" in
  /dev/nvme*)
    echo "ERROR: refusing to use NVMe device $dev"
    exit 1
    ;;
  esac
done

mkdir -p "$ROOT_MNT" "$HOME_MNT" "$BOOT_MNT"
mount "$ROOT_DEV" "$ROOT_MNT"
mount "$HOME_DEV" "$HOME_MNT"
mount "$BOOT_DEV" "$BOOT_MNT"

echo "Backup destinations:"
findmnt -T "$ROOT_MNT" -o TARGET,SOURCE,FSTYPE
findmnt -T "$HOME_MNT" -o TARGET,SOURCE,FSTYPE
findmnt -T "$BOOT_MNT" -o TARGET,SOURCE,FSTYPE
echo
echo "WARNING: rsync --delete will remove files from the backup that no longer exist internally."
echo "No partitioning or formatting will be performed."
echo
read -r -p 'Type BACKUP to continue: ' confirm
[[ "$confirm" == "BACKUP" ]] || {
  echo "Cancelled."
  exit 0
}

RSYNC=(rsync -aAXH --delete --delete-delay --info=progress2)

echo "=== Backing up / ==="
"${RSYNC[@]}" --exclude='/dev/*' --exclude='/proc/*' --exclude='/sys/*' --exclude='/run/*' --exclude='/tmp/*' --exclude='/mnt/*' --exclude='/media/*' --exclude='/home/*' --exclude='/boot/*' --exclude='/lost+found' / "$ROOT_MNT/"

echo "=== Backing up /home ==="
"${RSYNC[@]}" --exclude='/lost+found' /home/ "$HOME_MNT/"

echo "=== Backing up /boot ==="
"${RSYNC[@]}" /boot/ "$BOOT_MNT/"

sync
echo "Backup completed successfully."
echo "External SSD was not formatted or repartitioned."
