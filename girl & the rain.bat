<!-- : Begin batch script
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
TITLE girl ^& the rain
MODE 34,30
FOR %%M in (Rain ErikSatieGymnopedies) DO (
    START /B CSCRIPT //NOLOGO "%~f0?.wsf" //JOB:Music %%M.mp3
)
::Clear out useless variables
FOR /F "tokens=1 delims==" %%G in ('SET') DO (
    IF not "%%G" == "Path" (
        SET "%%G="
    )
)
FOR /F %%A in ('ECHO prompt $E^| cmd') DO SET "ESC=%%A"
(SET \n=^
%=EMPTY=%
)
SET "col=%ESC%[38;2;cm"
ECHO %ESC%[?25l

:MENU
SET /A "gradient=30","rand=!RANDOM!*(3-1+1)/32768+1","chance=!RANDOM!*(15-5+1)/32768+5"
IF %rand% EQU 1 (
    SET "rain[all]=116;127;193-84;52;226-u seeing the rain? :|/ye, lots of it/i think it's beautiful./me too ^^_^^/wanna meet up at the cafe?/the usual ;)"
) else IF %rand% EQU 2 (
    SET "rain[all]=181;53;198-103;214;229-God, what is this?/Celestial Rain./It's stunning./Your descendants will not see it./Adam, come quickly^^^^^^^^^^^^^^^!/And God saw that it was good."
) else (
    SET "rain[all]=86;135;115-66;244;173-Look, it's raining^^^^^^^^^^^^^^^!/Again?/Yes^^^^^^^^^^^^^^^!/I'll have to put in the clothes./Can we watch?/.../Please?/Oh, alright."
)
FOR /F "tokens=1-3 delims=-" %%H in ("%rain[all]%") DO (
    SET "rain[start]=%%H"
    SET "rain[end]=%%I"
    SET "dialogue=%%J"
)
FOR /F "tokens=1-6 delims=;" %%A in ("%rain[start]%;%rain[end]%") DO (
    SET "pair[1]=%%A"
    SET "pair[2]=%%B"
    SET "pair[3]=%%C"
    SET /A "dist[1]=(%%D-%%A)/%gradient%","dist[2]=(%%E-%%B)/%gradient%","dist[3]=(%%F-%%C)/%gradient%"
)
ECHO %ESC%[2J%ESC%[1;1HLowsun 2019%ESC%[10;10Hgirl ^& the rain%ESC%[11d
PAUSE>NUL
FOR %%L in ("!\n!") DO (
    FOR /F "delims=" %%X in ("!dialogue:/=%%~L!") DO (
        SET /A "count+=1","rate=count %% 2"
        IF !rate! EQU 0 (
            ECHO !col:c=%rain[start]%!%%X
        ) else (
            ECHO !col:c=%rain[end]%!%%X
        )
        PAUSE>NUL
    )
)
FOR /L %%G in (1, 1, 34) DO (
    SET /A "rand=!RANDOM!*(30-1+1)/32768+1"
    SET "ground=!ground!%col:c=[1];[2];[3]%Û"
    FOR /L %%E in (1, 1, 3) DO (
        SET /A "colour=pair[%%E]+(rand*dist[%%E])""
        FOR /F %%X in ("!colour!") DO (
            SET "ground=!ground:[%%E]=%%X!"
        )
    )
)
ECHO %ESC%[30d%ground%

:RAIN
FOR /L %%# in (1, 1, 1000) DO (
    SET /A "rand=!RANDOM!*(33-1+1)/32768+1","rate=!RANDOM!*(%chance%-1+1)/32768+1"
    IF !rate! EQU 1 (
        SET /A "total[par]+=1"
        SET "par[!total[par]!]=!rand!;1"
        SET "total[rain]=!total[rain]! [!total[par]!]"
    )
    FOR %%R in (!total[rain]!) DO (
        FOR /F "tokens=1-2 delims=;" %%A in ("!par%%R!") DO (
            SET /A "new=%%B+1"
            IF !new! EQU 30 (
                SET /A "splat=%%A-1","new=%%B-1"
                SET "par%%R="
                SET "rain=!rain!%ESC%[!new!;!splat!H\ /"
                SET "total[rain]=!total[rain]:%%R=!"
            ) else (
                SET "par%%R=%%A;!new!"
                SET "rain=!rain!%ESC%[%%B;%%AH%col:c=[1];[2];[3]%Þ"
                FOR /L %%E in (1, 1, 3) DO (
                    SET /A "colour=pair[%%E]+((%%B-(30-%%B))*dist[%%E])"
                    FOR /F %%X in ("!colour!") DO (
                        SET "rain=!rain:[%%E]=%%X!"
                    )
                )
            )
        )
    )
    <NUL SET /P "=%ESC%[28;34H%ESC%[1J!rain!"
    SET "rain="
    FOR /L %%J in (1,100,1000000) DO REM
)
SET "total[rain]="
GOTO :MENU

----- Begin wsf script --->
<package>
  <job id="Music">
    <script language="VBScript">
      Set Sound = CreateObject("WMPlayer.OCX.7")
      Sound.URL = WScript.Arguments.Item(0)
      Sound.settings.volume = 100
      Sound.settings.setMode "loop", True
      Sound.Controls.play
      While Sound.playState <> 1
      WScript.Sleep 100
      Wend
    </script>
  </job>
</package>