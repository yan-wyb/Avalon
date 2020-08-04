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

Set the `reboot_mode` variable, see the transfer in uboot and kernel, realize automatic restart under linux, used for aging board use

# uboot

## Define variable value

* file path : `arch/arm/include/asm/reboot.h`

```shell
$ vim path/to/u-boot/arch/arm/include/asm/reboot.h
```

Define variable value

```c++
#define {board-name}_AUTO_REBOOT        15
```

## edit reboot command

* file path: `common/cmd_reboot.c`

```shell
$ vim path/to/u-boot/common/cmd_reboot.c
```

* Add setting environment variables into function `do_get_rebootmode`

```c

case AMLOGIC_AUTO_REBOOT:
{
setenv("reboot_mode","auto_reboot");
break;
}

```

* Set in the `do_reboot` function to get the value passed when the kernel restarts

```c
else if (strcmp(mode, "auto_reboot") == 0)
    reboot_mode_val = AMLOGIC_AUTO_REBOOT;
```

* Add `auto_reboot` to `U_BOOT_CMD`

```c
"    auto_reboot\n"
```

# Add `reboot_mode` to `storeargs`

* file path: `path/to/u-boot/board/{chip-board}/configs/{board-name}.h`

```shell
reboot_mode=${reboot_mode}
```

# kernel

## Define variable value

* edit file:`reboot.h`

```shell
$ vim `path/to/kernel/include/linux/{chip-board}/reboot.h
```

Add automatic restart variable definition

```c++
#define MESON_AUTO_REBOOT       15
```

## edit driver

* driver file `reboot.c`

```shell
$ vim path/to/kernel/drivers/{chip-board}/reboot/reboot.c
```

Add code to the `parse_reason` function

```c
else if (strcmp(cmd, "auto_reboot") == 0)
    reboot_reason = MESON_AUTO_REBOOT;
```

# ubuntu

## edit `cmdline`

* file `boot.ini`

```shell
$ vim path/to/boot.ini
```

* Set the rebootmode variable

```c
setenv rebootmode "reboot_mode=${reboot_mode}"
```

* Add to startup parameters

```c
${rebootmode}
```

## Reboot script file

* file paht: `usr/local/bin`

```shell
$ vim usr/local/bin/auto-reboot-handle.sh
```

* content:

```shell
#!/bin/bash

sleep 15

sync
reboot -f auto_reboot
```

## autoreboot service

* service path: `/lib/systemd/system`

```shell
$ sudo vim lib/systemd/system/auto-reboot.service
```

* content:

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

## edit rc.local

* file path: `etc/rc.local`

```shell
$ sudo vim etc/rc.local
```

* add content

```shell
# Reboot test handle
if cat /proc/cmdline | grep -q auto_reboot > /dev/null; then
    if ! systemctl is-active auto-reboot | grep "^active$" > /dev/null; then
        systemctl start auto-reboot
    fi
fi
```

## auto reboot commamd

```shell
$ sudo reboot -f auto_reboot
```

# buildroot

## Start-up script

* file path: `/etc/init.d/`

```shell
$ vim /etc/init.d/S98autoreboot
```

* content:

```shell
#!/bin/bash

if cat /proc/cmdline | grep -q auto_reboot > /dev/null; then
    sleep 15
    sync
    reboot -f -t
fi
```

## edit busybox reboot command

* file name `halt.c`

```shell
$ vim path/to/busybox/init/halt.c
```

* Modify the `halt_main` function and add local variable definitions

```c
char reboot_test = 0;
```

* Modify the `halt_main` function and add the `-t` parameter

```c
flags = getopt32(argv, "d:+nfwit", &delay); --> flags = getopt32(argv, "d:+nfwit", &delay);
```

* Modify `halt_main` function, modify `reboot` call

```c
delect:
    rc = reboot(magic[which]);
add:
    if (reboot_test)
        rc = reboot(0xA1B2C3D4, 537993216, 0xA1B2C3D4, "reboot_test");
    else
        rc = reboot(0xA1B2C3D4, 537993216, 0xA1B2C3D4, "");
```

## Modify the busybox header file

* edit file `reboot.h`

```shell
$ vim path/to/busybox/init/reboot.h
```

* repalce header file 

```c
+//#include <sys/reboot.h>
#include <linux/reboot.h>
```

## auto reboot command

```shell
root@root# reboot -f -t
```

Use `-t` to enter automatic restart mode

# Source code 

[https://github.com/yan-wyb/source/tree/master/c/embedded/combine/auto-reboot](https://github.com/yan-wyb/source/tree/master/c/embedded/combine/auto-reboot)

# issues

If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
