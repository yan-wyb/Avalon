---
layout: post
author: Yan 
toc: true
image: assets/images/embedded/kernel/1-Wire-logo.png
title: 增加单总线支持
tags:
categories: kernel
top-first: true
top-twice: true
first-level-classification: embedded
twice-level-classification: kernel
permalink: /:year/:month/:day/:title:output_ext
---

通过GPIO连接控制单总线

# dts配置

```shell
 onewire:onewire {
     compatible = "w1-gpio";
     gpios = <&gpio GPIOH_6 GPIO_ACTIVE_HIGH>;
     status = "disable";
};
```

# 内核配置

```shell
CONFIG_W1=y                    #打开总线配置
CONFIG_W1_MASTER_GPIO=y        #配置到GPIO
CONFIG_W1_SLAVE_THERM=y        #打开w1_salve用于读取值
```

# 使用

以ds18b20为例

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

**注意**

单总线设备不支持热插拔

# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
