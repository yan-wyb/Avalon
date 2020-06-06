---
layout: post
author: Yan 
toc: true
image: assets/images/miscellaneous/VIM-profile.jpeg
title: VIM
tags:
categories: vim
top-first: true
tpo-twice: false
first-level-classification: miscellaneous
twice-level-classification:
permalink: /:categories/:year/:month/:day/:title:output_ext
---

VIM编辑器配置

## 安装VIM


直接使用系统的包管理器或者软件中心安装。以ubuntu为例
```shell
$ sudo apt install vim
```
或者从官方的git上面clone,然后编译。
```shell
$ git clone https://github.com/vim/vim.git
$ cd vim/src
$ make
```

## VIM配置文件

默认安装的VIM是没有配置文件。在home目录创建一个，文件名`.vimrc`。每次VIM启动都会默认在home目录下加载这个配置文件.
```shell
$ touch ~/.vimrc
```
简单的配置一下这个文件，如打开行号，tab键的功能等.

```shell
syntax on
set cindent
set hlsearch

set nu
set cursorline

set ts=4
set expandtab
%retab!
set sw=4
"set tabstop=4
set fencs=utf-8,GB18030

set background=dark

if has("autocmd")
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

```

