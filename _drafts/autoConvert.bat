@echo off
chcp 65001

set _DATA_=%date:~3,4%-%date:~8,2%-%date:~11,2%
set _FILE_NAME_=%~n1
set _NAME_=%_DATA_%-%_FILE_NAME_%

set _SOURCE_PATH=%1
set _DEST_PATH_=D:\idea_src_工程\skyc00p.github.io\_posts\
set _FILE_=%_DEST_PATH_%%_NAME_%.md

echo ---> yaml.tmp
echo layout: post >> yaml.tmp
echo title: %_FILE_NAME_% >> yaml.tmp
echo categories: >> yaml.tmp
echo tags: >> yaml.tmp
echo author: skycoop >> yaml.tmp
echo --- >> yaml.tmp
echo.>> yaml.tmp
echo * content >> yaml.tmp
echo {:toc} >> yaml.tmp
echo.>> yaml.tmp

copy /y yaml.tmp /B + %_SOURCE_PATH% /B "%_FILE_%" /B
del yaml.tmp

start %_DEST_PATH_%
"%_DEST_PATH_%%_NAME_%.md"
exit