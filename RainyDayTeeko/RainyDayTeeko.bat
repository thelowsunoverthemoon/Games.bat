<!-- : Begin batch script
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
:: 917504 = size 14 * 65536
IF "%1" == "" (
    >NUL REG ADD HKCU\Console\RainyDayTeeko /v FaceName /t REG_SZ /d "Courier New" /f
	>NUL REG ADD HKCU\Console\RainyDayTeeko /v FontSize /t REG_DWORD /d 917504 /f
    >NUL REG ADD HKCU\Console\RainyDayTeeko /v ScreenColors /t REG_DWORD /d 00000000 /f
    >NUL REG ADD HKCU\Console\RainyDayTeeko /v QuickEdit /t REG_DWORD /d 00000000 /f
    >NUL REG ADD HKCU\Console\RainyDayTeeko /v FullScreen /t REG_DWORD /d 00000000 /f
    START "RainyDayTeeko" CONHOST "%~0" Font
    EXIT
) else IF "%1" == "Font" (
    >NUL REG DELETE HKCU\Console\RainyDayTeeko /f
)

:: WRONG DIALOGUE THURSDAY FOR JACKIE
:: CROP MIA PHOTO CUZ OF RED BIT
:: rain hits other person side!!
:: add colour to teeko turn for better
:: RANDOM EVENT bus crash / late night studying
:: make correct default for mia
:: make mia box lighter ... also why cursor sowing?
:: problem mia event repeats (problem with teeko?)
:MAIN

CALL :PRELUDE
CALL :MACROS

ECHO %\e%[?25l%col:c=204;204;204%

:GAME
%$silence%
%$music:type name=Track rain%
%$music:type name=Track dreading%

SETLOCAL
CALL scripts\rain.bat menu
ENDLOCAL

%$silence%
%$music:type name=Track rain%
%$music:type name=Track bikesatthepier%

SET /A "jackie.branch=jackie.day=mia.branch=mia.day=allison.branch=allison.day=1"

FOR %%D in (Monday Tuesday Wednesday Thursday Friday) DO (
    SET "day=%%D"
    CALL :DAY normal
    IF "!jackie.day!" == "1" (
        CALL :DAY Jackie
    ) else IF "!allison.day!" == "1" (
        CALL :DAY Allison
    ) else IF "!mia.day!" == "1" (
        CALL :DAY Mia
    )
)

SETLOCAL
CALL scripts\novel.bat end
ENDLOCAL

%$silence%
%$music:type name=Track rain%
%$music:type name=Track peacefulnights%

SETLOCAL
CALL scripts\rain.bat end
ENDLOCAL

GOTO :GAME

:DAY <type>
SETLOCAL
CALL scripts\novel.bat %1
ENDLOCAL & SET "person=%person%" ^
         & SET "jackie.branch=%jackie.branch%" ^
         & SET "allison.branch=%allison.branch%" ^
         & SET "mia.branch=%mia.branch%"
SETLOCAL
CALL scripts\teeko.bat
ENDLOCAL
SETLOCAL
CALL scripts\novel.bat postgame
ENDLOCAL
SET /A "%person%.day+=1"
GOTO :EOF

:PRELUDE
MODE 70, 38
CHCP 65001 >NUL
TITLE Rainy Day Teeko
TASKKILL /F /IM CHOICE.exe >NUL 2>NUL
DEL /F /Q "%~dpn0.quit" "turn.txt" "turn_cpy.txt" 2>NUL

SET "save=Path ComSpec TEMP SystemRoot SystemDrive save"
FOR /F "tokens=1 delims==" %%A in ('SET') DO (
    IF "%save%" == "!save:%%A=!" (
        SET "%%A="
    )
)
SET "save="

FOR /F %%A in ('ECHO PROMPT $E^| CMD') DO SET "\e=%%A"
SET "col=%\e%[38;2;cm"
SET "bkg=%\e%[48;2;cm"
SET "up=%\e%[nA"
SET "dn=%\e%[nB"
SET "bk=%\e%[nD"
SET "nx=%\e%[nC"
SET "dia.box=┌────────────────────────────────────────┐%dn:n=1%%bk:n=42%│                                        │%dn:n=1%%bk:n=42%│                                        │%dn:n=1%%bk:n=42%│                                        │%dn:n=1%%bk:n=42%└────────────────────────────────────────┘"
GOTO :EOF

:MACROS
SET "$music=(PUSHD music & START /B CSCRIPT //NOLOGO "%~f0?.wsf" //JOB:Music type name.mp3 & POPD)>NUL"
SET "$silence=TASKKILL /F /IM CSCRIPT.exe >NUL 2>NUL"
SET $strlen=SET "str=A^!text^!" ^& SET "len=0" ^& FOR /L %%A in (12, -1, 0) DO (SET /A "len|=1<<%%A" ^& FOR %%B in (^^!len^^!) DO IF "^!str:~%%B,1^!" == "" SET /A "len&=~1<<%%A")
SET $rain=SET "rain.cpy=^!rain.par^!" ^& SET "rain.par=" ^& SET "rain=" ^& FOR %%R in (^^!rain.cpy^^!) DO (FOR /F "tokens=1-3" %%1 in ("%%~R") DO (SET /A "rain.y=%%2 + 1" ^& SET "rain=^!rain^!%\e%[%%2;%%1H%up:n=1% " ^& IF not "^!rain.y^!" == "39" (SET "rain=^!rain^!%\e%[%%2;%%1H%%3" ^& SET rain.par=^^^!rain.par^^^! "%%1 ^!rain.y^! %%3")))
SET $get_time=FOR /F "tokens=1-4 delims=:.," %%A in ("^!TIME: =0^!") DO SET /A
GOTO :EOF

----- Begin wsf script --->
<package>
  <job id="Music">
    <script language="JScript">
        var player = new ActiveXObject("WMPlayer.OCX.7");
        player.URL = WScript.arguments(1);
        player.settings.volume = 100;
        player.settings.setMode("loop", WScript.arguments(0) == "Track");
        player.controls.play();
        while (player.playState !== 1) {
            WScript.Sleep(100);
        }
    </script>
  </job>
</package>