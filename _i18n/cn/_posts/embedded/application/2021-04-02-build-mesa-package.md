---
layout: post
author: Yan 
toc: true
image: assets/images/embedded/application/mesa-logo.jpg
title: Ubuntu下编译mesa包
tags:
categories: [mesa, ubuntu]
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: application
permalink: /:year/:month/:day/:title:output_ext
---

记录如何在ubuntu20.40上编译适配的mesa包

# 源码

## mesa源码

mesa源码位于官方自构建的源码网站上,

```sh
$ mkdir ${workspace}
$ git clone https://gitlab.freedesktop.org/mesa/mesa
```

直接使用最新的代码,或者选择一个合适的tag,例如使用`21.0.1`

```sh
$ cd ${workspace}/mesa
$ git chechout 21.0.1
$ git checkout -b 21.0.1
```

##　DEBIAN编译规则

1. 打开source list的配置

```sh
$ vim /etc/apt/sources.list
```

将配置里面的deb-src全部打开

```
#deb-src http://ports.ubuntu.com/ focal main restricted universe multiverse --> deb-src http://ports.ubuntu.com/ focal main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ focal-security main restricted universe multiverse --> deb-src http://ports.ubuntu.com/ focal-security main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ focal-updates main restricted universe multiverse --> deb-src http://ports.ubuntu.com/ focal-updates main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ focal-backports main restricted universe multiverse --> deb-src http://ports.ubuntu.com/ focal-backports main restricted universe multiverse
```
2. 更新

```sh
$ sudo apt update
```

3. 获取DEBIAN规则

```sh
$ cd ${workspace}
$ apt source mesa
```

获取的源码里面,有一个debian文件夹,就是需要的编译规则,复制到mesa源码包中

```sh
$ cp -ravx ${workspace}/mesa-20.2.6/debian ${workspace}/mesa
```

# 编译准备

1. 安装编译依赖选项

```sh
$ sudo apt-get install devscripts build-essential lintian
```

2. 安装编译依赖库

```sh
$ sudo apt install libxcb-shm0-dev
```

3. 准备编译环境

```sh
$ cd ${workspace}/mesa
$ sudo apt build-dep mesa
```

这一步会生成用于编译mesa包的环境配置

# 编译

1. 清理缓存的编译

```sh
$ debuild -i -us -uc -b
```

2. 不清除缓存的编译

```sh
$ debuild -i -us -uc -b -nc
```

编译报错,一般都是DEBIAN规则不使用新版本的源码,修改以后, 需要使用清理缓存的编译

# Picturs ![]({{ site.baseurl }}/assets/images/)
# link []({{ site.baseurl }})

