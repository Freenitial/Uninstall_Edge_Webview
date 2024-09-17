@echo off
setlocal enabledelayedexpansion

set "WEBVIEW2_KEY1=SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}"
set "WEBVIEW2_KEY2=SOFTWARE\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}"
set "INSTALLED=false"
for %%K in ("%WEBVIEW2_KEY1%" "%WEBVIEW2_KEY2%") do (
    reg query "HKLM\%%~K" >nul 2>&1
    if !errorlevel! equ 0 (
        set "INSTALLED=true"
        goto :break
    )
)
:break

if "!INSTALLED!"=="true" (
    echo Microsoft Edge WebView2 Runtime is already installed.
    echo You can close this window.
    pause >nul & exit /b
) else (
    echo Microsoft Edge WebView2 Runtime is not installed.
    set "OS_ARCHITECTURE="
    if defined ProgramFiles(x86) (set "OS_ARCHITECTURE=x64") else (set "OS_ARCHITECTURE=x86")
    cd /d "%~dp0"
    if "%OS_ARCHITECTURE%"=="x64" (
        echo Windows x64 detected.
        curl https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/22845a8e-4143-4806-a5cd-c6908efc8dce/MicrosoftEdgeWebView2RuntimeInstallerX64.exe --output MicrosoftEdgeWebView2RuntimeInstallerX64.exe
        MicrosoftEdgeWebView2RuntimeInstallerX64.exe /silent /install
    ) else (
        echo Windows x86 detected.
        curl https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/627758f5-bbf5-4e1d-ada2-b54ad81969ba/MicrosoftEdgeWebView2RuntimeInstallerX86.exe --output MicrosoftEdgeWebView2RuntimeInstallerX86.exe
        MicrosoftEdgeWebView2RuntimeInstallerX86.exe /silent /install
    )
    echo Microsoft Edge WebView2 Runtime is now installed.
    echo You can close this window.
    pause >nul & exit /b
)

endlocal
