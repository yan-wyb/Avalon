---
layout: post
author: Yan 
toc: true
image: assets/images/embedded/kernel/1-Wire-logo.png
title: Add 1-Wire driver supports
tags:
categories: [kernel, dts]
top-first: true
top-twice: true
first-level-classification: embedded
twice-level-classification: kernel
permalink: /:year/:month/:day/:title:output_ext
---

Control a single bus via GPIO connection.

# dts configiure

```shell
 onewire:onewire {
     compatible = "w1-gpio";
     gpios = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
     status = "disable";
};
```

# kernel configiure

```shell
CONFIG_W1=y                   #open 1-Wire driver
CONFIG_W1_MASTER_GPIO=y       #chooise use for gpio
CONFIG_W1_SLAVE_THERM=y       #open node to read value
```

# Use

Use ds18b20 as an example:

```shell
$ cd /sys/bus/w1/devices
$ ls
28-0119395ebf91  w1_bus_master1
$ cd 28-0119395ebf91
$ ls
driver  id  name  power  subsystem  uevent  w1_slave
$ cat w1_slave 
b1 01 4b 46 7f ff 0c 10 d8 : crc=d8 YES 
b1 01 4b 46 7f ff 0c 10 d8 t=27062
```

**note**

Single bus devices do not support hot swap.

# issues

If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
