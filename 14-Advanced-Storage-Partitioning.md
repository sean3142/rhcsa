# Advanced Storage and Partitioning
This chapter is mostly about LVM.

* LVM will break volumes into __extends__
  * Physical Extents (PEs) for disks/partitions
  * Logical Extents (LEs) for logical volumes
  * Default for both is 4MiB, alter with `-s` flag  
  * PE > LE or PE < LE both acceptable


1. You must have a gpt/msdos partition table available to provision for LVM (see above).
    a. According to literature, you may use a disk with or without a logical partition.
    b. In practice, I have had to create a partition
2. Set the lvm flag in the partition table (not convinced this is absolutely necessary).
```
[sean@rhel-1 ~]# parted /dev/vda set 2 lvm on
```
3. Inititalise the _Physical Volume_ on a device/partition.  A name is not required.
```
[sean@rhel-1 ~]# pvcreate /dev/vda1 /dev/vdc1
``` 
4. Create a __volume group__ using one or more Physical Volumes.  It must have a name.
```
[sean@rhel-1 ~]# vgcreate volg_1 /dev/vda1 /dev/vdc1
``` 
5. Create a __logical volume__. Specify LV name before VG if required (default lvoln). Length in PEs with `-l`, Eng Units - `-L`. 
```
[sean@rhel-1 ~]# lvcreate -L 1G volg_1
``` 
