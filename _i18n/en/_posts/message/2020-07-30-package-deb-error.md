---
layout: post
author: Yan 
toc: true
image: assets/images/message/debian-image.png
title: Compilation errors encountered when packaging deb packages
tags:
categories: [debs, python]
top-first: true
top-twice: 
first-level-classification: message
twice-level-classification:
permalink: /:year/:month/:day/:title:output_ext
---

Record the bugs encountered in the packaged deb package and the solutions


# 1.`dh` error

## error info

```shell
fakeroot debian/rules clean
dh clean --with python3 --buildsystem=python_distutils
dh: warning: Compatibility levels before 9 are deprecated (level 7 in use)
dh: error: unable to load addon python3: Can't locate Debian/Debhelper/Sequence/python3.pm in @INC (you may need to install the Debian::Debhelper::Sequence::python3 module) (@INC contains: /etc/perl /usr/local/lib/aarch64-linux-gnu/perl/5.30.0 /usr/local/share/perl/5.30.0 /usr/lib/aarch64-linux-gnu/perl5/5.30 /usr/share/perl5 /usr/lib/aarch64-linux-gnu/perl/5.30 /usr/share/perl/5.30 /usr/local/lib/site_perl /usr/lib/aarch64-linux-gnu/perl-base) at (eval 4) line 1.
BEGIN failed--compilation aborted at (eval 4) line 1.
```

## Solution

```shell
$ sudo apt install dh-python
```

# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
