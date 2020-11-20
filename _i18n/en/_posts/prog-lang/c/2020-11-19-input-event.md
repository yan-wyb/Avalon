---
layout: post
author: Yan 
toc: true
image: assets/images/no-title/no-title1.jpg
title: Analysis of input events under Linux-C
tags:
categories: [linux, c]
top-first: true
top-twice: true
first-level-classification: prog-lang
twice-level-classification: c
permalink: /:year/:month/:day/:title:output_ext
---

The linux input subsystem protocol uses type types and encoding codecs to represent the value of the input device and use this to notify the user space.

# Struct `input_event`

`input_event` is the most important structure, which records all the information of the input event. It is defined in the file `linux/input.h`

```c
struct input_event
{
	struct timeval time;
	__u16 type;
	__u16 code;
	__s32 value;
};
```

1. `time`  Indicates when the event occurred
2. `type`  Indicates the type of event
3. `code`  The code representing the event
4. `value` Parameter value representing the event


# `evnet type`

Defines the type of input event. For example, the common `EV_KEY`, key input

1. `EV_SYN`       : The division mark between events. Events may be divided by time or space
2. `EV_KEY`       : Describe the state changes of keyboards, keys or similar keyboard devices
3. `EV_REL`       : Describe the change of the value on the relative axis
4. `EV_ABS`       : Describe the change of the value on the relative coordinate axis
5. `EV_MSC`       : When it cannot match the existing type, use that type for description
6. `EV_SW`        : Describe input switches with two states
7. `EV_LED`       : Control the on and off of the LED lights on the device
8. `EV_SND`       : Used to output prompt sound to the device
9. `EV_REP`       : Used for devices that can be automatically repeated (autorepeating)
10.`EV_FF`        : Send mandatory feedback commands to input devices
11.`EV_PWR`       : Especially for power switch input
12.`EV_FF_STATUS` : Receive the mandatory feedback status of the device

All `event types` are defined in `include/uapi/linux/input-event-codes.h`

# `event code`

A more detailed definition of the type defined by `Event tpye`. Take the keyboard as an example,
	
When `type`=`EV_KEY`, `code`=KEY_A` represents the input event of A on the keyboard.

All the detailed definitions of `event type` are in `include/uapi/linux/input-event-codes.h`

# `value`

`value` is the parameter value carried when the event occurs. Take the keyboard as an example

1. `value`=`0`Indicates that the button is pressed
2. `value`=`1`Indicates that the button is released
3. `value`=`2`Indicates that the key is automatically repeated


# issues

If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
