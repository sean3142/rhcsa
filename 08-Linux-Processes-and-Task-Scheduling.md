# Linux Proccesses and Task Scheduling
## Processes and Priorties
### Process States

1. Running
2. Sleeping 
3. Waiting - for user/process input
4. Stopped - Halted until signal to start
5. Zombie - PID held until removed by parent process - no resources

### Moniroting with ps and top
```
[sean@rhel-1 ~]ps -eFl
F S UID          PID    PPID  C PRI  NI ADDR SZ WCHAN    RSS PSR STIME TTY          TIME CMD
4 S root           1       0  0  80   0 - 43767 -      13436   0 May09 ?        00:00:01 /usr/lib/systemd/systemd --switched-root --system --deserialize 18
1 S root           2       0  0  80   0 -     0 -          0   0 May09 ?        00:00:00 [kthreadd]
1 I root           3       2  0  60 -20 -     0 -          0   0 May09 ?        00:00:00 [rcu_gp]
1 I root           4       2  0  60 -20 -     0 -          0   0 May09 ?        00:00:00 [rcu_par_gp]
1 I root           9       2  0  60 -20 -     0 -          0   0 May09 ?        00:00:00 [mm_percpu_wq]
5 I root        6633       2  0  80   0 -     0 -          0   0 08:24 ?        00:00:00 [kworker/0:2-events_power_efficient]
0 S sean        6650    6567  0  80   0 - 11973 hrtime  9204   0 08:27 pts/0    00:00:00 vim 8-Linux-Processes-and-Task-Scheduling.md
1 I root        6656       2  0  80   0 -     0 -          0   0 08:30 ?        00:00:00 [kworker/0:1-events_power_efficient]
0 S sean        6657    6650  0  80   0 -  3181 -       2968   0 08:33 pts/0    00:00:00 /bin/bash -c ( ps -eFl) >/tmp/vwLOlE1/1 2>&1
0 R sean        6658    6657  0  80   0 - 14684 -       3932   0 08:33 pts/0    00:00:00 ps -eFl
```

| Column | Description |
|-------:|: -----------|
|    F     |   Forest - Shows parent/child level in heirarchy |
|    S     |   |
|    UID   | Owner's User ID  |
|    PID   | Process ID from  |
|    PPID  |   |
|    C     | CPU Utilisation  |
|    PRI   |   Priority - Scale from 0-80 |
|    NI    |   Niceness - -20 to 19|
|    ADDR  |   |
|    SZ    |   |
|    WCHAN |   |
|    RSS   |   |
|    PSR   |   |
|    STIME |   |
|    TTY   | Controlling Terminal (? for daemon)  |
|    TIME  | Execution time  |
|    CMD   | Command name  |

Tree-like output
```
[sean@rhel-1 ~]$ ps -x
``` 
The `top` command provides and interactive live display of metrics.
```
[sean@rhel-1 ~]$ top
``` Interactive output.

 * `pidof virt-manager`
 * `rgrep virt-manager`
 * `ps -U sean` PIDs started by me
 * `ps -G sean` PIDs started by my Group

## Niceness

Priority of process given by cpu scheduler.  
 * Typically ranges from -20 (highest priority) to +19.
 * Default is 0
 * You can increase the nice parameter of your own PIDs.
 * You need root to alter niceness of PIDs owned by others or decrease own.

Change at start of process
```
[sean@rhel-1 ~]$ nice -n 2 vim
```

Change a running process
```
[sean@rhel-1 ~]$ renice 2 vim
[sean@rhel-1 ~]$ ps -l -U sean | grep vim
0 R  1000   30186   28841  0  82   2 - 64436 -      pts/1    00:00:00 vim
```

Increase from Default
```
[sean@rhel-1 ~]$ sudo nice -n -2 vim
```

## Signals

```
[sean@rhel-1 ~]$ sudo nice -n -2 vim

 1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
 6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1	64) SIGRTMAX	
```

| 1 
