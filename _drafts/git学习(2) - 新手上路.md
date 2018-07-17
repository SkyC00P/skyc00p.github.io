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

## git status，git add，git commit##

今天的充电时间已经耗尽，在`学习笔记`目录下，新建了目录`大话数据结构`，包含了随笔`timeLine.md`，现在加入到版本管理去。

在`学习笔记`目录下,执行如下命令，就提交到本地版本库上去了。
```
git add -A
git commit -m "大话数据结构 - timeLine.md create."
```

### 命令学习: git add ###

Add file contents to the index.
> 添加文件到暂存区(索引区)

语法
```
git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
        [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
        [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
        [--chmod=(+|-)x] [--] [<pathspec>...]
```

看了帮助文档，`git add`的主要功能是添加对新文件的追踪，标记哪些文件是需要提交到版本库的，简而言之，执行一次`git add`相当于对当前的工作打上一个临时快照。

与`SVN`不同的是，通过`git add`添加的文件是没有持续追踪的，也就是说，保存的只是执行`git add`当时的状态，后续的修改需要重新执行`git add`再次加入。

### 命令学习:git commit###

Record changes to the repository
> 将暂存区(索引区)保存到本地版本库里

语法
```
git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
           [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
           [--date=<date>] [--cleanup=<mode>] [--[no-]status]
           [-i | -o] [-S[<keyid>]] [--] [<file>...]
```

看了帮助文档，这个命令与`SVN`对应的`commit`也有不同之处，这个命令并不是真正的提交到远程服务器，而是提交到本地的版本库，换句话说，在Git的世界里，大家都是**Git远程版本库**，自己的本地版本库对于别人来说也是一个远程版本库。值得注意的是，里面有很多可以修改已经提交的`commit`的选项，例如`--amend`.

### 命令学习: git status ###

Show the working tree status
> 显示工作区的状态

语法
```
 git status [<options>...] [--] [<pathspec>...]
```

看了帮助文档，这个查看状态看的是什么状态呢？有三个状态，一个是咱们工作区跟暂存区(索引区)的区别，一个是暂存区(索引区)跟版本库指向的提交之间的区别，一个是未被Git追踪的文件列表。所以这个是搭配`git add`和`git commit`来使用的。

看了上面的选项，配了一个快捷命令`git config --global alias.st "status -s -b"`, 简短输出并加上分支输出。

### 实践 ###

使用情景: 每天有一个学习目标，但是在学习目标达成之前，我的笔记都是处于一个草稿的状态，但是这些临时状态都要备份下来，如果每次备份都执行`commit`命令，那么提交历史就有很多无意义的提交了，我想我的提交历史干净一目了然，所以有意义的提交应该只有两个**目标确定**,**目标完成**。

情景模拟:7月份完成《大话数据结构》的学习

7月1号，确定目标。在`学习目录下`新建了`大话数据结构`目录，将所有的笔记，测试的源码都放置在该目录下，在结束一天的学习后，执行`git status -s -b`查看是否有不应该添加到版本管理的文件，确定全部可以添加后，执行`git add -A`,将全部保存到暂存区，再次执行`git status -s -b`查看是否有遗漏。没有遗漏，执行`git commit -m "决定7月份完成《大话数据结构》的学习"`提交到版本库。

7月2号 - Now，学习的过程中，第一次备份时，照常提交，执行`git commit -m "备份"`，后续备份提交时执行`git commit --amend --no-edit`，这样提交历史永远都只有两个。

7月31号，目标达成，最后一次提交，执行`git commit --amend -m "7月份完成《大话数据结构》的学习"`。

总结下来流程，第一次确定目标时使用命令
```
git status -s -b
git add -A
git status -s -b
git commit -m "决定7月份完成《大话数据结构》的学习"
```

第一次备份时
```
git status -s -b
git add -A
git status -s -b
git commit -m "备份"
```

后续的备份
```
git status -s -b
git add -A
git status -s -b
git commit --amend --no-edit
```

目标达成时
```
git status -s -b
git add -A
git status -s -b
git commit --amend -m "7月份完成《大话数据结构》的学习"
```

## 总结 ##

`git init` 实例化版本库。

`git status`, `git add`, `git commit` 日常提交。

这四个命令掌握了，本地的版本管理就OK了。

基于日常的习惯，增加快捷键
```
git config --global alias.cifix "commit --amend --no-edit"
git config --global alias.cifixmsg "commit --amend -m"
git config --global alias.st "status -s -b"
```

