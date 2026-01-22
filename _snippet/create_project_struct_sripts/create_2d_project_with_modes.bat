@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

echo Creating 2D game project structure with modes...

set CREATE_DIR=call :make_dir

:: =====================
:: ASSETS (2D only)
:: =====================
%CREATE_DIR% assets "2D visual and audio assets. No gameplay logic."
%CREATE_DIR% assets\audio "All audio assets."
%CREATE_DIR% assets\audio\music "Background music."
%CREATE_DIR% assets\audio\sfx "Sound effects."

%CREATE_DIR% assets\sprites "All 2D sprites."
%CREATE_DIR% assets\sprites\units "Unit sprites (soldiers, enemies)."
%CREATE_DIR% assets\sprites\environment "Environment sprites."
%CREATE_DIR% assets\sprites\effects "VFX sprites."
%CREATE_DIR% assets\sprites\ui "UI sprites and icons."

%CREATE_DIR% assets\tilesets "Godot TileSets (visual only)."
%CREATE_DIR% assets\tilesets\mission "TileSets for tactical missions."
%CREATE_DIR% assets\tilesets\base "TileSets for player base."
%CREATE_DIR% assets\tilesets\geoscape "TileSets for global map."
%CREATE_DIR% assets\tilesets\shared "Shared/common tiles."

%CREATE_DIR% assets\fonts "Fonts."
%CREATE_DIR% assets\shaders "2D shaders."

:: =====================
:: DATA (game rules)
:: =====================
%CREATE_DIR% data "Game data and rules (Resources)."
%CREATE_DIR% data\units "Unit definitions and stats."
%CREATE_DIR% data\weapons "Weapon definitions."
%CREATE_DIR% data\research "Research tree."
%CREATE_DIR% data\buildings "Base buildings."
%CREATE_DIR% data\map_tiles "Tile gameplay data (LOS, cover, HP)."
%CREATE_DIR% data\missions "Mission definitions."
%CREATE_DIR% data\ai "AI data (GOAP / Utility)."
%CREATE_DIR% data\balance "Global balance values."

:: =====================
:: CORE (pure logic)
:: =====================
%CREATE_DIR% core "Pure game logic. No scenes, no rendering."
%CREATE_DIR% core\world "Global game state and time."
%CREATE_DIR% core\combat "Combat systems and rules."
%CREATE_DIR% core\map "Grid map state and pathfinding."
%CREATE_DIR% core\visibility "LOS, Fog of War, cover."
%CREATE_DIR% core\ai "AI planners and decision logic."
%CREATE_DIR% core\save "Save/load and serialization."

:: =====================
:: MODES (gameplay modes)
:: =====================
%CREATE_DIR% modes "Game modes (scenes + controllers)."

%CREATE_DIR% modes\geoscape "Global strategy mode (world map)."
%CREATE_DIR% modes\geoscape\scenes "Geoscape scenes."
%CREATE_DIR% modes\geoscape\ui "Geoscape UI."
%CREATE_DIR% modes\geoscape\controllers "Geoscape controllers."

%CREATE_DIR% modes\base "Base management mode."
%CREATE_DIR% modes\base\scenes "Base scenes."
%CREATE_DIR% modes\base\ui "Base UI."
%CREATE_DIR% modes\base\controllers "Base controllers."

%CREATE_DIR% modes\mission "Tactical combat mode."
%CREATE_DIR% modes\mission\scenes "Mission scenes."
%CREATE_DIR% modes\mission\ui "Tactical UI."
%CREATE_DIR% modes\mission\controllers "Mission controllers."

:: =====================
:: UI (shared)
:: =====================
%CREATE_DIR% ui "Shared UI elements."
%CREATE_DIR% ui\common "Reusable UI widgets."
%CREATE_DIR% ui\styles "Themes and styles."

:: =====================
:: SYSTEMS (Godot adapters)
:: =====================
%CREATE_DIR% systems "Godot-specific adapters."
%CREATE_DIR% systems\input "Input handling."
%CREATE_DIR% systems\camera "2D camera logic."
%CREATE_DIR% systems\audio "Audio control."

:: =====================
:: AUTOLOAD / DEBUG / TESTS
:: =====================
%CREATE_DIR% autoload "Autoload singletons."
%CREATE_DIR% debug "Debug and developer tools."
%CREATE_DIR% tests "Logic tests (no scenes)."

echo.
echo Project structure created successfully.
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