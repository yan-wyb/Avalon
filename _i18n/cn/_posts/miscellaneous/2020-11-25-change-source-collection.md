---
layout: post
author: Yan 
toc: true
image: assets/images/no-title/no-title1.jpg
title: 换源方法合集
tags:
categories:
top-first: flase
top-twice: false
first-level-classification: miscellaneous
twice-level-classification:
permalink: /:year/:month/:day/:title:output_ext
---

# npm 

1. 临时换源

```shell
--registry https://registry.npm.taobao.org
```

2. 修改源配置

```shell
npm config set registry https://registry.npm.taobao.org
```

# nvm

```shell
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
```

# ruby

1. ruby

```shell
$ gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
```

2. bundler

```shell
$ bundle config mirror.https://rubygems.org https://gems.ruby-china.com
```
# rvm

```shell
echo "ruby_url=https://cache.ruby-china.com/pub/ruby" > /usr/local/rvm/user/db
```

# python-pip

1. 临时换源

```shell
-i https://pypi.tuna.tsinghua.edu.cn/simple
```

2. 修改源配置

```shell
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```


# issues

如果有疑惑或错误,请提issues --> [Issues](https://github.com/yan-wyb/issues/issues)
