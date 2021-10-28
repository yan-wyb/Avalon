---
layout: post
author: Yan 
toc: true
image: assets/images/no-title/no-title2.jpg
title: 调试命令合集
tags:
categories: [debug]
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: combine
permalink: /:year/:month/:day/:title:output_ext
---

1. 挂载调试文件系统`debugfs`

```sh
$ mount -t debugfs debugfs /sys/kernel/debug
```

验证

```sh
$ mount | grep debug
debugfs on /sys/kernel/debug type debugfs (rw,relatime)
```

2. 查看USB设备信息节点

```sh
$ cat /sys/kernel/debug/usb/devices
```

{% raw %}
{% endraw %}

