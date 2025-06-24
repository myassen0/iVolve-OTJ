# Lab 2: Disk Management and Logical Volume Setup

---

## 📋 Objective

This lab demonstrates fundamental Linux disk management tasks, focusing on creating partitions and managing **LVM (Logical Volume Manager)**. The goal is to practice dynamic disk resizing and flexible storage configuration using Volume Groups and Logical Volumes.

---

## 🛠️ Tasks Overview

1. **Attach a new 6 GB virtual disk** to your VM.
2. **Create two partitions** on the disk:
   - First partition: **2 GB**
   - Second partition: **3 GB**
3. **Set up LVM:**
   - Initialize the **2 GB** partition as a **Physical Volume (PV)**.
   - Create a **Volume Group (VG)** using that PV.
   - Create a **Logical Volume (LV)** from the VG.
4. **Extend the Logical Volume:**
   - Add the **3 GB** partition to the same VG.
   - Extend the existing LV to include the new space.

---

## 📦 Requirements

- Linux VM (CentOS, RHEL, or Ubuntu recommended)
- `lvm2` package installed
- A second virtual disk with **6 GB** of storage (unformatted)

---

## 🧱 Step-by-Step Instructions
### 1. Verify the New Disk
```bash
lsblk
fdisk -l
```
```
NAME                  MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sr0                    11:0    1  9.7G  0 rom
nvme0n1               259:0    0   30G  0 disk
├─nvme0n1p1           259:1    0  600M  0 part /boot/efi
├─nvme0n1p2           259:2    0    1G  0 part /boot
└─nvme0n1p3           259:3    0 28.4G  0 part
  ├─cs-root           253:0    0 25.4G  0 lvm  /
  └─cs-swap           253:1    0    3G  0 lvm  [SWAP]
nvme0n2               259:4    0    6G  0 disk
```
![image](https://github.com/user-attachments/assets/4049ddcb-8c58-48a6-a0f2-2f9da0d5c68b)

Assume the new disk is `/dev/nvme0n2`

### 2. Create Partitions
```bash
sudo fdisk /dev/nvme0n2
```
- Create:

   - /dev/nvme0n2p1 `2 GB`

   - /dev/nvme0n2p2  `3 GB`

- Change partition type to `8e` (Linux LVM)

- Write and exit
#### Refresh partition table:
```bash
partprobe
```

### 3. Initialize LVM
#### Create Physical Volume (PV)
```bash
sudo pvcreate /dev/nvme0n2p1
```

#### Create Volume Group (VG)
```bash
sudo vgcreate vg_lab /dev/nvme0n2p1
```

#### Create Logical Volume (LV)
```bash
sudo lvcreate -L 1.5G -n lv_lab vg_lab
```
⚠️*Note: You can create the LV slightly smaller than the PV to leave room for metadata if desired.*

#### Format the Logical Volume with ext4:
```
sudo mkfs.ext4 /dev/vg_yassen/lv_data
```

#### Create Mount Point and Mount the LV:
```
sudo mkdir /mnt/lv_data
sudo mount /dev/vg_yassen/lv_data /mnt/lv_data
```
### 4. Extend the Logical Volume

#### Add Second Partition to VG:
```bash
sudo pvcreate /dev/nvme0n2p2
sudo vgextend vg_lab /dev/nvme0n2p2
sudo vgdisplay
```
![image](https://github.com/user-attachments/assets/ded88a4a-1aab-435b-a4f2-ee91d044fd21)

#### Extend the Logical Volume:
```bash
sudo lvextend -l +100%FREE /dev/vg_lab/lv_lab
```
#### Resize Filesystem:
```
sudo resize2fs /dev/vg_lab/lv_lab
```
#### Confirm Final Size :
```
df -h /mnt/lv_data
```
![image](https://github.com/user-attachments/assets/24cf2d7d-a675-4a0a-90c9-6b6da6a06a09)

---

## ✅ Verification
```
lsblk
df -h
sudo vgs
sudo lvs
```
![image](https://github.com/user-attachments/assets/cddb50ac-9ca4-4f02-ad4f-9e2ee4dc1eb1)

---

👨‍💻 Author:




