# Advanced Package Management
## Package Groups
### Environment Groups
* Server
* Server with GUI
* Minimal Install
* Workstation
* Virtualization Host
* Custom

## Module
A Module is a "set" of packages.  Sometimes packages in a module have inter-dependencies.  Other times they may rely on each-other in user-space.  E.g. the PostgreSQL __module__ may be:

> postgres 
> +-- postgres-plperl
> +-- postgres-python3
> +-- postgres-server
> +-- postgres-docs
> +-- postgres-contrib


### Module Stream
Described as a *virtual repository*, this normally describes a major release and subsequent packages.  For example,

> php-7.2
> php-7.4

We can use the `dnf module list` command to query the modules available for php.
```
[sean@rhel-1 ~]$ dnf module list php
Name Stream  Profiles                   Summary               
php  7.2 [d] common [d], devel, minimal PHP scripting language
php  7.3 [e] common [d], devel, minimal PHP scripting language
php  7.4     common [d], devel, minimal PHP scripting language
php  8.0     common [d], devel, minimal PHP scripting language
Hint: [d]efault, [e]nabled, [x]disabled, [i]nstalled
```
Each of the above modules will have it's own minor releases.  Once enabled, a `dnf update` command will take minor releases from a module and apply them.
Here is an exmaple where we switch out an already installed php:7.3 module with php7.4.
```
[sean@rhel-1 ~]# dnf remove php
[sean@rhel-1 ~]# dnf module reset php:7.3
[sean@rhel-1 ~]# dnf module enable php:7.4
[sean@rhel-1 ~]# dnf install php
```

### Module Profiles
These are subsets of all packages contained in a module design for a specific user-case.  E.g. 
* postgres
    * client - *Module Pofile* may not install the full database engine if requests are served from a remote server  
    * server

* httpd
    * minimal
   * development - May install additional headers required for compiling.

## Repository
Library of Packages. The out-of-the-box examples are shown under the `repolist` command below.  Other common examples are EPEL (Extra Packages for Enterprise Linux) and [rpm fusion](https://rpmfusion.org).
```
[sean@rhel-1 ~]$ dnf repolist
repo id             repo name
appstream           Rocky Linux 8 - AppStream
baseos              Rocky Linux 8 - BaseOS
jxtras              Rocky Linux 8 - Extras
```

## Software Management with dnf

### dnf Config File

`/etc/dnf/dnf.conf` is the dnf configuration file formatted as ini.

### dnf Command
* Automatically resolves dependancies (rpm does not)
* Softlink to `yum` as of RHEL 8

* `dnf repoquery` - List all packages available from enabled repos
    * `--repo "BaseOS"` will limit the output to a given repo
    * Will return repos with incompatible architecture 
* `dnf list` - All available for install from enabled repos
* `dnf list installed` 
* `dnf list updates` - Show packages which can be updated
* `dnf list <package>` - Show package availability
* `dnf remove <package>` - Show package availability

