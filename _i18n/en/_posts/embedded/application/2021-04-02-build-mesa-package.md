---
layout: post
author: Yan 
toc: true
image: assets/images/embedded/application/mesa-logo.jpg
title: Compile mesa package on Ubuntu
tags:
categories: [mesa, ubuntu]
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: application
permalink: /:year/:month/:day/:title:output_ext
---

How to compile the adapted mesa package on ubuntu20.40

# source code

## mesa source code

The mesa source code is located on the official self-built source code website,

```sh
$ mkdir ${workspace}
$ git clone https://gitlab.freedesktop.org/mesa/mesa
```

Use the latest code directly, or choose a suitable tag, for example, use `21.0.1`

```sh
$ cd ${workspace}/mesa
$ git chechout 21.0.1
$ git checkout -b 21.0.1
```

## DEBIAN compilation rules

1. Open source list configuration

```sh
$ vim /etc/apt/sources.list
```

Open all deb-src in the configuration

```
#deb-src http://ports.ubuntu.com/ focal main restricted universe multiverse --> deb-src http://ports.ubuntu.com/ focal main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ focal-security main restricted universe multiverse --> deb-src http://ports.ubuntu.com/ focal-security main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ focal-updates main restricted universe multiverse --> deb-src http://ports.ubuntu.com/ focal-updates main restricted universe multiverse
#deb-src http://ports.ubuntu.com/ focal-backports main restricted universe multiverse --> deb-src http://ports.ubuntu.com/ focal-backports main restricted universe multiverse
```
2. update

```sh
$ sudo apt update
```

3. Get DEBIAN compilation rules

```sh
$ cd ${workspace}
$ apt source mesa
```

In the obtained source code, there is a debian folder, which is the required compilation rules, copied to the mesa source code package

```sh
$ cp -ravx ${workspace}/mesa-20.2.6/debian ${workspace}/mesa
```

# Compilation preparation

1. Install compile dependency options

```sh
$ sudo apt-get install devscripts build-essential lintian
```

2. Install and compile dependencies

```sh
$ sudo apt install libxcb-shm0-dev
```

3. Prepare the compilation environment

```sh
$ cd ${workspace}/mesa
$ sudo apt build-dep mesa
```

This step will generate the environment configuration used to compile the mesa package

# Compile

1. Compile with Clean up

```sh
$ debuild -i -us -uc -b
```

2. Compile without Clean up

```sh
$ debuild -i -us -uc -b -nc
```

Compilation errors, generally the DEBIAN rule does not use the new version of the source code, after modification, you need to use the compilation that cleans the cache


