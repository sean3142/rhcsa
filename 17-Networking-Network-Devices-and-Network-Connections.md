# Networking, Network Devices and Network Connections
`/etc/services` provides a list of well-known ports.
```
[sean@rhel-1 ~]$ parted /dev/vda set 2 lvm on
```
## NetworkManager
RHEL uses the Network Manager daemon to control network interfaces. There are three user interfaces.
* nmcli - command line (see below)
* nmtui - text user interface
* nm-connection-editor or nmgui - Graphical User Interface
### The Interface Config File

```
[sean@rhel-1 ~]$ cat /etc/sysconfig/network-scripts/ifcfg-enp1s0
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=dhcp
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
NAME=enp1s0
UUID=0e3dbb8c-36bc-49da-b9ef-f9597898b4e9
DEVICE=enp1s0
```
ONBOOT=no
```

| Parameter	| Description		|
| --------	| -----------		|
| BOOTPROTO	| DHCP or NONE/STATIC (same effect)	|
| DEFROUTE	| yes/no use this as default route	|
| DNS1		| DNS Server		|
| DEVICE	| Name of the network interface	|
| GATEWAY	| Default Gateway	|
| HWADDR	| MAC Address (not sure if this can be used to spoof	|
| IPV4_FAILURE_FATAL	| yes/no disable iface if failure to connect	|
| IPV6INIT	| Enable IPv6 Support	|
| NAME		| Same as DEVICE unless alias is desired	|
| NETMASK	| Subnet Mask if BOTOPROTO is STATIC	|
| NM_CONTROLLED	| yes/no allow changes via NetworkManager	|
| ONBOOT	| Enable during poot process	|
| PEERDNS	| Modify `/etc/resolv.conf` (Yes if BOOTPROTO=DHCP)	|
| PREFIX	| Subnet Mask	|
| TYPE		|  ??	|


### NetworkManager CLI Command `nmcli`

| Sub-Command		| Description		|
| `show`		| List connections	|
| `up`/`down`		| Brings up/down interface	|
| `add` 		| 			|

```

[root@rhel-1 ~]# nmcli connnection show
NAME    UUID                                  TYPE      DEVICE 
enp1s0  0e3dbb8c-36bc-49da-b9ef-f9597898b4e9  ethernet  enp1s0 
[root@rhel-1 ~]# nmcli con add		\
			type ethernet	\
			ifname enp0s8	\
			con-name enp0s8	\
			ip4 192.168.0.10/24 \
			gw4 192.168.8.1
```

