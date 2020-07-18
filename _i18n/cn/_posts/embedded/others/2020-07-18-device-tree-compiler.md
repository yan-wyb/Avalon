---
layout: post
author: Yan 
toc: true
image: assets/images/embedded/others/device-tree-compiler-image.png
title: device-tree-compiler
tags:
categories: dts
top-first: true
top-twice: true
first-level-classification: embedded
twice-level-classification: others
permalink: /:year/:month/:day/:title:output_ext
---

device-tree-compiler 是用于`dts`和`dtb`的工具合集

# 安装

这里以APT源为例

```shell
$ sudo apt-get install device-tree-compiler
```

# 编译和反编译

dtc命令用于编译`dts`和反编译`dtb`

## dts编译成dtb

```shell
$ cd ${workspace} && ls
filename.dtb
```

`-I`参数指定源,`-O`参数指定目标格式为`dts`

```shell
$ dtc -I dtb -O dts filename.dtb > filename.dts
```

或者

```shell
$ dtc filename.dtb > filename.dts
```

## dtb反编译成dts

```shell
$ cd ${workspace} && ls
filename.dts
```

`-O`指定目标格式为`dtb`

```shell
$ dtc -O dtb -o filename.dtb filename.dts
```

或者

```shell
$ dtc filename.dts > filename.dtb
```

# 修改`dtb`的节点

`fdtget`和`fdtput`用于读取和修改`dtb`

## 读取节点状态

```shell
$ cd ${workspace} && ls
filename.dtb
$ fdtget filename.dtb /onewire status
okay
```

## 修改节点状态

```shell
$ cd ${workspace} && ls
filename.dtb
$ fdtput -t s filename.dtb /onewire status "disable"
$ fdtget filename.dtb /onewire status
disable
```

**note**: 有的节点修改完需要reboot才能生效

# 比较`dtb`区别

`dtdiff`命令,用于比较不同`dtb`之间的区别

```shell
$ cd ${workspace} && ls
filename.dtb
$ fdtget filename.dtb /onewire status
okay
$ cp filename.dtb filename2.dtb
$ fdtput -t s filename2.dtb /onewire status "disable"
$ dtdiff filename.dtb filename2.dtb
--- /dev/fd/63  2020-07-18 02:27:13.437617744 +0000
+++ /dev/fd/62  2020-07-18 02:27:13.437617744 +0000
@@ -1703,7 +1703,7 @@
                compatible = "w1-gpio";
                gpios = <0x1b 0x17 0x0>;
                phandle = <0x10a>;
-               status = "okay";
+               status = "disable";
        };

        p_tsensor@ff634594 {
```

# 读取dtb头部和节点信息

`fdtdump`工具可用于读取`dtb`的头部信息和节点信息


```shell
$ fdtdump -sd filename.dtb > dump.txt
$ cat dump.txt
(这里是部分打印信息)
// magic:               0xd00dfeed
// totalsize:           0x15a8b (88715)
// off_dt_struct:       0x38
// off_dt_strings:      0x1394c
// off_mem_rsvmap:      0x28
// version:             17
// last_comp_version:   16
// boot_cpuid_phys:     0x0
// size_dt_strings:     0x213f
// size_dt_struct:      0x13914
```

# 覆盖dtb节点

`fdtoverlay`用于覆盖设备节点

```shell
$ fdtoverlay -h
Usage: apply a number of overlays to a base blob
        fdtoverlay <options> [<overlay.dtbo> [<overlay.dtbo>]]

<type>  s=string, i=int, u=unsigned, x=hex
        Optional modifier prefix:
                hh or b=byte, h=2 byte, l=4 byte (default)

Options: -[i:o:vhV]
  -i, --input <arg>  Input base DT blob
  -o, --output <arg> Output DT blob
  -v, --verbose      Verbose messages
  -h, --help         Print this help and exit
  -V, --version      Print version and exit
```
# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
