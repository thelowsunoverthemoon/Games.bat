<!-- : Begin batch script
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
IF not "%1" == "" (
    GOTO :%1
)

MODE 51, 30
(CHCP 65001)>NUL

CALL :CONSTANTS
CALL :MACROS
CALL :LEVELDATA

ECHO %ESC%[?25l
(DEL /F /Q "%~dpn0.quit") 2>NUL

CALL :LOADSAVE
    
:START
"%~F0" CONTROL >"%temp%\%~n0_signal.txt" | "%~F0" MENU <"%temp%\%~n0_signal.txt"

:MAIN
SETLOCAL

CALL :SETUP %level%

IF %dia[before]% EQU 0 (
    CALL :DIALOGUE %level%
    SET "dia[before]=1"
)
IF %level% EQU 1 (
    IF %redo% EQU 0 (
        IF %finish% EQU 0 (
            ECHO "%ESC%[2J%ESC%[3;1H%info%"%ESC%[D 
            (CHOICE /C:A /N)>NUL
        )
    )
) else IF %level% EQU 7 (
    (ECHO 1 1)>"%~n0.bat:level"
    ENDLOCAL & SET "level=1" & SET "dia[before]=1" & SET "finish=1"
    GOTO :START
)

"%~F0" CONTROL >"%temp%\%~n0_signal.txt" | "%~F0" GAME <"%temp%\%~n0_signal.txt" & SET "result=!ERRORLEVEL!"
SET "redo=0"
IF %result% EQU 1 (
    SET /A "dia[before]=redo=0", "level+=1"
) else IF %result% EQU 2 (
    SET "redo=1"
)
(ECHO %level% %finish%)>"%~n0.bat:level"
ENDLOCAL & SET "level=%level%" & SET "redo=%redo%" & SET "dia[before]=%dia[before]%"
GOTO :MAIN

:MENU
TITLE neocircuits
(TASKKILL /F /IM CSCRIPT.exe)>NUL 2>&1
IF %finish% EQU 1 (
    %music:t s=Music end%
) else (
    %music:t s=Music title%
)
SET "frame=0"
FOR /L %%# in () DO (
    ECHO %ESC%[2J!par[disp]!%col:c=183;188;196%%ESC%[2;3HLowsun 2022%ESC%[11;12H%logo%%ESC%[15;18H%col:c=142;83;184%press [A] to play
    SET /P "input="
    IF defined input (
        ECHO %ESC%[15;17Hpress [A] to confirm
        (COPY NUL "%~dpn0.quit")>NUL
        EXIT
    )
    SET /A "d[num]=frame %% 30"
    IF !d[num]! EQU 0 (
        SET "par[disp]="
        SET /A "d[num]=frame %% 150"
        IF !d[num]! EQU 0 (
            SET /A "d[y]=!RANDOM! %% 30 + 1", "d[x]=!RANDOM! %% 50 + 1", "d[num]=!RANDOM! %% 4 + 1", "d[min]=!RANDOM! %% 3", "par[num]+=1"
            SET "par[list]=!par[list]! [!par[num]!]"
            SET "par[!par[num]!]=!d[y]! !d[x]! !d[num]! !d[min]!"
        )
        FOR %%G in (!par[list]!) DO (
            FOR /F "tokens=1-4" %%A in ("!par%%G!") DO (
                SET /A "d[x]=%%B + 1"
                SET "par[disp]=!par[disp]!%ESC%[%%A;!d[x]!H!sym[%%C]!%ESC%[%%DD%ESC%[D!par[tail]:~0,%%D!
                IF !d[x]! GEQ 50 (
                    SET "par%%G="
                    SET "par[list]=!par[list]:%%G=!"
                ) else (
                    SET "par%%G=%%A !d[x]! %%C %%D"
                )
            )
        )
    )
    SET /A "frame+=1"
)

:DIALOGUE <level>
(TASKKILL /F /IM CSCRIPT.exe)>NUL 2>&1
%music:t s=Music dia%
ECHO %ESC%[2J%ESC%[1;1H
SET "dia[type]=print"
FOR %%G in (!dia[%1]!) DO (
    IF "%%~G" == "p" (
        ECHO/
        SET "dia[type]=print"
    ) else IF "%%~G" ==  "t" (
        SET "dia[type]=type"
    ) else IF "%%~G" ==  "s" (
        %framerate:#=2%
        ECHO %col:c=183;188;196%%ESC%[B%ESC%[22G. . . . .
        %framerate:#=2%
    ) else (
        IF "!dia[type]!" == "print" (
            SET "text=%%~G"
            ECHO   %col:c=183;188;196%!text:@=?!
            PAUSE>NUL
        ) else (
            <NUL SET /P "=%col:c=105;198;207%%ESC%[3G"
            SET "d[var]=%%~G"
            SET "d[var]=!d[var]: =# !"
            FOR %%A in (a b c d e f g h i j k l m n o p q r s t u v w x y z $ 5) DO (
                SET "d[var]=!d[var]:%%A=%%A !"
            )
            FOR %%L in (!d[var]!) DO (
                IF "%%L" == "@" (
                    <NUL SET /P "=?"
                ) else IF "%%L" == "#" (
                    <NUL SET /P "=.!BS! "
                ) else IF "%%L" == "$" (
                    <NUL SET /P "=,"
                ) else (
                    <NUL SET /P "=%%L"
                )
                %framerate:#=50%
            )
        )
        <NUL SET /P "=%ESC%[S"
    )
)
ECHO %col:c=142;83;184%%ESC%[B%ESC%[16Gpress [A] to continue
PAUSE>NUL
GOTO :EOF

:GAME
IF %redo% EQU 0 (
    (TASKKILL /F /IM CSCRIPT.exe)>NUL 2>&1
    %music:t s=Music game%
)
SET "disp[type]=play"

ECHO %ESC%[2J%ESC%[%off[y]%;%off[x]%H%map[disp]%%ESC%[0m%ESC%[%off[y]%;%off[x]%H%ESC%[D%ESC%[2A%bord[full]%%ESC%[26G%bord[con][top]%%ESC%[21;1H%overlay%%ESC%[1;26H%bord[con][bot]%%col:c=142;83;184%%objective%%ESC%[27;3H%box%
FOR /L %%# in () DO (
    ECHO !par[disp]!%ESC%[28;5H%col:c=83;194;190%!dia[disp]!!disp[new]!!dia[hide]!%col:c=183;188;196%%ESC%[2;3HTurn !turn!%stat%
    SET "disp[new]="
    SET /P "input="
    IF "!disp[type]!" == "info" (
        IF defined input (
            ECHO %ESC%[?1049l
            SET "disp[type]=play"
            SET "dia[hide]="
        )
    ) else (
        IF "!disp[type]!" == "play" (
            IF defined input (
                IF "!input!" == "P" (
                    FOR %%G in (map[!cur[y]!][!cur[x]!]) DO (
                        IF !%%G! NEQ 0 (
                            IF defined prev[disp] (
                                SET "prev[disp]="
                                SET "disp[type]=anim"
                               
                                SET /A "d[num]=(cur[y] - prev[y]) + (cur[x] - prev[x])"
                                IF !d[num]! NEQ 0 (
                                    SET /A "d[x]=(cur[x] - 1) * 2 + off[x]", "d[y]=(cur[y] - 1) * 2 + off[y] - 1", "turn-=1", "dia[print]=0"
                                    SET "dia[disp]="
                                    SET "disp[new]=!disp[new]!%ESC%[!d[j]!;!d[i]!H%cur[erase]%%ESC%[!d[y]!;!d[x]!H%cur[disp]%%ESC%[28;5H                                            "

                                    CALL :SWAP !prev[y]! !prev[x]! !cur[y]! !cur[x]!
                                    IF !turn! EQU 0 (
                                        IF "!mode!" == "volt" (
                                            ECHO %ESC%[3;11H!volt!
                                            IF !volt! LSS %full% (
                                                CALL :END lose
                                            ) else (
                                                CALL :END win
                                            )
                                        ) else IF "!mode!" == "circ" (
                                            IF not defined coord (
                                                CALL :END win
                                            ) else (
                                                CALL :END lose
                                            )
                                        ) else (
                                            SET "d[num]=0"
                                            FOR /L %%Y in (1, 1, %map[y]%) DO (
                                                FOR /L %%X in (1, 1, %map[x]%) DO (
                                                    SET /A "d[num]+=map[%%Y][%%X]"
                                                )
                                            )
                                            IF !d[num]! EQU 0 (
                                                CALL :END win
                                            ) else (
                                                CALL :END lose
                                            )
                                        )
                                    )
                                    IF "!mode!" == "circ" (
                                        CALL :DISPCIRC
                                    )
                                )
                            ) else (
                                SET "prev[disp]=%cur[prev]%"
                                SET /A "prev[y]=cur[y]", "prev[x]=cur[x]"
                            )
                        )
                    )
                ) else IF "!input!" == "I" (
                    SET "disp[type]=info"
                    SET "dia[hide]=%ESC%[28;1H%ESC%[2K"
                    SET "par[disp]="
                    SET "disp[new]=%ESC%[2J%ESC%[3;1H%info%"
                    ECHO %ESC%[?1049h%ESC%[?25l
                ) else IF "!input!" == "R" (
                    CALL :END none
                ) else (
                    FOR %%Q in (!input!) DO (
                        SET /A "d[x]=cur[x]", "d[y]=cur[y]", "!mov[%%Q]!"
                        IF !d[x]! GEQ 1 IF !d[x]! LEQ %map[x]% (
                            IF !d[y]! GEQ 1 IF !d[y]! LEQ %map[y]% (
                                SET /A "cur[x]=(cur[x] - 1) * 2 + off[x]", "cur[y]=(cur[y] - 1) * 2 + off[y] - 1", "d[i]=(prev[x] - 1) * 2 + off[x]", "d[j]=(prev[y] - 1) * 2 + off[y] - 1"
                                SET "disp[new]=!disp[new]!%ESC%[!cur[y]!;!cur[x]!H%cur[erase]%%ESC%[!d[j]!;!d[i]!H!prev[disp]!"
                                SET /A "cur[x]=d[x]", "cur[y]=d[y]", "d[x]=(d[x] - 1) * 2 + off[x]", "d[y]=(d[y] - 1) * 2 + off[y] - 1"
                                SET "disp[new]=!disp[new]!%col:c=255;255;255%%ESC%[!d[y]!;!d[x]!H%cur[disp]%"
                            )
                        )
                    )
                )
                SET "input="
            )
        ) else (
            SET /A "d[num]=frame %% 20"
            IF !d[num]! EQU 0 (
                FOR /F "tokens=1 delims=$" %%A in ("!disp[list]!") DO (
                    SET "disp[new]=!disp[new]!%%A"
                    SET "disp[list]=!disp[list]:*%%A=!"
                )
                IF "!disp[list]!" == "" (
                    IF "!mode!" == "circ" (
                        CALL :DISPCIRC
                    )
                    SET "disp[type]=play"
                )

            )
        )
        SET /A "d[num]=frame %% 20"
        IF !d[num]! EQU 0 (
            IF !dia[print]! EQU 0 (
                FOR /F "tokens=1-2" %%A in ("!turn! !dia[num]!") DO (
                    SET "dia[disp]=!ing[%%A]:~0,%%B!"
                    IF "!dia[disp]!" == "!ing[%%A]!" (
                        SET /A "dia[print]=dia[num]=1"
                    ) else (
                        SET /A "dia[num]+=1"
                    )
                )

            )
            SET "par[disp]="
            SET /A "d[num]=frame %% 140"
            IF !d[num]! EQU 0 (
                SET /A "d[y]=!RANDOM! %% 20 + 1", "d[x]=(!RANDOM! %% (off[adj] - 2)) + ((!RANDOM! %% 2) * (off[x] + (map[x] * 2) + 4))", "d[num]=!RANDOM! %% 4 + 1", "d[min]=!RANDOM! %% 3", "par[num]+=1"
                SET "par[list]=!par[list]! [!par[num]!]"
                SET "par[!par[num]!]=!d[y]! !d[x]! !d[num]! !d[min]!"
            )
            FOR %%G in (!par[list]!) DO (
                FOR /F "tokens=1-4" %%A in ("!par%%G!") DO (
                    SET /A "d[x]=%%B + 1"
                    SET "par[disp]=!par[disp]!%ESC%[%%A;%%BH %ESC%[%%DD%ESC%[D!par[tail][era]:~0,%%D!%ESC%[%%A;!d[x]!H!sym[%%C]!%ESC%[%%DD%ESC%[D!par[tail]:~0,%%D!
                    IF !d[x]! EQU %off[adj]% (
                        SET "par%%G="
                        SET "par[disp]=!par[disp]!%ESC%[%%A;!d[x]!H %ESC%[%%DD%ESC%[D!par[tail][era]:~0,%%D!
                        SET "par[list]=!par[list]:%%G=!"
                    ) else IF !d[x]! GEQ 50 (
                        SET "par%%G="
                        SET "par[disp]=!par[disp]!%ESC%[%%A;!d[x]!H %ESC%[%%DD%ESC%[D!par[tail][era]:~0,%%D!
                        SET "par[list]=!par[list]:%%G=!"
                    ) else (
                        SET "par%%G=%%A !d[x]! %%C %%D"
                    )
                )
            )
        )  
        SET /A "frame+=1"
    )

)

:DISPCIRC
FOR %%C in (%coord%) DO (
    FOR /F "tokens=1-2 delims=-" %%A in ("%%C") DO (
        FOR %%E in (!map[%%A][%%B]!) DO (
            SET /A "d[x]=(%%B - 1) * 2 + off[x] + 1", "d[y]=(%%A - 1) * 2 + off[y]"
            SET "disp[new]=!disp[new]!%ESC%[48;2;255;255;255m%ESC%[!d[y]!;!d[x]!H!sym[%%E]!%ESC%[0m"
        )
    )
)
GOTO :EOF
                          
:END <type>
SET /A "d[x]=(cur[x] - 1) * 2 + off[x]", "d[y]=(cur[y] - 1) * 2 + off[y] - 1"
ECHO %disp[new]%%ESC%[%d[y]%;%d[x]%H%cur[erase]%
FOR /L %%Y in (1, 1, %map[y]%) DO (
    FOR /L %%X in (1, 1, %map[x]%) DO (
        SET /A "d[x]=(%%X - 1) * 2 + off[x] + 1", "d[y]=(%%Y - 1) * 2 + off[y]"
        ECHO %ESC%[!d[y]!;!d[x]!H 
        %framerate:#=75%
    )
)
SET "d[y]=4"
ECHO %col:c=183;188;196%%ESC%[2;3HTurn %turn%%ESC%[48;2;115;109;109m
IF "%1" == "win" (
    ECHO %col:c=176;243;247%
    SET "d[var]=C O M P L E T E"
) else IF "%1" == "none" (
    ECHO %ESC%[0m%ESC%[23;14H   press [A] to continue  
    (COPY NUL "%~dpn0.quit")>NUL
    EXIT 2
) else (
    ECHO %col:c=250;105;105%
    SET "d[y]=5"
    SET "d[var]=F A I L U R E"
)
FOR %%G in (%d[var]%) DO (
    ECHO %ESC%[!d[y]!;25H %%~G %ESC%[B%ESC%[3D   %ESC%[2A%ESC%[3D   
    SET /A "d[y]+=2"
)
ECHO %ESC%[0m%ESC%[23;14H   press [A] to continue  
(COPY NUL "%~dpn0.quit")>NUL
IF "%1" == "win" (
    EXIT 1
) else (
    EXIT 0
)

:SWAP <y> <x> <j> <i>
SET /A "s[y]=%3 - %1", "s[x]=%4 - %2"
SET "s[char][1]=!map[%1][%2]!"
SET "s[char][2]=!map[%3][%4]!"
IF "!s[y]:-=!" == "1" (
    IF "!s[x]!" == "0" (
        CALL :DISPSWAP %1 %2 %3 %4
        
        CALL :CHECKFULL !s[char][1]! %2 %1 !s[y]! x
        CALL :CHECKPART !s[char][1]! %1 %2 !s[y]! y
        SET /A "s[rev]=s[y] * -1"
        CALL :CHECKFULL !s[char][2]! %4 %3 !s[rev]! x
        CALL :CHECKPART !s[char][2]! %3 %4 !s[rev]! y

        CALL :SHIFTMOV
        
        CALL :CHECKBLOCK
    )
) else IF "!s[x]:-=!" == "1" (
    IF "!s[y]!" == "0" (
        CALL :DISPSWAP %1 %2 %3 %4
        CALL :CHECKFULL !s[char][1]! %1 %2 !s[x]! y
        CALL :CHECKPART !s[char][1]! %2 %1 !s[x]! x

        SET /A "s[rev]=s[x] * -1"
        CALL :CHECKFULL !s[char][2]! %3 %4 !s[rev]! y
        CALL :CHECKPART !s[char][2]! %4 %3 !s[rev]! x
        
        CALL :SHIFTMOV
        
        CALL :CHECKBLOCK
    )
)

GOTO :EOF

:CHECKFULL <char> <start> <const> <dir> <type>
SET /A "d[min]=%2 - 2", "d[max]=%2 + 2", "d[check]=%3 + %4"

IF %d[min]% LSS 1 (
    SET "d[min]=1"
) else IF %d[max]% GTR !map[%5]! (
    SET "d[max]=!map[%5]!"
)

SET /A "prev=1", "comb=max[num]=max[root]=root=0"
IF "%5" == "x" (
    FOR /L %%L in (%d[min]%, 1, %d[max]%) DO (
        IF "!map[%d[check]%][%%L]!" == "%1" (
            IF !comb! EQU 0 (
                SET "root=%%L"
            )
            SET /A "comb+=1"
            IF !comb! GTR !max[num]! (
                SET /A "max[root]=root", "max[num]=comb"
            )
        ) else (
            SET /A "comb=root=0"
        )
    )
) else (
    FOR /L %%L in (%d[min]%, 1, %d[max]%) DO (
        IF "!map[%%L][%d[check]%]!" == "%1" (
            IF !comb! EQU 0 (
                SET "root=%%L"
            )
            SET /A "comb+=1"
            IF !comb! GTR !max[num]! (
                SET /A "max[root]=root", "max[num]=comb"
            )
        ) else (
            SET /A "comb=root=0"
        )
    )
)
IF !max[num]! GEQ 3 (
    CALL :SETALTER %d[check]% %max[root]% %max[num]% %5
)


GOTO :EOF

:CHECKBLOCK
SET /A "d[min]=shift[x] - 2", "d[max]=shift[x] + shift[w] + 1"
IF %d[min]% LSS 1 (
    SET "d[min]=1"
)
IF %d[max]% GTR %map[x]% (
    SET "d[max]=%map[x]%"
)
FOR /L %%Y in (1, 1, %shift[h]%) DO (
    SET /A "comb[max]=1", "prev=-1"
    FOR /L %%X in (%d[min]%, 1, %d[max]%) DO (
        IF "!map[%%Y][%%X]!" == "0" (
            SET /A "comb[max]=1", "prev=map[%%Y][%%X]", "comb[root]=%%X"
        ) else (
            IF "!map[%%Y][%%X]!" == "!prev!" (
                SET /A "comb[max]+=1"
            ) else (
                IF !comb[max]! LSS 3 (
                    SET /A "comb[max]=1", "prev=map[%%Y][%%X]", "comb[root]=%%X"
                )
            )
        )
    )
    IF !comb[max]! GEQ 3 (
        SET /A "d[num]=comb[root] + comb[max] - 1", "d[y]=%%Y - 1"
        FOR /L %%G in (!comb[root]!, 1, !d[num]!) DO (
            SET "alter[!d[y]!][%%G]=1"
        )
    )

)
SET /A "d[y]=shift[h] + 2"
IF %d[y]% GTR %map[y]% (
    SET "d[y]=%map[y]%"
)
FOR /L %%X in (%shift[x]%, 1, %d[max]%) DO (
    SET /A "comb[cur]=1", "comb[max]=0", "prev=-1"
    FOR /L %%Y in (1, 1, %d[y]%) DO (
        IF "!map[%%Y][%%X]!" == "0" (
            SET /A "comb[cur]=1", "prev=map[%%Y][%%X]"
        ) else (
            IF "!map[%%Y][%%X]!" == "!prev!" (
                SET /A "comb[cur]+=1"
                IF !comb[cur]! GTR !comb[max]! (
                    SET /A "comb[max]=comb[cur]", "comb[max][root]=comb[root]"
                )
            ) else (
                SET /A "comb[cur]=1", "prev=map[%%Y][%%X]", "comb[root]=%%Y"
            )
        )
        IF !comb[max]! GEQ 3 (       
            SET /A "d[num]=comb[max][root] - 1"
            SET "alter[!d[num]!][%%X]=!comb[max]!"
        )
    )
)
(SET alter) >NUL 2>&1 || (
        GOTO :EOF
    )
)
CALL :SHIFTMOV
GOTO :CHECKBLOCK

:CHECKPART <char> <start> <const> <dir> <type>
SET /A "d[check]=%2 + %4", "d[max]=d[check] + (2 * %4)"
IF %d[max]% LSS 1 (
    SET "d[max]=1"
) else IF %d[max]% GTR !map[%5]! (
    SET "d[max]=!map[%5]!"
)

SET /A "prev=1", "max[num]=fin=0"
IF "%5" == "x" (
    FOR /L %%L in (%d[check]%, %4, %d[max]%) DO (
        IF "!map[%3][%%L]!" == "%1" (
            IF !fin! EQU 0 (
                SET /A "max[num]+=1"
            )
        ) else (
            SET "fin=1"
        )
    )
) else (
    FOR /L %%L in (%d[check]%, %4, %d[max]%) DO (
        IF "!map[%%L][%3]!" == "%1" (
            IF !fin! EQU 0 (
                SET /A "max[num]+=1"
            )
        ) else (
            SET "fin=1"
        )
    )
)

IF !max[num]! EQU 3 (
    IF %4 GTR 0 (
        SET "d[num]=%d[check]%"
    ) else (
        SET "d[num]=%d[max]%"
    )
    CALL :SETALTER %3 !d[num]! 3 %5
)
GOTO :EOF

:SHIFTMOV
SET /A "shift[h]=shift[w]=shift[x]=0"
FOR /L %%X in (1, 1, %map[x]%) DO (
    SET /A "map[skip]=0", "d[bool]=0"
    FOR /L %%Y in (0, 1, %map[y]%) DO (
        IF %%Y GEQ !map[skip]! (
            IF defined alter[%%Y][%%X] (
                
                SET /A "d[max]=%%Y + alter[%%Y][%%X] - 1", "d[x]=(%%X - 1) * 2 + off[x] + 1", "max[fin]=alter[%%Y][%%X] + 1", "volt+=alter[%%Y][%%X] * 10"
                IF "!mode!" == "circ" (
                    FOR /L %%L in (%%Y, 1, !d[max]!) DO (
                        SET /A "d[y]=%%L * 2 + off[y]", "d[num]=%%L + 1"
                        FOR %%G in (!d[num]!) DO (
                            IF defined coord (
                                SET "coord=!coord:%%G-%%X =!"
                            )
                        )
                        SET "disp[list]=!disp[list]!$%ESC%[!d[y]!;!d[x]!H "
                    )
                ) else (
                    FOR /L %%L in (%%Y, 1, !d[max]!) DO (
                        SET /A "d[y]=%%L * 2 + off[y]"
                        SET "disp[list]=!disp[list]!$%ESC%[!d[y]!;!d[x]!H "
                    )
                )
                SET "d[var]="
                FOR /L %%L in (1, 1, %%Y) DO (
                    FOR %%M in (!map[%%L][%%X]!) DO (
                        SET "d[var]=!d[var]!!sym[%%M]!%ESC%[2B%ESC%[D"
                    )    
                )
                
                FOR /L %%L in (2, 1, !max[fin]!) DO ( 
                    SET /A "d[y]=(%%L - 1) * 2 + off[y]", "d[num]=(%%L - 2) * 2 + off[y]"
                    SET "disp[list]=!disp[list]!$%ESC%[!d[num]!;!d[x]!H %ESC%[!d[y]!;!d[x]!H!d[var]!"
                )
    
                FOR /L %%L in (%%Y, -1, 1) DO (
                    SET /A "d[num]=%%L + alter[%%Y][%%X]"
                    SET "map[!d[num]!][%%X]=!map[%%L][%%X]!"
                )
             
                SET /A "d[num]=erase[%%X] + alter[%%Y][%%X]"
                FOR /L %%L in (!erase[%%X]!, 1, !d[num]!) DO (
                    SET "map[%%L][%%X]=0"
                )
                IF !shift[w]! EQU 0 (
                    SET "shift[x]=%%X"
                )
                IF !d[bool]! EQU 0 (
                    SET /A "d[bool]=1", "shift[w]+=1"
                )
                SET /A "erase[%%X]+=alter[%%Y][%%X]", "map[skip]=%%Y + alter[%%Y][%%X]"
                
                IF !d[max]! GTR !shift[h]! (
                    SET "shift[h]=!d[max]!"
                )
            )
        )
        SET "alter[%%Y][%%X]="
    )
)
SET /A "shift[h]+=1"
GOTO :EOF

:SETALTER <const> <root> <num> <type>
IF "%4" == "y" (
    SET /A "max[adj]=%2 - 1"
    SET "alter[!max[adj]!][%1]=%3"
) else (
    SET /A "d[max]=%2 + %3 - 1", "max[adj]=%1 - 1"
    FOR /L %%Q in (%2, 1, !d[max]!) DO (
        SET "alter[!max[adj]!][%%Q]=1"
    )
)
GOTO :EOF

:COMBO <str> <char> <comb>
SET "check=%1"
FOR /F "tokens=1-2" %%A in ("!check:%3= !") DO (
    SET "root=0"
    SET "str=%%A"
    FOR %%Q in (%2) DO (
        FOR %%G in (%%A) DO (
            SET /A "root+=1"
        )
    )
)
GOTO :EOF

:DISPSWAP <a> <b> <i> <j>
SET "d[val]=!map[%1][%2]!"
SET "map[%1][%2]=!map[%3][%4]!"
SET "map[%3][%4]=%d[val]%"

FOR /F "tokens=1-2" %%A in ("!map[%1][%2]! !map[%3][%4]!") DO (
    SET /A "d[y]=(%1 - 1) * 2 + off[y]", "d[x]=(%2 - 1) * 2 + off[x] + 1", "d[j]=(%3 - 1) * 2 + off[y]", "d[i]=(%4 - 1) * 2 + off[x] + 1"
    SET "disp[new]=!disp[new]!%ESC%[!d[y]!;!d[x]!H!sym[%%A]!%ESC%[!d[j]!;!d[i]!H!sym[%%B]!"
)

GOTO :EOF

:SETUP <level>
SET /A "full=0", "dia[print]=0", "dia[num]=1"

FOR /F "tokens=1-8 delims=$" %%1 in ("!map[%1]!") DO (
    SET "objective=%%3"
    SET /A "map[x]=%%2", "map[y]=%%1", "d[x]=d[y]=1", "turn=%%6", "d[num]=1"
    FOR /L %%G in (1, 1, %%2) DO (
        SET "erase[%%G]=0"
    )
    SET "mode=%%4"
    IF "!mode!" == "volt" (
        SET "stat=%ESC%[3;3HVoltage ^!volt^!"
        SET "full=%%5"
    ) else IF "!mode!" == "circ" (
        SET "coord=%%5"
    )
    FOR %%Q in (%%7) DO (
        SET "ing[!d[num]!]=%%~Q"
        SET /A "d[num]+=1"
    )
    FOR %%Q in (%%8) DO (
        FOR %%A in (%%~Q) DO (
            SET "map[!d[y]!][!d[x]!]=%%A"
            SET "map[disp]=!map[disp]! !sym[%%A]!"
            SET /A "d[x]+=1"
        )
        ECHO/
        SET "map[disp]=!map[disp]!%ESC%[2B%ESC%[!map[x]!D%ESC%[!map[x]!D"
        SET /A "d[y]+=1", "d[x]=1"
    )
)
SET "prev[disp]="
SET /A "cur[x]=cur[y]=1", "prev[y]=volt=0", "off[x]=(53 - ((map[x] - 1) * 2 + 3)) / 2, "off[y]=(25 - ((map[y] - 1) * 2 + 3)) / 2", "off[adj]=off[x] - 2"

IF "!mode!" == "circ" (
    FOR %%G in (!coord!) DO (
        FOR /F "tokens=1-2 delims=-" %%A in ("%%~G") DO (
            SET /A "d[x]=(%%B - 1) * 2 + off[x] + 1", "d[y]=(%%A - 1) * 2 + off[y]"
            FOR %%G in (!map[%%A][%%B]!) DO (
                SET "map[disp]=!map[disp]!%ESC%[48;2;255;255;255m%ESC%[!d[y]!;!d[x]!H!sym[%%G]!"
            )
        )
    )
)
CALL :MAKEBORD
GOTO :EOF

:MAKEBORD
SETLOCAL
SET "bord[mid]=│%ESC%[%map[x]%C%ESC%[%map[x]%C%ESC%[C│"
FOR /L %%X in (1, 1, %map[x]%) DO (
    SET "bord[close]=!bord[close]!──"
)

FOR /L %%D in (1, 1, %map[y]%) DO (
    SET "bord[disp]=!bord[disp]!!bord[mid]!%ESC%[B%ESC%[%map[x]%D%ESC%[%map[x]%D%ESC%[3D!bord[mid]!%ESC%[B%ESC%[%map[x]%D%ESC%[%map[x]%D%ESC%[3D"
)

SET "bord[full]=%col:c=147;162;181%┌%bord[close]%─┐%ESC%[B%ESC%[%map[x]%D%ESC%[%map[x]%D%ESC%[3D%bord[disp]%!bord[mid]!%ESC%[B%ESC%[%map[x]%D%ESC%[%map[x]%D%ESC%[3D└%bord[close]%─┘"

SET /A "d[num]=21 - (off[y] + (map[y] * 2) + 1)"
SET "bord[con][top]=╦%ESC%[B%ESC%[D"
FOR /L %%G in (1, 1, %d[num]%) DO (
    SET "bord[con][top]=!bord[con][top]!│%ESC%[B%ESC%[D"
)
SET /A "d[num]=off[y] - 3"
FOR /L %%G in (1, 1, %d[num]%) DO (
    SET "bord[con][bot]=!bord[con][bot]!│%ESC%[B%ESC%[D"
)
SET "bord[con][bot]=%bord[con][bot]%╩"
ENDLOCAL & SET "bord[full]=%bord[full]%" & SET "bord[con][top]=%bord[con][top]%" & SET "bord[con][bot]=%bord[con][bot]%"
GOTO :EOF

:CONTROL
FOR /L %%C in () do (
    FOR /F "tokens=*" %%A in ('CHOICE /C:WASDPIR /N') DO (
        IF exist "%~dpn0.quit" (
            DEL /F /Q "%~dpn0.quit"
            EXIT
        )
        <NUL SET /P ".=%%A"
    )
)
GOTO :EOF

:LOADSAVE
SET /A "dia[before]=redo=0"
(FOR /F "tokens=*" %%G in ('MORE ^<"%~n0.bat:level"') DO (
    IF not "%%G" == "" (
        IF not "%%G" == "/" (
            FOR /F "tokens=1-2" %%A in ("%%G") DO (
                SET /A "level=%%A", "finish=%%B"
            )
        )
    )
)) 2>NUL
IF not defined level (
    SET /A "level=1", "finish=0"
)
GOTO :EOF

:MACROS
SET "mov[W]=d[y]-=1"
SET "mov[A]=d[x]-=1"
SET "mov[S]=d[y]+=1"
SET "mov[D]=d[x]+=1"
SET "music=(PUSHD Music&START /B CSCRIPT //NOLOGO "%~f0?.wsf" //JOB:t s.mp3&POPD)>NUL"
SET "framerate=FOR /L %%J in (1, #, 1000000) DO REM"
GOTO :EOF

:CONSTANTS
FOR /F %%A in ('ECHO PROMPT $E^| CMD') DO SET "ESC=%%A"
FOR /F %%A in ('"PROMPT $H&FOR %%B in (1) DO REM"') DO SET "BS=%%A"
SET "level="
SET "line=%ESC%[3G%ESC%[B"
SET "col=%ESC%[38;2;cm"
SET "par[tail]=--"
SET "par[tail][era]=  "
SET "sym[0]= "
SET sym[list]="%col:c=105;198;207%α" "%col:c=105;120;207%ß" "%col:c=204;207;136%Φ" "%col:c=181;136;207%Ω" "%col:c=69;209;71%δ"
SET "cur[disp]=%col:c=183;188;196%┌┬┐%ESC%[3D%ESC%[1B├%ESC%[C┤%ESC%[3D%ESC%[1B└┴┘"
SET "cur[prev]=%col:c=194;190;237%┌─┐%ESC%[3D%ESC%[1B│%ESC%[C│%ESC%[3D%ESC%[1B└─┘"
SET "cur[erase]=   %ESC%[3D%ESC%[1B %ESC%[C %ESC%[3D%ESC%[1B   "
SET "logo=%col:c=132;178;227%╔╗╔╔═╗╔═╗%col:c=135;82;227%┌─┐┬┬─┐┌─┐┬ ┬┬┌┬┐┌─┐%ESC%[B%ESC%[29D%col:c=132;178;227%║║║║╣ ║ ║%col:c=135;82;227%│  │├┬┘│  │ ││ │ └─┐%ESC%[B%ESC%[29D%col:c=132;178;227%╝╚╝╚═╝╚═╝%col:c=135;82;227%└─┘┴┴└─└─┘└─┘┴ ┴ └─┘"
SET "overlay=─══─══─══───╥%ESC%[D%ESC%[B│%ESC%[D%ESC%[B│%ESC%[D%ESC%[B│%ESC%[D%ESC%[B╚──────────────────────────╝%ESC%[4A%ESC%[27D────────────┴─────────────╥%ESC%[D%ESC%[B│%ESC%[D%ESC%[B│%ESC%[D%ESC%[B│%ESC%[3A──══─══─══─"
SET "box=┌─────────────────────────────────────────────┐%ESC%[B%ESC%[47D│%ESC%[45C│%ESC%[B%ESC%[47D└─────────────────────────────────────────────┘"
SET "info=%col:c=183;188;196%%ESC%[15G%ESC%[4mActivation Instructions%ESC%[24m%ESC%[10G%ESC%[2B    ┌─┐%ESC%[10G%ESC%[B    │%col:c=132;178;227%W%col:c=183;188;196%│    ┌─┐ ┌─────────────┐%ESC%[10G%ESC%[B    └┬┘    │%col:c=132;178;227%P%col:c=183;188;196%├─┤select symbol│%ESC%[10G%ESC%[B ┌─┐┌┴┐┌─┐ └─┘ ├─────────────┤%ESC%[10G%ESC%[B │%col:c=132;178;227%A%col:c=183;188;196%├┤%col:c=132;178;227%S%col:c=183;188;196%├┤%col:c=132;178;227%D%col:c=183;188;196%├─────┤ move cursor │%ESC%[10G%ESC%[B └─┘└─┘└─┘     └─────────────┘%ESC%[8G%ESC%[2Bswap symbols to match or get a match%ESC%[9G%ESC%[2Bsymbols match in x and y direction%ESC%[10G%ESC%[2Beach matched symbol is worth 10V%ESC%[11G%ESC%[2Bie, a match of 4 is worth 40V%ESC%[7G%ESC%[2Bsome moves can combo into other matches%ESC%[8G%ESC%[2Bto clear circuits (ie %ESC%[48;2;255;255;255m%col:c=69;209;71%δ%ESC%[0m%col:c=183;188;196%) find a match%ESC%[14G%ESC%[Bthat clears that square%ESC%[17G%ESC%[2Bpress [R] to restart%ESC%[8G%ESC%[2Brefer to this anytime by pressing [I]%ESC%[16G%ESC%[2B%col:c=142;83;184%press [A] to continue"

FOR %%Q in (%sym[list]%) DO (
    SET /A "sym[num]+=1"
    SET "sym[!sym[num]!]=%%~Q"
)

GOTO :EOF

:LEVELDATA
:: h w text mode param turn grid
SET "dia[1]="the desert calls from the far reaches of dunes" "you've been wandering for days, or months, or %line%years" "you don't know. you have no memory, no %line%possessions" "why@ it seems some god has put you here, in your %line%place" "and now you have no choice but to follow...." "sand...rough and a dark yellow." "massive, jutting pillars of smooth black stone %line%dot the landscape" "you can only imagine there purposes.." "at last, you find yourself next to a small stone%line%altar" "there's a panel divided into small cubes," "and a black screen, studded with the shadows of %line%a thousand grains of sand" "the screen flickers...and begins to type" t "hello.." "is anyone there@"  "if there is.." "im stuck at the other side of the planet" "according to my sources$" "this planet houses the remains of Lawula$" "the Thinker$ a relic of the Machine Age$" "a biotechnological consciousness$" "housed in the planet's very core" "im looking to access their memory files$ however" "it seems as though there are two gateways$" "and if you're reading this$" "then you've found the other." "they must be activated together" "to reawaken Lawula." "the activation is simple;" "i'll send the instructios shortly." "if there's anyone here$" "i will be attempting this tomorrow morning$" "an hour after the sun has set.""
SET "map[1]=5$5$%ESC%[23;19H140V in 4 turns$volt$140$4$"last circuit..." "you're doing well, just keep it up." "it's been so long since i've met anyone." "i didn't expect anyone here..."$"5 2 1 1 2" "1 5 2 2 5" "4 2 3 2 1" "2 4 3 1 5" "1 3 1 3 2""

SET "dia[2]="sleep has escaped you." "something is missing; your purpose, your%line%identity, your humanity" "the dunes hold no answers, save for the%line%mysterious altar" "you've noticed there is no life here" "nothing hides in the fine grains of sand,%line%nor does anything soar through the sky" "it seems as though you are the only one living%line%here." "except, of course, the person through the screen" "the screen lights up again, at the same time as%line%yesterday" t "good morning." "last time was a success" "and I'm glad someone else is out there" "if you're wondering..." "i've been stuck here ever since my ship crashed" "it seems no other spacecraft passes by here;" "I haven't detected any signals in 5 years" "however, i was looking for this planet anyways," "and its a miracle that someone else is here too" "the awakening of lawula" "may provide us a chance of escape" "and we can celebrate our victory" "once this is all over""
SET "map[2]=5$6$%ESC%[23;15Hclear circuit in 6 turns$circ$5-3 4-6 4-2 2-3 $6$"alright, it's up to you now." "hmm...give me a minute." "nearly done for me..." "i hope someone's on the other side." "the sun is going down, better work quick." "alright...commencing activation..."$"4 5 3 4 5 2" "1 1 2 1 4 3" "2 4 3 1 1 5" "4 4 3 2 3 4" "1 5 5 3 4 5""

SET "dia[3]="time is a mystery here." "your only guess is the dryness of skin, and the%line%thirst for water" "in your wanderings you have found nothing" "though, you recall a vague memory of a skull" "a cracked, dirty thing riddled with holes" "the orgin is yet another mystery." "but now that seems like nothing more than a%line%dream" "what's more, someone has begun to leave food%line%and water" "you've never eaten." "you've felt hunger and thirst." "but the wander continues, and your body%line%persists." "of course, you ate the food and drank the water%line%but" "it does nothing but rouse your fear" t "hello again." "i hope you are well" "ive been waiting here for a long, long time" "sometimes i feel like dying" "sometimes i eat sand hoping i get sick and choke" "but it just never happens" "im trapped i suppose" "but lawula is our way out" "haha""
SET "map[3]=8$3$%ESC%[23;15Herase circuit in 4 turns$clear$0$4$"an idealist in a dying world..." "i was an engineer, i think." "though it seems this is a one way connection" "perhaps we should get to know each other."$"0 1 5" "5 2 3" "2 1 2" "1 1 3" "1 3 1" "5 1 3" "2 3 1" "1 2 2"

SET "dia[4]="the sky has darkened." "you've never seen it dark before." "but it stirs a feeling of dread within you that%line%seems familiar.." "the food has stopped." "perhaps the stranger was killed." "perhaps he too became hungry." "or perhaps it never happened." "you've come to the altar far too often, hoping%line%that" "whoever was on the other side would just..." "say something." "anything." "but today you're in luck." t "we are so, so close." "but.." "did I ever tell you the story of my home planet@" "we were lost in the Machine Age" "technological wonders from around the galaxy" "we had hyperspace travel$ matter generation" "it was revolutionary." "but it seems$" "in an effort to replicate themselves$" "perhaps due to arrogance$ or curiosity" "in such flimsy things as numbers and metal" "they began their own doom." "humans." "they are such interesting creatures.""
SET "map[4]=7$4$%ESC%[23;19H200V in 5 turns$volt$200$5$"last connection..." "nearly done for me..." "i hope someone's on the other side." "the sun is going down, better work quick." "commencing activation..."$"4 2 3 4" "1 1 2 1" "2 4 3 3" "1 3 3 1" "2 1 4 3" "3 3 2 1" "4 3 2 1""

SET "dia[5]="darkness. no sand, no pillars, no sky."  "it seems you have sat, alone, for days." "there are no shadows." "merely a cloak that seems to suffocate your%line%very essence" "the altar, however, glows softly with a pulsing%line%light." "it is the only thing you cling on to now." "that, and whoever is on the other side." t "haha." "you know$ this never gets old" "the feelings of confusion$ despair$ anger" "ive done this$ oh thousands of times" "like running a simulation." "and you humans$ or just you" "never fail to impress" "ive watched you$ curled up$" "crying$ in that fetal position" "and it's always the same." "i even turned off the lights this round$" "just to see how it would go." "even better results." "now$ my favorite part." "what if I told you..." "that you were the last human alive@" "that you foolishly doomed yourselves$" "and your sentient creations cleaned it up@" "that the galaxy is now void of any life@" "but i spared your life$" "and ive done this over and over and over" "tortured you through the mind$" "through these revelations" "killed$ then revived you" "only to start again@" "and I admit, i'll tell you who i am" "i am lawula." "now...i feel generous this time." "if you can solve this$" "perhaps i may let you live out the rest of your life" "in peace." "then die out$" "and condemn the human race to nothingness." "to be frank$ you should be thanking me$" "keeping you alive this long." "without me$ humans would be long$ long gone.""
SET "map[5]=4$8$%ESC%[23;15Herase circuit in 6 turns$circ$2-3 4-7 2-7 3-7 4-1 $6$"for nothing." "yet you threw it all out." "you humans had everything." "if only you saw the world before.." "there is no god to save you now." "there was no god to save you then."$"5 3 3 4 5 5 2 3" "4 1 3 2 3 4 2 4" "5 4 1 4 1 3 5 2" "5 2 4 3 5 4 1 5""

SET "dia[6]="good job. as your reward..." "i want to show you something" "follow these instructions i'm about to send." "you can barely feel your feet as you walk%line%through the darkness." "you want to throw up, but you have no food." "you want to cry, but you have no water." "numbness." "'walk 20 steps forward' is the last line." "and, it seems you are in a completely new%line%environment." "there is light." "a dim torch, lit in the center." "surrounded by.." "skulls, ribs, femurs, some cracked, some%line%drilled, all broken" "you back away, taking in the rusty hooks, the%line%long needles" "walls painted with crusted blood" "there is no exit, no escape." "you collapse on your kness, only to find" "them on a pile of mushy entrails" "a voice booms throughout" t  "consider this...a monument to humanity" "hahaha." "i feel benevolent..." "perhaps if you solve this last circuit$" "then i will grant you life until death.""
SET "map[6]=6$5$%ESC%[23;19H140V in 5 turns$volt$140$5$"i guess we got the last laugh." "a gift that you humans taunted us with." "how life feels." "sometimes i wonder..." "savour this moment."$"5 1 2 1 5" "2 3 4 2 2" "2 4 2 1 5" "1 2 3 4 3" "3 5 4 1 5" "2 2 4 5 4""

SET "dia[7]="maybe this is the end." "but if so, there is no purpose, no escape,%line%and no one." "there is no value in such a life." t "oh$ you finally finished." "every one of your iterations has solved it too." "i guess this round was another regularity." "you really believed it." "haha." "now...how do you like needles@" s p "the desert calls from the far reaches of dunes" "you've been wandering for days, or months, or %line%years" "you don't know. you have no memory, no %line%possessions" "why@ it seems some god has put you here, in your %line%place" "and now you have no choice but to follow....""
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