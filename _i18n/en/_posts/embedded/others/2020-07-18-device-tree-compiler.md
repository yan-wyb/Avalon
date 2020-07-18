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

device-tree-compiler is a collection of tools for `dts` and `dtb`.

# Install

Here take APT source as an example,

```shell
$ sudo apt-get install device-tree-compiler
```

# Compile and decompile

`dtc` tool use for  compile `dts` and decompile `dtb`

## dts compile to dtb

```shell
$ cd ${workspace} && ls
filename.dtb
```

The `-I` parameter specifies the source, and the `-O` parameter specifies the target format as `dts`.

```shell
$ dtc -I dtb -O dts filename.dtb > filename.dts
```

or,

```shell
$ dtc filename.dtb > filename.dts
```

## dtb decompile to dts

```shell
$ cd ${workspace} && ls
filename.dts
```

`-O` specifies the target format as `dtb`.

```shell
$ dtc -O dtb -o filename.dtb filename.dts
```

or,

```shell
$ dtc filename.dts > filename.dtb
```

# Modify the node of `dtb`

`fdtget` and `fdtput` are used to read and modify `dtb`.

## Get node information

```shell
$ cd ${workspace} && ls
filename.dtb
$ fdtget filename.dtb /onewire status
okay
```

## Modeify node 

```shell
$ cd ${workspace} && ls
filename.dtb
$ fdtput -t s filename.dtb /onewire status "disable"
$ fdtget filename.dtb /onewire status
disable
```

**note**: Some nodes need to reboot to take effect after modification.

# Compare `dtb` difference

`dtdiff` tool, Compare `dtb` difference

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

# Read dtb header and node information.

`fdtdump` tool use for Read dtb header and node information.


```shell
$ fdtdump -sd filename.dtb > dump.txt
$ cat dump.txt
(Here are some printed information)
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

# overlay node 

`fdtoverlay` tool use for overlay node 

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

If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
