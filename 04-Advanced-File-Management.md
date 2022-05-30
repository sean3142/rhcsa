# Advanced File Management
## File Permissions
File have read-write-execute permissions against user-group-other.
* files have default permissions of 666
* directories have default permissions of 777

## `umask`
These file persmissions are automatically modified by the umask integer.  Default umasks are
* 022 for root 
* 002 for all other users 
### Example
Creating a file with the default umask of 002 will generate permissions of 775 (777-002).
```
[sean@rhel-1 ~]$ umask 
0002
[sean@rhel-1 ~]$ touch file1
[sean@rhel-1 ~]$ ls -l file1
-rw-rw-r--. 1 sean sean 0 May 30 14:13 file1

[root@rhel-1 ~]# umask -S
u=rwx,g=rx,o=rx
[root@rhel-1 ~]# touch file2
[root@rhel-1 ~]# stat -c %a %A %n file2
664 -rw-rw-r-- file2
```

## Special File Persmissions

| | __Executable__ | __Directory__ | 
| :---: | :---: | :---: | 
| __setuid__ | Run as Owner | No Effect |
| __setgid__ | Run as Group | Inherit Dir Permissions |
| _sticky__ | No Effect | Prevent Deletion by Group |

### User Identifier (setuid) bit
When set on a binary executable file, the file will be run with file owner's privileges regardless of who envoked the execution.
```
[sean@rhel-1 ~]$ touch file3 
[sean@rhel-1 ~]$ chmod u+s file3 	# Set setuid bit
[sean@rhel-1 ~]$ ls -l file3
-rwsrwxr-x. 1 sean sean 0 May 30 14:17 file3
[sean@rhel-1 ~]$ chmod -4000 +s file3 	# reset setuid bit
```
## Groud Identifier (setgit) bit
Much like the setuid bit, an executable will be run and have _group_ level privileges during execution.
```
[sean@rhel-1 ~]$ chmod +2000  file3 	# Set setuid bit
[sean@rhel-1 ~]$ ls -l file3
-rwxrwsr-x. 1 sean sean 0 May 30 14:17 file3
[sean@rhel-1 ~]$ chmod u-g file3 	# Reset setuid bit
```

However when set for a **directory**, files created within that directory will inherit owners group.

## Searching Files
```
[sean@rhel-1 ~]$ find . -name Letter.md
[sean@rhel-1 ~]$ find . -iname letter.md	# Case Insensitive
[sean@rhel-1 ~]$ find . -size -2M 		# Less than 2M size
[sean@rhel-1 ~]$ find . -user sean 		# Owned by me
[sean@rhel-1 ~]$ find . -maxdepth 2  		# All files 2 directory layers below .
[sean@rhel-1 ~]$ find . -type d  		# All Directories (b for block, c for char, l for link)
[sean@rhel-1 ~]$ find . -mtime +31  		# Modified __more than__ one month ago
[sean@rhel-1 ~]$ find . -mmin -60  		# Modified __within__ previous hour
```

Execute commands on files found.  For example, delete all files less than 60-minutes old.
```
[sean@rhel-1 ~]$ find . -mtime -60 -exec rm {} \;
[sean@rhel-1 ~]$ find . -mtime -60 -ok rm {} \;
```
* The `{}` denotes the argument position in the find file.  
* `\;` is a delimited end-of-line.
* The `-ok` flag is equivalent but with a confirmation at each line.

#### Case Insensitive
```
[sean@rhel-1 ~]$ find . -iname letter.md
```

