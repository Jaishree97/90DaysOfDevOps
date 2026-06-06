# Day 13 - Linux Logical Volume Manager (LVM)

## Task

Learn LVM to manage storage flexibly by creating, mounting, and extending volumes.

---

## Task 1: Check Current Storage

Run: `lsblk`, `pvs`, `vgs`, `lvs`, `df -h`

### Screenshot

![Current Storage](images/01-list-all.png)

---

## Task 2: Verify Attached Volumes

Run: `lsblk`

### Screenshot

![Attached Volumes](images/02-after-creating-ataching-volumes.png)

---

## Task 3: Create Physical Volume

### Screenshot

![PV Creation](images/03-pv-creation.png)

---

## Task 4: Create Volume Group

### Screenshot

![VG Creation](images/04-vg-creation.png)

---

## Task 5: Create Logical Volume

### Screenshot

![LV Creation](images/05-lv-creation.png)

---

## Task 6: Mount and Format  

### Screenshot

![Format and Mount](images/06-mount-format-vg-lv.png)

---

## Task 7: Extend the Volume

### Screenshot

![LV Extend](images/09-lv-extend.png)

---

## Task 8: Mounting Disk Directly

### Screenshot

![Mount Disk Directly](images/08-mount-format-disk.png)

---

## Task 9: Verify Data Persistence

### Screenshot

![Data Persistence](images/07-testing-umount-mount.png)

---

## Additional LVM Inspection Commands

Run: `pvdisplay`, `vgdisplay`, `lvdisplay`

### Purpose
- `pvdisplay` - Shows detailed information about Physical Volumes (PV)
- `vgdisplay` - Shows detailed information about Volume Groups (VG)
- `lvdisplay` - Shows detailed information about Logical Volumes (LV)

These commands help verify LVM configuration, inspect storage allocation, and troubleshoot storage-related issues.

---

## Commands Used

- `lsblk` - List block devices and their mount points
- `df -h` - Show filesystem disk usage in human-readable format
- `pvcreate /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1` - Initialize disks as Physical Volumes (PV)
- `pvs` - List all Physical Volumes
- `pvdisplay` - Display detailed Physical Volume information
- `vgcreate devops-vg /dev/nvme1n1 /dev/nvme2n1` - Create a Volume Group from PVs
- `vgs` - List all Volume Groups
- `vgdisplay` - Display detailed Volume Group information
- `lvcreate -L 10G -n tws-lv devops-vg` - Create a 10 GB Logical Volume
- `lvs` - List all Logical Volumes
- `lvdisplay` - Display detailed Logical Volume information
- `mkfs.ext4 /dev/devops-vg/tws-lv` - Create ext4 filesystem on the Logical Volume
- `mount /dev/devops-vg/tws-lv /mnt/tws-vg-mount` - Mount the Logical Volume
- `umount /mnt/tws-vg-mount` - Unmount the Logical Volume
- `lvextend -L +5G /dev/devops-vg/tws-lv` - Extend Logical Volume by 5 GB
- `resize2fs /dev/devops-vg/tws-lv` - Resize the filesystem after extending the LV
- `mkfs -t ext4 /dev/nvme3n1` - Create ext4 filesystem on a standalone disk
- `mount /dev/nvme3n1 /mnt/tws-disk-mount` - Mount the standalone disk

---

## What I Learned

- Learned the LVM storage hierarchy: Physical Volume (PV) → Volume Group (VG) → Logical Volume (LV).
- Learned how to convert raw disks into Physical Volumes using `pvcreate`.
- Learned how to combine multiple Physical Volumes into a single Volume Group using `vgcreate`.
- Learned how to create and manage Logical Volumes using `lvcreate`.
- Learned how to format and mount Logical Volumes using the ext4 filesystem.
- Learned the difference between mounting a Logical Volume and mounting a disk directly.
- Learned how to verify storage configuration using `pvs`, `vgs`, `lvs`, and `lsblk`.
- Learned how to inspect detailed LVM information using `pvdisplay`, `vgdisplay`, and `lvdisplay`.
- Learned how to safely unmount storage using `umount`.
- Learned how to extend a Logical Volume dynamically using `lvextend` and resize the filesystem using `resize2fs`.
---
