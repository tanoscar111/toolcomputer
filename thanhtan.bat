@echo off
title PC Cleanup and Error Fixer - No Admin
color 0A
echo ========================================
echo    PC CLEANUP AND ERROR FIXER - NO ADMIN 
echo ========================================
echo.

:: Kiểm tra xem đã chạy với quyền Admin chưa
net session >nul 2>&1
if %errorLevel% == 0 (
    set "isAdmin=1"
) else (
    set "isAdmin=0"
)

:start
echo Scanning for common issues...

:: Kiểm tra dung lượng trống trên ổ C:
echo Checking disk space...
for /f "tokens=3" %%a in ('dir C:\ ^| find "bytes free"') do set freeSpace=%%a
set /a freeSpaceMB=%freeSpace:~0,-3%/1024
echo Free space on C: is %freeSpaceMB% MB
if %freeSpaceMB% LSS 1024 (
    echo Low disk space detected! Freeing up space...
    start /b "" cmd /c del /s /f /q "%temp%\*.*" 2>nul
    start /b "" cmd /c del /s /f /q "%userprofile%\AppData\Local\Temp\*.*" 2>nul
    start /b "" compact /c /s:"%userprofile%\AppData\Local\Temp" >nul 2>&1
    echo Temporary files cleaned and compressed!
) else (
    echo Disk space is sufficient.
)

:: Kiểm tra và sửa lỗi DNS
echo.
echo Checking DNS connectivity...
ping 8.8.8.8 -n 2 | find "Reply" >nul
if %errorlevel% NEQ 0 (
    echo DNS issue detected! Flushing DNS cache...
    ipconfig /flushdns >nul 2>&1
    echo DNS cache cleared!
) else (
    echo DNS is working fine.
)

:: Kiểm tra file tạm quá nhiều
echo.
echo Checking for excessive temporary files...
dir "%temp%" /a-d | find "File(s)" >nul
if %errorlevel% EQU 0 (
    for /f "tokens=1" %%a in ('dir "%temp%" /a-d ^| find "File(s)"') do set fileCount=%%a
    if !fileCount! GTR 1000 (
        echo Too many temp files detected! Cleaning up...
        start /b "" cmd /c del /s /f /q "%temp%\*.*" 2>nul
        echo Temporary files cleaned!
    ) else (
        echo Temp files are within normal range.
    )
) else (
    echo No temp files found.
)

:: Kiểm tra và xóa cache Web
echo.
echo Checking browser cache...
if exist "%userprofile%\AppData\Local\Microsoft\Windows\WebCache" (
    echo Web cache detected! Cleaning up...
    start /b "" cmd /c del /s /f /q "%userprofile%\AppData\Local\Microsoft\Windows\WebCache\*.*" 2>nul
    echo Web cache cleared!
) else (
    echo No web cache found.
)

:: Kiểm tra trạng thái Print Spooler
echo.
echo Checking Print Spooler status...
sc query spooler | find "RUNNING" >nul
if %errorlevel% NEQ 0 (
    echo Print Spooler issue detected!
    if %isAdmin%==1 (
        echo Fixing Print Spooler with Admin rights...
        net stop spooler >nul 2>&1
        start /b "" cmd /c del /s /f /q "%systemroot%\System32\spool\PRINTERS\*.*" 2>nul
        net start spooler >nul 2>&1
        echo Print Spooler has been reset successfully!
    ) else (
        echo Admin rights required to fix Spooler. Restarting script with Admin privileges...
        echo Set objShell = CreateObject("Shell.Application") > "%temp%\runas.vbs"
        echo objShell.ShellExecute "%~f0", "", "", "runas", 1 >> "%temp%\runas.vbs"
        start "" wscript "%temp%\runas.vbs"
        timeout /t 1 /nobreak >nul
        del "%temp%\runas.vbs" 2>nul
        exit
    )
) else (
    echo Print Spooler is running normally.
)

echo.
echo Scan, cleanup, and fix completed successfully!

:: Hiển thị thông báo cửa sổ
echo Set objShell = CreateObject("WScript.Shell") > "%temp%\thankyou.vbs"
echo objShell.Popup "Thank you Thanh Tan for using this tool!", 0, "Cleanup and Fix Complete", 64 >> "%temp%\thankyou.vbs"
start "" wscript "%temp%\thankyou.vbs"
timeout /t 1 /nobreak >nul
del "%temp%\thankyou.vbs" 2>nul

echo Press any key to exit...
pause >nul