工作两年，用的版本控制是SVN，对于Git从未了解。在学习Git的过程中，思考了svn与git的差别，git的优势在哪？在项目开发过程中，需要掌握到git到什么程度。我以零基础的Git初学者，开发者的视角来试着解这个问题。





## Git 的安装 ##

无论如何，Git的安装在第一次学习时，总是避不过去的。

**Linux下的安装**

类Fedora系统
````
sudo yum install git
````

类Ubuntu系统
 
````
sudo apt-get install git
````

**Windows安装（1）**

- 到Git官方网址下载安装 [https://git-scm.com/](https://git-scm.com/)
- 安装命令行工具 TortoiseGit [https://tortoisegit.org](https://tortoisegit.org)

**Windows安装（2）**
- 安装Github for Windows [http://windows.github.com](http://windows.github.com)

### 初次运行Git前的配置 ###

安装完Git之后，我们需要配置自己的用户信息，以便在提交时自动附加自己的信息，同时基于命令行的个人习惯设置则可自由商榷。

- 配置用户信息

````
git config --global user.name "Skycoop"
git config --global user.email skycoop@163.com
````

- 个人设置

````
# 命令快捷方式设置
git config --global alias.st status
git config --global alias.ct "commit -m"
git config --global alias.br branch
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
# 开启git输出着色
git config --global color.ui true
# 设置中文支持
git config --global core.quotepath false
````

## 获得帮助 ##

无论如何，看再多再多次的Git教程，都无法记住所有的命令。所以必须学会看懂Git的帮助文档来查阅。

在命令行里输入`git`则会出现常用的命令或是`man git`来查看帮助文档。又或是
```
git help <verb>
git <verb> --help
man git-<verb>
```

例如，要想获得 `config` 命令的手册，执行`git help config`

## Git 基本命令 ##

基于常见的使用情境，掌握以下基本命令（）条便足够。

```
clone, init, add, mv, reset, rm, bisect, grep, log, show, status, branch, checkout, commit, diff, merge, rebase, tag, remote, fetch, pull, push
```

### 不同角色所需的掌握程度 ###
让我们思考一个问题，在使用Git的过程中，我们扮演的是什么角色？我们深知Git的命令一大堆，细节很多，是有一定的学习成本的。如果需要快速上手，我们需要舍弃掉复杂难懂的命令，以及自己使用场景不会应用到的命令。

角色(1) ----- 一个孤独的开发者。
> 不用跟其他人进行协作。项目的所有者仅有你一个人，项目的开发，管理，代码的日常更新与提交，项目的版本管理
