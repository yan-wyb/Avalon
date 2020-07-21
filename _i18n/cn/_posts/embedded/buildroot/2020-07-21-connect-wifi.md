---
layout: post
author: Yan 
toc: true
image: assets/images/embedded/buildroot/wifi_logo.svg
title: buildroot如何连接wifi
tags:
categories: [amlogic, buildroot, net]
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: buildroot
permalink: /:year/:month/:day/:title:output_ext
---

# wpa_cli

使用`wpa_cli`命令直接连接wifi,重启即失效.

```shell
buildroot# wpa_cli -i wlan0 add_network
0
buildroot# wpa_cli -i wlan0 set_network 0 ssid '"XXX"'
buildroot# wpa_cli -i wlan0 set_network 0 key_mgmt WPA-PSK
buildroot# wpa_cli -i wlan0 set_network 0 psk '"XXXXXXXX"'
buildroot# wpa_cli -i wlan0 select_network 0
buildroot# wpa_cli -i wlan0 enable_network 0
buildroot# dhcpcd wlan0
```

# wpa_supplicant

## 修改配置文件

```shell
buildroot# nano /etc/wpa_supplicant
```

示例如下

```shell
ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=0
ap_scan=1
network={
    ssid=”myAP” pairwise=CCMP TKIP
    group=CCMP TKIP
    proto=WPA RSN
    key_mgmt=WPA-PSK
    priority=5
    psk=”my_passwd”
}
```

## 重启服务

直接重启整个wifi服务

```shell
buildroot# /etc/init.d/S42wifi reload
```

或者

```shell
buildroot# wpa_supplicant -B -Dnl80211 -iwlan0 -c/etc/wpa_supplicant.conf
```

## 重启dhcpcd

```shell
buildroot# dhcpcd
```

# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
