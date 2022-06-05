# Basic User Management
## Commands
`w`
* `whoami`
* `last` - Displays all last logons from `/var/log/wtmp`, a binary file.
  * `last reboot`
* `lastb` - Failed Logon attempts. 
* `lastlog` - Logon attempts from all users.
* `id` - User information (including SELinux)
* `groups` - Groups I am a member of
  * `groups` _user_ - Groups _user_ is member of.


## `/etc/login.defs` file

Upon account creation, the files located in `/etc/skel/` directory are copied to the user's home directory.  

```
[sean@rhel-1]$ ls -la /etc/skel
.
..
.bash_logout
.bash_profile
.bashrc
```
Commands `useradd`, `usermod` and `userdel` manage users.  Some common switches are shown in the table below.

| Switch | Function 		|
| :----: | :------		|
| `-b`   | Default `/home`	|
| `-s`	 | Shell (`/bin/bash`)	|
| `-c`   | Convention to use users full name	|
| `-m`	 | Create the _home_ directory |
| `-d`	 | Home directory path	|
| `-e`   | Account Expiry date |
| `-u`	 | Set UID	|
| `-g`	 | Set GID (default = UID)	|
| `-G`	 | Set additional user group	|
| `-D`   | Display contents of `/etc/default/useradd`	|
| `-k`	 | Skeleton Directory (`/etc/skel`) |
| `-f`	 | Auto disable _x_ days after password expiry  |
| `-o`	 | Share UID	|
| `-r`	 | Service account (no expiry, UID<1000) |


|	    | `/etc/login.defs` | `/etc/default/useradd` | 
| `useradd` | x	| x	|
| `usermod` |	| x 	|
| `userdel` |	| x	|
| `chage`   |	| x	|
| `passwd`  |	| x	|
