---
layout: post
author: Yan 
toc: true
image: assets/images/embedded/uboot/uboot-logo1.jpg
title: 如何设置uboot的Autoboot
tags:
categories: uboot
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: uboot
permalink: /:year/:month/:day/:title:output_ext
---

配置uboot的Autoboot.使系统在自动启动内核前,可以手动停留在uboot命令行

# mainline uboot

Clone最新的主线uboot到本地

```shell
$ cd {workspace}
$ git clone https://github.com/u-boot/u-boot.git
```

# 打开配置界面

1. 从`/configs`目录下选择你需要的配置.

```shell
$ cd {workspace}/u-boot
$ make ARCH=arm xxx_defconfig
#
# configuration written to .config
#

```
2. 启动配置界面

```shell
$ cd {workspace}/u-boot
$ make ARCH=arm menuconfig
```

看到启动了配置的UI,就是启动成功了

# 配置过程

1. 选择 `Command line interface` 选项

![Autoboot1]({{ site.baseurl }}/assets/images/embedded/uboot/Autoboot-1.png)

2. 选择 `Autoboot options` 选项

![Autoboot2]({{ site.baseurl }}/assets/images/embedded/uboot/Autoboot-2.png)

3. 这里可以配置几个选项

![Autoboot3]({{ site.baseurl }}/assets/images/embedded/uboot/Autoboot-3.png)

* Stop autobooting via specific input key / string : 在启动时,可以通过键盘停下Autoboot

* (Autoboot in %d seconds\n) Autoboot stop prompt : 可以输入打印的信息格式

* Delay autobooting via specific input key / string: Autoboot的倒计时时长

* Stop autobooting via specific input key / string : 通过特定的按键停下,比如空格或者回车,此时其他按键失效

# 保存配置

1. 选择`Save`按钮保存你的配置到`.config`

2. 保存成`defconfig`

```shell
$ cd {workspace}/u-boot
$ make ARCH=arm savedefconfig
```

3. 将生成的defconfig替换原本的defconfig

```shell
$ cd {workspace}/u-boot
$ mv defconfig confgis/xxx_defconfig
```

# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
