# Basic Storage Partitioning
## Parted
You can edit both MBR (msdos) and GPT partitions with the `parted` command.

| subcommand | Function | 
| :--------: | -------- |
| print	| displays partition table |
| mklabel | Applies a label to the disk i.e. gpt or msdos | 
| mkpart | Creates a new Partition |
| name | Assigns name to partition |
| rm | Removes the specified partition |

```
[sean@rhel-1 rhcsa]$ sudo parted /dev/vda mklabel gpt
[sean@rhel-1 rhcsa]$ sudo parted /dev/vda mkpart MyPartName 1 101M
```

Note that a gpt table must have a __name__ specified in mkpart.  Also, msdos partitions must have the __type__ specified as either __primary__, __logical__ or __extended.

The `/proc/partitions` file produces a list of current partitions.


## Virtual Data Optimiser
Kernel module to handle filesystems.  Offers three advantages.

* Defragmentation
* Compression
* Deduplication

| subcommand | Function | 
| :--------: | -------- |
| create | Adds new vdo volume |
| status | prints status info | 
| list | lists vdo volumes |
| start | start vdo volume |
| stop | you can guess |

