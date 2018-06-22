---
layout: post
title:  "Hello World!!!"
date:   2018-06-12 11:40:18 +0800
categories: 博客
tags: blog jekyll
author: skycoop
mathjax: true
---

* content
{:toc}

Hello World !!!

这是搭建的博客发布的第一篇文章。记录了发布文章的要点。






## 文章头部

_posts目录下存放文章信息，文章头部注明 layout(布局)、title、date、categories、tags、author(可选)、mathjax(可选，点击这里查看更多关于Mathjax)，如下：

````
---
layout: post
title:  "Hello World!!!"
date:   2018-06-12 11:40:18 +0800
categories: 博客
tags: blog jekyll
author: skycoop
mathjax: true
---
````


## 文章目录

下面这两行代码为产生目录时使用

````
* content
{:toc}
````


## 文章摘要

文章中存在的4次换行为摘要分割符，换行前的内容会以摘要的形式显示在主页Home上，进入文章页不影响。

换行符的设置见配置文件_config.yml的 excerpt，如下：

````
# excerpt
excerpt_separator: "\n\n\n\n"
````

## 语法

使用 markdown 语法写文章。

代码风格与 GitHub 上 README 或 issue 中的一致。使用4个````的方式。

