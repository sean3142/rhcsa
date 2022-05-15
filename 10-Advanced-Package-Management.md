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

> postgresql-9
> postgresql-10

We can use the `dnf module list` command to query the modules available for postgres.

```
[sean@rhel-1 ~]$ dnf module list postgresql
AppStream
Name       Stream Profiles           Summary                            
postgresql 9.6    client, server [d] PostgreSQL server and client module
postgresql 10 [d] client, server [d] PostgreSQL server and client module
postgresql 12     client, server [d] PostgreSQL server and client module
postgresql 13     client, server [d] PostgreSQL server and client module

Hint: [d]efault, [e]nabled, [x]disabled, [i]nstalled
```

To use a module other than the default, one can simply specify the module/stream in the command.  Use the format <package>:<stream>/<profile>.  For example 

```
[sean@rhel-1 ~]$ dnf module install postgresql:9.6/client
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
