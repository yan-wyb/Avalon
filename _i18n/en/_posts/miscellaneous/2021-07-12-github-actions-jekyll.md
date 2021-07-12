---
layout: post
author: Yan 
toc: true
image: assets/images/miscellaneous/github-actions-logo.png
title: Github Actions automatically deploy jekyll
tags:
categories: [jekyll, github]
top-first: false
top-twice: false
first-level-classification: miscellaneous
twice-level-classification:
permalink: /:year/:month/:day/:title:output_ext
---

This article mainly records how to deploy jekyll using Github Actions

# Repositories Settings

1. First, set the project to `public` on `github`, `travis` is only free for open source projects, and then clone the project to the local

**note** : Here, you must use the `ssh` method to clone down, you cannot use `https`.

```shell
$ cd ${workspace}
$ git clone git@github.com:${user}/{your-blog}.git
```
2. After that, you need to create a new `gh-pages` branch and push it to the remote

```shell
$ git branch gh-pages
$ git push origin pg-pages
```

3. Open `github pages`

Open the setting of git repository

![github-repo-setting]({{ site.baseurl }}/assets/images/miscellaneous/github-repo-setting.png)

Find `github pages` in the list and set it to `gh-pages` branch

![github-pages-setting]({{ site.baseurl }}/assets/images/miscellaneous/github-pages-setting.png)

# Token Settings

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

6. Add token to `secrets`

![github secrets]({{ site.baseurl }}/assets/images/miscellaneous/github-secrets.png)

# Deployment script settings

Just create a new `.github/workflows` folder in the warehouse directory, and the deployment will be triggered automatically after pushing to github.

1. Create a new `.github/workflows` folder

```sh
$ mkdir -p .github/workflows
```

2. New script

```sh
$ vim .github/workflows/avalon.yaml
```

content:

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

among them,

```sh
1. `git config`   To configure as your git user
2. `repository`   To be configured as your source code repository
3. `ACCESS_TOKEN` Is the token you generated in the Token settings
```

3. New ruby version file

```sh
echo 2.5.1 > .ruby-version
```

4. Push and deploy automatically

After the code is pushed to github, it will trigger automatic deployment

![github action botton]({{ site.baseurl }}/assets/images/miscellaneous/github-action-botton.png)

In `Actions`, you can see whether your automatic deployment script runs successfully.

# Domain name redirection

1. Create a new CNAME file and add your own domain name

```sh
echo example.com > CNAME
```

2. Set up DNS resolution

Here is an example of Alibaba Cloud's domain name,

![github action dns]({{ site.baseurl }}/assets/images/miscellaneous/github-action-dns.jpg)

Set up two dns resolutions as shown above, and fill in your github.io address in the second resolution record.

3. Use https

Check the `github pages`

![github pages https]({{ site.baseurl }}/assets/images/miscellaneous/github-pages-https.png)


