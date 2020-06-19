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
permalink: /:year/:month/:day/:title:output_ext
---

VIM editor configuration

# Install VIM

Install that using the system's package manager or software center. Take ubuntu as an example

```shell
$ sudo apt install vim
```

Or clone from the official github and then compile.

```shell
$ git clone https://github.com/vim/vim.git
$ cd vim/src
$ make
```

# VIM configuration file

The VIM installed by default has no configuration file. Create one in the home directory with the file name `.vimrc`. Every time VIM starts, this configuration file is loaded in the home directory by default.

```shell
$ touch ~/.vimrc
```

Simply configure this file, such as opening the line number, the function of the tab key, etc.

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

# issues

If there are doubts or errors, please mention issues --> [Issues](https://github.com/yan-wyb/issues/issues)

