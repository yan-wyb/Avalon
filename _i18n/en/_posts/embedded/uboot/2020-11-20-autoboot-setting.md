---
layout: post
author: Yan 
toc: true
image: assets/images/embedded/uboot/uboot-logo1.jpg
title: How to set Autoboot of uboot
tags:
categories: uboot
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: uboot
permalink: /:year/:month/:day/:title:output_ext
---

Configure Autoboot of uboot. Make the system manually stay on the uboot command line before automatically starting the kernel

# mainline uboot

Clone the latest mainline uboot to the local.

```shell
$ cd {workspace}
$ git clone https://github.com/u-boot/u-boot.git
```

# Open the configuration interface

1. Select the configuration file you need from the `/configs` directory

```shell
$ cd {workspace}/u-boot
$ make ARCH=arm xxx_defconfig
#
# configuration written to .config
#

```
2. Start the configuration interface

```shell
$ cd {workspace}/u-boot
$ make ARCH=arm menuconfig
```

Seeing that the configured UI is started, the startup is successful

# Configuration process

1. choose `Command line interface` option

![Autoboot1]({{ site.baseurl }}/assets/images/embedded/uboot/Autoboot-1.png)

2. choose `Autoboot options` option

![Autoboot2]({{ site.baseurl }}/assets/images/embedded/uboot/Autoboot-2.png)

3. Several options can be configured here

![Autoboot3]({{ site.baseurl }}/assets/images/embedded/uboot/Autoboot-3.png)

* Stop autobooting via specific input key / string : At startup, you can stop Autoboot via the keyboard

* (Autoboot in %d seconds\n) Autoboot stop prompt : You can enter the information format for printing

* Delay autobooting via specific input key / string: Autoboot countdown time

* Stop autobooting via specific input key / string : Stop by a specific key, such as space or enter, at this time other keys are invalid

# Save configuration

1. Select the `Save` button to save your configuration to `.config`

2. Save as `defconfig`

```shell
$ cd {workspace}/u-boot
$ make ARCH=arm savedefconfig
```

3. Replace the generated defconfig with the original defconfig

```shell
$ cd {workspace}/u-boot
$ mv defconfig confgis/xxx_defconfig
```

# issues

If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
