
## 获取帮助 ##

学习指导:[https://wiki.python.org/moin/BeginnersGuideChinese](https://wiki.python.org/moin/BeginnersGuideChinese)

官方文档:[https://docs.python.org/3.6/index.html](https://docs.python.org/3.6/index.html)

参考书籍:

## 启动与结束 ##

[https://docs.python.org/3.6/tutorial/appendix.html](https://docs.python.org/3.6/tutorial/appendix.html)

启动解释器两个方式: `py -3` 和 `python -c command [arg] ...`, `python -m module [arg] ...`

或是以脚本启动`python fibo.py <arguments>`

启动的命名空间可能不同，用`__name__`属性来看

退出`quit()`, **Control-D on Unix, Control-Z on Windows**

启动命令的DOC [https://docs.python.org/3.6/using/cmdline.html#using-on-general](https://docs.python.org/3.6/using/cmdline.html#using-on-general)

**参数传递** 导入 `import sys`, 在`argv`变量里

## 变量，常量，传参 ##

变量定义`your_var_name = your_var_vaule`

多个变量定义`v1, v2 = 0, 1`,`a,b = b,a+b`，先执行右边的表达式再执行变量分配，而右边的表达式从左到右执行

## 注释 ##

单行注释 `#`, 文档注释`"""`包围

## 操作符 ##

数学运算符:加减乘除`+`,`-`,`*`,`/`,括号包围优先级`()`，忽略小数点的除`//`，求余`%`, 平方`**`，求值符号`=`

连接符: 重复多次连接`*`，字符连接`+`

条件判断符号: `<`,`>`,`>=`,`<=`,`==`,`!=`,`in`, `not in`，`is`,`is not`,`and`, `or`, `not`

## 数据结构 ##

Python 里一切皆对象。基本数据类型:数字和字符串，高级数据结构:列表(Stacks，Queues，etc), 元组，字典，集合。

### 字符串 ###
`'...'`单引号或`"..."`双引号都可以表示字符串，`\`表示转义

`*` 多次重复字符串，`+`连接字符串

两个或多个相连的`''`,`"""`字符串自动连接，但是不支持变量和表达式相连

字符串可以当成字符数组使用,索引从左数0为起始，从右数从-1,如有字符串`word = 'Python'`, 则`word[0]`和`word[-6]`为`P`,`word[5]`和`word[-1]`为`n`

支持字符截取`word[0:2]`为`'Py'`,`word[:2]`为`'Py'`

字符串长度获取`len()`

**更多参阅**
字符串内部的实现是文本序列`str`:[https://docs.python.org/3.6/library/stdtypes.html#textseq](https://docs.python.org/3.6/library/stdtypes.html#textseq) 

字符串方法:[https://docs.python.org/3.6/library/stdtypes.html#string-methods](https://docs.python.org/3.6/library/stdtypes.html#string-methods)

字符串格式化输出
- [https://docs.python.org/3.6/reference/lexical_analysis.html#f-strings](https://docs.python.org/3.6/reference/lexical_analysis.html#f-strings)
- [https://docs.python.org/3.6/library/string.html#formatstrings](https://docs.python.org/3.6/library/string.html#formatstrings)
- [https://docs.python.org/3.6/library/stdtypes.html#old-string-formatting](https://docs.python.org/3.6/library/stdtypes.html#old-string-formatting)

### 列表 ###
`[]` 中括号包围的，以逗号分隔的就是列表。如`squares = [1, 4, 9, 16, 25]`，允许保存不同的数据类型，支持正序和倒序索引获取元素，也支持获取指定范围, 支持`+`将两个列表合并

`append()`添加到列表末尾，`len()`获取列表长度

更多有用的方法:`extend(iterable)`,`insert(i, x)`,`remove(x)`,`pop([i])`,`clear()`,`index(x[, start[, end]])`,`count(x)`,`sort(key=None, reverse=False)`,`reverse()`,`copy()`

`del` 关键字可以通过索引删除列表元素。

`list()`用来创建列表

### 元组 ###

元组就是不变的列表。初始化定义是以逗号分隔定义的，如`t = 12345, 54321, 'hello!'`, 或以`()`包围表示一个元组，如`t= （1，2，3）`

**值得注意的是初始化一个元素的元组时，最后面要加个逗号**

### 集合 ###

集合就是保存的元素无序且不可重复。

集合以`{}`包围定义，或是用`set()`初始化

### 字典 ###

字典其实就是Java里的`Map`。Key-Vaule的映射。`{}`包围的就是字典。如`tel = {'jack': 4098, 'sape': 4139}`

`dict()`方法用来创建一个字典。

### 高级数据结构的遍历 ###

遍历字典用关键字`items()`, 遍历序列的用关键字`enumerate()` ,同时遍历多个序列用关键字`zip()`

## 日志打印 ##

[https://docs.python.org/3.6/howto/logging.html](https://docs.python.org/3.6/howto/logging.html)

`print(str)` 打印字符串。 `print(r"str")` 加上`r`取消str里的特殊字符。`print(""" """)`打印多行，可能需要`\`转义换行符

## 流程控制语句 ##

判断的逻辑
>  In Python, like in C, any non-zero integer value is true; zero is false. The condition may also be a string or list value, in fact any sequence; anything with a non-zero length is true, empty sequences are false. 

### 循环语句:while ###
```
 "while" expression ":" suite
                ["else" ":" suite]
```

### 条件语句:if ###
```
 "if" expression ":" suite
             ("elif" expression ":" suite)*
             ["else" ":" suite]
```

### 循环语句:for ###
```
"for" target_list "in" expression_list ":" suite
              ["else" ":" suite]
```
与其他语言不同的是，for循环遍历的是列表

如要执行循环次数，可以利用`range()`函数，如循环5次，写成`for i in range(5)：`

### 中断语句:break, continue ###

与C和Java类似，`break`跳出整个循环，`continue`跳出当次循环，继续下一个循环

### pass ###

不做什么事清，空语句，无意义，只是用来避免语法错误的。
```
while True:
	pass  # Busy-wait for keyboard interrupt (Ctrl+C)
```

## 代码重用: 函数 ##

```
def fuction_name ( var_list ):
   your_code
   ...
   return your_result_if_you_need
```

`def` 为定义的关键字，`return`返回结果，如果没有，打印出的值默认为`None`，`var_list`为参数列表,用括号包围，如有多个，逗号分隔

定义个默认参数的函数,直接在参数列表里赋值
```
def ask_ok(prompt, retries=4, reminder='Please try again!'):
   print(prompt, retries, reminder)
```

Python 支持任意参数，参数前加`*`
```
>>>  def concat(*args, sep="/"):
...     return sep.join(args)
...
>>> concat("earth", "mars", "venus")
'earth/mars/venus'
>>> concat("earth", "mars", "venus", sep=".")
'earth.mars.venus'
```

传参时`*`支持列表取消包围，`**`取消字典包围，即可以这样用

```
>>> args = [3, 6]
>>> list(range(*args))            # call with arguments unpacked from a list
[3, 4, 5]

>>> def parrot(voltage, state='a stiff', action='voom'):
...     pass
...
>>> d = {"voltage": "four million", "state": "bleedin' demised", "action": "VOOM"}
>>> parrot(**d)
```

`lambda` 关键字允许用lamba函数

### 调用 ###
以函数`ask_ok`为例子，有多个默认参数时，可以传必须参数调用`ask_ok("Hello World")`，可以修改默认参数`ask_ok('OK to overwrite the file?', 2)`, 可以全部传入`ask_ok('OK to overwrite the file?', 2, 'Come on, only yes or no!')`, 也可以指定关键参数赋值，不必按顺序来调用`ask_ok(retries=4, prompt="1.please wait")`

### 打包成模块 ###

[https://docs.python.org/3.6/tutorial/modules.html](https://docs.python.org/3.6/tutorial/modules.html)

将函数的定义放到以`py`为后缀的文件中，在解释器或在新的Python脚本中加入`import module_name`即可调用封装的函数。

导入指定的函数`from module_name import fuc_name`

指定寻找模块的路径
```
>>> import sys
>>> sys.path.append('/ufs/guido/lib/python')
```

否则默认搜素路径
> - The directory containing the input script (or the current directory when no file is specified).
> - PYTHONPATH (a list of directory names, with the same syntax as the shell variable PATH).
> - The installation-dependent default.

## 错误处理 ##

两种错误:语法错误和异常

捕获异常的语法
```
try:
	x = int(input("Please enter a number: "))
	break
except ValueError:
    print("Oops!  That was no valid number. Try again...")

```

`raise` 关键字生成异常或是继续往上抛，`finally`关键字类似Java的`finally`， `else` 关键字可以增加对特定异常的特定处理
```
>>> def divide(x, y):
...     try:
...         result = x / y
...     except ZeroDivisionError:
...         print("division by zero!")
...     else:
...         print("result is", result)
...     finally:
...         print("executing finally clause")
...
>>> divide(2, 1)
result is 2.0
executing finally clause
>>> divide(2, 0)
division by zero!
executing finally clause
>>> divide("2", "1")
executing finally clause
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 3, in divide
TypeError: unsupported operand type(s) for /: 'str' and 'str'
```

## 调试 ##

FAQ:[https://docs.python.org/3.6/faq/programming.html#is-there-a-source-code-level-debugger-with-breakpoints-single-stepping-etc](https://docs.python.org/3.6/faq/programming.html#is-there-a-source-code-level-debugger-with-breakpoints-single-stepping-etc)

Python 提供了一个调试的模块叫pdb.链接:[https://docs.python.org/3.6/library/pdb.html#module-pdb](https://docs.python.org/3.6/library/pdb.html#module-pdb)

`PyCharm` IDE提供了常见的断点，单步的图形调试器。

## 后记 ##