@echo off
cd %~dp0
setlocal enabledelayedexpansion
title Classic User Account Control for Windows 10 Installer

:: Variables
set UAC_LOCALE=en-US

if "%~1" == "/locale" (
    if NOT "%~2" == "" (
        set UAC_LOCALE=%2
    )
)

set UAC_FILES=consent.exe wincredui.dll
set UAC_MUIS=wincredui.dll.mui

set UAC_AUTHUI=authui.dll
set UAC_AUTHUI_MUI=authui.dll.mui

:: Texts
cls
echo.
echo Classic User Account Control for Windows 10
echo ==========================================================================
echo.

:: Check for admin.
net session >nul 2>&1
if NOT %ERRORLEVEL% == 0 (
    goto noadmin
)

echo This batch script will replace system files to restore the classic UAC from
echo from Windows 10 v1607 in newer Windows 10. Only MUIs for en-US are provided by
echo default. If you want to install this for another locale, grab those files from
echo Windows 10 v1607, create a new folder with the locale code in "files", and put
echo the files in there.
echo.
echo   Locale to install: %UAC_LOCALE%
echo.
echo If that locale is incorrect, please exit this script and pass your proper locale
echo with the /locale argument.
echo.

choice /n /m "Do you wish to continue? Doing so will replace system files. (Y/N)"

:: User said no
if %ERRORLEVEL% == 2 (
    goto end
)

:: Style choice
echo.
choice /c v78 /n /m "Do you want it themed like Windows (V)ista, (7), or (8)?"

if %ERRORLEVEL% == 1 (
    set UAC_AUTHUI=authui_vista.dll
    set UAC_AUTHUI_MUI=authui_vista.dll.mui
) else if %ERRORLEVEL% == 2 (
    set UAC_AUTHUI_MUI=authui_seven.dll.mui
)

:: INSTALL
cls

:: Registry
echo.
echo|set /p="Importing registry keys..."
call regedit /s "%~dp0regs\entries.reg"
echo done.

echo.

:: Files
echo Copying files...

:: DLLs
for %%f in (%UAC_FILES%) do call "%~dp0scripts\ownreplace" %SystemRoot%\System32\%%f %~dp0files\%%f
call "%~dp0scripts\ownreplace" %SystemRoot%\System32\authui.dll %~dp0files\%UAC_AUTHUI%

:: MUIs
for %%f in (%UAC_MUIS%) do call "%~dp0scripts\ownreplace" %SystemRoot%\System32\%UAC_LOCALE%\%%f %~dp0files\%UAC_LOCALE%\%%f
call "%~dp0scripts\ownreplace" %SystemRoot%\System32\%UAC_LOCALE%\authui.dll.mui %~dp0files\%UAC_LOCALE%\%UAC_AUTHUI_MUI%

echo.
echo The classic UAC has been installed! The next time you get prompted, it will
echo show the classic UAC prompt.
echo.
pause
goto end

:noadmin
echo You must run this script as administrator. Right click the script and click
echo Run as Administrator, and if you need to pass arguments, run it in a Command
echo Prompt window that is running as administrator.
echo.
pause
goto end

:end
cls