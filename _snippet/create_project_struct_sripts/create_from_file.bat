@echo off
chcp 65001 > nul
setlocal EnableDelayedExpansion

if "%~1"=="" (
    echo Usage: %~nx0 structure_file.txt
    exit /b 1
)

set "STRUCT=%~1"

if not exist "%STRUCT%" (
    echo File not found: %STRUCT%
    exit /b 1
)

for /f "usebackq tokens=1* delims=|" %%A in ("%STRUCT%") do (
    set "PATH=%%A"
    set "DESC=%%B"

    if not exist "!PATH!" mkdir "!PATH!"

    if not exist "!PATH!\README.md" (
        >"!PATH!\README.md" echo(# !PATH!
        >>"!PATH!\README.md" echo(
        >>"!PATH!\README.md" echo(!DESC!
    )
)

echo Done.
pause
