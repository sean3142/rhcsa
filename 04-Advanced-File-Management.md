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

[root@rhel-1 ~]$ touch file2
[root@rhel-1 ~]$ touch file2

```

## The `find` Command
```
[sean@rhel-1 ~]$ find . -name Letter.md
```

#### Case Insensitive
```
[sean@rhel-1 ~]$ find . -iname letter.md
```

#### Case Insensitive
```
[sean@rhel-1 ~]$ find . -iname letter.md
```

