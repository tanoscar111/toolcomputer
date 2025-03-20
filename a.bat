@echo off
title CPU & RAM Optimizer
color 0A
echo Starting CPU and RAM optimization...
echo.

:: Dừng các dịch vụ không cần thiết để giảm tải CPU và RAM
net stop "Windows Search" >nul 2>&1
net stop "SysMain" >nul 2>&1
net stop "WSearch" >nul 2>&1
echo Stopped unnecessary services...

:: Danh sách ứng dụng nền phổ biến để tắt
set "apps_to_kill=OneDrive.exe Skype.exe Dropbox.exe GoogleDriveFS.exe iTunesHelper.exe Steam.exe Discord.exe epicgameslauncher.exe uplay.exe origin.exe adobeupdateservice.exe ccleaner.exe"

echo Terminating background applications...
for %%i in (%apps_to_kill%) do (
    tasklist | find /i "%%i" >nul 2>&1
    if !errorlevel!==0 (
        taskkill /f /im "%%i" >nul 2>&1
        if !errorlevel!==0 (
            echo - Terminated %%i
        ) else (
            echo - Failed to terminate %%i
        )
    )
)

:: Xóa file tạm để giải phóng RAM
echo Cleaning temporary files...
del /q /f /s "%temp%\*.*" >nul 2>&1
del /q /f /s "C:\Windows\Temp\*.*" >nul 2>&1
del /q /f /s "C:\Windows\Prefetch\*.*" >nul 2>&1

:: Giải phóng RAM bằng cách xóa bộ nhớ đệm
echo Flushing memory cache...
echo n | %windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks >nul 2>&1

:: Tối ưu hóa mức ưu tiên CPU
echo Optimizing CPU priority...
wmic process where name="svchost.exe" CALL setpriority "below normal" >nul 2>&1

echo.
echo Optimization completed!
echo Press any key to exit...
pause >nul