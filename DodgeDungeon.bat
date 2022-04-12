::Editted and improved by dbenham
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
MODE 60, 25

IF not "%~1" == "" (
    GOTO :%~1
)

FOR /F %%A in ('ECHO prompt $E^| cmd') DO SET "ESC=%%A"
SET "score=0"
SET mv[W]="y[#]-=1","x[#]+=1"
SET mv[A]="x[#]-=3"
SET mv[S]="y[#]+=1","x[#]-=1"
SET mv[D]="x[#]+=3"
SET up=%ESC%[nA
SET dn=%ESC%[nB
SET bk=%ESC%[nD
SET nx=%ESC%[nC
SET col=%ESC%[38;2;cm
SET framerate=FOR /L %%J in (1,40,1000000) DO REM
SET every="1/(((~(0-(count %% #))>>31)&1)&((~((count %% #)-0)>>31)&1))"
DEL "%~dpn0.quit" 2>nul
ECHO %ESC%[?25l

:MENU
TITLE Dodge Dungeon
ECHO %ESC%[2J%ESC%[0m%ESC%[2;4HLowsun 2019 (help by dbenham)%ESC%[7;10H__   __   __   __   ___%dn:n=1%%bk:n=24%^|  \ /  \ ^|  \ / _` ^|__%dn:n=1%%bk:n=23%^|__/ \__/ ^|__/ \__^> ^|___%dn:n=1%%bk:n=23%%col:c=135;245;233%^<Í D U N G E O N Í^>%ESC%[0m%ESC%[15;9H1) Large%dn:n=2%%ESC%[9G2) Medium%dn:n=2%%ESC%[9G3) Small%dn:n=2%%ESC%[9GQ) Quit%ESC%[11;10HSCORE : !score!
CHOICE /C 123Q /N>NUL
IF %errorlevel% EQU 4 EXIT /B
SET /A "grid[x]=16-(3*%errorlevel%)","grid[y]=14-(3*%errorlevel%)","grid[bk]=(grid[x]*3)+1","score=0","p[rt]=15","margin=20-grid[x]","x[u]=18","y[u]=6"
FOR /L %%X in (1, 1, %grid[x]%) DO (
    SET "grid[xlen]=!grid[xlen]!/_/"
    SET "grid[tlen]=!grid[tlen]!__ "
)
SET "grid[disp]=!nx:n=%grid[y]%!%grid[tlen]%%dn:n=1%!bk:n=%grid[bk]%!"
FOR /L %%Y in (1, 1, %grid[y]%) DO (
    SET "grid[disp]=!grid[disp]!%grid[xlen]%%dn:n=1%!bk:n=%grid[bk]%!"
)


IF exist "%temp%\%~n0_signal.txt" (
    DEL "%temp%\%~n0_signal.txt"
)
"%~F0" CONTROL >"%temp%\%~n0_signal.txt" | "%~F0" GAME <"%temp%\%~n0_signal.txt" & SET /A "score=!errorlevel!" & SET "grid[xlen]=" & SET "grid[tlen]="
GOTO :MENU

:GAME
FOR /L %%# in () DO (
    SET /P "rec="
    TITLE Score : !score!
    ECHO %ESC%[2J%col:c=222;218;206%%ESC%[5;%margin%H%grid[disp]%%ESC%[1B%ESC%[%margin%GUse WASD to move%col:c=135;245;233%!p[dp]!%col:c=222;201;131%!p[jp]!%ESC%[!y[u]!;!x[u]!Hß%bk:n=1%%up:n=1%Û
    SET /A "count+=1"
    SET "p[jp]="
    FOR %%G in (!rec!) DO (
        (SET /A "y[t]=y[u]","x[t]=x[u]",!mv[%%G]:#=t!,"y[d]=y[t]","x[d]=x[t]",!mv[%%G]:#=t!,"1/((((5-y[t])>>31)&1)&(((y[t]-(grid[y]+6))>>31)&1)&((((((grid[y]-(y[t]-5)))+%margin%)-x[t])>>31)&1)&(((x[t]-((((grid[y]-(y[t]-5)))+%margin%)+(3*grid[x])))>>31)&1))" 2>NUL) && (
            SET "p[jp]=%col:c=151;98;191%%ESC%[!y[d]!;!x[d]!Hß%bk:n=1%%up:n=1%Û%ESC%[0m"
            SET /A "y[u]=y[t]","x[u]=x[t]"
        )
    )
    FOR %%Q in (!p[rt]!) DO (
        2>NUL SET /A !every:#=%%Q! && (
            SET /A "p[ct]+=1","d[y]=(!RANDOM!*grid[y]/32768+1)+5","d[x]=((grid[y]-(d[y]-5)))+5","d[max]=((grid[y]-(d[y]-5)))+(%margin%+1)+(3*grid[x])"
            SET /A "p[!p[ct]!]=d[max]<<16|d[y]<<8|d[x]"
            SET "p[li]=!p[li]! [!p[ct]!]"
        )
    )
    2>NUL SET /A !every:#=50! && (
        IF !p[rt]! GTR 2 (
            SET /A "p[rt]-=1"
        )
    )
    2>NUL SET /A !every:#=2! && (
        SET "p[dp]="
        FOR %%Q in (!p[li]!) DO (
            SET /A "d[x]=(p%%Q>>0&255)+3","d[y]=(p%%Q>>8&255)","d[max]=(p%%Q>>16&255)","p%%Q=d[max]<<16|d[y]<<8|d[x]"
            IF !d[x]! EQU !d[max]! (
                SET /A "score+=1"
                SET "p[li]=!p[li]:%%Q=!"
            ) else (
                SET "p[dp]=!p[dp]!%ESC%[!d[y]!;!d[x]!H^>%bk:n=2%Í"
            )
            IF "!x[u]!;!y[u]!" == "!d[x]!;!d[y]!" (
                ECHO %ESC%[2J%col:c=222;218;206%%ESC%[5;%margin%H%grid[disp]%%ESC%[1B%ESC%[%margin%GOuch^^! Press any of WASD to continue%col:c=135;245;233%!p[dp]!%col:c=219;29;55%%up:n=1%Û
                copy nul "%~dpn0.quit" >nul
                EXIT !score!
            )
        )
    )
    SET "rec="
    %framerate%
)

:CONTROL
FOR /L %%C in () do (
    FOR /F "tokens=*" %%A in ('CHOICE /C:WASD /N') DO (
        IF exist "%~dpn0.quit" DEL "%~dpn0.quit" & exit
        <NUL SET /P ".=%%A"
    )
)
GOTO :EOF