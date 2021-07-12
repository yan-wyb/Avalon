---
layout: post
author: Yan 
toc: true
image: assets/images/linux/ubuntu/ubuntu-logo.jpg
title: Ubuntu下使用VNC
tags:
categories: ubuntu
top-first: false
top-twice: true
first-level-classification: linux
twice-level-classification: ubuntu
permalink: /:year/:month/:day/:title:output_ext
---

这篇记录如何在Ubuntu20.04下配置使用VNC。

# 安装

1. 安装依赖

```sh
$ sudo apt-get install gnome-session-flashback
```

2. 安装`VNC Server`

```sh
$ sudo apt-get install tigervnc-standalone-server
```

# 配置

1. 关闭防火墙

```sh
$ sudo ufw disable
Firewall stopped and disabled on system startup
```

关闭以后可以通过`status`命令查看

```sh
$ sudo ufw status
Status: inactive
```

2. 设置密码

```
$ vncpasswd 
Password:
Verify:
Would you like to enter a view-only password (y/n)? n
```

这个密码是远程连接时需要输入的密码

3. 设置配置文件

```sh
$ vim ~/.vnc/xstartup
```

配置内容如下

```sh
#!/bin/sh

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export XKL_XMODMAP_DISABLE=1
export XDG_CURRENT_DESKTOP="GNOME-Flashback:GNOME"
export XDG_MENU_PREFIX="gnome-flashback-"
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
gnome-session --session=gnome-flashback-metacity --disable-acceleration-check &
```

4. 添加执行权限

```sh
$ sudo chmod +x  ~/.vnc/xstartup
```

# 使用

1. 启动服务端

```sh
$ vncserver -localhost no
Cleaning stale pidfile '/home/khadas/.vnc/localhost:1.pid'!

New 'localhost:1 (khadas)' desktop at :1 on machine localhost

Starting applications specified in /home/khadas/.vnc/xstartup
Log file is /home/khadas/.vnc/localhost:1.log

Use xtigervncviewer -SecurityTypes VncAuth -passwd /home/khadas/.vnc/passwd :1 to connect to the VNC server.
```

2. 查看端口

根据第一步提供的信息`/home/khadas/.vnc/localhost:1.log`

```sh
$ cat /home/khadas/.vnc/localhost:1.log
Mon Jul 12 07:39:39 2021
 vncext:      VNC extension running!
 vncext:      Listening for VNC connections on local interface(s), port 5901
 vncext:      created VNC server for screen 0
 ComparingUpdateTracker: 0 pixels in / 0 pixels out
 ComparingUpdateTracker: (1:nan ratio)
```
3. 客户端连接

[vnc view下载地址](https://www.realvnc.com/en/connect/download/viewer/)，选择自己对应的平台

客户端连接格式

```
ip:part #示例192.168.1.172:5091
```

输入密码即可控制远程桌面


