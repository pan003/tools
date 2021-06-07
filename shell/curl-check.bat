@echo off
:: 设置窗体背景颜色
color 1f
:: 设置窗体标题
title 正在监控http://localhost:8080
echo 正在监控 http://localhost:8080
 
:next
set code=500
curl -I -m 10 -s -w %{http_code} 10.66.32.23:8080 -o nul > check.txt
for /f %%i in (check.txt) do set "code=%%i"
echo code为：%code%
if %code%==200 (
 echo 在%date:~0,10% %time:~0,8% 访问正常
 echo 正在监控http://localhost:8080
) else (
 echo 在%date:~0,10% %time:~0,8% 无法正常访问
 call kill-office.bat
 echo 在%date:~0,10% %time:~0,8% 无法正常访问，kill-office中...
)
:: 休眠15秒
choice /t 15 /d y /n >nul
goto next
