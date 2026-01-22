@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

echo Creating MOD / DLC structure...

set CREATE_DIR=call :make_dir

:: =====================
:: MODS ROOT
:: =====================
%CREATE_DIR% mods "All game mods and DLCs."

:: =====================
:: SAMPLE MOD
:: =====================
set MOD_NAME=example_mod

%CREATE_DIR% mods\%MOD_NAME% "Standalone mod or DLC package."

:: ----- metadata -----
if not exist "mods\%MOD_NAME%\mod.json" (
    echo( {>"mods\%MOD_NAME%\mod.json"
    echo(   "id": "%MOD_NAME%",>>"mods\%MOD_NAME%\mod.json"
    echo(   "name": "Example Mod",>>"mods\%MOD_NAME%\mod.json"
    echo(   "version": "1.0.0",>>"mods\%MOD_NAME%\mod.json"
    echo(   "author": "Your Name",>>"mods\%MOD_NAME%\mod.json"
    echo(   "description": "Example mod / DLC package",>>"mods\%MOD_NAME%\mod.json"
    echo(   "dependencies": [],>>"mods\%MOD_NAME%\mod.json"
    echo(   "load_order": 100>>"mods\%MOD_NAME%\mod.json"
    echo( }>>"mods\%MOD_NAME%\mod.json"
)

:: ----- data -----
%CREATE_DIR% mods\%MOD_NAME%\data "Gameplay data added or overridden by this mod."
%CREATE_DIR% mods\%MOD_NAME%\data\units "New or overridden units."
%CREATE_DIR% mods\%MOD_NAME%\data\weapons "New or overridden weapons."
%CREATE_DIR% mods\%MOD_NAME%\data\research "New research entries."
%CREATE_DIR% mods\%MOD_NAME%\data\map_tiles "Tile gameplay data."
%CREATE_DIR% mods\%MOD_NAME%\data\missions "New missions."

:: ----- assets -----
%CREATE_DIR% mods\%MOD_NAME%\assets "Visual/audio assets used by the mod."
%CREATE_DIR% mods\%MOD_NAME%\assets\sprites "Sprites."
%CREATE_DIR% mods\%MOD_NAME%\assets\tilesets "TileSets."
%CREATE_DIR% mods\%MOD_NAME%\assets\audio "Audio assets."
%CREATE_DIR% mods\%MOD_NAME%\assets\shaders "Shaders."

:: ----- overrides -----
%CREATE_DIR% mods\%MOD_NAME%\overrides "Overrides of base game data."
%CREATE_DIR% mods\%MOD_NAME%\overrides\data "Override existing game data."
%CREATE_DIR% mods\%MOD_NAME%\overrides\assets "Override existing assets."

:: ----- scripts (optional) -----
%CREATE_DIR% mods\%MOD_NAME%\scripts "Optional mod-specific scripts."

echo.
echo Mod/DLC structure created successfully.
pause
exit /b

:: =====================
:: Function
:: =====================
:make_dir
if not exist "%~1" (
    mkdir "%~1"
)

setlocal EnableDelayedExpansion
set "desc=%~2"

if not exist "%~1\README.md" (
    echo(# %~nx1>"%~1\README.md"
    echo(>>"%~1\README.md"
    echo(!desc!>>"%~1\README.md"
)
endlocal
exit /b