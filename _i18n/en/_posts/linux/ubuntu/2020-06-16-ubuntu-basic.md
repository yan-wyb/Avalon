---
layout: post
author: Yan 
toc: true
image: assets/images/linux/ubuntu/ubuntu-logo.jpg
title: Ubuntu 20.04 Configiure
tags:
categories: linux
top-first: true
top-twice: true
first-level-classification: linux
twice-level-classification: ubuntu
permalink: /:year/:month/:day/:title:output_ext
---

# Sougou Pinyin
Ubuntu20.04 no longer supports QT4, so it originally relied on QT4's Sogou input method, and currently cannot be installed on 20.04,
Currently, a community developer has extracted an available version from the customized version of the enterprise.

```shell
$ cd ${workspace}
$ wget https://github.com/yan-wyb/somethingelse/raw/master/tools/sogouimebs.deb
$ sudo apt install ./sogouimebs.deb

```

The system will automatically install dependencies, including `fcitx`. Next set --> open `Language Supports`.

![Language Supports icon]({{ site.baseurl }}/assets/images/linux/ubuntu/language-supports-icon.png)

Set `Keyboard input method system` to `fcitx`.

![Language Supports]({{ site.baseurl }}/assets/images/linux/ubuntu/language-supports.png)

Then restart, you will see the fcitx settings in the upper right corner.

![Language Supports Setting]({{ site.baseurl }}/assets/images/linux/ubuntu/language-supports-setting.png)

Click the `+` sign in the lower left corner, do not check `Only Show Current Language`. Search for `sogou`, and click add.

![Language Support Add]({{ site.baseurl }}/assets/images/linux/ubuntu/language-supports-add.png)

# tweaks

tweaks is one of the best tools for managing UI.

```shell
$ sudo apt upate
$ sudo apt install gnome-shell-extensions
$ sudo apt install gnome-tweak-tool 
```

After configuration, first open the user themes, and then restart the software,

![tweaks user themes]({{ site.baseurl }}/assets/images/linux/ubuntu/tweaks-user-themes.png)

Restart the software to configure the theme, icon, terminal style, wallpaper, etc.

![tweaks]({{ site.baseurl }}/assets/images/linux/ubuntu/tweaks.png)

# docky

docky is a dock tool imitating IOS style.

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

![docky]({{ site.baseurl }}/assets/images/linux/ubuntu/docky.png)

After the installation is complete, you can delete the downloaded `deb`.

```shell
$ cd ${workspace}
$ rm *.deb
```

# ScreenShot

There are many screenshot tools under Linux, but the screenshot tool that comes with the Gnome desktop is very easy to use.

```shell
$ gnome-screenshot
```

Only want to take a screenshot, you can bring the `-a` parameter.

```shell
$ gnome-screenshot -a
```

Set as a shortcut key `Setting --> Keyboard`, click `+` to add a new shortcut key, fill in `name` and `command`.

![shortcut screenshot]({{ site.baseurl }}/assets/images/linux/ubuntu/shortcut-screenshot.png)


# VirtualBox

Ubuntu20.04 can be installed directly through the APT source to install the latest virtualBox.

```shell
$ sudo apt update
$ sudo apt install build-essential
$ sudo apt install virtualbox
$ sudo apt install virtualbox-ext-pack
```

Set USB read and write permissions.

```shell
$ sudo groupadd usbfs
$ sudo adduser $USER vboxusers
$ sudo adduser $USER usbfs
```

**note**: `source boot` cannot be opened in the BIOS, if it is opened, please close it and add `--reinstall` to reinstall.

# Sublime Text

```shell
$ wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
$ sudo apt-add-repository "deb https://download.sublimetext.com/ apt/stable/"
$ sudo apt install sublime-text
```

# Serial port tool to add USB permission

```shell
$ sudo usermod -a -G dialout $(whoami)
```

Effective after logout or restart

# SecureCRT

```sh
$ wget https://github.com/yan-wyb/somethingelse/raw/master/tools/Ubuntu20.04_SecureCRT.7z
$ 7z x Ubuntu20.04_SecureCRT.7z
```

follow readme to intall 

# issues

If there are doubts or errors, please mention issues --> [Issues](https://github.com/yan-wyb/issues/issues)
