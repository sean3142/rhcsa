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

