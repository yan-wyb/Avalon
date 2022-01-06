---
layout: post
author: Yan 
toc: true
image: assets/images/linux/basic-linux/linux.jpg
title: Linux下格式化存储器
tags:
categories:
top-first: false
top-twice: true
first-level-classification: linux
twice-level-classification: basic-linux
permalink: /:year/:month/:day/:title:output_ext
---

这篇记录如何在Linux下格式化如SSD，u盘硬盘之类的存储器


# 确认节点

1. u盘以及硬盘的节点一般为`/dev/sdx`

2. SSD在linux下的节点一般为`/dev/nvmex`

3. SD卡在linux下的节点一般为`/dev/mmcblkx`

# 设置分区

这里以u盘为例。

1. 使用`fdisk`命令打开设备节点

```sh
$ sudo fdisk /dev/sdx
```

2. 输入 `d`，删除原有分区，知道显示没有分区为止。

3. 输入`p`,设置主分区，随后输入`g`设置，设置为GPT格式。

4. 输入`n`,设置分区，默认即可，如果你需要格式成多个分区，可以设置分区大小，并再次重复输入`n`。

5. 输入`w`，保存退出。

# 设置分区格式

这里依然以U盘为例。

设置完分区以后，数据分区为`/dev/sdx1`。(SSD以及SSD卡一般后缀是`p1`)。

使用mkfs命令格式化。

```sh
$ sudo mkfs.ext4 /dev/sdx1
```

这里采用`ext4`格式，如果使用其他格式可以修改命令。如`ntfs`为`mkfs.ntfs`。

# 挂载

依然以u盘为例。

```sh
$ sudo mount /dev/sdx1 /path/to/your/directory
```

