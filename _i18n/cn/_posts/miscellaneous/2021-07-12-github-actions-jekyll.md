---
layout: post
author: Yan 
toc: true
image: assets/images/miscellaneous/github-actions-logo.png
title: Github Actions自动部署jekyll
tags:
categories: [jekyll, github]
top-first: false
top-twice: false
first-level-classification: miscellaneous
twice-level-classification:
permalink: /:year/:month/:day/:title:output_ext
---

这篇主要记录如何使用GIthub Actions部署jekyll

# Repositories设置

1. 首先要在`github`上把项目设置成`public`,`travis`只对开源项目免费，然后将项目clone到本地

**note** : 这里一定要使用`ssh`的方式clone下来,不能使用`https`.

```shell
$ cd ${workspace}
$ git clone git@github.com:${user}/{your-blog}.git
```

2. 之后需要新建`gh-pages`分支,同时推送到远端

```shell
$ git branch gh-pages
$ git push origin pg-pages
```

3. 打开`github pages`

打开仓库的setting

![github-repo-setting]({{ site.baseurl }}/assets/images/miscellaneous/github-repo-setting.png)

在列表中找到`github pages`,设置成`gh-pages`分支

![github-pages-setting]({{ site.baseurl }}/assets/images/miscellaneous/github-pages-setting.png)


# Token设置


1. 打开`github`的`setting --> Development Settings`.

![github-setting]({{ site.baseurl }}/assets/images/miscellaneous/github-setting.png)

2. 点击左边最底下的`Personal access token`,在右上角就会看到`Generate new token`.

![github-generate-token]({{ site.baseurl }}/assets/images/miscellaneous/github-generate-token.png)

3. 为即将生成的新`token`设置`note`，相当于标识，或者别名

![github-token-note]({{ site.baseurl }}/assets/images/miscellaneous/github-token-note.png)

4. 设置`token`的权限

![github-token-scopes]({{ site.baseurl }}/assets/images/miscellaneous/github-token-scopes.png)

5. 记下`token`的值，这个值只有第一次生成时会显示，之后就不会再显示了，因此生成时一定要复制下来

![github-token-value.png]({{ site.baseurl }}/assets/images/miscellaneous/github-token-value.png)

6. 将token添加到`secrets`

![github secrets]({{ site.baseurl }}/assets/images/miscellaneous/github-secrets.png)

# 部署脚本设置

只要在仓库目录下新建`.github/workflows`文件夹，推送到github以后就会自动触发部署。

1. 新建`.github/workflows` 文件夹

```sh
$ mkdir -p .github/workflows
```

2. 新建脚本

```sh
$ vim .github/workflows/avalon.yaml
```

内容如下，

```sh
{% raw %}
name: Publish to my blog

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
      with:
        persist-credentials: false # otherwise, the token used is the GITHUB_TOKEN, instead of your personal token

    - name: Setup Ruby
      uses: ruby/setup-ruby@v1
    - name: Ruby gem cache
      uses: actions/cache@v1
      with:
        path: vendor/bundle
        key: ${{ runner.os }}-gems-${{ hashFiles('**/Gemfile.lock') }}
        restore-keys: |
          ${{ runner.os }}-gems-
    - name: Install gems
      run: |
        bundle config path vendor/bundle
        bundle install --jobs 4 --retry 3

    - name: Build Jekyll site
      run: JEKYLL_ENV=production bundle exec jekyll build

    - name: Commit files
      run: |
        cd ./_site
        git init
        git config --local user.name "Your name"
        git config --local user.email "Your email"
        git add .
        git commit -m "jekyll build at $(date)"
    - name: Push changes
      uses: ad-m/github-push-action@master
      with:
        directory: ./_site
        repository: {{ github user }}/{{ repository name }}
        branch: gh-pages
        github_token: ${{ secrets.ACCESS_TOKEN }}
        force: true
{% endraw %}
```

其中，

```sh
1. `git config`   要配置成你的git用户
2. `repository`   要配置成你的源码仓库
3. `ACCESS_TOKEN` 是Token设置中你生成的token
```

3. 新建ruby版本文件

```sh
echo 2.5.1 > .ruby-version
```

4. Push并自动部署

代码push到github以后就会触发自动部署，

![github action botton]({{ site.baseurl }}/assets/images/miscellaneous/github-action-botton.png)

在`Actions`就可以看到你的自动部署脚本是否成功运行。

# 域名重定向

1. 新建CNAME文件并添加自己的域名

```sh
echo example.com > CNAME
```

2. 设置DNS解析

这里以阿里云的域名为例，

![github action dns]({{ site.baseurl }}/assets/images/miscellaneous/github-action-dns.jpg)

如上图设置两条dns解析,第二条的解析记录填写你的github.io地址。

3. 打开https

在`github pages`处勾选


![github pages https]({{ site.baseurl }}/assets/images/miscellaneous/github-pages-https.png)


