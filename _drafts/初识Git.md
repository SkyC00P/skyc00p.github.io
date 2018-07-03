工作两年，用的版本控制是SVN，对于Git从未了解。在学习Git的过程中，思考了svn与git的差别，git的优势在哪？在项目开发过程中，需要掌握到git到什么程度。我以零基础的Git初学者，开发者的视角来学习。





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
$ git config --global user.name "Skycoop"
$ git config --global user.email skycoop@163.com
````

- 个人设置

````
# 命令快捷方式设置
git config --global alias.st status
git config --global alias.br branch
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
# 开启git输出着色
git config --global color.ui true
# 设置中文支持
git config --global core.quotepath false
````

## 获得帮助 ##

无论如何，看再多再多次的Git教程，都无法记住所有的命令。所以必须学会看懂Git的帮助文档来查阅。

在命令行里输入`git`则会出现常用的命令。

````
usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   branch     List, create, or delete branches
   checkout   Switch branches or restore working tree files
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   merge      Join two or more development histories together
   rebase     Reapply commits on top of another base tip
   tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.

````
