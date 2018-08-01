一直在想，如何快速学习一门新的编程语言？总结下学习 CMD 批处理的过程中的一些经验, 看是否能应用到其他编程语言中，当然这经验都是从第一次编写批处理 `convert.bat` 而来, 更多的是批处理的经验总结以及编写过程中遇见的问题。

<!--more-->

## 权威文档和获取帮助说明 ##

在决定开始用批处理写脚本的一瞬间，就上网搜索官方帮助文档，或者学习批处理的推荐参考书。

参考书我有两个标准：一本面面俱到，细节到位，示例翔实。一本简明扼要，直抓要害。目的是快速形成对编程语言的总体轮廓，以便在编程实践过程中迅速定位相关主题，按图索骥寻找正确的解决方案。

参考书可以没有，但是绝对需要知道如何获取第一手资料，即官方提供的一切文档，API，最佳编程实践等。至于那些什么从官方翻译的，自己随便复制黏贴的，过时的技术博客什么之类的，看看就好，不要太当真。

### 实践 ###

按照上面的思路，参考书没有找到满意的，`Microsoft` 上面的MSDN文档也已经变成404了。

但是找到了这个 [https://ss64.com/nt/](https://ss64.com/nt/). 这个够我用了，语法，命令列表都有。

在CMD命令行里获取帮助。`command /?`, 如想知道`IF`的语法，直接`if /?`就可以显示`if`的帮助说明。

### 吐槽 ###

CMD 里的帮助说明跟没有的一样，看了跟没看一样。尤其是官方权威文档真是一言难尽，居然没有，而且上网搜居然还挺难搜的。估计我的搜索技巧要提高一下了。

## 所有编程语言的共性 ##

为了实现我人生中的第一个批处理，根据以前的编程经验，达到可以进行编程的地步最少需要知道这些点。

- 启动，执行入口，退出
- 变量，常量，传参
- 数据结构
- 操作符
- 流程控制语句，跳转，循环
- 注释
- 打印
- 调试
- 代码重用
- 处理错误

结合[CMD语法](https://ss64.com/nt/syntax.html) 和 [CMD命令API](https://ss64.com/nt/) 和上面的点，结合编写`convert.bat`的经验，总结要点，以便日后查阅。

### 启动，执行入口，退出 ###

1. 与启动有关的命令`start`,`cmd`,`call`
2. 双击文件名以 `bat`,`cmd` 结尾的文件
3. 命令行以批处理的文件名启动
4. 将命令写入注册表的右键菜单中，右键启动

`%CMDCMDLINE%` 是启动批处理的完整命令。

批处理逐行解释并运行，所以第一行就是入口，解释的最后一行就是出口，而出口可以被`goto:eof`导向

退出命令`exit`

> 明白如何启动，执行入口在哪，如何退出，这个是最关键的。
> 
> 写完代码就是要运行的，怎么运行，能不能被其他程序运行，有什么运行选项可以配置，不同的启动方式会有什么影响，
> 还有退出，怎么个退出法才能确认程序是正常退出还是异常退出，退出的日志有没有，退出前能不能做什么。
>
> 但是也不用了解那么细，第一次需要知道的常规正常启动的了解一个，常规退出的了解一个，执行的第一行命令在哪，后面的按需了解

### 变量，常量，传参 ###

相关主题文档 [Parameters](https://ss64.com/nt/syntax-args.html) 和 [Windows Environment Variables](https://ss64.com/nt/syntax-variables.html)

关键命令`set`, 关键引用变量符号`%var%`

设置变量`set "_var="Hello World!!!""`

显示变量`set _` 或者 `set _var` 或者 `echo %_var%`

命令传参时像`MyScript.cmd January 1234 "Some value"`, 以空格为分隔符分割参数，参数里有空格的带`""`包围。

跟Shell类似，`%*`代表全部参数，`%1`代表第一个参数，以此类推，CMD支持参数的扩展, 下面扩展第一个参数

> `%~f1` 扩展成完整路径 - C:\utils\MyFile.txt
> 
> `%~d1` 扩展盘符 - C:
> 
> `%~p1` 扩展文件路径仅用`\`包围的 - \utils\

多余的看[Parameters](https://ss64.com/nt/syntax-args.html) 和 [Windows Environment Variables](https://ss64.com/nt/syntax-variables.html) 的 `Parameter Extensions`

跟环境变量有关的命令`setX`, 跟局部变量有关的`setlocal` 和 `endlocal`

### 数据结构 ###

批处理没有什么基础数据结构，什么数组，集合，列表都没有。所以按字符串处理就行。

### 操作符 ###

`||`, `&&`, `&`, `|`, `>`,`<`,`!var!`,`>>`

### 流程控制语句，跳转，循环 ###

- 跳转 `goto`,`call`
- 循环 `FOR %%parameter IN (set) DO command ` 
- 条件 `if condition (command)` 和 `if condition (command) else (command)`

> 不得不吐槽，条件语句居然没有`else if`语义，循环语句没有`while`语义，跳出循环没有`continue`

### 注释 ###

`REM` 或 `::` 提供单行注释，对，没有多行注释

### 打印 ###

`echo` 负责向窗口输出。

打印空行`echo.` 或者 `echo:`

开启或关闭命令行的输出`echo on/off` 和 `@`

重定向跟Shell一样，`>`,`2>`,`>>`,`2>>`,`>file 2>&1`,`>fileA 2> fileB`

> 这里不得不吐的槽，这个打印功能真是弱。不能打印特殊字符，不能屏蔽掉变量里携带的特殊字符。

### 调试 ###

没有什么有效的手段，只能靠`pause` 和 `echo off` 和 `echo on` 和 `echo` 和 `@`，和`>file 2>&1`

就是人工设断点和打印日志。

### 代码重用 ###

批处理提供了一个函数封装。

```
:function
   command...
goto:eof
```

调用方式 `call :function`或者`goto function`

### 处理错误 ###

每条命令执行是否成功都会有`%errorlevel%`值，通过这个值来判断。

或者是命令执行错误都会输出错误日志，执行命令时增减`2> file`把错误日志重定向到文件，判断文件是否为空也可以达到目的。

## 特性 ##

编程语言的特性是独立于其他语言的特点。了解这些语言特性并运用他，才是脱离了入门阶段步向高级阶段的里程碑。

批处理有个特性，叫解析边运行，也就是说读取一行命令，解析一行命令，再执行命令，如此循环。(我的理解也就到这里了，不想太深入)

## 经验之谈 ##

### 变量的命名规则 ###

自定义的全局变量名字前都加个`_`, 名字自由，大小写随意，而且统一用`set "_var=vaule"`定义变量

这样的好处是通过`set _` 即可显示自己定义的所有全局变量，而且跟系统的变量分离。而用`""`来包围则是为了避免变量值有空格或者其他特殊符号造成解析错误。

### 注释的规则 ###

**单行通用的注释规则**

用 `rem`，大小写忽略不计

**多行通用注释规则**

```
::--------------------------------------------------------
::-- Key : Vaule (you can ignore it)
rem -- Your Content in here.
rem -- Maybe another line.
:: -- OtherKey : Vaule
rem -- write your other content in here.
rem -- and so on.
::--------------------------------------------------------
YourCodeHere
```

> 例子: convert.bat 的脚本说明

```
::--------------------------------------------------------
::-- Name : convert.bat
::-- Function : 
rem -- 辅助Jekyll发布文章所用，保留源文件markdown文件，生成或同步指定的YAML标签头，合并YAML标签头和源文件生成带时间戳的markdown文件，并支持打开生成的YAML标签头和生成目录以及最终的markdown文件
::-- Version : v1.0
::-- author : skycoop
::--------------------------------------------------------
```

> 例子: 函数的简单说明

```
::--------------------------------------------------------
rem - 已确定头文件存在，从头文件里获取日期
rem - 如果不存在日期，代表执行 [call :add] 时异常退出或者不符合规范，回显文件内容，询问是否删除，然后退出脚本
rem - 如果存在日期，代表旧文件可能存在，删掉旧文件,回显头文件内容，询问是否打开头文件进行修改，无论如何都进行合并操作
::--------------------------------------------------------
:update
rem it's todo list.
goto:eof
```

### 代码结构 ###

```
{ 运行环境的代码 : 例如命令回显，代码页更改，显示运行命令等}

{ 程序说明注释文档 }

{ 程序入参检测 }

{ 程序全局变量定义 }

{ 初始化当前运行环境 }

{ 程序Debug入口 } / { 程序执行主入口 }

{ 函数定义区 }
```

### 中文乱码问题 ###

指定运行的代码页为UTF-8 `@chcp 65001 >nul`

注释用英文，不要带中文，尽量避免用中文。注意特殊符号的中英文半角问题。

### 调试技巧 ###

像这种动态语言，调试起来就没静态语言那么舒服了。但是批处理有一个类似C语言宏的东西，即可以将命令用变量保存起来，执行的时候会将变量替换掉。例如定义一个暂停命令`set _pause=pause`, 在执行`%_pause%`, 批处理就会暂停。

有这么个东西，就可以做到按需调试了。

用一个变量`_DEBUG`来判断当前是否开启调试, 然后以此初始化变量，如我`convert.bat`做的
```
set "_DEBUG=y"

::--------------------------------------------------------
::-- Function : 初始化参数
rem - _DEBUG
rem - _toNul
rem - _pause
rem - _exit
rem - _echoY , _echoN
::--------------------------------------------------------
:init

setlocal
set "toNul=^>nul" & set "debug=REM " & set "breakpoint=" & set "exit=exit" & set "echoY=" & set "echoN="
if /i [%_DEBUG%] == [Y] set "debug=" & set "toNul=" & set "breakpoint=pause" & set "exit=pause & exit" & set "echoY=@echo on" & set "echoN=@echo off"
endlocal & (set _DEBUG=%debug% & set _toNul=%toNul% & set "_pause=%breakpoint%" & set "_exit=%exit%" & set "_echoY=%echoY%" & set "_echoN=%echoN%")

goto:eof
```

如此一来，如果我想在测试时，断点才生效，退出换成先暂停再输出，某些打印日志生效，某些区域的命令输出可以开启。当我测试OK了，将变量`_DEBUG`改为`n`,那么一切恢复原样，下次如果有出现问题，再修改一次，再进行测试，不用再手动添加实际的调试代码进去，调试ok了，也不用手动再去删除。

甚至可以做到单元测试某个函数。通过修改或自定义变量影响调试参数的初始化，可以让脚本不进入实际的主入口，而是进入我们不同的测试入口，例如`convert.bat`在`_DEBUG`为`Y`时，就会进入`F_debug`函数里。定义一组测试函数，通过不同的变量控制。

当然更加优化的方式是将启动以及赋予变量值的工作给另一个脚本来做。也就是最好的方式启动一个脚本，实际工作的一个脚本，这样调试的代码就不会侵入到实际的脚本。

### 打印日志的技巧 ###

打印日志用`echo`，打印文件的内容用`type`

值得注意的是打印变量和打印特殊符号，打印特殊符号要转义`^`,打印变量，用`""`包围避免特殊符号的影响。

最好不要用来打印不确定的东西，因为打印语句也可能会出错，最好执行`@echo on`把回显打开。

### 变量的延迟赋值 ###

`EnableDelayedExpansion` 搜这个，如果在一个`()`里的代码块存在这样的代码

```
rem - 设置一个全局变量 _var
set "_var=a"

if "%_var%" == "a" (
  set "_var=b"
  echo %_var%
)
```

那么最终的结果不是预想的`b`，而是`a`.

因为`()`会将全部的命令读取，并替换变量，然后再执行，所以执行`echo %_var%`的时候是`echo a`.

解决方法，开启`EnableDelayedExpansion`, 用`!`包围变量。

### 全局变量赋值函数的返回值 ###

```
:fuction
setlocal
set "a=a"
endlocal & set "_a=%a%"
goto:eof

```

### 路径的问题 ###

不管怎么样，路径有空格的都带`""`包围，但是要注意已经有`""`不要再添加。

### 用户交互输入 ###

用`set /p _ANS="MSG"`

用`choice /t 3 /d n /m "打开[_post]目录"` 也行

### 文件是否存在 ###

`if exist filePath commands`

### 时间获取 ###

调用**WMIC**接口获取yyyy-MM-dd 格式的时间
```
FOR /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') DO Set _DTS=%%a
Set data=%_DTS:~0,4%-%_DTS:~4,2%-%_DTS:~6,2%
echo data
```
调用`date`命令并截取时间格式
> 吐槽: 用`date`获取的时间格式跟文件编码有关。

### 字符串截取 ###
`%var:SeachStr=replaceStr%`

例子，替换d变量的空格`set "a=%d: =%"`

> 不得不吐的槽: 你丫对一个空字符串替换都能替换，真是服了，试着这条替换`"`为空的命令，`set "a=%b:"=%"`，一个空字符串你居然给我返回" =",我勒个去。

### 正则匹配 ###

`findStr` 支持正则匹配，但是支持有限。就下面这么点

![](https://i.imgur.com/i1vHsJJ.png)

> 吐个槽:[A-Z],[a-z]执行结果出乎你意料。
> See This:
> The problem is FINDSTR does not collate the characters by their byte  code value (commonly thought of as the ASCII code, but ASCII is only  defined from 0x00 - 0x7F). Most regex implementations would treat [A-Z]  as all upper case English capital letters. But FINDSTR uses a collation  sequence that roughly corresponds to how SORT works. So [A-Z] includes  the complete English alphabet, both upper and lower case (except for  "a"), as well as non-English alpha characters with diacriticals.

## 感想 ##

以后再也不写批处理了。谢谢。