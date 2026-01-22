@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

echo Creating project structure...

:: =========================
:: Helper: create dir + README
:: =========================
set CREATE_DIR=call :make_dir

:: ---------- assets ----------
%CREATE_DIR% assets "All visual and audio assets. No gameplay logic."
%CREATE_DIR% assets\audio "Music and sound effects."
%CREATE_DIR% assets\audio\music "Background music."
%CREATE_DIR% assets\audio\sfx "Sound effects."
%CREATE_DIR% assets\sprites "All 2D sprites."
%CREATE_DIR% assets\sprites\units "Unit sprites."
%CREATE_DIR% assets\sprites\weapons "Weapon sprites."
%CREATE_DIR% assets\sprites\environment "Environment sprites."
%CREATE_DIR% assets\sprites\effects "Visual effects."
%CREATE_DIR% assets\sprites\ui "UI graphics."
%CREATE_DIR% assets\tilesets "Godot TileSets."
%CREATE_DIR% assets\tilesets\tactical "TileSets for tactical missions."
%CREATE_DIR% assets\tilesets\base "TileSets for player base."
%CREATE_DIR% assets\tilesets\geoscape "TileSets for global map."
%CREATE_DIR% assets\tilesets\shared "Shared/common tiles."
%CREATE_DIR% assets\shaders "2D shaders."
%CREATE_DIR% assets\fonts "Fonts."

:: ---------- data ----------
%CREATE_DIR% data "Game data (Resources). Rules and content."
%CREATE_DIR% data\units "Unit stats and definitions."
%CREATE_DIR% data\weapons "Weapon definitions."
%CREATE_DIR% data\research "Research tree."
%CREATE_DIR% data\buildings "Base buildings."
%CREATE_DIR% data\map_tiles "Tile gameplay data (LOS, cover, HP)."
%CREATE_DIR% data\missions "Mission definitions."
%CREATE_DIR% data\ai "AI data (GOAP / Utility)."
%CREATE_DIR% data\balance "Global balance values."

:: ---------- core ----------
%CREATE_DIR% core "Pure game logic, engine-independent."
%CREATE_DIR% core\world "Global game state and time."
%CREATE_DIR% core\combat "Combat rules and systems."
%CREATE_DIR% core\map "Grid map logic and pathfinding."
%CREATE_DIR% core\visibility "LOS, Fog of War, cover."
%CREATE_DIR% core\ai "AI logic (planners, world state)."
%CREATE_DIR% core\economy "Economy and upkeep."
%CREATE_DIR% core\save "Save/load and serialization."

:: ---------- modes ----------
%CREATE_DIR% modes "Game modes (scenes + controllers)."
%CREATE_DIR% modes\geoscape "Global strategy mode."
%CREATE_DIR% modes\base "Base management mode."
%CREATE_DIR% modes\mission "Tactical combat mode."

:: ---------- ui ----------
%CREATE_DIR% ui "UI scenes and layouts."
%CREATE_DIR% ui\common "Reusable UI elements."
%CREATE_DIR% ui\hud "In-mission HUD."
%CREATE_DIR% ui\menus "Main menus."
%CREATE_DIR% ui\styles "Themes and styles."

:: ---------- systems ----------
%CREATE_DIR% systems "Godot-specific adapters."
%CREATE_DIR% systems\input "Input handling."
%CREATE_DIR% systems\camera "Camera logic."
%CREATE_DIR% systems\audio "Audio control."
%CREATE_DIR% systems\animation "Animation helpers."

:: ---------- autoload ----------
%CREATE_DIR% autoload "Singletons (autoloads)."

:: ---------- debug ----------
%CREATE_DIR% debug "Debug tools and overlays."

:: ---------- tests ----------
%CREATE_DIR% tests "Logic tests (no scenes)."

echo.
echo Done!
pause
exit /b

:: =========================
:: Function
:: =========================
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

