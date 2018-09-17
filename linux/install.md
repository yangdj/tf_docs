# Linux

## Installation for Centos7

### Partition

after booting computer, select `install centos7`, then click `tab` key, at the bottom of the information, append `inst.gpt`, then press `enter` key. the system will use **gpt** to partition the disk.

you can specify:

* `2M` for `biosboot` using **standard partition**
* `1G` for `/boot` using **standard partition** and **xfs** filesystem
* `/`, `/home`, `swap` using **lvm** and **xfs** file system, specify storage file according to your system

### Configuration

## User and Group

* `adduser demo`, `passwd demo`, `gpasswd -a username wheel`
