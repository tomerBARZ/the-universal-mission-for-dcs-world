@echo off
cls

@REM -------------------------------------------
@REM CREATE SCENARIOS
@REM -------------------------------------------
set buildConfig=p
echo THE ULTIMATE MISSION BUILDER SCRIPT:
echo - Build [P]ersianGulf debug theater only (default)
echo - Build all [D]ebug theaters
echo - Build all [R]elease theaters
echo.
set /p buildConfig=Your choice:
echo.

IF "%buildConfig%" == "d" goto BUILD-DEBUG-ALL
IF "%buildConfig%" == "D" goto BUILD-DEBUG-ALL
IF "%buildConfig%" == "p" goto BUILD-DEBUG-PERSIAN
IF "%buildConfig%" == "P" goto BUILD-DEBUG-PERSIAN
IF "%buildConfig%" == "r" goto BUILD-RELEASE
IF "%buildConfig%" == "R" goto BUILD-RELEASE
IF "%buildConfig%" == "s" goto START-DEBUG
IF "%buildConfig%" == "S" goto START-DEBUG
goto CANCEL-END

:BUILD-DEBUG-ALL
if exist *.miz del *.miz
c:\php\php Make.php debug
goto END

:BUILD-DEBUG-PERSIAN
if exist *.miz del *.miz
c:\php\php Make.php debug persiangulf
goto END

:BUILD-RELEASE
if exist *.miz del *.miz
c:\php\php Make.php release
goto END

@REM -------------------------------------------
@REM COPY OUTPUT MIZ FILES TO DCS'S MISSIONS DIRECTORY
@REM -------------------------------------------
if not exist "%userprofile%\Saved Games\DCS\Missions\" goto END
if not exist *.miz goto END
echo Copying output MIZ files to %userprofile%\Saved Games\DCS\Missions...
copy /y *.miz "%userprofile%\Saved Games\DCS\Missions"
echo DONE
echo.

:CANCEL-END
echo.
echo Build cancelled.
goto END

:END
echo.
