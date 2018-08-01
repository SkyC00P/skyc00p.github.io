---
layout: post
title:  "jekyll + Github Pages 搭建个人博客"
categories: jekyll
tags: jekyll Github git blog
author: skycoop
---

* content
{:toc}

一直有个想法想要搭个博客，尝试自己建站，但是太复杂了，不想花费太多的精力，但又不想用简书，CSDN这些网站来管理，限制太多。机缘巧合之下得知**GitHub** 提供了 Github Pages 服务，可以用来建立轻量级个人博客，可定制，免费，可以与git协同，实现备份与同步功能，300MB的免费空间，可使用Markdown编辑发布。最主要的是可以将所有的精力集中在编写博客身上，只需将写好的文章推送到远程仓库就行。于是花了几天时间研究了下，这篇文章就是这几天的总结经验。




## 搭建总纲 ##

GitHub 的 GitHub Pages 服务是基于 **Jekyll模版系统** 来生成静态页的。所以为了能正儿八经的在本地也能看到效果，咱本地环境搭一个**Jekyll**的测试环境，Copy 一份别人已经搞好的自己看着顺眼的博客主题，改一改，本地调试OK了，然后将其推到自己的Github的仓库上，开启那个仓库的**GitHub Pages**选项就大功告成了。

## 本地测试环境 ##

我的本地测试环境是在 Linux 环境下进行的，版本是`ubuntu-18.04-live-server-amd64.iso`, 虚拟机搭建Linux环境并进行测试。怎么用**VMware**搭建虚拟机不多说，参考网上教程。

**Jekyll** 的搭建参考官方网站指导 [https://jekyllrb.com/docs/installation/#ubuntu](https://jekyllrb.com/docs/installation/#ubuntu)，以最新为准。

**注意不要切换到 root 用户，用普通用户的权限执行命令就行。**

安装依赖
````
sudo apt-get install ruby ruby-dev build-essential
````

编辑环境变量
````
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME=$HOME/gems' >> ~/.bashrc
echo 'export PATH=$HOME/gems/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
````

安装**Jekyll**
````
gem install jekyll bundler
````

`jekyll -version` 查看版本,有则Jekyll 安装成功

## Jekyll 主题模版 ##

网上有一大堆 Jekyll 主题，去知乎或者百度搜索**Jekyll 主题**即可，有很多人乐意分享自己的博客主题。我则挑了`https://github.com/Gaohaoyang/gaohaoyang.github.io` 这个模版.

下载，`git clone`, fork 这个仓库的代码都可以，我选择`git clone` 方式。

安装git
````
sudo apt-get install git
````

复制仓库下载到本地
````
git clone https://github.com/Gaohaoyang/gaohaoyang.github.io.git
````

进入项目尝试本地跑下看看效果。
````
cd gaohaoyang.github.io/
jekyll s -w --host=0.0.0.0
````

一般来讲，跑别人的博客，大概率会出错，原因可能是插件未安装，或者jekyll版本更新导致不兼容。所以要发挥自己的主观能动性，学会观看日志自己定位问题，学会百度搜索，最后实在不行，才去网上发问吧或者找原作者问问看(但不要轻易做伸手党)。

这里我跑的时候日志显示插件**[jekyll-paginate]**未安装,而且插件在配置文件的选项在Jekyll新版本里已经做了更改。所以参照官网 [https://jekyllrb.com/docs/plugins/](https://jekyllrb.com/docs/plugins/) 安装了插件.

原博客是用**_config.yml**来配置插件的，所以**Vim**打开**_config.yml**文件，定位到如下的位置

````
gems: [jekyll-paginate]
````
修改为
````
plugins:
  - jekyll-paginate
````
保存退出，执行命令`gem install jekyll-paginate` 安装插件

安装完成后再次执行`jekyll s -w --host=0.0.0.0 `, 如果没报错显示如下:

````
Configuration file: /home/skycoop/gaohaoyang.github.io/_config.yml
            Source: /home/skycoop/gaohaoyang.github.io
       Destination: /home/skycoop/gaohaoyang.github.io/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 

                    done in 2.468 seconds.
 Auto-regeneration: enabled for '/home/skycoop/gaohaoyang.github.io'
    Server address: http://0.0.0.0:4000/
  Server running... press ctrl-c to stop.
````

好了，在我本地浏览器里输入`http://192.168.1.105:4000/`就可以查看效果了。注意`192.168.1.105`是我虚拟机的IP地址，如果虚拟机里的Ubuntu是桌面环境的，你可以直接开里面的浏览器直接访问`http://localhost:4000/`,谁叫我装了个服务器版本的，没有桌面，只能强制加启动参数`-w --host=0.0.0.0`指定局域网内也可以访问，让我可以在Windows10上面来看效果。

注意原博客的主人持续一直在更新他的博客源码，如果要跟我此次操作的仓库源码保持一致，那我建议你恢复到跟我一样的 commit = `e4bc128abe515eb2b51343f8120b2a0460f0f065`。
````
skycoop@skycoop:~/gaohaoyang.github.io$ git log 
commit e4bc128abe515eb2b51343f8120b2a0460f0f065 (HEAD -> master, origin/master, origin/HEAD)
Author: chuan shi(haoyang gao) <ghy118432@alibaba-inc.com>
Date:   Sat Jun 2 23:51:16 2018 +0800
````

## 页面改造 ##

- `[^]` 导航栏调整，修改**_includes/header.html**文件，修改为中文导航
- `[^]` **_layouts/page.html** 去掉标题显示，调整间距，中英文转换
- `[-]` **_layouts/post.html** 去掉评论，去掉无用的**`page.meta` 的`label-card`**
- `[^]` 主页 **index.html** 修改，欢迎文字修改，去掉无用标签**`page.meta` 的`label-card`**，中英文转换
- `[^]` 归档页模版 **/page/0archives.html**，类别页模版 **/page/1category.html**， 标签页模版 **/page/2tags.html**修改。`title` 改为中文，去掉标题头，页面显示元素去掉评论，标签，类别
- `[-]` 收藏页模版 **/page/3collections.md** ，示例页模版 **/page/3demo.html** 修改 `type` 取消引入
- `[^]` **/page/4about.md** 修改自我介绍等。
- `[^]` 替换了网站图标
- `[^]` 修改了表格样式
- `[^]` **_config.yml** 文件修改

| 选项 | before | after | 
| - | :-: | -: | 
| title | HyG| Skycoop | 
| brief-intro | Front-end Dev Engineer | - | 
| url | https://gaohaoyang.github.io | https://skyc00p.github.io |
|twitter_username| gaohaoyang126 | - |
|facebook_username| gaohaoyang.water | -|
|github_username | Gaohaoyang | skyc00p |
|email| gaohaoyang126@126.com | skycoop@163.com |
|weibo_username| 3115521wh | - |
|zhihu_username| gaohaoyang | skycoop |
|linkedIn_username| gaohaoyang | - |
|description_footer | 本站记录我前端之旅的沿途风景！ | - |
| disqus_shortname | gaohaoyang | #gaohaoyang |
| baidu_tongji_id | cf8506e0ef223e57ff6239944e5d46a4 | 86e2c0b051a53fb47d0be21e7726d96f|
| google_analytics_id | UA-72449510-4 | UA-120868552-1 |

## 推送Github ##

删除他人的版本库, 他人信息的相关文件

````
rm -rf .git _drafts/* README* _posts/*
````

实例化本地 git 版本库, 并提交

````
git init
git add -A
git commit -m "blog created"
````

在github新建一个仓库，`Repository name` 最好命名为 `{username}.github.io`, 这样网址链接就是`http://{username}.github.io`.

推送到远程仓库,`https://github.com/USERNAME/USERNAME.github.io.git` 替换成你自己的。
````
git remote add origin https://github.com/USERNAME/USERNAME.github.io.git
git push -u origin master
````

开启 `Github Page` 功能, 在 **Github** 点击 `Settings` 进入仓库配置页面, 选择主分支并保存即可.

![](https://i.imgur.com/lRBGnuD.png)

然后点击下图的链接就可以直接进入你的博客网站了。

![](https://i.imgur.com/11jh3gR.png)

## 发布文章 ##

将写好的 markdown 文件直接推送到远程仓库的 `_post` 目录下就行。

只不过上传的 markdown 文件需要遵循规范。

### 文件规范 ###

**1. 文件头信息**

每个 markdown 文件开头都必须插入这个标签头，以`---`包围，定义该文件的信息以便 Jekyll 去读取并渲染页面，每个定义值以每行`Key:Value`的形式。

| 选项 | 含义 | 可选 | 
| - | :- | -: | 
| layout | 页面布局，默认post不变 | 必选 |
| title | 文件标题 | 必选 |
| categories | 指定分类，多个以空格分割 | 必选 |
| tags | 指定标签，多个以空格分割 | 必选
| date | 创建时间 | 可选 |
| author | 作者名 | 可选 |
| mathjax | 是否开启数学公式 | 可选 |

如这篇文章的文件头如下所示

````
---
layout: post
title:  "jekyll + Github Pages 搭建个人博客"
categories: jekyll
tags: jekyll Github git blog
author: skycoop
---
````

**2. 文件名格式规范**

保存的 markdown 文件的名字必须符合在 **`_config.yml`** 定义的 `permalink` 规范。

例如我的为**`permalink: /:year/:month/:day/:title/`**, 即我的这篇文章要保存成 `2018-06-25-jekyll + Github Pages 搭建个人博客.md` 才能被 **Jekyll** 模版引擎正确解析成一个合法的url来链接到该文章。

### 可选功能 - 文章目录 ###

下面这两行代码为产生目录时使用

````
* content
{:toc}
````

### 可选功能 - 文章摘要

文章中存在的4次换行为摘要分割符，换行前的内容会以摘要的形式显示在主页Home上，进入文章页不影响。

换行符的设置见配置文件_config.yml的 excerpt，如下：

````
# excerpt
excerpt_separator: "\n\n\n\n"
````
