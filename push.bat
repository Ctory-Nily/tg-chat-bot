@echo off
echo 正在同步github仓库
git pull origin main

echo 正在添加所有文件到暂存区
git add .

:: 格式化日期和时间
for /f "tokens=1-3 delims=/- " %%a in ("%date%") do (
    set year=%%a
    set month=%%b
    set day=%%c
)
for /f "tokens=1-3 delims=:.," %%a in ("%time%") do (
    set hour=%%a
    set minute=%%b
)

:: 去掉小时前面的空格（如果小时是单数）
set hour=%hour: =%

:: 组合成 "年 月 日 时 分" 格式
set formatted_time=%year%年%month%月%day%日%hour%时%minute%分

:: 询问是否自定义提交信息
:input_confirm
set /p confirm=是否自定义提交信息？(输入 y 或 n): 
if "%confirm%"=="" (
    echo 输入不能为空，请重新输入！
    goto input_confirm
)

if "%confirm%"=="y" (
    :input_msg
    set /p commit_msg=请输入提交信息: 
    if "%commit_msg%"=="" (
        echo 输入不能为空，请重新输入！
        goto input_msg
    )
    git commit -m "%commit_msg%"
) else (
    git commit -m "%formatted_time%"
)

echo 正在推送到远程仓库
git push -u origin main

echo 操作完成！
pause