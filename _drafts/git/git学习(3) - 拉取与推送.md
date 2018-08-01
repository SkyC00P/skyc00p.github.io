对远程版本库的拉取和推送，添加和移除远程版本库等与远程管理的命令才是重点。之前一直简单的`git remote add `和`git pull`，`git push`。现在想详细了解下。重点:4个重要命令 `git remote`, `git fetch`, `git pull`, `git push`，`git clone`。在本地的`192.168.1.105`上的Gitlab新建了一个远程版本库`git-demo`作为测试

<!--more-->

## Git命令学习 ##

### git remote ###

Manage the set of repositories ("remotes") whose branches you track.
> 远程库的管理

语法
```
git remote [-v | --verbose]
git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=<fetch|push>] <name> <url>
git remote rename <old> <new>
git remote remove <name>
git remote set-head <name> (-a | --auto | -d | --delete | <branch>)
git remote set-branches [--add] <name> <branch>...
git remote get-url [--push] [--all] <name>
git remote set-url [--push] <name> <newurl> [<oldurl>]
git remote set-url --add [--push] <name> <newurl>
git remote set-url --delete [--push] <name> <url>
git remote [-v | --verbose] show [-n] <name>...
git remote prune [-n | --dry-run] <name>...
git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]
```

### git fetch ###
Download objects and refs from another repository
> 从其他版本库拉取

语法
```
git fetch [<options>] [<repository> [<refspec>...]]
git fetch [<options>] <group>
git fetch --multiple [<options>] [(<repository> | <group>)...]
git fetch --all [<options>]
```

### git push ###
Update remote refs along with associated objects
> 推送更新到远程版本库

语法
```
git push [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose] [-u | --set-upstream] [--push-option=<string>] [--[no-]signed|--signed=(true|false|if-asked)] [--force-with-lease[=<refname>[:<expect>]]] [--no-verify] [<repository> [<refspec>...]]
```

推送的命令只有这一条。其实我有疑问，推送到远程库能推送什么上去？能控制到什么地步？推送完能强制别人更新吗？怎么个推法可以写篇技术总结 -- 《Git：How to push》。

### git pull ###
Fetch from and integrate with another repository or a local branch
> 从远程库拉取更新并更新合并到本地

语法
```
git pull [options] [<repository> [<refspec>...]]
```

### git clone ###
Clone a repository into a new directory
> 克隆复制一个远程版本库到本地

语法
```
git clone [--template=<template_directory>]
          [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
          [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
          [--dissociate] [--separate-git-dir <git dir>]
          [--depth <depth>] [--[no-]single-branch] [--no-tags]
          [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
          [--jobs <n>] [--] <repository> [<directory>]
```

## 实操 ##

在我的虚拟机上已经有Git服务器GitLab，服务器上有`git-demo`仓库作为测试。虚拟机上也作为一个客户端，我Dell电脑本地作为一个客户端，来进行模拟推送拉取之前的所有使用情景。

### 测试1.导出远程库的项目到DELL本地 ###

在Dell笔记本上，执行Git命令行`git clone`。
```
cd ~
mkdir project
cd project
git clone http://192.168.1.105/root/git-demo.git
```

### 测试2. 在Dell推送文件到GitLab ###
在`git-demo`下新建了一个文件`demo.txt`,并提交到本地版本库。此时将此次提交推送到远程版本库。