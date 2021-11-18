---
layout: post
author: Yan 
toc: true
image: assets/images/no-title/no-title1.jpg
title: stress test tool
tags:
categories: [tool, linux]
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: application
permalink: /:year/:month/:day/:title:output_ext
---

Stress is a commonly used stress testing tool under linux, here is how to use stress to test the performance of the board

## Install

Here is ubuntu as an example

```sh
$ sudo apt install stress
```
## test

Run `stress` directly, you can see the command parameter description of stress

```sh
$ stress
`stress' imposes certain types of compute stress on your system

Usage: stress [OPTION [ARG]] ...
 -?, --help         show this help statement
     --version      show version statement
 -v, --verbose      be verbose
 -q, --quiet        be quiet
 -n, --dry-run      show what would have been done
 -t, --timeout N    timeout after N seconds
     --backoff N    wait factor of N microseconds before work starts
 -c, --cpu N        spawn N workers spinning on sqrt()
 -i, --io N         spawn N workers spinning on sync()
 -m, --vm N         spawn N workers spinning on malloc()/free()
     --vm-bytes B   malloc B bytes per vm worker (default is 256MB)
     --vm-stride B  touch a byte every B bytes (default is 4096)
     --vm-hang N    sleep N secs before free (default none, 0 is inf)
     --vm-keep      redirty memory instead of freeing and reallocating
 -d, --hdd N        spawn N workers spinning on write()/unlink()
     --hdd-bytes B  write B bytes per hdd worker (default is 1GB)

Example: stress --cpu 8 --io 4 --vm 2 --vm-bytes 128M --timeout 10s

Note: Numbers may be suffixed with s,m,h,d,y (time) or B,K,M,G (size).

```

1. CPU test

```sh
$ stress --cpu N
```

2. DDR test

```sh
$ stress --vm N --vm-bytes 300M
```

`--vm-bytes` specifies the memory occupied by a single process

3. HDD test

```sh
$ stress --io N --hdd N --hdd-bytes 512M
```

`--io` generates N processes to call sync repeatedly, `--hdd` generates N processes to write fixed-size temporary files and then delete them, `--hdd-bytes` specifies the file size

