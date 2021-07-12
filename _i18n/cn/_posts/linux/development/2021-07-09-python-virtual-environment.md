---
layout: post
author: Yan 
toc: true
image: assets/images/linux/development/python-logo.png
title: Linux下创建python虚拟环境的几种方法
tags:
categories: python
top-first: false
top-twice: true
first-level-classification: linux
twice-level-classification: development
permalink: /:year/:month/:day/:title:output_ext
---

这篇主要介绍在Linux下创建python虚拟环境的几种方法。这里的Linux系统使用Ubuntu作为示例。

# Conda

`Conda`是一个python包管理工具，可以通过安装anaconda或者miniconda安装conda虚拟环境。

这里以miniconda为例(anaconda和miniconda的区别在于预安装的python包的数量不同)，

## 安装conda

```sh
$ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
$ bash Miniconda3-latest-Linux-x86_64.sh
```

输入yes同意协议，然后一直回车，就会默认安装到home目录下，miniconda会预安装常用的python数据处理包。

## 使用conda创建虚拟环境

### 激活conda环境

安装完conda以后，需要先激活conda环境，

```
yan@yan:~$ bash
(base) yan@yan:~$ 
```

看到`(base)`前缀就是激活conda环境成功了

### 创建虚拟环境

conda在创建虚拟环境时可以指定python版本，

```
(base) yan@yan:~$ conda create --name yan-wyb python=3.8 pip
```

这里指定python版本为3.8，同时包括pip包

### 激活虚拟环境与退出虚拟环境

激活创建的虚拟环境

```sh
(base) yan@yan:~$ conda activate yan-wyb
(yan-wyb) yan@yan:~$
```

退出虚拟环境

```sh
(yan-wyb) yan@yan:~$ conda deactivate
(base) yan@yan:~$
```

Conda与其他方法相比的有点在于，可以指定python版本，同时预装了python基础的数据处理包和常用包。

缺点在于预装包会导致虚拟环境占空间较大，不需要可以使用下面其他方法

# pipenv

pipenv是Python官方推荐的包管理工具。

## 安装

```sh
$ pip install pipenv
```

如果没有安装pip，可以使用下面的命令

```sh
$ sudo apt insall python3-pip
```

## 创建虚拟环境

```sh
$ cd ${workspace}
$ pipenv install
$ pipenv install requests
```

如果不存在pipfile,会生成一个pipfile，创建以后安装新库，会自动更新pipfile.

## 激活

```sh
$ pipenv shell
$ python --version
```
# venv

## 安装

```sh
$ sudo apt install python3-venv
```

## 创建虚拟环境

```sh
$ python3 -m venv --system-site-packages ./venv
```
## 激活环境

```sh
$ source ./venv/bin/activate
```

## 退出环境

```sh
$ deactivate
```

# issues

If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
