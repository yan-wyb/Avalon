---
layout: post
author: Yan 
toc: true
image: assets/images/miscellaneous/jekyll-travis.png
title: jekyll自动部署
tags:
categories: [ruby, git, nginx, travis, ssh, linux]
top-first: false
top-twice: false
first-level-classification: miscellaneous
twice-level-classification:
permalink: /:year/:month/:day/:title:output_ext
---


使用travis自动部署jekyll博客到服务器或者github-pages



# 部署到服务器

## 简述

1. 授权`travis`读写和监测仓库的权限
2. 本地到push代码到远程触发`travis`
3. `travis`通过`ssh`登录服务器自动同步代码编译新的静态网页代码
4. `nginx`实现部署

## 环境准备

这步主要是设置服务器的环境和travis对github的授权获取

### 服务器

服务器使用阿里云或者腾讯云都可以,配置基本可以走最低配置,大多数时候只跑一个nginx而已.系统选择`ubuntu`或者`centos`.下面以`ubuntu18.04`的阿里云为例

登录服务器以后先更新系统

```shell
root# apt update 
root# apt upgrade
```

为了避免安全风险,应该先建立一个带有sudo权限的普通用户部署博客.按照[linux新建用户里面的方法]({{ site.baseurl }}/2020/06/05/add-user.html)新建.
之后所有操作切换到普通用户进行.

### git

服务器上需要安装`git`工具

```shell
$ sudo apt install git
```

克隆你的blog到服务器

```shell
$ cd ${workspace}
$ git clone git@github.com:/${user}/&{your-blog}.git
```

github上的该仓库需要设置成开源,`travis`对私有项目部署是收费的

### ruby

在服务器上安装`ruby`环境请参考[Ruby安装使用]({{ site.baseurl }}/2020/06/05/ruby.html)

安装完以后需要安装三个`ruby`包

```shell
$ gem install jekyll bundler travis
```

其他的包后续使用`bundle install`可以自动完成

### nginx

`ngix`在服务器上的安装与设置请参考[Nginx安装配置]({{ site.baseurl }}/2020/06/06/nginx.html)

配置好环境以后,`root`的路径先不用配置

### ssh

`ssh`在服务器上的安装请参照[ssh安装使用]({{ site.baseurl }}/2020/05/30/ssh.html)

然后生成一对秘钥待使用

### travis

首先要使用github登录[travis](https://www.travis-ci.org/).打开`setting`

然后同步账号的仓库信息

![travis-sync-account]({{ site.baseurl }}/assets/images/miscellaneous/travis-sync-account.png)

接着打开你要自动部署的仓库

![travis-open-repo]({{ site.baseurl }}/assets/images/miscellaneous/travis-open-repo.png)

## 实现自动部署

切换到你的blog路径

```shell
$ cd ${workspace}/${your-blog}
```

### 基本自动部署脚本

新建`.travls.yml`

```shell
$ vim .travis.yml
```

```yml
language: ruby
rvm:
- 2.7.0
branches:
  only:
  - master
install:
- bundle install
script: jekyll build
```

### tarvis login

```shell
$ travis login
Warning: the running version of Bundler (2.1.2) is older than the version that created the lockfile (2.1.4). We suggest you to upgrade to the version that created the lockfile by running `gem install bundler:2.1.4`.
We need your GitHub login to identify you.
This information will not be sent to Travis CI, only to api.github.com.
The password will not be displayed.

Try running with --github-token or --auto if you don't want to enter your password anyway.

Username: ${your/github/user}
password: {your/github/password}
```
出现`success`就是登录成功


### 生成保密key

```shell
$ travis encrypt-file ~/.ssh/id_rsa --add
```

按照提示操作,就会生成`id_rsa.enc`文件,同时在`.travis`文件里会生成
```yml
before_install:
- openssl aes-256-cbc -K $encrypted_ebb8fbb5669e_key -iv $encrypted_ebb8fbb5669e_iv
  -in id_rsa.enc -out ~/.ssh/id_rsa -d
```

### 设置自动部署脚本

travis检测到新提交并成功`isntall`以后,登录服务器,进行我们自动部署的步骤

这里我在根目录新建`.travis`目录,把travis相关文件放置到这个文件夹下

```shell
$ mv id_rsa.enc .travis
```

修改`.travis.yml`文件

```yml
before_install:
- openssl aes-256-cbc -K $encrypted_ebb8fbb5669e_key -iv $encrypted_ebb8fbb5669e_iv
  -in id_rsa.enc -out ~/.ssh/id_rsa -d

```

修改为

```yml
before_install:
- openssl aes-256-cbc -K $encrypted_ebb8fbb5669e_key -iv $encrypted_ebb8fbb5669e_iv
  -in .travis/id_rsa.enc -out ~/.ssh/id_rsa -d

```

在文件最后新增`after_success`:

```yml
atfer_success:
- chmod 600 ~/.ssh/id_rsa
- ssh {user}@xx.x.xx.x -o StrictHostKeyChecking=no 'cd ~/blog/Avalon && bash .travis/deploy.sh && exit'
```

在`.travis`文件加下新建deploy.sh脚本

```shell

$ vim .travis/deploy.sh
```

内容如下

```shell
set -euxo pipefail

echo -e "\033[32m $(git version) \033[0m"

git config user.name ${user}
git config user.email ${email}

cd ${workspace}/{your-blog}

git pull origin master
~/.rvm/gems/ruby-2.7.0/wrappers/bundle install
~/.rvm/gems/ruby-2.7.0/wrappers/jekyll build

exit 0
```

### nginx部署

在`nginx`配置文件中将目录指向编译生成的`_site`

```shell
location / {
                        root ${workspace}/${your-blog}/_site;
                        index index.html index.htm;
                }

```

自此,整个自动部署流程就结束了,之后每次push代码,`travis`都会自动检测并登录服务器进行更新

# 部署到github pages

## 简述

1. 授权`travis`读写和监测仓库的权限
2. 本地到push代码到远程触发`travis`
3. `travis`编译完以后push到仓库的'gh-pages'分支
4. githubio完成部署

## 准备环境

主要完成本地PC环境的部署和github对travis的授权

### ssh

在本地安装`ssh`，将生成的公钥放上个github。请参照[ssh安装使用]({{ site.baseurl }}/2020/05/30/ssh.html)

### ruby

在本地环境中安装`ruby`环境请参考[Ruby安装使用]({{ site.baseurl }}/2020/06/05/ruby.html)

安装完需要在本地环境中安装3个`ruby`包

```shell
$ gem install jekyll bundler travis
```

### git

#### Repositories设置

首先要在`github`上把项目设置成`public`,`travis`只对开源项目免费，然后将项目clone到本地

```shell
$ cd ${workspace}
$ git clone git@github.com:${user}/{your-blog}.git
```

之后需要新建`gh-pages`分支,同时推送到远端

```shell
$ git branch gh-pages
$ git push origin pg-pages
```

#### 打开`github pages`

打开仓库的setting

![github-repo-setting]({{ site.baseurl }}/assets/images/miscellaneous/github-repo-setting.png)

在列表中找到`github pages`,设置成`gh-pages`分支

![github-pages-setting]({{ site.baseurl }}/assets/images/miscellaneous/github-pages-setting.png)


### travis

首先要使用github登录[travis](https://www.travis-ci.org/).打开`setting`

然后同步账号的仓库信息

![travis-sync-account]({{ site.baseurl }}/assets/images/miscellaneous/travis-sync-account.png)

接着打开你要自动部署的仓库

![travis-open-repo]({{ site.baseurl }}/assets/images/miscellaneous/travis-open-repo.png)


## 实现自动部署

与部署到服务器不同,部署到`github pages`我们借用了`rake`实现自动部署

### github生成新的`token`

在使用`github`登陆`travis`时实际上已经生成了一个`token`,但是这个`token`没有写repo的权限，因此需要生成新的`token`

1. 打开`github`的`setting --> Development Settings`.

![github-setting]({{ site.baseurl }}/assets/images/miscellaneous/github-setting.png)

2. 点击左边最底下的`Personal access token`,在右上角就会看到`Generate new token`.

![github-generate-token]({{ site.baseurl }}/assets/images/miscellaneous/github-generate-token.png)

3. 为即将生成的新`token`设置`note`，相当于标识，或者别名

![github-token-note]({{ site.baseurl }}/assets/images/miscellaneous/github-token-note.png)

4. 设置`token`的权限

![github-token-scopes]({{ site.baseurl }}/assets/images/miscellaneous/github-token-scopes.png)

5.记下`token`的值，这个值只有第一次生成时会显示，之后就不会再显示了，因此生成时一定要复制下来

![github-token-value.png]({{ site.baseurl }}/assets/images/miscellaneous/github-token-value.png)

### `token`生成密钥

利用`travis`的`ruby`包可以生成包含`token`的密钥

```shell
$ travis encrypt 'GIT_NAME="${user}" GIT_EMAIL="${email}" GH_TOKEN=${token}'

Detected repository as ${user}/${your-blog}, is this correct? |yes| yes
Please add the following to your .travis.yml file:

  secure: "N/5TqXrxjS0J6yKvRlzXnuYtfRPFYeK/O2oumIMuCWTK9U9v54pBTyOhiuCvoS5zJkxa4hdQwXs+wdIBDimILPu1JqQEhtjqLC2toK3vMNgf76KE6G+FtBzpEOrjA8vsEALNGlh5LH8n9XkeCDzXgFx3bghMXKms/EOlnR+21Un3SQVDAvuNK32VLexokTxy9nDZ769kTD5ymvP7DU5ObzdstnMeYY5SDAllPOPI2FboQbU1bg71P2LRvc3aF+Gu3X95pVoUSRPqAuJhnPp1DyXW0ifC/hIH/6wEv+10HRXtBoMrW3SJc7OIBmuM1jjqbT/WR/19rlugBm5x4mL1ZFY2PjoYKIhAIIJGzG4biSc/UIQ801NdKPaB42+ZcPwVPrVgRjuCL7khbzMFM+JzwgQA54kp6YSnE1cfGNIdpLVjIzyhJBlpChn6ZDya+L2mnB37J8yOO02+BQJ+ZxoL/A10VLYE4RAvurMWC/YPjPK+Bszl9eEdE2iQyzddWOlCkYfrdOC7zcjdpkcoDNXGfCddKXC77uI/L0kFYxzAEANEdEWclrwP5+f5AnZyr8hVp6XyR3Zg7S4t8iSAXrQIP1tI3h50qNj1OAluQCqM43HXSz199LzAtruJQpv094V0/oey7IuRrXq/fiTrkmFNyB/tWqeNp9vZO19R+xSI4g8="

Pro Tip: You can add it automatically by running with --add.


```

保存這個`secure`值,在連接`travis`push生成的代碼到`gh-pages`分支時會使用這個`secure`,我們需要配置到`.travis.yml`文件裡面


### `.travis.yml`文件

将刚才生成的`secure`放入`.travis.yml`文件中, 完整文件:

```yml
language: ruby
rvm:
- 2.7.0
branches:
  only:
  - master
install:
- bundle install
script: bundle exec rake deploy --quiet
env:
  global:
    secure:"${secure}"
```

编译和psuh的整个过程都通过`script: bundle exec rake deploy --quiet`交由`rake`完成


### `rake`实现编译和push

#### rakefile

在根目录下新建一个`rakefile`

```ruby
#############################################################################
#
# Modified version of jekyllrb Rakefile
# https://github.com/jekyll/jekyll/blob/master/Rakefile
#
#############################################################################

require 'rake'
require 'date'
require 'yaml'

CONFIG = YAML.load(File.read('_config.yml'))
USERNAME = CONFIG["username"] || ENV['GIT_NAME']
REPO = CONFIG["repo"] || "#{USERNAME}.github.io"

# Determine source and destination branch
# User or organization: source -> master
# Project: master -> gh-pages
# Name of source branch for user/organization defaults to "source"
if REPO == "#{USERNAME}.github.io"
  SOURCE_BRANCH = CONFIG['branch'] || "source"
  DESTINATION_BRANCH = "master"
else
  SOURCE_BRANCH = "master"
  DESTINATION_BRANCH = "gh-pages"
end

def check_destination
  unless Dir.exist? CONFIG["destination"]
    sh "git clone https://#{ENV['GIT_NAME']}:#{ENV['GH_TOKEN']}@github.com/#{USERNAME}/#{REPO}.git #{CONFIG["destination"]}"
  end
end

task :deploy do
    # Detect pull request
    if ENV['TRAVIS_PULL_REQUEST'].to_s.to_i > 0
      puts 'Pull request detected. Not proceeding with deploy.'
      exit
    end

    # Configure git if this is run in Travis CI
    if ENV["TRAVIS"]
      sh "git config --global user.name '#{ENV['GIT_NAME']}'"
      sh "git config --global user.email '#{ENV['GIT_EMAIL']}'"
      sh "git config --global push.default simple"
    end

    # Make sure destination folder exists as git repo
    check_destination

    sh "git checkout #{SOURCE_BRANCH}"
    # Generate the site
    #sh "bundle exec jekyll build"

    puts CONFIG["destination"]

    Dir.chdir(CONFIG["destination"]) { sh "git checkout #{DESTINATION_BRANCH}" }

    sh "bundle exec jekyll build"

    # Commit and push to github
    sha = `git log`.match(/[a-z0-9]{40}/)[0]
    Dir.chdir(CONFIG["destination"]) do
      sh "git add --all ."
      sh "git commit -m 'Updating to #{USERNAME}/#{REPO}@#{sha}.'"
      sh "git push --quiet origin #{DESTINATION_BRANCH}"
      puts "Pushed updated branch #{DESTINATION_BRANCH} to GitHub Pages"
    end
end
```

#### Gemfile

添加`rake`到`Gemfile`中,这样子`bundle install`就会自动安装`rake`以及依赖.没有`Gemfile`则新建一个

```ruby
gem "rake"
gem "github-pages", ">= 204"
```

#### 修改`_config.yml`

最后需要把`rakefile`,`Gemfile`以及`.travisi.yml`等添加添加到配置文件的`exclude`.配置文件等不作为编译的内容

```yml
exclude:
  - README.md
  - Rakefile
  - Gemfile
  - Gemfile.lock
  - changelog.md
  - "*.Rmd"
  - vendor
  - .travis.yml
  - LICENSE.txt
```

新建一个`repo`变量,变量值为你的源码仓库的名字,在`rake`中push代码时会读取

```yml
repo: ${your-blog}
```

现在,在本地push代码到github以后,travis就会自动部署到你的`github pages`,你的`github pages`地址为

```
https://${user}.github.io/${your-blog}

```


# **note**

1. `gitlab`操作与`github`相同
2. 部署到github-pages的话,部署分支名字只能为`gh-pages`
3. 凡是`${ }`的都要替换
