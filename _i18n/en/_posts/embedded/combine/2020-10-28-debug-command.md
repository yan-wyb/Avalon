---
layout: post
author: Yan 
toc: true
image: assets/images/no-title/no-title2.jpg
title: Collection of debugging commands
tags:
categories:
top-first: embedded
top-twice: combine
first-level-classification: true
twice-level-classification: true
permalink: /:year/:month/:day/:title:output_ext
---

1. Mount the debug file system `debugfs`

```sh
$ mount -t debugfs debugfs /sys/kernel/debug
```

verify

```sh
$ mount | grep debug
debugfs on /sys/kernel/debug type debugfs (rw,relatime)
```
2. View USB device information node

```sh
$ cat /sys/kernel/debug/usb/devices


{% raw %}
{% endraw %}

