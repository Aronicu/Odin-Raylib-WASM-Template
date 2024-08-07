@echo off

set compiler_flags=-define:RAYLIB_SHARED=true -debug -show-timings -vet -use-separate-modules

echo Building Game DLL
odin build src/game -build-mode:dll -out:game.dll %compiler_flags%
IF %ERRORLEVEL% NEQ 0 exit /b 1


:: Check if the exe is already running
set exe_name=SDun.exe
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %exe_name%"') DO IF %%x == %exe_name% exit /b 0

echo Building Game EXE
odin run src/dev_hmr -out:%exe_name% %compiler_flags%
IF %ERRORLEVEL% NEQ 0 exit /b 1
