# Boot Process, GRUB2, and the Linux Kernel
1. Firmware Phase (BIOS/UEFI)
2. Bootloader Phase
3. Kernel Phase
4. Initialisation Phase

## Boot Process
### Firmware Phase
Bootloader
### Bootloader Phase
Grub2 bootloader will perform tasks based on the type of boot.  These tasks are loader from either of the below configuration files.
* BIOS - `/boot/grub2/grub.cfg`
* UEFI - `/boot/efi/EFI/redhat/grub.efi`

### Kernel Phase
Extracts Kernel initrd (initial RAM disk) from `/boot` in RAM, decompresss, mount as `/sysroot`.  initrd will contain the necessary drivers for the boot process e.g. disk, sata, network etc.  The main objective is to mount the full kernel to `/` root and start systemd as PID1.

### Initialisation Phase
Start services/units etc.

## Grub Configuration
Though the `/boot/[efi/EFI/redhat/]grub.cfg` file holds the configuration for the bootloader phase, this file is generated when the `grub2-mkconfig` utility is run.  This tool will read configuration stored in `/etc/default/grub` and `/etc/grub.d/`.

## Reset the Root Password

1. Press any key during system boot to enter the __grub menu__
2. Press __e__ to edit the one-time boot grub settings
3. Edit the grub config file to change the initramfs settings.
    a. Append the line starting *linux * with __rd.break__
    b. Exit grub settings and boot with __Ctrl-x__
4. Remount the root partition on /sysroot in read-write mode
    a. Command `mount -o remount,rw /dev/sda2 /sysroot`
    b. Use the `mount` command with not arguments to determine the device-id
5. chroot into the `/sysconfig` mount point
6. Run `passwd`
6. Create a `.autorelabel` file in the root directory to relabel the SELinux policies on all files.
7. reboot

## Kernel
The kernel is packaged in the same way as other rpm packages.  There are a few associate packages listed in the table below.

|Installed Packages        | |
|--------------------------|--- |
|kernel.x86_64             | |
|kernel.x86_64             | |
|kernel-core.x86_64        | |
|kernel-core.x86_64        | |
|kernel-devel.x86_64       | |
|kernel-headers.x86_64     | |
|kernel-modules.x86_64     | |
|kernel-modules.x86_64     | |
|kernel-tools.x86_64       | |
|kernel-tools-libs.x86_64  | | 

The kernel version may be determined with the command below.
```
[sean@rhel-1 ~]$ uname -r 
4.18.0-348.el8.0.2.x86_64
| |/ | \_/ \_/ | | \____/
| |  |  |   |  | |    |
| |  |  |   |  | |    +----- Archetecture
| |  |  |   |  | +---------- ??
| |  |  |   |  +------------ ??
| |  |  |   +--------------- Enterprise Linux 8
| |  |  +------------------- Red Hat version
| |  +---------------------- Kernel Patch Version
| +------------------------- Major Revision
+--------------------------- Major Version
```
Kernel files are stored in the `/boot` directory (filesystem) which is created during installation.  The 4 files below make up the kernel.
* _vmlinuz_ - Kernel File
* _initramfs_ - Boot Image
* _config_ - configuration
* _System.map_ - Mapping

Rock Linux Guide to [Compiling the Kernel](https://docs.rockylinux.org/guides/custom-linux-kernel/)

## /proc
* Virtual
* Stored in Memory
* 87817 files in tree (`find /proc | wc -l` on current systme)
* Status info on
    * Memory
    * CPU
* Device info
    * `/proc/cpuinfo`
    * `/proc/meminfo`
* Data in `/proc` is reference by ps, top, uptime etc.

