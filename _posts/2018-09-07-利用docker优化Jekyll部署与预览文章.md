---
layout: post
title:  "利用docker优化Jekyll部署与预览文章"
categories: 开发者日志
tags: docker
author: skycoop
---

* content
{:toc}

每当我写好一篇博客，想在本地先预览再提交到GitHub上时，我要先打开Vmware的虚拟机，等待几分钟，把博客上传，再执行Jekyll命令运行，最终才可以在浏览器看到效果。如果博客再改动下，又要再上传才能看到效果。整个的过程漫长而繁琐，如果是新的机器，那还要加上部署Jekyll环境。所以考虑采用docker来替代Vmware，将博客挂载到容器，映射端口4000，本地的修改即可同步，随时预览，切换到新的机器时，也支持一键部署预览效果。

<!--more-->

## 安装docker ##

前言，这是我第一次使用docker,之前久闻大名，但不知名在何处，于是趁此机会了解下。

首先从安装docker开始，熟读官方文档: [https://docs.docker.com/docker-for-windows/install/](https://docs.docker.com/docker-for-windows/install/)

我本地的操作系统是**Windows 10 Pro**. 所以直接安装`Docker for Windows`
> docker 虽然号称跨平台，但在Linux下体验更佳，安装简便，命令行终端更顺手，也不用额外安装虚拟机来提供Linux内核的支持。Windows下的需要对**Hyper-V**提供支持，修改BIOS设置，而且`Docker for Windows`仅支持版本**64bit Windows 10 Pro, Enterprise and Education**，否则就要安装**boot2docker.iso**提供支持

在官网注册个ID，然后下载，安装过程也很简单，一直下一步下一步就行。
>官网注册完ID才能下载`Docker for Windows`, 但是他的注册页面又调用了谷歌的验证API，国内原因导致无法注册，我是通过我好基友翻墙帮忙注册才搞定的。这里是别的博客提供的下载链接[https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)

安装完成后有个小鲸鱼的图标，登录上Docker Gub，让他跑起来就行。

## 定制Jekyll的运行环境 ##

```
# 编译参数
# Docker version 18.06.0-ce, build 0ffa825
# 编译系统 : Windows10 Pro
# 基础镜像信息
FROM jekyll/minimal:3.8.3

# 维护者信息
MAINTAINER skycoop <skycoop@163.com>

# 镜像操作指令 - 下载博客
RUN\
 git clone --depth 1 --no-tags https://github.com/SkyC00P/skyc00p.github.io.git /home/jekyll/ &&\
 cd /home/jekyll/ && gem install jekyll-paginate

WORKDIR /home/jekyll/
EXPOSE 4000 80

# 容器启动指令
CMD ["jekyll", "s", "-w", "--force_polling"]
```

将上面内容保存为`Dockerfile`, 然后在`Dockerfile`所在目录按`Shift`+ 右键开PowerShell执行命令 `docker build -t skyc00p/blog:latest .` 生成镜像**skyc00p/blog:latest**

`docker image ls` 命令可查看所有的镜像。

### `Dockerfile` 大概 ###
以`jekyll/minimal:3.8.3`为基本镜像，该镜像包含了Jekyll的运行环境以及Git工具，将Github上我的博客项目克隆到`/home/jekyll`, 安装好插件，指定`/home/jekyll`为每个docker容器的工作目录，暴露端口4000，80，指定每个容器一启动就自动编译我博客。

## 启动docker容器预览网站 ##

PowerShell 或 cmd 执行
```
set "_path=D:\idea_src_工程\skyc00p.github.io"
set "_dst=/home/jekyll"
docker run --rm -p 127.0.0.1:80:4000 --name jekyll-skycoop --volume="%_path%:%_dst%" -d skyc00p/blog
```
我将上面的命令直接封装成`run.cmd`，当我需要预览时，直接双击即可。

上面命令执行后，docker就会启动一个容器到后台，将我本机上的`127.0.0.1:80`跟容器的`4000`端口映射到一起，同时将我本机的博客项目`_path`直接挂载到docker容器上。

在我的浏览器上输入`127.0.0.1` 或是 `localhost`就可以直接看到我网页。修改`_post`的文章内容，保存之后，重新刷新浏览器就可以看到变化。

## 推送镜像到docker Gub ##

将制作好的镜像`skyc00p/blog`推送到远程仓库，这样如果我的电脑重装了，我只要装好docker，执行`run.cmd`时，检测到`skyc00p/blog`不存在，自动去下载并运行，如此我就不用再编译一个镜像了。

1. 首先在`dockerGub`创建仓库`blog`.（很简单，略过）

2. 按`username/repositoryName:tagName`的规范为镜像打个标签，如我的`dockerHub` ID 为 **skyc00p**, 仓库名`blog`, 标签为`latest`, 除了标签名，其余两个固定，因为要关联到个人dockerHub的仓库。可以见到我编译镜像的时候我已经指定好TAG，这里把`skyc00p/blog:latest` 再打个 1.0 的标签。`docker tag skyc00p/blog:latest skyc00p/blog:1.0`

3. 本地登录到dockerHub，`docker login`

4. 推送1.0版本上去 `docker push skyc00p/blog:1.0`

**验证是否推送成功**

执行`docker image rm skyc00p/blog:1.0`删除镜像，再执行`docker pull skyc00p/blog:1.0` 看是否能下载来。

## 遇见的问题 ##

### Windows 对命令行操作的缺陷 ###

命令无法自动补全，CMD 和 PowerShell 配色糟糕，在PowerShell用Vim写东西，默认的看不见文字，利用 **git bash** 调用docker命令又提示需要更改命令。

### Vmware,VirtualBox 跟 Hyper-V 冲突 ###

要想在 Windows 平台下使用 docker , 就必须虚拟化一个虚拟机来模拟 Linux 环境，因为 docker 用到了 Linux 内核的特性。而官方默认支持 **Hyper-V** 和 **VirtualBox** 的虚拟化。支持的列表:[https://docs.docker.com/machine/drivers/](https://docs.docker.com/machine/drivers/). **vmware** 系列驱动不由官方维护。

不可避免，**Hyper-V** 不能跟 **VirtualBox**， **vmware** 同时使用。

原来是使用 **Vmware** 作为开发测试，不想换成 **Hyper-V**,所以找了替代方案。

[https://www.cnblogs.com/stulzq/p/9064828.html](https://www.cnblogs.com/stulzq/p/9064828.html)
[https://github.com/pecigonzalo/docker-machine-vmwareworkstation](https://github.com/pecigonzalo/docker-machine-vmwareworkstation)

这个替代方案就是 docker 的 docker-machine 方案。

本质就是利用 docker-machine 创建一个虚拟机(可以用任意的虚拟解决方案)，在虚拟机里运行 docker , 然后再封装了一系列的API提供给 Host 调用。那么这里我可以继续使用我的Vmware.

但是在实际的测试过程中，发现该技术还不成熟。而且跟我的实际需求相差甚远。本来的需求就是要求弃掉Vmware，但不是完全无法使用，如今解决我的需求更加复杂，原本在默认的使用 **Hyper-V** 安装方式下，执行`docker run --rm -p 127.0.0.1:80:4000 --name jekyll-skycoop --volume="%_path%:%_dst%" -d skyc00p/blog`命令，可以直接访问本机IP，直接挂载目录到docker容器，但是切换到Vmware之后，真正的Host主机变成了虚拟出来的虚拟机，导致需要访问虚拟机的IP才可以，而挂载本地目录到docker, 也要先挂载我本机的目录到虚拟机上才成功，而且要保证Vmware虚拟机持续在运行。

>  **Hyper-V** 安装方式下，可能真正的Host主机也是虚拟机，但是官方封装得好，使用体验不出差别。

## docker 使用体验 ##

一直在想，docker 到底解决了什么痛点才流行了起来呢？

我使用下来，感受最大的就是: **docker 解决了环境的统一，封装了环境，让环境随时可用**。

运行环境，编译环境，测试环境，生产环境，开发环境，实际环境的不同会导致可能出现不可预期的问题，即所谓的"这个程序在我机子上能跑啊，怎么你那里不行。" 环境的搭建，迁移，备份，项目的部署都是常见的应用场景，必须严格按步骤，按流程走，有时就算按指南一步一步下来，还是会遇见不可预期的问题（如防火墙，权限限制等），这些都是重复而繁琐还重要，必不可少。

为了优化工作流，省时省力，一般都会自动化，脚本，CI，能上的都上， 而 docker 提供了这个一个标准，就让这些脚本，工具更加统一高效率。

docker 给我的感受就是一个轻量级的虚拟机，类Vmware, 但是不同的是，docker 舍弃了虚拟 OS ，所以隔离环境时开销小了很多。有人说 docker 像集装箱。

> 在一艘大船上，可以把货物规整的摆放起来。并且各种各样的货物被集装箱标准化了，集装箱和集装箱之间不会互相影响。那么我就不需要专门运送水果的船和专门运送化学品的船了。只要这些货物在集装箱里封装的好好的，那我就可以用一艘大船把他们都运走。

相比传统的虚拟机，docker 更轻量，更简单，更快速, 但是相对的虚拟机隔离环境更加彻底，对硬件的模拟更彻底。简而言之，docker 共享系统资源， 传统虚拟机独占系统资源

尽管在物理机上可运行多个docker 和 多个虚拟机，灵活性和安全性提高了，但是相应的管理的复杂度也提高了，在实际的体验过程中，有三个普遍的问题，权限，通信，数据。在引入了docker也要重新熟悉解决方案。

1. 权限
2. 容器或虚拟机跟物理机的通讯，容器或虚拟机互相的通信，（网络，挂载设备等等）
3. 数据的读写，持久化和共享

话说回来，docker 跟 Java 一样， **一次编译，到处运行**。

我觉得 docker 就适合服务端环境上的基础服务，中间件等，面向开发人员和运维人员来干活，直接分发给用户运行应用我觉得不现实，现阶段在Windows 跑 docker 也不是能跟 Linux 下媲美。