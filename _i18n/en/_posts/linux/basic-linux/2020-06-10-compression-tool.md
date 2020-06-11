---
layout: post
author: Yan 
toc: true
image: assets/images/linux/basic-linux/linux.jpg
title:
tags:
categories: linux
top-first: true
top-twice: true
first-level-classification: linux
twice-level-classification: basic-linux
permalink: /:year/:month/:day/:title:output_ext
---

## tar/gz/bz

这些是linux系统自带的解压

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

## rar

安装`rar`.以`APT`源为例

```shell
$ sudo apt update
$ sudo apt install unrar
```

解压和压缩

```shell
$ unrar e file.rar
$ rar a file
```

## 7z

安装`7z`,以`APT`源为例

```shell
$ sudo apt-get install p7zip
```

解压与压缩

```shell
$ 7z x file.7z -r -o file
$ 7z a -t7z -r file.7z file
```

## zip/unzip

安装`zip/unzip`,以`APT`源为例

```shell
$ sudo apt update
$ sudo apt install zip unzip
```
解压与压缩

```shell
$ zip -r file.zip file
$ unzip file.zip
```


## 超大文件压缩成多个文件

```shell
$ rar a -v50m(50k) file.rar file
$ tar cjf - file |split -b 50m - file.tar.bz2
$ 7z a file.7z file -v2048m
```





