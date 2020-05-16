# process

## `ps` 

shows processes information

* `TTY` is short for *teletype* and refers to the controling terminal for the process
* `TIME` is the amount of the CPU time consumed by the process.
* `CMD` is the executable name
* `STAT` is short for *state*, and reveals the current status of the process
    * `R` running, means the process is running or ready to run
    * `S` sleeping, means it is waiting for an event, such as a keystroke or network packet
    * `D` uninterruptible sleep. process is waiting for I/O such as a disk drive and cannot handle a signal and cannot be killed
    * `T` stopped, means process has been instructed to stop
    * `Z` a defunct or *zombie* process. this is a child process that has terminated, but has not been cleaned up by its parent
    * `<` a high priority process
    * `N` a low priority process. a process with low priority will be *nice* because it will only get processor time after other processes with high priority have been serviced
* `%CPU` cpu usage in percent
* `%MEM` memory usage in percent
* `VSZ` virtual memory size
* `RSS` resident set size, the amount of physical memory (RAM) the process is using in kilobytes
* `START` time when the process started

you can use the following options to show more information:

* `x` tells `ps` to show all of our processes regardless of what terminal they are controlled by. the presence of a *?* in the TTY column indicates no controlling terminal. using this option, we see a list of every process that we are own

## `top` 

shows processes dynamically

* `up` called `uptime`. it is amount of time since the machine was last booted
* `users` means how many users logged in
* `load average` refers to the number of processes that are waiting to run, that is the number of processes that are in a runnable state and are sharing the cpu. three values are shown, each for a different period of time. the first is the average for the last 60 seconds, the next the previous 5 minutes, and finally, the previous 15 minutes
* `tasks` summarizes the number of processes and their various process states
* `cpu(s)` describes the character of the activities that the cpu is performing
    * `us` for user space processes
    * `sy` for kernal processes
    * `ni` for nice (low priority) processes
    * `id` for cpu that is idle
    * `wa` for cpu that is waiting for I/O
    * `hi` for hard interrupt
    * `si` for soft interrupt
    * `st` for stolen cpu
* `mem` shows how phisical RAM is being used
* `swap` shows how swap space (virtual memory) is being used

some options:

* `q` quits top
* `h` displays the program's help screen

## process control

to launch a program in the background, you can append a `&` to the end of the program like `sleep 20 &`.

using `jobs` to list programs executing in the background. to return a process to the foreground, use the `fg` command like `fg %1`.

* `ctrl-c` interrputs a process
* `ctrl-z` stops a foreground process without terminating it. we can either restore the program to the foreground, using the `fg` command, or move the program to the background with the `bg` command like `bg %`.

## signals

### `kill`

the `kill` command is used to *kill* processes. this allows us to terminate programs that need killing. `kill 2000` will terminate a process with pid 2000 and `kill %1` will terminate job 1. in fact, the `kill` command doesnot exactly kill processes, rather it sends them *signals*.

signals are one of several ways that the operating system communicates with programs. in the case of `ctrl-c`, a signal called `INT` (interrupt) is sent; with `ctrl-z`, a signal called `TSTP` (terminal stop). programs, in turn, *listen* for signals and may act upon them as they are received.

    kill [-signal] pid...

if no signal is specified on the command line, then the `TERM` (terminal) signal is sent by default. some others:

* `2 or INT` interrupts, performing the same function as `ctrl-c` key sent from the terminal. it will usually terminate a program
* `9 or KILL` kills. the `KILL` signal is never actually sent to the target program. rather, the kernal immediately terminates the process. when a process is terminated in this manner, it is given no opportunity to *clean up* after itself or save its work. for this reason, the `KILL` signal should only be used as a last resort when other termination signals fail
* `11 or SEGV` segmentation violation. this signal is sent if a program makes illegal use of memory, that is, it tried to write somewhere it was not allowed to
* `15 or TERM` terminates. the default signal sent by the `kill` command. if a program is still *alive* enough to receive signals, it will terminate
* `18 or CONT` continues. this will restore a process after a `STOP` signal
* `19 or STOP` stops. this signal causes a process to pause without terminating. like the `KILL` signal, it is not sent to the target process, and thus it cannot be ignored
* `20 or TSTP` terminal stop. this is the signal sent by the terminal when `ctrl-z` key is pressed. unlike the `STOP` signal, the `TSTP` signal is received by the program but the program may choose to ignore it

    kill -2 1000
    kill -INT 1000
    kill -SIGINT 1000

processes, like files, have owners, and you must be the owner of a process (or the superuser) in order to send it signals with will.

### `killall`

it is also to send signals to multiple processes matching a specified program or username using the `killall` command:

    killall [-u user] [-signal] name...

    sleep 30 &
    sleep 30 &

    killall sleep

### other process related commands

* `pstree`
* `vmstat`
