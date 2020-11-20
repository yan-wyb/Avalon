---
layout: post
author: Yan 
toc: true
image: assets/images/no-title/no-title1.jpg
title: Linux-C下的输入事件分析
tags:
categories: [linux, c]
top-first: true
top-twice: true
first-level-classification: prog-lang
twice-level-classification: c
permalink: /:year/:month/:day/:title:output_ext
---

linux输入子系统协议用类型types和编码codecs来表示输入设备的值并用此来通知用户空间.

# 结构体`input_event`

`input_event`是其中最重要的结构体,该结构体记录了输入事件的所有信息.定义在文件`linux/input.h`中

```c
struct input_event
{
	struct timeval time;
	__u16 type;
	__u16 code;
	__s32 value;
};
```

1. `time`  表示事件发生的时间
2. `type`  表示事件的类型
3. `code`  表示事件的编码
4. `value` 表示事件的参数值


# `evnet type`

定义了输入事件的类型.例如常见的`EV_KEY`,按键输入

1. `EV_SYN`       : 事件间的分割标志。事件可能按时间或空间进行分割
2. `EV_KEY`       : 描述键盘，按键或者类似键盘设备的状态变化
3. `EV_REL`       : 描述相对坐标轴上数值的变化
4. `EV_ABS`       : 描述相对坐标轴上数值的变化
5. `EV_MSC`       : 当不能匹配现有的类型时，使用该类型进行描述
6. `EV_SW`        : 描述具备两种状态的输入开关
7. `EV_LED`       : 控制设备上的LED灯的开和关
8. `EV_SND`       : 用来给设备输出提示声音
9. `EV_REP`       : 用于可以自动重复的设备(autorepeating)
10.`EV_FF`        : 给输入设备发送强制回馈命令
11.`EV_PWR`       : 特别用于电源开关的输入
12.`EV_FF_STATUS` : 接收设备的强制反馈状态。

所有的`event type`都定义在`include/uapi/linux/input-event-codes.h`

# `event code`

对`Event tpye`定义的类型进行更详细的定义.以键盘为例,
	
当`type`=`EV_KEY`时, `code`=KEY_A`代表了键盘上的A发生了输入事件.

所有`event type`的详细定义都在`include/uapi/linux/input-event-codes.h`

# `value`

`value`就是事件发生时所带的的参数值. 以键盘为例

1. `value`=`0`表示按键按下
2. `value`=`1`表示按键松开
3. `value`=`2`表示按键自动重复


# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
