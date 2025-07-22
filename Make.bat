@echo off
cls

@REM -------------------------------------------
@REM DELETE PREVIOUSLY GENERATED MISSIONS
@REM -------------------------------------------
if exist *.miz del *.miz

@REM -------------------------------------------
@REM CREATE SCENARIOS
@REM -------------------------------------------
c:\php\php Make.php
echo.

@REM -------------------------------------------
@REM COPY OUTPUT MIZ FILES TO DCS'S MISSIONS DIRECTORY
@REM -------------------------------------------
if not exist "%userprofile%\Saved Games\DCS\Missions\" goto EOF
if not exist *.miz goto EOF
echo Copying output MIZ files to %userprofile%\Saved Games\DCS\Missions...
copy /y *.miz "%userprofile%\Saved Games\DCS\Missions"
echo DONE
echo.

:EOF
