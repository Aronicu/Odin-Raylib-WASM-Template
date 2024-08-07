@echo off
if not exist build mkdir build

set compiler_flags=-o:speed -show-timings -vet -use-separate-modules -subsystem:windows

set exe_name=SDun-Release.exe
odin build src/desktop_release -out:build/%exe_name% %compiler_flags%