新手上路，将Git应用到实战中。最近需要学习计算机基础理论，所以打算将学习中的笔记都用Git管理起来，操练下基本命令，并记录下在Git实战中出现的各种问题。




## git init ##

学的第一个命令是`git init`, 让目录 `学习笔记` 加入到版本管理中去。

执行`git init "学习笔记"`，可以看到生成了目录`学习笔记`, 并且里面已经有一个文件夹`.git`,这个就是版本库了。

### 命令学习 ###
Create an empty Git repository or reinitialize an existing one
> 创建一个空的版本库或是重新初始化版本库

语法
```
git init [-q | --quiet] [--bare] [--template=<template_directory>]
                 [--separate-git-dir <git dir>]
                 [--shared[=<permissions>]] [directory]
```

看了帮助文档，所谓的创建版本库，其实就是新建了`.git`目录，里面包含了`objects`,`refs/heads`,`refs/tags`, 以及一些模版文件。看了选项的说明，有三个选项比较感兴趣`--bare`,`[--template=<template_directory>]`,`[--shared[=<permissions>]]`

`--bare` 加了这个选项，那么这个仓库就变成了空版本库了。有什么区别呢？
See diff in [http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/](http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/)
> 总结起来，用途不一样, 一个是**To share**, 一个是**To Work**

`[--template=<template_directory>]`,`[--shared[=<permissions>]]`
> 这个跟权限控制，版本库的文件目录结构以及自定义模版, 这个是高阶应用了，属于服务端管理员范畴了。

有个疑问，如果在`学习笔记`重新运行`git init`会不会重新初始化，导致丢失所有的提交记录呢？答案是不会。重新运行`git init`是很安全的，不会重写已经存在的文件。

### GitLab 创建 ###

点击 `+` 选择 `New Project`, 见下图

![](https://i.imgur.com/XeHSpIH.png)

项目名，项目描述，公开权限设置好，点`Create project` 即可。一个 **bare repository** 就创建成功了。

## git add ##

学的第二个命令是`git add`, 今天的充电时间已经耗尽，今天所学的总结出笔记`《初识数据结构》`，将今天所学的加入到版本管理去




