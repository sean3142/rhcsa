# Basic Storage Partitioning
## Parted
You can edit both MBR (msdos) and GPT partitions with the `parted` command.

| subcommand | Function | 
| :--------: | -------- |
| `print`	| displays partition table |
| `mklabel` | Applies a label to the disk i.e. gpt or msdos | 
| `mkpart` | Creates a new Partition |
| `name` | Assigns name to partition |
| `rm` | Removes the specified partition |

### Creating a Partition with parted
#### msdos Table
`msdos` partitions must have the _type_ specified as either `primary`, `logical_ or `extended`.  The final two arguments are the start/end positions of the partition. The example shows a 100MiB partition starting at 1 MiB.
```
[sean@rhel-1 rhcsa]# parted /dev/vda mklabel msdos
[sean@rhel-1 rhcsa]# parted /dev/vda mkpart primary 1 101M
```
Tip: Use -1 for the end position to utilise the whole partition.  You will need to enter the parted shell or escape the '-' symbol.
#### gpt Table
The newer scheme, gpt doesn't need a _type_ specified.  However a name is mandatory and should be given in the 1st argument after the `mkpart` subcommand.
```
[sean@rhel-1 rhcsa]# parted /dev/vda mklabel gpt
[sean@rhel-1 rhcsa]# parted /dev/vda mkpart MyPartName 1 101M
```
### Other Utilities
Partitions can be viewed using a number of tools.  
* The `/proc/partitions` file produces a list of current partitions.
* `fdisk -l` command will give some additional information on partition sizes
* `parted <device> print` will also provide some information on a given physical device.


## Virtual Data Optimiser
Kernel module to handle filesystems.  Offers three advantages.

* Defragmentation
* Compression
* Deduplication

| subcommand | Function | 
| :--------: | -------- |
| `create` | Adds new vdo volume |
| `status` | prints status info | 
| `list` | lists vdo volumes |
| `start` | start vdo volume |
| `stop` | you can guess |

##
