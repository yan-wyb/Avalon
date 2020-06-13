---
layout: post
author: Yan 
toc: true
image: assets/images/miscellaneous/jekyll-travis.png
title: jekyll automatic deployment
tags:
categories: [ruby, git, nginx, travis, ssh, linux]
top-first: false
top-twice: false
first-level-classification: miscellaneous
twice-level-classification:
permalink: /:year/:month/:day/:title:output_ext
---


Use travis to automatically deploy jekyll blog to server or github-pages


# Deploy to server

## Brief description

1. Authorize `travis` to read, write, and monitor warehouse permissions
2. Local to push code to remote trigger `travis`
3. `travis` login server via `ssh` to automatically synchronize code to compile new static web page code
4. `nginx` implementation deployment

Automate the deployment of private repositories to the server or the source repository on the server can use `githooks` --> [githooks automated deployment] ({{ site.baseurl }}/2020/06/09/githooks.html)

## Environmental preparation

This step is mainly to set the environment of the server and obtain the authorization of travis to github

### server

The server can use Alibaba Cloud or Tencent Cloud. The configuration can basically go to the minimum configuration. Most of the time, only one nginx is run. The system selects ubuntu or centos. The following uses Alibaba Cloud of ubuntu18.04 as an example

Update the system after logging into the server

```shell
root# apt update 
root# apt upgrade
```

In order to avoid security risks, an ordinary user with sudo privileges should be established to deploy the blog. Follow the method in [Linux New User] ({{ site.baseurl }}/2020/06/05/add-user.html) .
After that, all operations are switched to ordinary users.

### git

The git tool needs to be installed on the server

```shell
$ sudo apt install git
```

Clone your blog to the server

```shell
$ cd ${workspace}
$ git clone git@github.com:/${user}/&{your-blog}.git
```

The repository on github needs to be set up as open source, `travis` is charged for private project deployment

### ruby

To install `ruby` environment on the server, please refer to [Ruby Installation and Use]({{ site.baseurl }}/2020/06/05/ruby.html)

After installation, you need to install three `ruby` packages

```shell
$ gem install jekyll bundler travis
```

Subsequent use of `bundle install` for other packages can be done automatically

### nginx

Subsequent use of `bundle install` for other packages can be done automatically

After configuring the environment, the root path does not need to be configured first

### ssh

For the installation of `ssh` on the server, please refer to [ssh installation and use] ({{ site.baseurl }}/2020/05/30/ssh.html)

Then generate a pair of keys for use

### travis

First use github to log in [travis] (https://www.travis-ci.org/). Open `setting`

Then synchronize the warehouse information of the account

![travis-sync-account]({{ site.baseurl }}/assets/images/miscellaneous/travis-sync-account.png)

Then open the warehouse you want to deploy automatically

![travis-open-repo]({{ site.baseurl }}/assets/images/miscellaneous/travis-open-repo.png)

## Implement automatic deployment

Switch to your blog path

```shell
$ cd ${workspace}/${your-blog}
```

### Basic automatic deployment script

new a file name `.travls.yml`

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
We need your GitHub login to identify you.
This information will not be sent to Travis CI, only to api.github.com.
The password will not be displayed.

Try running with --github-token or --auto if you don't want to enter your password anyway.

Username: ${your/github/user}
password: {your/github/password}
```

"Success" appears to indicate successful login


### Generate secret key

```shell
$ travis encrypt-file ~/.ssh/id_rsa --add
```
Follow the prompts, the id_rsa.enc file will be generated, and it will be generated in the .travis file:

```yml
before_install:
- openssl aes-256-cbc -K $encrypted_ebb8fbb5669e_key -iv $encrypted_ebb8fbb5669e_iv
  -in id_rsa.enc -out ~/.ssh/id_rsa -d
```

### Set up an automatic deployment script

After travis detects the new submission and successfully isntall, log in to the server and perform our automatic deployment steps

Here I create a new `.travis` directory in the root directory and place travis related files under this folder

```shell
$ mv id_rsa.enc .travis
```

Modify `.travis.yml` file

```yml
before_install:
- openssl aes-256-cbc -K $encrypted_ebb8fbb5669e_key -iv $encrypted_ebb8fbb5669e_iv
  -in id_rsa.enc -out ~/.ssh/id_rsa -d

```

change into:

```yml
before_install:
- openssl aes-256-cbc -K $encrypted_ebb8fbb5669e_key -iv $encrypted_ebb8fbb5669e_iv
  -in .travis/id_rsa.enc -out ~/.ssh/id_rsa -d

```

Add `after_success` at the end of the file:

```yml
atfer_success:
- chmod 600 ~/.ssh/id_rsa
- ssh {user}@xx.x.xx.x -o StrictHostKeyChecking=no 'cd ~/blog/Avalon && bash .travis/deploy.sh && exit'
```

Add a new deploy.sh script under the `.travis` file

```shell

$ vim .travis/deploy.sh
```

The content is as follows

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

### nginx deployment

In the `nginx` configuration file, point the directory to the `_site` generated by the compilation

```shell
location / {
                        root ${workspace}/${your-blog}/_site;
                        index index.html index.htm;
                }

```

Since then, the entire automatic deployment process has ended, and every time you push the code, `travis` will automatically detect and log in to the server to update

# Deploy to github pages

## Brief description

1. Authorize `travis` to read, write, and monitor warehouse permissions
2. Local to push code to remote trigger `travis`
3. After `travis` is compiled, push to the'gh-pages' branch of the repository
4. `githubio` completes deployment

## Prepare the environment

Mainly complete the deployment of the local PC environment and github's authorization for travis

### ssh


Install `ssh` locally and put the generated public key on github. Please refer to [ssh installation and use]({{ site.baseurl }}/2020/05/30/ssh.html)

### ruby

To install `ruby` in the local environment, please refer to [Ruby Installation and Use]({{ site.baseurl }}/2020/06/05/ruby.html)

After installation, you need to install 3 `ruby` packages in the local environment

```shell
$ gem install jekyll bundler travis
```

### git

#### Repositories settings

First, set the project to `public` on `github`, `travis` is only free for open source projects, and then clone the project to the local

**note** : Here, you must use the `ssh` method to clone down, you cannot use `https`.

```shell
$ cd ${workspace}
$ git clone git@github.com:${user}/{your-blog}.git
```
After that, you need to create a new `gh-pages` branch and push it to the remote

```shell
$ git branch gh-pages
$ git push origin pg-pages
```

#### open `github pages`

Open the setting of git repository

![github-repo-setting]({{ site.baseurl }}/assets/images/miscellaneous/github-repo-setting.png)

Find `github pages` in the list and set it to `gh-pages` branch

![github-pages-setting]({{ site.baseurl }}/assets/images/miscellaneous/github-pages-setting.png)


### travis

First use github to log in [travis] (https://www.travis-ci.org/). Open `setting`

Then synchronize the warehouse information of the account

![travis-sync-account]({{ site.baseurl }}/assets/images/miscellaneous/travis-sync-account.png)

Then open the warehouse you want to deploy automatically

![travis-open-repo]({{ site.baseurl }}/assets/images/miscellaneous/travis-open-repo.png)


## Implement automatic deployment

Unlike deploying to a server, deploying to `github pages` we borrowed `rake` for automatic deployment

### github generates new `token`

When using `github` to log in `travis`, a `token` has actually been generated, but this `token` does not have permission to write repo, so a new `token` needs to be generated

1. Open `setting --> Development Settings` on `github`.

![github-setting]({{ site.baseurl }}/assets/images/miscellaneous/github-setting.png)

2. Click on `Personal access token` at the bottom of the left, and you will see `Generate new token` in the upper right corner.

![github-generate-token]({{ site.baseurl }}/assets/images/miscellaneous/github-generate-token.png)

3. Set a note for the new token to be generated, which is equivalent to an identifier, or an alias

![github-token-note]({{ site.baseurl }}/assets/images/miscellaneous/github-token-note.png)

4. Set permissions for `token`

![github-token-scopes]({{ site.baseurl }}/assets/images/miscellaneous/github-token-scopes.png)

5. Make a note of the value of `token`. This value will only be displayed when it is first generated, and will not be displayed afterwards, so it must be copied when it is generated.

![github-token-value.png]({{ site.baseurl }}/assets/images/miscellaneous/github-token-value.png)

### `token` generate key

Use `git` account to log in to `travis`

```shell
$ travis login
We need your GitHub login to identify you.
This information will not be sent to Travis CI, only to api.github.com.
The password will not be displayed.

Try running with --github-token or --auto if you don't want to enter your password anyway.

Username: ${your/github/user}
password: {your/github/password}
```

Using the `ruby` package of `travis` can generate a key containing `token`

```shell
$ travis encrypt 'GIT_NAME="${user}" GIT_EMAIL="${email}" GH_TOKEN=${token}'

Detected repository as ${user}/${your-blog}, is this correct? |yes| yes
Please add the following to your .travis.yml file:

  secure: "N/5TqXrxjS0J6yKvRlzXnuYtfRPFYeK/O2oumIMuCWTK9U9v54pBTyOhiuCvoS5zJkxa4hdQwXs+wdIBDimILPu1JqQEhtjqLC2toK3vMNgf76KE6G+FtBzpEOrjA8vsEALNGlh5LH8n9XkeCDzXgFx3bghMXKms/EOlnR+21Un3SQVDAvuNK32VLexokTxy9nDZ769kTD5ymvP7DU5ObzdstnMeYY5SDAllPOPI2FboQbU1bg71P2LRvc3aF+Gu3X95pVoUSRPqAuJhnPp1DyXW0ifC/hIH/6wEv+10HRXtBoMrW3SJc7OIBmuM1jjqbT/WR/19rlugBm5x4mL1ZFY2PjoYKIhAIIJGzG4biSc/UIQ801NdKPaB42+ZcPwVPrVgRjuCL7khbzMFM+JzwgQA54kp6YSnE1cfGNIdpLVjIzyhJBlpChn6ZDya+L2mnB37J8yOO02+BQJ+ZxoL/A10VLYE4RAvurMWC/YPjPK+Bszl9eEdE2iQyzddWOlCkYfrdOC7zcjdpkcoDNXGfCddKXC77uI/L0kFYxzAEANEdEWclrwP5+f5AnZyr8hVp6XyR3Zg7S4t8iSAXrQIP1tI3h50qNj1OAluQCqM43HXSz199LzAtruJQpv094V0/oey7IuRrXq/fiTrkmFNyB/tWqeNp9vZO19R+xSI4g8="

Pro Tip: You can add it automatically by running with --add.


```

Save this `secure` value, this code will be used when connecting the code generated by `travis` push to the `gh-pages` branch, we need to configure it in the `.travis.yml` file

### `.travis.yml` file

Put the `secure` just generated in the `.travis.yml` file, the complete file:

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

The entire process of compilation and psuh is completed by `script: bundle exec rake deploy --quiet`

### `rake` to compile and push

#### Rakefile


Create a new `Rakefile` in the blog root directory

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

Add `rake` to `Gemfile` so that `bundle install` will automatically install `rake` and dependencies. If there is no `Gemfile` then create a new one

```ruby
gem "rake"
gem "github-pages", ">= 204"
```

#### Modify `_config.yml`

Finally, you need to add `Rakefile`, `Gemfile`, `.travisi.yml`, etc. to the `exclude` of the configuration file. The configuration file, etc. are not used as compiled content

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

destination: ./build_site/
```

Create a new `repo` variable, the variable value is the name of your source repository, it will be read when pushing the code in `rake`

```yml
repo: ${your-blog}
```

Now, after the local push code reaches github, travis will be automatically deployed to your `github pages`, your `github pages` address is

```
https://${user}.github.io/${your-blog}

```

# Complete source code

## server

If using server deployment, the source code template is as follows

travis : [https://github.com/yan-wyb/source/tree/master/web/blog/jekyll/travis-to-server](https://github.com/yan-wyb/source/tree/master/web/blog/jekyll/travis-to-server)

nginx  : [https://github.com/yan-wyb/source/blob/master/web/nginx/nginx.conf](https://github.com/yan-wyb/source/blob/master/web/nginx/nginx.conf)

## github Pages

If deployed on `github pages`, the template is as follows

travis : [https://github.com/yan-wyb/source/tree/master/web/blog/jekyll/travis-to-github-pages](https://github.com/yan-wyb/source/tree/master/web/blog/jekyll/travis-to-github-pages)

# **note**

1. `gitlab` operation is the same as `github`

2. When deploying to github-pages, the deployment branch name can only be `gh-pages`

3. Replace all "${ }` 
