# Security Advanced Linux

| Term | Descriptor | Definition |
| :--: | ----------- | --------- |
| Subject | A user or processes accessing an object.  e.g. _system_u_. |
| Object  | File, Directory or hardware device.  e.g. *object_r* |
| Access  | Action performed on object by subject |
| Policy  | System-Wide set of security contexts |
| Context | Defines how a MAC behaves when a _subject_ accesses an _object |
| Label | a File's context |
| SELinux User | |
| Role | Group of subject policies. e.g. *user_r* |
| Type | Group of objects e.g *user_home_dir_t*
| Domain | Group of Subjects (Processes) e.g. *firewall_t* |
| Level | Policy configurable parameters |

## Controlling SELinux Module
Get the current running status of SELinux
```
[sean@rhel-1 ~]$ getenforce
Enforcing
[sean@rhel-1 ~]$ sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Memory protection checking:     actual (secure)
Max kernel policy version:      33
```
SELinux may be disabled (non-retentetively) with `setenforce 0`.  To change the state of SELinux at boot time, edit the file `/etc/selinux/config`
```
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= can take one of these three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected. 
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
```

## Label

Labels are in the format
```
user : role : type : [level]
```

e.g. 
```
[sean@rhel-1 ~]$ ls -lZ /usr/sbin/httpd
-rwxr-xr-x. 1 root root system_u:object_r:httpd_exec_t:s0 579992 Mar 24 17:34 /usr/sbin/httpd

[sean@rhel-1 ~]$ ls -lZ /etc/httpd
total 4
drwxr-xr-x. 2 root root system_u:object_r:httpd_config_t:s0       37 May 18 21:39 conf
drwxr-xr-x. 2 root root system_u:object_r:httpd_config_t:s0      135 May 23 08:45 conf.d
drwxr-xr-x. 2 root root system_u:object_r:httpd_config_t:s0      266 May 23 08:45 conf.modules.d
-rw-------. 1 root root unconfined_u:object_r:httpd_config_t:s0 1854 May 18 20:32 key.pem
...
```
## Context
Example:
The `http_t` context contains the following types

| type |
| :--- |
| `httpd_config_t` |
| `httpd_log_t` |
| `httpd_content_t` |
| `httpd_unit_file_t` |

You can change the context in _long-form_ using the following command.  

```
[sean@rhel-1 ~]# chcon -u <user> -r <role> -t <type> <file>
[sean@rhel-1 ~]# chcon -u system_u -r object_r -t httpd_content_t /var/www/html/new.php
```
Typically for a _targeted_ policy, the user and role arguments are not required.
```
[sean@rhel-1 ~]# chcon -t httpd_content_t /var/www/html/new.php
```
...or we could use a referene file to alter the context.
```
[sean@rhel-1 ~]# chcon --reference /var/www/html/index.php /var/www/html/new.php
```
...or we could make everything within the sub-tree equivalent to the directory.
```
[sean@rhel-1 ~]# restorecon -R /var/www/html/
```


## Bools

```
[sean@rhel-1 ~]$ getsebool -a
```

## Troubleshooting
Install the troubleshooting tools
```
[sean@rhel-1 ~]# dnf install setroubleshoot setroubleshoot-server
```
