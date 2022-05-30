# Remote File Systems
## NFS
Creating an NFS export is easy.
### Server-Side
1. Install the NFS Utilities. This packages provides functions for both client and server.
```
[sean@rhel-1 ~]# dnf install nfs-utils
```
2. Start the daemon using systemd `systemctl start nfs-server`
3. Create the `/etc/exports` file with a share on each line in the format <directory>	<client>(<options>) e.g.
```
/data		10.0.0.0/8(ro) 192.168.1.0/24(rw)
/datapool	192.168.8.123(rw)
```
4. Open the firewall port (typically 111 and 2049 UDP and TCP.  
```
[sean@rhel-1 ~]# firewall-cmd --permanent --add-service nfs
[sean@rhel-1 ~]# firewall-cmd --reload
```
5. Run the `exportfs` command to enable the export
```
[sean@rhel-1 ~]# exportfs -av
```

### Client-Side
1. Install the nfs-utilities.
2. Mount the filesystem. Server is connected to client on 192.168.8.122.
```
[sean@rhel-1 ~]# mount -t nfs 192.168.8.122:/data /mnt
```
3. Edit the `/etc/fstab` file to make the mount permanent, include the `_netdev` in options to make ensure networking is alive before mount is attempted.
```
192.168.8.122:/data	/mnt	nfs	_netdev,rw	0	0
```

