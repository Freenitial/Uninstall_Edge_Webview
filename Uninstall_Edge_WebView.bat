@echo off
Net session >nul 2>&1 || (PowerShell -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb runAs" & exit)

echo Closing Edge...
taskkill /f /im msedge.exe
timeout 3 >nul

echo Deleting Folder...
if exist "C:\Program Files (x86)\Microsoft\EdgeWebView\Application" (
    cd "C:\Program Files (x86)\Microsoft\EdgeWebView\Application\1*\"
    del /s /q "*" 2 >nul
)

echo Deleting Registry keys...
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\ClientState\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\ClientStateMedium\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView" /f

echo. & echo  END.
timeout 3 >nul & exit
