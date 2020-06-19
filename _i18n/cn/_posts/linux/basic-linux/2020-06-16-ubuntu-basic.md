---
layout: post
author: Yan 
toc: true
image: assets/images/linux/basic-linux/ubuntu-logo.jpg
title: Ubuntu 20.04 配置
tags:
categories: linux
top-first: true
top-twice: true
first-level-classification: linux
twice-level-classification: basic-linux
permalink: /:year/:month/:day/:title:output_ext
---

# 搜狗输入法

Ubuntu20.04 不再支持QT4,所以原本依赖QT4的搜狗输入法,目前无法安装在20.04上,
目前有一个社区开发者从企业定制版本中抽取出来了一个可用版本

```shell
$ cd ${workspace}
$ wget https://github.com/yan-wyb/somethingelse/raw/master/tools/sogouimebs.deb
$ sudo apt install ./sogouimebs.deb

```

系统会自动安装依赖,其中就包括`fcitx`.接下来设置 --> 打开`Language Supports`.

![Language Supports icon]({{ site.baseurl }}/assets/images/linux/basic-linux/language-supports-icon.png)

将`Keyboard imput method system`设置成`fcitx`.

![Language Supports]({{ site.baseurl }}/assets/images/linux/basic-linux/language-supports.png)

然后重启,就会在右上角看到键盘的设置.

![Language Supports Setting]({{ site.baseurl }}/assets/images/linux/basic-linux/language-supports-setting.png)


点击左下角的`+`号,不要勾选`Only Show Current Language`.搜索`sogou`,点击添加

![Language Support Add]({{ site.baseurl }}/assets/images/linux/basic-linux/language-supports-add.png)

# tweaks

tweaks是用来管理UI的最好用的工具之一

```shell
$ sudo apt upate
$ sudo apt install gnome-shell-extensions
$ sudo apt install gnome-tweak-tool 
```

配置以后先打开`user themes`,然后重启软件,

![tweaks user themes]({{ site.baseurl }}/assets/images/linux/basic-linux/tweaks-user-themes.png)

重启软件就可以配置主题,图标,终端风格,壁纸等

![tweaks]({{ site.baseurl }}/assets/images/linux/basic-linux/tweaks.png)

# docky

docky是仿IOS风格的dock工具

```shell
$ cd ${workspace}
$ wget http://archive.ubuntu.com/ubuntu/pool/universe/g/gnome-sharp2/libgconf2.0-cil_2.24.2-4_all.deb
$ wget http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1_amd64.deb
$ wget http://archive.ubuntu.com/ubuntu/pool/universe/libg/libgnome-keyring/libgnome-keyring-common_3.12.0-1build1_all.deb
$ wget http://archive.ubuntu.com/ubuntu/pool/universe/libg/libgnome-keyring/libgnome-keyring0_3.12.0-1build1_amd64.deb
$ wget http://archive.ubuntu.com/ubuntu/pool/universe/g/gnome-keyring-sharp/libgnome-keyring1.0-cil_1.0.0-5_amd64.deb
$ sudo apt-get install ./*.deb
$ wget http://archive.ubuntu.com/ubuntu/pool/universe/d/docky/docky_2.2.1.1-1_all.deb
$ sudo apt-get install ./docky_2.2.1.1-1_all.deb
```

![docky]({{ site.baseurl }}/assets/images/linux/basic-linux/docky.png)

安装完成以后,可以删除下载的`deb`

```shell
$ cd ${workspace}
$ rm *.deb
```

# 截图

linux下的截图工具很多,但是Gnome桌面自带的截图工具就非常好用

```shell
$ gnome-screenshot
```

只想截图一部分,可以带上`-a`参数

```shell
$ gnome-screenshot -a
```

设置成快捷键 `Setting --> Keyboard`,点击`+`添加一个新的快捷键,填入`name`和`command`

![shortcut screenshot]({{ site.baseurl }}/assets/images/linux/basic-linux/shortcut-screenshot.png)


# VirtualBox

ubuntu20.04通过APT源直接安装就可以安装最新的virtualBox

```shell
$ sudo apt update
$ sudo apt install build-essential
$ sudo apt install virtualbox
$ sudo apt install virtualbox-ext-pack
```

设置USB读写权限

```shell
$ sudo groupadd usbfs
$ sudo adduser $USER vboxusers
$ sudo adduser $USER usbfs
```

**note**: BIOS中`source boot`不能打开,如果打开了请关闭后加上`--reinstall`重新安装

# Sublime Text

```shell
$ wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
$ sudo apt-add-repository "deb https://download.sublimetext.com/ apt/stable/"
$ sudo apt install sublime-text
```

# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
