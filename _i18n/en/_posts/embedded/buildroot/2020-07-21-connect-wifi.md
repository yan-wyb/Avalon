---
layout: post
author: Yan 
toc: true
image: assets/images/embedded/buildroot/wifi_logo.svg
title: connect wifi on buildroot
tags:
categories: [amlogic, buildroot, net]
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: buildroot
permalink: /:year/:month/:day/:title:output_ext
---

# wpa_cli

use `wpa_cli` command to connect it , Restart is invalid.

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

## edit configiure file 

```shell
buildroot# nano /etc/wpa_supplicant
```

for example:

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

## Restart service

Restart wifi service

```shell
buildroot# /etc/init.d/S42wifi reload
```

or

```shell
buildroot# wpa_supplicant -B -Dnl80211 -iwlan0 -c/etc/wpa_supplicant.conf
```

## restart dhcpcd

```shell
buildroot# dhcpcd
```

# issues

If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
