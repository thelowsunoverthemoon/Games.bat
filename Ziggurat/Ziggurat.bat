<!-- : Begin batch script
::Credits to IcarusLives for improved "every" macro
::Lower volume megatron stop
::Correct ghoul
::Make spell check macro
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
MODE 40, 20
CD Music
CALL :MACROS
::°±²Û
::Û is head
::u is player, t is test
::only three attacks
::Slime Phoenix Seraphim MadWizard CrazedMage Minotaur Banshee
SET palette[1]=196;149
SET palette[2]=43;43
SET palette[3]=13;139
SET palette[4]=192;219
SET palette[5]=114;40
SET palette[6]=213;0
SET palette=13;139
::Since there is a specific order
SET "data[Slime]=%col:c=119;244;66%%back:n=1%/^\,3"
SET "data[Phoenix]=%col:c=237;122;0%%back:n=1%-Û-,2"
SET "data[Seraphim]=%col:c=109;123;135%%back:n=2%±²Û%back:n=1%%up:n=1%\%back:n=1%%down:n=2%/,5"
SET "data[Minotaur]=%back:n=2%<}Û{>,3"
SET "data[Chimera]=%col:c=188;20;20%%back:n=1%}Û{%col:c=117;186;20%-%back:n=3%%down:n=1%%col:c=119;24;9%| |%col:c=117;186;20%\_<,7"
SET "data[MadWizard]=%col:c=164;66;244%Û%back:n=1%%up:n=1%^,4"
SET "data[CrazedMage]=%col:c=237;122;0%%back:n=1%<²>%back:n=2%%down:n=1%v,3"
SET "data[InsaneMaiden]=%col:c=156;55;163%%back:n=1%:Û:%up:n=1%%back:n=3%/:\,4"
SET "data[CorruptKing]=%col:c=166;201;42%Û%up:n=1%%back:n=2%%col:c=168;16;16%\|/,5"
SET "data[LunaticConsort]=%col:c=47;11;91%%back:n=1%/Û\%back:n=2%%up:n=1%|%back:n=1%%up:n=1%|,6"
SET "data[Banshee]=%col:c=66;19;137%%back:n=1%²Û²%back:n=3%%down:n=1%±%next:n=1%±,3"
SET "data[Ghoul]=%col:c=0;136;18%%back:n=1%±Û±%back:n=3%%down:n=1%_²_,5"
SET "data[Totem]=Û%back:n=1%%down:n=1%²%back:n=1%%down:n=1%±%back:n=1%%down:n=1%°,1"
SET "data[Demon]=%col:c=160;25;25%%back:n=1%\Û/%back:n=3%%up:n=1%| |,6"
SET "data[ThePsychic]=%col:c=107;66;244%Û,7"
SET "design1=1 4 4 6 3 3 8 2 2 7 1 1"
SET "design2=2 2 2 3 3 3 4 4"
SET "design3=9 4 4 3 3 3 3"
SET sp[Protect]=1 4 3 3 2 2 1 1,104;171;196,Û
SET sp[Fireball]=1 1 1,255;168;63,²
SET sp[Ensnare]=9 8 7 9,145;113;82,±
SET sp[Lightning]=9 7 9 7 9,46;242;225,°
SET sp[StoneHammer]=1 1 7 9 6,168;171;175,Û
SET sp[Aqua]=3 3 3,81;173;198,°
SET sp[Tenebrae]=7 8 6 9 9 6 8,64;62;104,²
SET sp[Mask]=1 6 6 6,159;149;188,°
SET sp[DemonHand]=7 7 9 4 4 6 8,99;29;142,±
SET sp[DemonFeet]=8 4 4 6 8 8 7 7,99;29;142,±
SET sp[Penetrate]=8 4 3 9,66;80;244,Û
SET sp[Serpent]=3 2 2 3 3 4 4 4 3 3 2,105;198;51,²
SET sp[Unearth]=8 8 4 4 4 4 7,68;29;13,²
SET sp[Miasma]=7 9 7 8 8 6 6 6,150;172;209,°
SET sp[Flower]=6 7 9 8 7 6 8 6,35;237;45,±
SET sp[Entangle]=9 4 3 6 9 4,166;193;168,Û
SET sp[Dragon]=1 2 1 1 4 4 4 1 1,74;239;192,²
SET sp[Petrichor]=1 1 3 3 3 3,60;201;119,°
SET sp[CharmI]=7 7,170;255;0,±
SET sp[CharmII]=9 9,255;76;0,±
SET sp[CharmIII]=8 8,110;255;0,±
SET sp[CharmIV]=6 6,0;255;97,±
SET sp[IllusionI]=9 3 3 4 4 1 1 2,94;229;179,°
SET sp[IllusionII]=7 3 3 2 2 1 1 4,94;229;179,°
SET sp[SongOfTheMoon]=7 7 9 9 6 6 8 8,225;242;121,Û
SET sp[AstralResurgence]=8 6 6 9 9 9 7,156;206;179,Û
SET sp[CelestialOrb]=7 7 8 8 6 6 6 9 6 9 9 9 7 7 8,206;229;78,Û
SET sp[PrayerForLuna]=7 8 6 6 9 9 7,246;255;198,Û
SET "cl[Magician]=%col:c=51;88;147%²-|%back:n=1%%up:n=1%%ESC%[48;2;127;219;170m%col:c=255;255;255%_%back:n=1%%up:n=1%%ESC%[0m%col:c=255;255;255%_,10,CharmI CharmII CharmIII CharmIV IllusionI IllusionII"
SET "cl[LunarPriestess]=%col:c=156;206;179%_/%col:c=206;229;78%Û%col:c=156;206;179%\_%back:n=3%%up:n=1%|,1,SongOfTheMoon AstralResurgence CelestialOrb PrayerForLuna"
SET "cl[Necromancer]=%col:c=78;21;127%Û%back:n=1%%up:n=1%%col:c=255;255;255%*,4,DemonHand DemonFeet Miasma Tenebrae Mask Entangle"
SET "cl[Druid]=%col:c=215;244;66%%back:n=1%¼%col:c=124;214;21%±%col:c=215;244;66%È%back:n=2%%up:n=1%Ë,3,Flower Ensnare Serpent Dragon Unearth Petrichor"
SET "cl[Elemental]=%col:c=234;99;3%%back:n=1%~%col:c=255;255;255%Û%col:c=36;234;207%~%back:n=2%%up:n=1%%col:c=37;175;24%~%back:n=1%%down:n=2%%col:c=175;107;23%~,6,Protect Fireball StoneHammer Aqua Lightning Penetrate"
SET "bullet=%col:c=20;158;173%[!col:c=94;%palette%!#%col:c=20;158;173%] %col:c=20;158;173%"
FOR /F "tokens=2 delims=[]" %%Q in ('SET cl[') DO (
    SET "classes=!classes! %%Q"
)
CALL :ARRAY "%classes%" class classnum
FOR /L %%G in (1, 1, %classnum%) DO (
    SET "choice=!choice!%%G"
)
FOR %%A in ("dir[7]=-1 -1" "dir[1]=0 -1" "dir[9]=1 -1" "dir[2]=-1 0" "dir[5]=0 0" "dir[4]=1 0" "dir[8]=-1 1" "dir[3]=0 1" "dir[6]=1 1") DO (
    FOR /F "tokens=1-3 delims== " %%0 in ("%%~A") DO (
        SET "%%0="x[#]+=%%1", "y[#]+=%%2""
    )
)
ECHO %ESC%[?25l

:MENU
%kill%
%music:t s=Music UnicronMedley%
SET /A "round=enenum=0","y[t]=8","x[t]=6","y[u]=19","x[u]=10","energy=70"
SET "background="
TITLE Ziggurat
<NUL SET /P "=%ESC%[2J%ESC%[2;2HLowsun 2019%ESC%[9;15H%col:c=87;125;130%Û Zi%col:c=20;158;173%gg%col:c=87;125;130%ur%col:c=20;158;173%at Û%ESC%[12;15H[1] Campaign%ESC%[14;15H[2] Boss Rush%ESC%[16;15H[3] Palette"
CALL :MAKETEMP 25
CHOICE /C 123 /N >NUL
IF %errorlevel% EQU 1 (
    SET "enemlist=Slime Phoenix Seraphim Minotaur Chimera MadWizard CrazedMage InsaneMaiden CorruptKing LunaticConsort Banshee Ghoul Totem Demon ThePsychic"
) else IF %errorlevel% EQU 2 (
    SET "enemlist=Chimera LunaticConsort ThePsychic"
) else (
    GOTO :PALETTE
)
CALL :ARRAY "%enemlist%" enem enenum
<NUL SET /P "=%ESC%[2J%background%%col:c=87;125;130%%ESC%[8;14HChoose a Class%col:c=20;158;173%
FOR /L %%E in (1, 1, %classnum%) DO (
    FOR /F %%T in ('SET /A "%%E + 10"') DO (
        ECHO %ESC%[%%T;15H!bullet:#=%%E!!class[%%E]!
    )
)
FOR /L %%@ in (1, 1, 2) DO (
    FOR /F %%G in ('SET /A "44 + (%%@ * 50)"') DO (
        ECHO %ESC%[48;2;%%G;%palette%m!%ESC%[7;16H PLAYER %%@ %ESC%[0m
    )
    CHOICE /C %choice% /N >NUL
    SET "spellnum%%@="
    FOR /F %%Q in ("!errorlevel!") DO (
        FOR /F %%S in ("!class[%%Q]!") DO (
            FOR /F "tokens=1-4 delims=," %%D in ("!cl[%%S]!") DO (
                SET "spri[u%%@]=%%D"
                SET "hp[u%%@]=%%E"
                CALL :ARRAY "%%F" spell%%@ spellnum%%@
            )
        )
    )
)
FOR %%Q in ("%ESC%[9;4HHigh Priests, defend the Ziggurat^!%ESC%[10;3HYou have command over local spirits." "%ESC%[9;13HUse WASD to move.%ESC%[10;12HQ to cast spirits." "%ESC%[9;13HConserve your Energy%ESC%[10;8H10 energy is required to cast" "%ESC%[9;8HHit the head to cause damage%ESC%[10;13HUsually the center") DO (
    <NUL SET /P "=%ESC%[2J%background%%%~Q"
    PAUSE>NUL
)
::Some ugly code structure on my part. Adjusting it would require an overhaul of the entire system, which I was not gonna do...
%kill%
%music:t s=Music MegatronStopped%
GOTO :CREATE

:LOOP
FOR /L %%L in () DO (
    SET /A "count+=1"
    TITLE Health - !hp[u%class%]! %enemy% - !hp[%enemy%]!
    <NUL SET /P "=%ESC%[2J%background%%ESC%[2;2HRound %round%%ESC%[3;2HEnergy !energy!%ESC%[!y[%enemy%]!;!x[%enemy%]!H!spri[%enemy%]!%ESC%[!y[u]!;!x[u]!H!spri[u%class%]!%ESC%[%y[e]%;%x[e]%H!crystal!%ESC%[0m"
    FOR %%G in (!display!) DO (
        <NUL SET /P "=%%~G"
        %frame:#=100%
    )
    IF !energy! LEQ 0 (
        CALL :LOSE
    )
    SET "display="&SET "hitspot="
    CHOICE /C WASDQ /N >NUL
    FOR /F %%R in ("!errorlevel!") DO (
        IF %%R EQU 5 (
            IF !energy! GEQ 10 (
                ECHO %ESC%[15d%col:c=255;255;255%
                FOR /L %%G in (1, 1, 3) DO (
                    ECHO !bullet:#=%%G! !atk[%%G]!
                )
                ECHO !bullet:#=4! Go Back
                CHOICE /C 1234 /N >NUL
                FOR /F %%Q in ("!errorlevel!") DO (
                    IF %%Q EQU 4 (
                        CALL :LOOP
                    )
                    SET /A "energy-=10"
                    %dispseq% !atk[%%Q]! u
                )
                FOR %%H in (!hitspot!) DO (
                    %hurt% %%H %enemy% %enemy% CREATE
                )
            )
        ) else (
            SET /A !dir[%%R]:#=u!,"energy-=1"
            %behav[e]%
            %hurt% !y[u]!!x[u]! %enemy% u%class% LOSE
            IF !y[u]!.!x[u]! EQU !y[e]!.!x[e]! (
                SET "crystal="
                SET /A "y[e]=x[e]=100","energy+=30"
            )
            FOR %%H in (!hitspot!) DO (
                %hurt% %%H u u%class% LOSE
            )
        )
    )
)

:LOSE
TITLE Health - !hp[u]! %enemy% - !hp[%enemy%]!
%music:t s=Sound Death%
FOR %%G in (!display!) DO (
    <NUL SET /P "=%%~G"
    %frame:#=100%
)
<NUL SET /P "=%ESC%[10;16HYou lost^!"
CALL :MAKETEMP 20
PAUSE >NUL
GOTO :MENU

:PALETTE
SET "check=0"
ECHO %ESC%[2J%background%%ESC%[2;2H%col:c=20;158;173%Choose a Palette :
FOR /L %%R in (1, 1, 6) DO (
    SET /A "check+=6"
    <NUL SET /P "=%ESC%[5;!check!H%col:c=87;125;130%Û%%RÛ%back:n=1%%down:n=1%"
    FOR /L %%E in (1, 1, 9) DO (
        FOR /F "tokens=1-2 delims=," %%G in ('SET /A "54 + %%E0"^&ECHO ^,!palette[%%R]!') DO (
            <NUL SET /P "=%back:n=1%%down:n=1%!col:c=%%G;%%H!Û"
        )
    )
)
CHOICE /C 123456 /N>NUL
SET "palette=!palette[%errorlevel%]!"
SET "bullet=%col:c=20;158;173%[!col:c=94;%palette%!#%col:c=20;158;173%] %col:c=20;158;173%"
GOTO :MENU

:MAKETEMP
ECHO %ESC%[100m
FOR /L %%F in (1, 1, %1) DO (
    FOR /F %%G in ('SET /A "!RANDOM! * (9 - 1 + 1) / 32768 + 1"') DO (
        FOR /F %%C in ('SET /A "54 + %%G0"') DO (
            SET /A !dir[%%G]:#=t!
            SET "background=!background!%ESC%[!y[t]!;!x[t]!H!col:c=%%C;%palette%!Û%ESC%[1X"
            <NUL SET /P "=%ESC%[!y[t]!;!x[t]!H!col:c=%%C;%palette%!Û%ESC%[1X"
        )
    )
)
SET background=%ESC%[100m%background%%ESC%[0m
ECHO %ESC%[0m
GOTO :EOF

:CREATE
SET /A "round+=1","energy+=30","class=round %% 2"
IF %class% EQU 0 (
    SET "class=1"
) else (
    SET "class=2"
)
IF %round% GTR %enenum% (
    %kill%
    %music:t s=Music LightingDarkestHour%
    ECHO %ESC%[9;16H%col:c=244;220;66%Vi%col:c=255;102;102%ct%col:c=244;220;66%or%col:c=255;102;102%y^^!
    PAUSE >NUL
    GOTO :MENU
)
SET "list="&SET "listatk="&SET "display="
FOR /L %%L in (1, 1, 3) DO (
    FOR /F %%X in ('SET /A "!RANDOM! * (!spellnum%class%! - 1 + 1) / 32768 + 1"') DO (
        SET "listatk=!listatk! !spell%class%[%%X]!"
    )
)
CALL :ARRAY "%listatk%" atk list
SET "crystal=%col:c=255;255;255%%ESC%[48;2;95;234;68m+"
SET enemy=!enem[%round%]!
SET behav[e]=!behav[%enemy%]!
FOR /F "tokens=1-2 delims=," %%F in ("!data[%enemy%]!") DO (
    SET "spri[%enemy%]=%%F"
    SET "hp[%enemy%]=%%G"
)
SET /A "y[%enemy%]=10","x[%enemy%]=20","x[e]=!RANDOM! * (40 - 1 + 1) / 32768 + 1","y[e]=!RANDOM! * (20 - 1 + 1) / 32768 + 1"
GOTO :LOOP

:ARRAY
FOR %%A in (%~1) DO (
    SET /A "%3+=1"
    SET "%2[!%3!]=%%A"
)
GOTO :EOF

:MACROS
FOR /F %%A in ('ECHO prompt $E^| cmd') DO SET "ESC=%%A"
SET "kill=TASKKILL /F /IM CSCRIPT.exe >NUL 2>&1"
SET "every=1/(((~(0-(count %% #))>>31)&1)&((~((count %% #)-0)>>31)&1))"
SET "music=START /B CSCRIPT //NOLOGO "%~f0?.wsf" //JOB:t s.mp3 >NUL"
SET frame=FOR /L %%J in (1,#,1000000) DO REM
SET col=%ESC%[38;2;cm
SET up=%ESC%[nA
SET down=%ESC%[nB
SET back=%ESC%[nD
SET next=%ESC%[nC
SET ^"LF=^

^" Above empty line is required - do not remove
SET ^"\n=^^^%LF%%LF%^%LF%%LF%^^"
::sequence, var to use off, colour, character
SET dispseq=FOR %%# in (1, 1, 2) DO IF %%#==2 ( FOR /F "tokens=1-2" %%Y in ("^!args^!") DO (%\n%
    SET /A "x[t]=^!x[%%Z]^!","y[t]=^!y[%%Z]^!"%\n%
    ^!music:t s=Sound %%Y^! %\n%
    FOR /F "tokens=1-4 delims=," %%A in ("^!sp[%%Y]^!") DO (%\n%
        FOR %%G in (%%~A) DO (%\n%
            SET /A ^^!dir[%%G]:#=t^^!%\n%
            SET "hitspot=^!hitspot^! ^!y[t]^!^!x[t]^!"%\n%
            SET display=^^!display^^! "^!col:c=%%B^!%ESC%[^!y[t]^!;^!x[t]^!H%%C"%\n%
        )%\n%
    )%\n%
)) else SET args=

::type, enemy
SET checktrack=FOR %%# in (1, 1, 2) DO IF %%#==2 ( FOR /F "tokens=1-2" %%A in ("^!args^!") DO (%\n%
    IF ^^!%%A[%%B]^^! LSS ^^!%%A[u]^^! (%\n%
        SET /A %%A[%%B]+=1%\n%
    ) else IF ^^!%%A[%%B]^^! GTR ^^!%%A[u]^^! (%\n%
        SET /A %%A[%%B]-=1%\n%
    )%\n%
)) else SET args=
::compare, whichhp, screen
SET hurt=FOR %%# in (1, 1, 2) DO IF %%#==2 ( FOR /F "tokens=1-4" %%A in ("^!args^!") DO (%\n%
    IF %%A EQU ^^!y[%%B]^^!^^!x[%%B]^^! (%\n%
        SET /A hp[%%C]-=1%\n%
        IF ^^!hp[%%C]^^! LEQ 0 (%\n%
            CALL :%%D%\n%
        )%\n%
    )%\n%
)) else SET args=
::Enemy Behaviours
CALL BEHAVIOURS.bat
GOTO :EOF

----- Begin wsf script --->
<package>
  <job id="Sound">
    <script language="VBScript">
      Set Sound = CreateObject("WMPlayer.OCX.7")
      Sound.URL = WScript.Arguments.Item(0)
      Sound.Controls.play
      do while Sound.currentmedia.duration = 0
      Wscript.sleep 100
      loop
      Wscript.sleep (int(Sound.currentmedia.duration)+1)*1000
    </script>
  </job>
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
