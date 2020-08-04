---
layout: post
author: Yan 
toc: true
image: assets/images/images1.bmp
title: sound card 调试
tags:
categories: kernel
top-first: false
top-twice: false
first-level-classification: embedded
twice-level-classification: kernel
permalink: /:year/:month/:day/:title:output_ext
---

HDMI以及CVBS的`sound card`调试记录

# 查看`sound card`驱动注册是否成功

* 切换到root用户

```shell
$ su
Password:
root@root#
```

* 查看是否注册成功

```shell
root@root# cat /proc/asound/cards
 0 [AMLAUGESOUND   ]: AML-AUGESOUND - AML-AUGESOUND
                      AML-AUGESOUN
```

正常会打印出注册成功的声卡

* 删除错误节点

注册失败,删除dts里面未使用的声卡节点.

# 测试`HDMI`以及`CVBS`声卡设备

* 打印出声卡下的可用设备

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

* 使用`aplay`调试声卡设备

```shell
$ aplay -Dhw:0,0 test.wav #CVBS是声卡0下的设备0
$ aplay -Dhw:0,1 test.wav #HDMI是声卡0下设备1
```

这里`CVBS`是`TDM-B-dummy-alsaPORT-i2s`,`HDMI`是`SPDIF-dummy-alsaPORT-spdif`.


# 调整`dts`

* 只使用`HDMI`,将`HDMI`相应的设备节点设置成`@0`.

* 使用`cvbs`和`HDMI`,`CVBS`节点为`@0`,`HDMI`节点为`@1`.


# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
