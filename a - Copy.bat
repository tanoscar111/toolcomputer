@echo off
title Auto Close Unused Taskbar Apps
color 0A
echo Starting to close unused taskbar applications...
echo.

:: Danh sách các ứng dụng thường xuất hiện trên taskbar nhưng không cần thiết
set "apps_to_check=notepad.exe calculator.exe msedge.exe chrome.exe firefox.exe winword.exe excel.exe powerpnt.exe outlook.exe explorer.exe"

:: Lấy tiến trình đang hoạt động (foreground) để không đóng nó
for /f "tokens=2 delims=," %%i in ('wmic process where "name='dwm.exe'" get Handle /format:csv') do (
    set "active_pid=%%i"
)

echo Closing unused applications...
for %%i in (%apps_to_check%) do (
    :: Kiểm tra xem tiến trình có đang chạy không
    tasklist /fi "imagename eq %%i" /fo csv | find "%%i" >nul 2>&1
    if !errorlevel!==0 (
        :: Lấy PID của tiến trình
        for /f "tokens=2 delims=," %%p in ('tasklist /fi "imagename eq %%i" /fo csv') do (
            set "pid=%%~p"
            :: So sánh với PID của tiến trình đang hoạt động
            if NOT "!pid!"=="!active_pid!" (
                taskkill /f /pid !pid! >nul 2>&1
                if !errorlevel!==0 (
                    echo - Closed %%i (PID: !pid!)
                ) else (
                    echo - Failed to close %%i (PID: !pid!)
                )
            ) else (
                echo - Skipped %%i (currently active)
            )
        )
    )
)

echo.
echo Unused taskbar apps cleanup completed!
echo Press any key to exit...
pause >nul