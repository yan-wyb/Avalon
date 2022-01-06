---
layout: post
author: Yan 
toc: true
image: assets/images/no-title/no-title12.jpg
title: 编译并打包OpenCV
tags:
categories: [opencv, linux]
top-first: false
top-twice: false
first-level-classification: embedded
twice-level-classification: application
permalink: /:year/:month/:day/:title:output_ext
---

这篇记录如何在arm环境下编译opencv并打包成deb包。

# 获取源码

1. Clone源码

```sh
yan@yan-wyb:~$ git clone https://github.com/opencv/opencv.git
```

2. 切换到需要的tag

这里以4.5为例，

```sh
yan@yan-wyb:~$ cd opencv/
yan@yan-wyb:~/opencv$ git checckout -b 4.5.0
```

可以使用`git tag`命令查看所有可用的tag


# 编译


1. opencv编译是使用cmake命令。没有的请先安装cmake，以ubuntu为例

```sh
yan@yan-wyb:~$ sudo apt install cmake
```

2. 创建编译目录


```sh
yan@yan-wyb:~$ cd opencv
yan@yan-wyb:~/opencv$ mkdir build
```

3. 使用cmake编译

这里编译使用一些常见选项，并安装到当前目录

```sh
yan@yan-wyb:~/opencv$ cd build/
yan@yan-wyb:~/opencv/build$ cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=./install \
      -D BUILD_TESTS=OFF \
      -D BUILD_EXAMPLES=OFF \
      -D INSTALL_PYTHON_EXAMPLES=OFF \
      -D BUILD_opencv_gapi=OFF \
      -D BUILD_opencv_python2=OFF \
      -D BUILD_opencv_python3=ON \
      -D PYTHON3_INCLUDE_DIR=/usr/include/python3.8 \
      -D PYTHON3_EXECUTABLE=/usr/bin/python3.8 \
      -D PYTHON3_LIBRARY=/usr/lib/aarch64-linux-gnu/libpython3.8.so.1.0 \
      -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/lib/python3.8/dist-packages/numpy/core/include/
yan@yan-wyb:~/opencv/build$ make
```

等待编译完成，编译完成以后安装到指定的目录，即当前目录下

```sh
yan@yan-wyb:~/opencv/build$ make install
```

如要安装到其他目录可在上一步中指定安装位置`-D CMAKE_INSTALL_PREFIX=`

# 打包

1. 创建打包脚本

```sh
yan@yan-wyb:~/opencv/build$ cd install
yan@yan-wyb:~/opencv/build/install$ mkdir DEBIAN
yan@yan-wyb:~/opencv/build/install$ vim DEBIAN/control
```

内容如下

```sh
Package: opencv
Version: 4.5.0
Section: kernel
Architecture: arm64
Maintainer: Yan <yan-wyb@foxmail.com>
Installed-Size: 1
Priority: optional
Description: OpenCV libraries.
```

2. 打包

```sh
yan@yan-wyb:~$ cd opencv/build/
yan@yan-wyb:~$ dpkg-deb -b install ./opencv-4.5.0.deb
```
