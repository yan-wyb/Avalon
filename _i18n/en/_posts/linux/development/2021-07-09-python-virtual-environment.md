---
layout: post
author: Yan 
toc: true
image: assets/images/linux/development/python-logo.png
title: Several methods of creating python virtual environment under Linux
tags:
categories: python
top-first: false
top-twice: true
first-level-classification: linux
twice-level-classification: development
permalink: /:year/:month/:day/:title:output_ext
---

This article mainly introduces several methods of creating python virtual environment under Linux. The Linux system here uses Ubuntu as an example.

# Conda

`Conda` is a python package management tool, you can install conda virtual environment by installing anaconda or miniconda.

Take miniconda as an example (the difference between anaconda and miniconda is the number of pre-installed python packages),

## Install onda

```sh
$ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
$ bash Miniconda3-latest-Linux-x86_64.sh
```

Enter yes to agree to the agreement, and then press Enter, it will be installed in the home directory by default, and miniconda will pre-install commonly used python data processing packages.

## Use conda to create a virtual environment

### Activate the conda environment

After installing conda, you need to activate the conda environment first.

```
yan@yan:~$ bash
(base) yan@yan:~$ 
```

Seeing the `(base)` prefix is ​​to activate the conda environment successfully

### Create a virtual environment

conda can specify the python version when creating a virtual environment

```
(base) yan@yan:~$ conda create --name yan-wyb python=3.8 pip
```

The python version specified here is 3.8, and the pip package is also included

### Activate and exit the virtual environment

Activate the virtual environment

```sh
(base) yan@yan:~$ conda activate yan-wyb
(yan-wyb) yan@yan:~$
```

exit

```sh
(yan-wyb) yan@yan:~$ conda deactivate
(base) yan@yan:~$
```

Compared with other methods, Conda can specify the python version, and pre-install python-based data processing packages and common packages.

The disadvantage is that the pre-installed package will cause the virtual environment to take up a lot of space, and you don’t need to use the following other methods

# pipenv

pipenv is a package management tool officially recommended by Python.

## Install

```sh
$ pip install pipenv
```

If pip is not installed, you can use the following command

```sh
$ sudo apt insall python3-pip
```

## Create

```sh
$ cd ${workspace}
$ pipenv install
$ pipenv install requests
```

If pipfile does not exist, a pipfile will be generated. After creating it and installing a new library, the pipfile will be updated automatically.

## Activate

```sh
$ pipenv shell
$ python --version
```
# venv

## Install

```sh
$ sudo apt install python3-venv
```

## Create


```sh
$ python3 -m venv --system-site-packages ./venv
```
## Activate

```sh
$ source ./venv/bin/activate
```

## exit

```sh
$ deactivate
```

# issues

If there are doubts or errors, please submit an issue --> [Issues](https://github.com/yan-wyb/issues/issues)
