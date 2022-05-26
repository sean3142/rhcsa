# System Initialisation, Message, Logging, and System Tuning

* __Socket__ - Communication method for different processes to pass commands/data
* __D-Bus__ - Allow Multiple Services to communicate in parallel

## sytemd
1. Create Sockets
2. Create daemons
3. Cache client requests in socket buffer

### Unit Files

`<name>.<type>`

Unit files are stored in the following directories

* `/usr/lib//systemd/system` - System Unit files, installed by packages
* `/etc/systemd/user` - User unit files 
* `/run/systemd/system` - High Priority _runtime_ unit files, normally destroyed after boot

#### Types
| Type Name	| Function
| :-----------: | ---------
| service	| start/stop/reload/restart daemons and processes
| socket	| Manages socket 
| target	| Defines grouping of multiple units
| automount	| automatic mounting capabilities when required by process e.g. during boot check-disk
| device	| Linked to kernel devices - Can be used to activate process
| mount	| Controls mounting/unmounting of file systems
| path	| Triggers paired unit when inotify detects filesystem directory is altered.
| scope	| Groups externally created processes into groups for resource management
| slice	| Abstraction above scope
| swap	| Manages swap space
| timer	| Time-based trigger activation of other units

### systemctl command

| Sub-Command | Description |
| :-----------: | --------- |
| start		| Start		 |
| stop		| Stop		 |
| restart	| Restart 	 |
| enable	| Enable	 |
| disable	| Disable	 |
| kill		| Kill		 |
| status	| Status	 |
| mask		| Prevents enable/disable commands working |
| get(set)-default	| Get/Set the boot target |
| list-sockets 	| list sockets	 |
| list-unit-files 	| list unit files	 |
| list-unit	| list units |
| list-dependencies	| list dependencies |

## Targets
A target is equivalent to the __run-level__ in init.
For example, the following command will cause the next reboot to stop at a shell and not load the GUI.
```
[sean@rhel-1 ~]# systemctl set-default multi-user.target
```

# Logs
`rsyslogd`

## Journals
Journals are stored under `/run/log/journal` i.e. in system memory.  They are not persistent by default.  Notice the below co mmand to print journal from _previous_ boot would return no results.  Persistance has the following modes which can be set in the `/etc/systemd/journald.conf` configuration file.

| mode | Description |
|:----:| ----------- | 
| volatile | Memory Only | 
| persistent | Stores to disk under `/var/log/journal` (generates directory if non-existent) | 
| auto (default) | Stores to disk if `/var/log/journal` exists | 
| none | disables volatile and non-volatile journals | 

`mkdir /var/log/journal/` will cause the journald process to automatically begin logging data.  The binary data is stored under the machine UUID also found under `/etc/machine-id`.

### journalctl

* `journalctl -b` - Since last boot
* `journalctl -b -1` - Since previous boot
* `journalctl -e` - Bottom of the list
* `journalctl -x` - Cross reference error code with catalogue to give helpful text
* `journalctl -k` - Kernel messages
* `journalctl -n3` - Show 3 lines
* `journalctl -r` - Show reverse
* `journalctl -f` - follow
* `journalctl /usr/sbin/crond` - Relating to given service
* `journalctl -p err` - Priority Error (see syslog priorities)
* `journalctl __PID=$(pgrep chronyd)` - Relating to given PID
* `journalctl __SYSTEMD_UNIT=sshd.service` - Relating to given unit
* `journalctl --since 2022-05-18 --until 2022-05-19` - Relating to given time

## System Tuning

RHEL has a systemd daemon _tuned.service_ which "tunes" the OS performance.  

`ls /usr/lib/tuned`
* accelerator-performance
* balanced
* desktop
* functions
* hpc-compute
* intel-sst
* latency-performance
* network-latency
* network-throughput
* optimize-serial-console
* powersave
* recommend.d
* throughput-performance
* virtual-guest
* virtual-host


