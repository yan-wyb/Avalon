---
layout: post
author: Yan 
toc: true
image: assets/images/linux/ubuntu/ubuntu-logo.jpg
title: Use VNC under Ubuntu
tags:
categories: ubuntu
top-first: false
top-twice: true
first-level-classification: linux
twice-level-classification: ubuntu
permalink: /:year/:month/:day/:title:output_ext
---

This article records how to configure and use VNC under Ubuntu 20.04.

# Install

1. Install dependencies

```sh
$ sudo apt-get install gnome-session-flashback
```

2. Install `VNC Server`

```sh
$ sudo apt-get install tigervnc-standalone-server
```

# Configiure

1. Disable UFW

```sh
$ sudo ufw disable
Firewall stopped and disabled on system startup
```

After closing, you can view it through the `status` command

```sh
$ sudo ufw status
Status: inactive
```

2. Set password

```
$ vncpasswd 
Password:
Verify:
Would you like to enter a view-only password (y/n)? n
```

This password is the password that needs to be entered when connecting remotely

3. Setup configuration file

```sh
$ vim ~/.vnc/xstartup
```

The configuration content is as follows

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

4. Add execute permission

```sh
$ sudo chmod +x  ~/.vnc/xstartup
```

# How To Use

1. Start the server

```sh
$ vncserver -localhost no
Cleaning stale pidfile '/home/khadas/.vnc/localhost:1.pid'!

New 'localhost:1 (khadas)' desktop at :1 on machine localhost

Starting applications specified in /home/khadas/.vnc/xstartup
Log file is /home/khadas/.vnc/localhost:1.log

Use xtigervncviewer -SecurityTypes VncAuth -passwd /home/khadas/.vnc/passwd :1 to connect to the VNC server.
```

2. View port

According to the information provided in the first step `/home/khadas/.vnc/localhost:1.log`

```sh
$ cat /home/khadas/.vnc/localhost:1.log
Mon Jul 12 07:39:39 2021
 vncext:      VNC extension running!
 vncext:      Listening for VNC connections on local interface(s), port 5901
 vncext:      created VNC server for screen 0
 ComparingUpdateTracker: 0 pixels in / 0 pixels out
 ComparingUpdateTracker: (1:nan ratio)
```
3. Client connection

[Download vnc view](https://www.realvnc.com/en/connect/download/viewer/)，Choose your own platform

Client connection format

```
ip:part #示例192.168.1.172:5091
```

Enter the password to control the remote desktop

