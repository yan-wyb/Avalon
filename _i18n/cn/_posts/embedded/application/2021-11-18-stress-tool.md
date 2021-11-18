---
layout: post
author: Yan 
toc: true
image: assets/images/no-title/no-title1.jpg
title: 压力测试工具stress
tags:
categories: [tool, linux]
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: application
permalink: /:year/:month/:day/:title:output_ext
---

stress是linux下常用的压力测试工具，这里介绍如何使用stress对板子性能进行测试

## 安装

这里以ubuntu为例

```sh
$ sudo apt install stress
```
## 测试

直接运行`stress`,能看到stress的命令参数说明

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

1. CPU测试

```sh
$ stress --cpu N
```

2. 内存测试

```sh
$ stress --vm N --vm-bytes 300M
```

`--vm-bytes`指定单个进程占的内存

3. 磁盘测试

```sh
$ stress --io N --hdd N --hdd-bytes 512M
```

`--io` 产生N个进程反复调用sync，`--hdd`产生N个进程写入固定大小临时文件再删除，`--hdd-bytes`指定文件大小

