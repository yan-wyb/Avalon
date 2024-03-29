---
layout: post
author: Yan 
toc: true
image: assets/images/no-title/no-title18.jpg
title: 搭建V2Ray服务
tags:
categories: [ubuntu, windows, v2ray]
top-first: false
top-twice: false
first-level-classification: miscellaneous
twice-level-classification:
permalink: /:year/:month/:day/:title:output_ext
---


# Linux

## 获取应用

```sh
$ mkdir ~/v2ray && cd ~/v2ray
$ git clone https://github.com/yan-wyb/v2rayApplication.git
$ cd v2rayApplication
$ unzip v2ray-linux-64.zip
```

## 配置客户端

### Step1: 配置V2Ray

1. 打开客户端,选择`Preferences`
```sh
$ ./Qv2ray-v2.7.0-linux-x64.AppImage
```
![]({{ site.baseurl }}/assets/images/miscellaneous/ubuntuv2ray1.png)
2. 选择`Kernel Settings`,V2Ray核心文件件配置为上一步获取的仓库中的V2Ray核心文件夹
![]({{ site.baseurl }}/assets/images/miscellaneous/ubuntuv2ray2.png)

### Step2: 添加V2Ray节点

1. 选择`import`添加节点
![]({{ site.baseurl }}/assets/images/miscellaneous/ubuntuv2ray3.png)
2. 将VMESS链接添加到`Share Link`,点击`Import`完成添加
![]({{ site.baseurl }}/assets/images/miscellaneous/ubuntuv2ray4.png)
3. 点击已添加的节点或者有右击节点连接

**注意**: 手动添加节点信息，不使用VMESS链接的，请点击`NEW`添加。
自此，V2Ray插件已经可以正常运行起来了。

## 额外协议支持

点击查看本地插件文件夹，将仓库内的插件添加到对应的文件，重启软件

![]({{ site.baseurl }}/assets/images/miscellaneous/ubuntuv2ray5.png)


# Windows

## 安装客户端

1. 点击下载[Qv2ray-v2.7.0-Windows-Installer.exe](https://github.com/yan-wyb/v2rayApplication/raw/master/windows/Qv2ray-v2.7.0-Windows-Installer.exe)
2. 双击安装，全部选择默认选项

## 配置V2Ray

1. 桌面新建文件夹`v2ray`, 将[v2ray-windows-64.zip](https://github.com/yan-wyb/v2rayApplication/raw/master/windows/v2ray-windows-64.zip)解压到桌面的文件夹内。
![]({{ site.baseurl }}/assets/images/miscellaneous/windowsv2ray1.png)
2. 配置V2Ray核心文件路径，`首选项` --> `内核配置`:
![]({{ site.baseurl }}/assets/images/miscellaneous/windowsv2ray2.png)
3. 导入节点。点击导入，将VMESS链接粘贴在分享链接出。
![]({{ site.baseurl }}/assets/images/miscellaneous/windowsv2ray3.png)
4. 双击默认分组，就能看到刚才配置的节点，连接就能使用。
![]({{ site.baseurl }}/assets/images/miscellaneous/windowsv2ray4.png)


