@echo off
chcp 65001

if "%~1"=="" (
    set /p msg=参数为空，回车退出
    exit;
)

:: ----------------------------------------------> 全局变量定义
:: -> 日期2018-07-12格式
set _DATA_=%date:~3,4%-%date:~8,2%-%date:~11,2%
:: -> 源文件的文件名
set _FILE_NAME_=%~n1
:: -> 生成的文件名 格式为: 2018-07-12-${_FILE_NAME_}
set _NAME_=%_DATA_%-%_FILE_NAME_%
:: -> 传入的源文件的绝对路径
set _SOURCE_FILE_=%1
:: -> 生成的文件的目录
set _DEST_PATH_=D:\idea_src_工程\skyc00p.github.io\_posts\
:: -> 与源文件对应的头标签目录
set _YAML_PATH_=D:\idea_src_工程\skyc00p.github.io\_drafts\yaml\
:: -> Yaml 头标签绝对路径
set "_YAML_FILE_=%_YAML_PATH_%%_FILE_NAME_%.yaml"
set HasDate=0
:: ----------------------------------------------

if exist "%_YAML_FILE_%" (
    setlocal enabledelayedexpansion
    call :syncName
    if /i !HasDate! equ 1 (
        call :openAndCopy
    ) else (
        echo find no date,please add date by yourself,then try again
        "%_YAML_FILE_%"
    )
) else (
    call :createYaml
    call :openAndCopy
)

pause
exit

::--------------------------------------------------------
::-- Function : 打开头文件，关闭头文件后再合并复制到目标目录下，在打开发布的目录
::--------------------------------------------------------
:openAndCopy
"%_YAML_FILE_%"
copy /y "%_YAML_FILE_%" /B + %_SOURCE_FILE_% /B "%_DEST_PATH_%%_NAME_%.md" /B
start %_DEST_PATH_%
"%_DEST_PATH_%%_NAME_%.md"
goto:eof

::--------------------------------------------------------
::-- Function : 创建Yaml头标签
::--------------------------------------------------------
:createYaml
echo ---> "%_YAML_FILE_%"
echo layout: post >> "%_YAML_FILE_%"
echo date: %_DATA_% >> "%_YAML_FILE_%"
echo title: "%_FILE_NAME_%" >> "%_YAML_FILE_%"
echo categories: >> "%_YAML_FILE_%"
echo tags: >> "%_YAML_FILE_%"
echo author: skycoop >> "%_YAML_FILE_%"
echo --- >> "%_YAML_FILE_%"
echo.>> "%_YAML_FILE_%"
echo * content >> "%_YAML_FILE_%"
echo {:toc} >> "%_YAML_FILE_%"
echo.>> "%_YAML_FILE_%"
goto:eof

::--------------------------------------------------------
::-- Function : 重置名字
:: 在 %_YAML_FILE_% 搜索date的值，重置变量 _DATA_ | _NAME_ 的值
::--------------------------------------------------------
:syncName
for /f "usebackq skip=1 tokens=1,* delims=: " %%a in ("%_YAML_FILE_%") do (
    if "date" == "%%a" (
        set HasDate=1
        set _DATA_=%%b
        set _NAME_=%%b-%_FILE_NAME_%
        goto:eof
    )
)
goto:eof