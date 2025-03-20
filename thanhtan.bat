@echo off
title thanhtantool Tool

:: Check for Administrator privileges (only for other options, not for ACTIVATE)
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo This tool requires Administrator privileges for some options.
    echo Option 1 will still work without Admin rights.
)

:MAIN_MENU
color 0A
echo Chao mung den KIOH thanhtantool!
echo Chon di ne!!:
echo 1. Active Win va Office ne!!
echo 2. Fix full disk ne!!
echo 3. Tu dong sua loi may in ne!!
echo 4. Exit
set /p choice="Nhap lua chon cua ban (1-2-3-4): "

if %choice%==1 goto ACTIVATE
if %choice%==2 goto ADMIN
if %choice%==3 goto FIXSPOOLER
if %choice%==4 goto EXIT

:ACTIVATE
echo Dang khoi dong PowerShell va chay lenh kich hoat...
start powershell -NoProfile -Command "irm https://massgrave.dev/get | iex"
echo PowerShell da duoc mo va lenh da duoc thuc thi.
goto ASK_AGAIN

:ADMIN
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if "%errorlevel%" NEQ "0" (
    echo: Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo: UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs" & exit 
)
if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"

CLS
echo Please wait !!!

regsvr32 comcat.dll /s
regsvr32 shdoc401.dll /s
regsvr32 shdoc401.dll /i /s
regsvr32 asctrls.ocx /s
regsvr32 oleaut32.dll /s
regsvr32 shdocvw.dll /I /s
regsvr32 shdocvw.dll /s
regsvr32 browseui.dll /s
regsvr32 browseui.dll /I /s
regsvr32 msrating.dll /s
regsvr32 mlang.dll /s
regsvr32 hlink.dll /s
regsvr32 mshtmled.dll /s
regsvr32 urlmon.dll /s
regsvr32 plugin.ocx /s
regsvr32 sendmail.dll /s
regsvr32 scrobj.dll /s
regsvr32 mmefxe.ocx /s
regsvr32 corpol.dll /s
regsvr32 jscript.dll /s
regsvr32 msxml.dll /s
regsvr32 imgutil.dll /s
regsvr32 thumbvw.dll /s
regsvr32 cryptext.dll /s
regsvr32 rsabase.dll /s
regsvr32 inseng.dll /s
regsvr32 iesetup.dll /i /s
regsvr32 cryptdlg.dll /s
regsvr32 actxprxy.dll /s
regsvr32 dispex.dll /s
regsvr32 occache.dll /s
regsvr32 occache.dll /i /s
regsvr32 iepeers.dll /s
regsvr32 urlmon.dll /i /s
regsvr32 cdfview.dll /s
regsvr32 webcheck.dll /s
regsvr32 mobsync.dll /s
regsvr32 pngfilt.dll /s
regsvr32 licmgr10.dll /s
regsvr32 icmfilter.dll /s
regsvr32 hhctrl.ocx /s
regsvr32 inetcfg.dll /s
regsvr32 tdc.ocx /s
regsvr32 MSR2C.DLL /s
regsvr32 msident.dll /s
regsvr32 msieftp.dll /s
regsvr32 xmsconf.ocx /s
regsvr32 ils.dll /s
regsvr32 msoeacct.dll /s
regsvr32 inetcomm.dll /s
regsvr32 msdxm.ocx /s
regsvr32 dxmasf.dll /s
regsvr32 l3codecx.ax /s
regsvr32 acelpdec.ax /s
regsvr32 mpg4ds32.ax /s
regsvr32 voxmsdec.ax /s
regsvr32 danim.dll /s
regsvr32 Daxctle.ocx /s
regsvr32 lmrt.dll /s
regsvr32 datime.dll /s
regsvr32 dxtrans.dll /s
regsvr32 dxtmsft.dll /s
regsvr32 WEBPOST.DLL /s
regsvr32 WPWIZDLL.DLL /s
regsvr32 POSTWPP.DLL /s
regsvr32 CRSWPP.DLL /s
regsvr32 FTPWPP.DLL /s
regsvr32 FPWPP.DLL /s
regsvr32 WUAPI.DLL /s
regsvr32 WUAUENG.DLL /s
regsvr32 ATL.DLL /s
regsvr32 WUCLTUI.DLL /s
regsvr32 WUPS.DLL /s
regsvr32 WUWEB.DLL /s
regsvr32 wshom.ocx /s
regsvr32 wshext.dll /s
regsvr32 vbscript.dll /s
regsvr32 scrrun.dll mstinit.exe /setup /s
regsvr32 msnsspc.dll /SspcCreateSspiReg /s
regsvr32 msapsspc.dll /SspcCreateSspiReg /s
regsvr32 /s urlmon.dll
regsvr32 /s mshtml.dll
regsvr32 /s shdocvw.dll
regsvr32 /s browseui.dll
regsvr32 /s jscript.dll
regsvr32 /s vbscript.dll
regsvr32 /s scrrun.dll
regsvr32 /s msxml.dll
regsvr32 /s actxprxy.dll
regsvr32 /s softpub.dll
regsvr32 /s wintrust.dll
regsvr32 /s dssenh.dll
regsvr32 /s rsaenh.dll
regsvr32 /s gpkcsp.dll
regsvr32 /s sccbase.dll
regsvr32 /s slbcsp.dll
regsvr32 /s cryptdlg.dll
regsvr32 /s schannel.dll
regsvr32 /s oleaut32.dll
regsvr32 /s ole32.dll
regsvr32 /s shell32.dll
regsvr32 /s initpki.dll
regsvr32 /s msscript.ocx
regsvr32 /s dispex.dll
regsvr32 jscript.dll /s
del %temp% /Q /F
net stop wuauserv
ren %windir%\system32\catroot2 catroot2.old
cd /d %windir%\SoftwareDistribution
rd /s DataStore /Q
regsvr32 wuapi.dll /s
regsvr32 wups.dll /s
regsvr32 wuaueng.dll /s
regsvr32 wucltui.dll /s
regsvr32 wuweb.dll /s
regsvr32 msxml.dll /s
regsvr32 msxml2.dll /s
regsvr32 msxml3.dll /s
regsvr32 urlmon.dll /s
echo off
net stop wuauserv
net stop Windows Update
Del C:\Windows\System32\Tasks\Microsoft\Windows\TaskScheduler\Idle Maintenance.*
Del C:\Windows\System32\Tasks\Microsoft\Windows\TaskScheduler\Regular Maintenance.*
echo off
rmdir /s /q %Temp%&mkdir %Temp%
del /S /Q %temp%\DLC1Temp\*.*
del /S /Q C:\WINDOWS\Prefetch\*.*
del /S /Q C:\WINDOWS\Temp\*.*
RD /S /Q "C:\DLC1Temp"
RD /S /Q "D:\DLC1Temp"
RD /S /Q "E:\DLC1Temp"
goto ASK_AGAIN

:FIXSPOOLER
echo Fixing Print Spooler errors...
echo Stopping Print Spooler service...
net stop spooler >nul 2>&1
if %errorlevel%==0 (
    echo Da dung dich vu Print Spooler thanh cong!
) else (
    echo Loi: Khong the dung dich vu Print Spooler!
)

echo Deleting temporary spooler files...
if exist "%systemroot%\System32\spool\PRINTERS\*.*" (
    del /q /f /s "%systemroot%\System32\spool\PRINTERS\*.*" >nul 2>&1
    if %errorlevel%==0 (
        echo Da xoa cac file tam thoi cua Print Spooler thanh cong!
    ) else (
        echo Loi: Khong the xoa cac file tam thoi cua Print Spooler!
    )
) else (
    echo Thu muc PRINTERS khong ton tai hoac khong co file nao de xoa.
)

echo Starting Print Spooler service...
net start spooler >nul 2>&1
if %errorlevel%==0 (
    echo Da khoi dong lai dich vu Print Spooler thanh cong!
) else (
    echo Loi: Khong the khoi dong lai dich vu Print Spooler!
)

echo Print Spooler has been reset and fixed!
goto ASK_AGAIN

:ASK_AGAIN
echo.
echo Ban co muon thuc hien them hanh dong khac khong?
echo Nhan phim bat ky de tiep tuc hoac ESC de thoat...
choice /c yn /n /t 5 /d y >nul
if errorlevel 2 goto EXIT
if errorlevel 1 goto MAIN_MENU

:EXIT
echo.
echo kioh
echo Tam biet!
msg * "Keep it one hundred"
exit