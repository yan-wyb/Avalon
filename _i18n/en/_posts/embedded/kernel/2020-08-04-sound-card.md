---
layout: post
author: Yan 
toc: true
image: assets/images/images1.bmp
title: sound card debug
tags:
categories: kernel
top-first: false
top-twice: false
first-level-classification: embedded
twice-level-classification: kernel
permalink: /:year/:month/:day/:title:output_ext
---

HDMI and CVBS `sound card` debugging records

# Check if the `sound card` driver registration is successful

* switch root user

```shell
$ su
Password:
root@root#
```

* Check if the registration is successful

```shell
root@root# cat /proc/asound/cards
 0 [AMLAUGESOUND   ]: AML-AUGESOUND - AML-AUGESOUND
                      AML-AUGESOUN
```

Normally, the registered sound card will be printed out.

* Delete the wrong node

Registration failed, delete unused sound card nodes in dts.

# Test `HDMI` and `CVBS` sound card equipment

* Print out the available devices under the sound card

```shell
$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: AMLAUGESOUND [AML-AUGESOUND], device 0: TDM-B-dummy-alsaPORT-i2s multicodec-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: AMLAUGESOUND [AML-AUGESOUND], device 1: SPDIF-dummy-alsaPORT-spdif dummy-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: AMLAUGESOUND [AML-AUGESOUND], device 2: TDM-C-dummy dummy-2 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: AMLAUGESOUND [AML-AUGESOUND], device 3: SPDIF-B-dummy-alsaPORT-spdifb dummy-3 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```

* Use `aplay` to debug sound card devices

```shell
$ aplay -Dhw:0,0 test.wav #CVBS is the device 0 under sound card 0
$ aplay -Dhw:0,1 test.wav #HDMI is the device 1 under sound card 0
```

In this board, `CVBS` is `TDM-B-dummy-alsaPORT-i2s`,`HDMI` is `SPDIF-dummy-alsaPORT-spdif`.


# Adjust `dts`

* Use `cvbs` and `HDMI`, `CVBS` node is `@0`, `HDMI` node is `@1`.

* Use `cvbs` and `HDMI`, `CVBS` node is `@0`, `HDMI` node is `@1`.


# issues

If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
