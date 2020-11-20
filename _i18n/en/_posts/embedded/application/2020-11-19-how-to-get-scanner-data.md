---
layout: post
author: Yan 
toc: true
image: assets/images/no-title/no-title1.jpg
title: How to get scanner data on Linux system
tags:
categories: [linux, c]
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: application
permalink: /:year/:month/:day/:title:output_ext
---

Linux obtains the scanner data, monitors the input node in the `/dev/input` directory, and reads the data

# Principle analysis

The principle of the scanner is the same as the principle of keyboard input, which belongs to the input device. Treat the scan as a normal input event, and get all the scanned data input from the `/dev/input/eventX` node.

You can filter out different events by inputting the `type` and `value` of the event, and the corresponding `data` is the input value of the scanner we need

# Code processing

## Get the name of the node

When specifying the input device, usually enter the name of the input device by printing to confirm whether the correct node is monitored.

```c
ioctl (fd, EVIOCGNAME (sizeof (name)), name);
```

Get the name of the event node through the `EVIOCGNAME` of the ioctl function group, and print it out to confirm the correctness of the node

```c
printf ("Reading From : %s (%s)\n", device, name);
```

## Get the data of the scanner

When you scan a barcode or QR code with the scanner, the data will be entered in the form of input events.

```c
read(fd,&buff,sizeof(struct input_event))
```

For the definition and use of `input_event`. event structure, please refer to [Analysis of Input Events under Linux-C]({{ site.baseurl }}/2020/11/19/input-event.html)

## Process the acquired data

1. The key input has two `value`: press and release. The scanner is similar to keyboard input, so there are `value=0` and `value=1`, just choose one of them
2. When the data type is `1`, which is `EV_KEY`. The data is the data of the scanner we need

```c
if (buff.value == 1 && buff.type == 1 ){
    printf("i:%d,type:%d code:%d value:%d\n",i,buff.type,buff.code,buff.value);
}
```

# example

Here is an example of the MAC address scanned by the scanner, and the data will be stored in the file after scanning

```c
 if (argv[1] == NULL){
     printf("Please specify (on the command line) the path to the dev event interface devicen");
     exit (0);
 }

 if ((getuid ()) != 0)
     printf ("You are not root! This may not work...n");

 if (argc > 1)
     device = argv[1];

 if ((fd = open (device, O_RDONLY)) == -1)
     printf ("%s is not a vaild device.n", device);

 //Print Device Name
 ioctl (fd, EVIOCGNAME (sizeof (name)), name);
 printf ("Reading From : %s (%s)\n", device, name);

 while (1){
     while(read(fd,&buff,sizeof(struct input_event))==0);
     if (buff.value == 1 && buff.type == 1  && buff.code != 42){
         printf("i:%d,type:%d code:%d value:%d\n",i,buff.type,buff.code,buff.value);
         printf("convert:%c\n",convert[buff.code]);
         convert_value[i]=convert[buff.code];
         i++;
         if(i == 17){
             break;
         }
     }
 }
 printf("%s\n",convert_value);
 close(fd);
 fp = fopen("/tmp/eth_mac.txt", "w+");
 if(fp == NULL){
     printf("OPEN FILE ERROR\n");
 }
 size = sizeof(char);
 fwrite(convert_value, size, 17, fp);
 if(rd == EOF){
     printf("write eth_mac faile\n");
 }
 rewind(fp);
 fwrite(convert_value, size, 17, fp);
 if(rd == EOF){
     printf("write eth_mac faile\n");
 }
 fclose(fp);
```

Complete source code[https://github.com/yan-wyb/source/tree/master/c/embedded/app/Scanner](https://github.com/yan-wyb/source/tree/master/c/embedded/app/Scanner)

# issues

If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
