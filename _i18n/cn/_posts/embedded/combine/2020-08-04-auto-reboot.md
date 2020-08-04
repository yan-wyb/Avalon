---
layout: post
author: Yan 
toc: true
image: assets/images/mina.jpeg
title: Auto Reboot
tags:
categories: [uboot, kernel, buildroot , ubuntu]
top-first: true 
top-twice: true
first-level-classification: embedded
twice-level-classification: combine
permalink: /:year/:month/:day/:title:output_ext
---

设置reboot_mode变量,在uboot和kernel见传递,实现linux下自动重启,用于老化板子使用

# uboot

## 定义变量值

* 文件路径`arch/arm/include/asm/reboot.h`

```shell
$ vim path/to/u-boot/arch/arm/include/asm/reboot.h
```

定义新的变量值

```c++
#define {board-name}_AUTO_REBOOT        15
```

## 修改重启命令

* 文件路径`common/cmd_reboot.c`

```shell
$ vim path/to/u-boot/common/cmd_reboot.c
```

* 添加设置环境变量进函数`do_get_rebootmode`

```c

case AMLOGIC_AUTO_REBOOT:
{
setenv("reboot_mode","auto_reboot");
break;
}

```

* 在`do_reboot`函数设置获取kernel重启时传递的值

```c
else if (strcmp(mode, "auto_reboot") == 0)
    reboot_mode_val = AMLOGIC_AUTO_REBOOT;
```

* 在`U_BOOT_CMD`中加入`auto_reboot`

```c
"    auto_reboot\n"
```

# 添加`reboot_mode`到`storeargs`

* 文件路径`path/to/u-boot/board/{chip-board}/configs/{board-name}.h`

```shell
reboot_mode=${reboot_mode}
```

# kernel

## 定义变量值

* 修改文件`reboot.h`

```shell
$ vim `path/to/kernel/include/linux/{chip-board}/reboot.h
```

添加自动重启变量定义

```c++
#define MESON_AUTO_REBOOT       15
```

## 修改驱动

* 驱动文件`reboot.c`

```shell
$ vim path/to/kernel/drivers/{chip-board}/reboot/reboot.c
```

添加代码到`parse_reason`函数

```c
else if (strcmp(cmd, "auto_reboot") == 0)
    reboot_reason = MESON_AUTO_REBOOT;
```

# ubuntu

## 修改`cmdline`

* 文件`boot.ini`

```shell
$ vim path/to/boot.ini
```

* 设置rebootmode变量

```c
setenv rebootmode "reboot_mode=${reboot_mode}"
```

* 添加进启动参数里

```c
${rebootmode}
```

## 重启脚本文件

* 文件路径`usr/local/bin`

```shell
$ vim usr/local/bin/auto-reboot-handle.sh
```

* 内容如下:

```shell
#!/bin/bash

sleep 15

sync
reboot -f auto_reboot
```

## autoreboot服务

* 系统服务文件路径`/lib/systemd/system`

```shell
$ sudo vim lib/systemd/system/auto-reboot.service
```

* 内容如下:

```shell
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.

[Unit]
Description=auto reboot service
#After=systemd-update-utmp-runlevel.service

[Service]
ExecStart=/usr/local/bin/auto-reboot-handle.sh

[Install]
WantedBy=multi-user.target
```

## 修改rc.local

* 文件路径`etc/rc.local`

```shell
$ sudo vim etc/rc.local
```

* 添加内容

```shell
# Reboot test handle
if cat /proc/cmdline | grep -q auto_reboot > /dev/null; then
    if ! systemctl is-active auto-reboot | grep "^active$" > /dev/null; then
        systemctl start auto-reboot
    fi
fi
```

## 重启命令

```shell
$ sudo reboot -f auto_reboot
```

# buildroot

## 开机运行脚本

* 文件路径`/etc/init.d/`

```shell
$ vim /etc/init.d/S98autoreboot
```

* 内容如下:

```shell
#!/bin/bash

if cat /proc/cmdline | grep -q auto_reboot > /dev/null; then
    sleep 15
    sync
    reboot -f -t
fi
```

## 修改busybox重启命令

* 文件名字`halt.c`

```shell
$ vim path/to/busybox/init/halt.c
```

* 修改`halt_main`函数,添加局部变量定义

```c
char reboot_test = 0;
```

* 修改`halt_main`函数,增加`-t`参数

```c
flags = getopt32(argv, "d:+nfwit", &delay); --> flags = getopt32(argv, "d:+nfwit", &delay);
```

* 修改`halt_main`函数,修改`reboot`调用

```c
delect:
    rc = reboot(magic[which]);
add:
    if (reboot_test)
        rc = reboot(0xA1B2C3D4, 537993216, 0xA1B2C3D4, "reboot_test");
    else
        rc = reboot(0xA1B2C3D4, 537993216, 0xA1B2C3D4, "");
```

## 修改busybox头文件

* 修改文件`reboot.h`

```shell
$ vim path/to/busybox/init/reboot.h
```

* 替换头文件

```c
+//#include <sys/reboot.h>
#include <linux/reboot.h>
```

## 重启命令

```shell
root@root# reboot -f -t
```

使用`-t`进入自动重启模式

# Source code 

[https://github.com/yan-wyb/source/tree/master/c/embedded/combine/auto-reboot](https://github.com/yan-wyb/source/tree/master/c/embedded/combine/auto-reboot)

# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
