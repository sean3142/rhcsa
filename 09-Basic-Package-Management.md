# Basic Package Management

## Overview

* Binary Packages
* Source Packages

Packages contain 

### Package Contents
1. pre-installation scripts
2. post-installation scripts
3. executables
4. configuration files,
5. library files
6. dependancy information
7. install locations
8. Documentation
	a. Install instructions
	b. Uninstall instructions
	c. Config file man-pages
	d. Command man-pages

### Package Intelligence
1. Prerequisites
2. User account setup (where required)
3. directories & soft-links
4

### Package Database

`/var/lib/rpm`

## rpm Command

| Command | Description |
|---------|:------------|
|   -e    | Erase	|
| --force | Re-install	|
|   -F    | Freshen (Upgrade)	|
|   -h    | Shows install Progress	|
|   -i    | Install	|
|   -K    | Validate Signature	|
|   -U    | Upgrade (or install) |
|   -V    | Verify Installation |

### Queries

| Command | Description |
|---------|:------------|
|    -qa     | All - Lists all installed Packages  |
|    -qc     | Config - Lists all Config Files  |
|    -qf     | File - Which package does this file belong to? |
|    -qi     | Info - Show package info |
|    -ql     | List - List all files in package |
|    -qR     | Requires - List dependancies |

``` Query (-q) All (-a) Packages
[sean@rhel-1 ~]$ rpm -qa openssh-server 
checkpolicy-2.9-1.el8.x86_64
libmodulemd-2.13.0-1.el8.x86_64
libxslt-1.1.32-6.el8.x86_64
libsolv-0.7.19-1.el8.x86_64
python3-systemd-234-8.el8.x86_64
gpgme-1.13.1-9.el8.x86_64
...

``` 

``` Query (-q) Config (-c) 
[sean@rhel-1 ~]$ rpm -qc openssh-server 
/etc/pam.d/sshd
/etc/ssh/sshd_config
/etc/sysconfig/sshd
```

``` Query (-q) info (-i) 
[sean@rhel-1 ~]$ rpm -qi openssh-server 
Name        : openssh-server
Version     : 8.0p1
Release     : 10.el8
Architecture: x86_64
Install Date: Tue 10 May 2022 15:48:56 BST
Group       : System Environment/Daemons
Size        : 1034256
License     : BSD
Signature   : RSA/SHA256, Mon 11 Oct 2021 02:23:46 BST, Key ID 15af5dac6d745a60
Source RPM  : openssh-8.0p1-10.el8.src.rpm
Build Date  : Mon 11 Oct 2021 02:18:12 BST
Build Host  : ord1-prod-x86build002.svc.aws.rockylinux.org
Relocations : (not relocatable)
Packager    : infrastructure@rockylinux.org
Vendor      : Rocky
URL         : http://www.openssh.com/portable.html
Summary     : An open source SSH server daemon
Description :
OpenSSH is a free version of SSH (Secure SHell), a program for logging
into and executing commands on a remote machine. This package contains
the secure shell daemon (sshd). The sshd daemon allows SSH clients to
securely connect to your SSH server.
```
### Verify
```
[sean@rhel-1 ~]$ rpm -V openssh-server 
S.?....T.  c /etc/ssh/sshd_config
..?......  c /etc/sysconfig/sshd
missing   d /usr/share/man/man8/sshd.8.gz
```


| Code | Description |
|---------|:------------|
>| S| file Size differs                                  
>| M| Mode differs (includes permissions and file type)
>| 5| digest (formerly MD5 sum) differs
>| D| Device major/minor number mismatch
>| L| readLink(2) path mismatch
>| U| User ownership differs
>| G| Group ownership differs
>| T| mTime differs
>| P| caPabilities differ
