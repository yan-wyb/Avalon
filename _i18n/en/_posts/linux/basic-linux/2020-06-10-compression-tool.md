---
layout: post
author: Yan 
toc: true
image: assets/images/linux/basic-linux/linux.jpg
title: Compression and decompression tools
tags:
categories: linux
top-first: false
top-twice: false
first-level-classification: linux
twice-level-classification: basic-linux
permalink: /:year/:month/:day/:title:output_ext
---

# tar/gz/bz

These are the decompression that comes with the linux system

.tar

```shell
$ tar zxvf file.tar
$ tar czvf file.tar file
```

.gz

```shell
$ gunzip file.gz / gzip -d file.gz
$ gzip file
```

.tar.gz (.tgz)

```shell
$ tar zxvf file.tar.gz
$ tar zcvf file.tar.gz file1 file2 ....
```

.bz2

```shell
$ bzip2 -d file.bz2 / bunzip2 file.bz2
$ bzip2 -z file
```

.tar.bz2
```shell
$ tar jxvf file.tar.bz2
$ tar jcvf file.tar.bz2 file
```

.tar.xz
```shell
$ xz -d file.tar.xz --> tar xvf file.tar
$ tar cvf file.tar file --> xz -z file.tar
```

# rar

Install `rar`. Take `APT` source as an example

```shell
$ sudo apt update
$ sudo apt install unrar
```

Unzip and compress

```shell
$ unrar e file.rar
$ rar a file
```

# 7z

Install `7z`, using `APT` source as an example

```shell
$ sudo apt install p7zip-full
```

Unzip and compress

```shell
$ 7z x file.7z -r -o file
$ 7z a -t7z -r file.7z file
```

# zip/unzip

Install `zip/unzip`, using `APT` source as an example

```shell
$ sudo apt update
$ sudo apt install zip unzip
```

Decompression and compression

```shell
$ zip -r file.zip file
$ unzip file.zip
```


# Oversize files compressed into multiple files

```shell
$ rar a -v50m(50k) file.rar file
$ tar cjf - file |split -b 50m - file.tar.bz2
$ 7z a file.7z file -v2048m
```

# issues

If there are doubts or errors, please mention issues --> [Issues](https://github.com/yan-wyb/issues/issues)



