# Containers

```
[root@rhel-1 ~]# dnf group install 'Container Management'
```

* podman (unlike docker) does not run as root
* container images are stored in `/var/lib/containers`

## The `podman` Command

| Sub-Command	| Description		|
| -----------	| -----------		|
| `attach`	| Connect terminal to running container	|
| `run`		| Run a command in a new container |
| `rm`		| Remove idle (running if `-f`) container	|
| `images`	| List images in local storage |
| `pull`	| Pull image from registry	|

## Run as non-root user.

1. Create user `useradd podman user 
