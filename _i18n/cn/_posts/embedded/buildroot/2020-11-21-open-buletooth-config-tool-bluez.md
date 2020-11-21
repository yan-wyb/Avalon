---
layout: post
author: Yan 
toc: true
image: assets/images/embedded/buildroot/bluetooth-logo1.png
title: 打开蓝牙配置工具Bluez
tags:
categories: buildroot
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: buildroot
permalink: /:year/:month/:day/:title:output_ext
---

Bluez是linux下用于配置蓝牙的一系列工具的合集


# 配置步骤

1. 打开buildroot配置界面

```shell
$ cd {path/to}/buildroot
$ make ARCH=arm64 xxx_defconfig
$ make ARCH=arm64 menuconfig
```

2. 选择`Target packages`

Picturs ![bluez-1]({{ site.baseurl }}/assets/images/embedded/buildroot/bluez-1.png)

3. 选择`Networking applications`

Picturs ![bluez-2]({{ site.baseurl }}/assets/images/embedded/buildroot/bluez-2.png)

4. 选择`bluez-utils 5.x`

Picturs ![bluez-3]({{ site.baseurl }}/assets/images/embedded/buildroot/bluez-3.png)

5. 保存配置

```shell
$ make ARCH=arm64 savedefconfig
$ mv defconfig configs/xxx_defconfig
```

# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
