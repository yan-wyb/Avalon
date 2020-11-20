---
layout: post
author: Yan 
toc: true
image: assets/images/no-title/no-title1.jpg
title: 如何在linux系统上获取扫描枪数据
tags:
categories: [linux, c]
top-first: false
top-twice: true
first-level-classification: embedded
twice-level-classification: application
permalink: /:year/:month/:day/:title:output_ext
---

Linux获取扫描枪数据,通过对`/dev/input`目录下的输节点监测,并读取其中的数据


# 原理分析

扫描枪的原理与键盘输入的原理相同,都属于输入设备.将扫描当成普通的输入事件处理即可,从`/dev/input/eventX`节点获取扫描的所有数据输入.

通过输入事件的`type`,`value`可以筛选出不同的事件,相应的`data`就是我们需要的扫描枪的输入的值

# 代码处理

## 获取节点的名字

在制定输入设备的时候,通常输入通过打印输入设备的名字,确认是否监测对了正确的节点.

```c
ioctl (fd, EVIOCGNAME (sizeof (name)), name);
```

通过ioctl函数组的`EVIOCGNAME`获取事件节点的名称,并打印出来,确认节点的正确性

```c
printf ("Reading From : %s (%s)\n", device, name);
```

## 获取扫描枪的数据

当你通过扫描枪扫描了一个条形码或者二维码时,数据就会通过输入事件的形式输入.

```c
read(fd,&buff,sizeof(struct input_event))
```

关于`input_event`.事件结构体的定义和使用,可以参考[Linux-C下的输入事件分析]({{ site.baseurl }}/2020/11/19/input-event.html)

## 处理获取的数据

1. 按键的输入有按下和松开两个`value`.而扫描枪是类似键盘输入的形式,所以也有`value=0`和`value=1`,选择其中一个即可
2. 当数据的类型为`1`,也就是`EV_KEY`.数据才是我们需要的扫描枪的数据

```c
if (buff.value == 1 && buff.type == 1 ){
    printf("i:%d,type:%d code:%d value:%d\n",i,buff.type,buff.code,buff.value);
}
```

# 示例

这里以扫描枪扫描MAC地址为例,扫描以后将数据存储到文件中

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

完整的源码[https://github.com/yan-wyb/source/tree/master/c/embedded/app/Scanner](https://github.com/yan-wyb/source/tree/master/c/embedded/app/Scanner)

# Picturs ![]({{ site.baseurl }}/assets/images/)
# link []({{ site.baseurl }})

# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
