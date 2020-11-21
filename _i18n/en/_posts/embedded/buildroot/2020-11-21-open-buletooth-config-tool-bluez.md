---
layout: post
author: Yan 
toc: true
image: assets/images/embedded/buildroot/bluetooth-logo1.png
title: Open the Bluetooth configuration tool Bluez
tags:
categories: buildroot
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: buildroot
permalink: /:year/:month/:day/:title:output_ext
---

Bluez is a collection of tools for configuring Bluetooth under Linux

# Configuration steps

1. Open the buildroot configuration interface

```shell
$ cd {path/to}/buildroot
$ make ARCH=arm64 xxx_defconfig
$ make ARCH=arm64 menuconfig
```

2. Choose `Target packages`

Picturs ![bluez-1]({{ site.baseurl }}/assets/images/embedded/buildroot/bluez-1.png)

3. Choose `Networking applications`

Picturs ![bluez-2]({{ site.baseurl }}/assets/images/embedded/buildroot/bluez-2.png)

4. Choose `bluez-utils 5.x`

Picturs ![bluez-3]({{ site.baseurl }}/assets/images/embedded/buildroot/bluez-3.png)

5. Save configuration

```shell
$ make ARCH=arm64 savedefconfig
$ mv defconfig configs/xxx_defconfig
```

# issues

If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
