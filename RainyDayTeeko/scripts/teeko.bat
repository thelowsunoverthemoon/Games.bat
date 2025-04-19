:: mode 0 no square select
:: mode 1 square selected
:: mode 2 enem turn wait

@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

:MAIN
IF not "%1" == "" (
    IF "%1" == "ENEM_AI" (
        CALL :ENEM_AI enem 0 3 -2000 2000
        EXIT /B
    ) else (
        GOTO :%1
    )
)
"%~F0" CONTROL > "%TEMP%\%~n0_sig.txt" | "%~F0" GAME < "%TEMP%\%~n0_sig.txt"
TASKKILL /F /IM CHOICE.exe >NUL 2>NUL
DEL /F /Q "%~dpn0.quit" "turn.txt" "turn_cpy.txt" 2>NUL
TIMEOUT /T 1 /NOBREAK >NUL
EXIT /B

:GAME
CALL :INIT_GAME

SET /A "dim=5"

CALL :MAKE_BOARD %dim%
CALL :GEN_HEURISTIC %dim%
CALL :POP_RAND_BOARD

CALL :LOAD_DIA %person%
SET /A "cur.x=cur.y=3", "sq.x=p.x=%offset.x:n=cur.x%", "sq.y=p.y=%offset.y:n=cur.y%", "mode=0"
SET "text=%person%'s Turn"
%$strlen%
SET /A "person.offset=35 - len / 2"

ECHO %\e%[?25l%\e%[%off.y%;%off.x%H%board%%\e%[33;14H%dia.box%%\e%[33;27H───Your Turn───
%$get_time% "t1=(((1%%A*60)+1%%B)*60+1%%C)*100+1%%D-36610100"
FOR /L %%# in () DO (
    SET /P "input="
    IF "!mode!" == "2" (
        IF exist turn.txt (
            COPY /Y turn.txt turn_cpy.txt >NUL
            FOR /F "tokens=1-2" %%1 in (turn_cpy.txt) DO (
                SET /A "mode=0", ^
                       "w.x=(3 * ((%%1 - 6) %% 5)) + off.x + 1", ^
                       "w.y=(3 * ((%%1 - 6) / 5)) + off.y + 1", ^
                       "d.x=(3 * ((%%2 - 6) %% 5)) + off.x + 1", ^
                       "d.y=(3 * ((%%2 - 6) / 5)) + off.y + 1", ^
                       "board.enem|=(1 << %%2)", ^
                       "board.enem&=~(1 << %%1)"
                FOR %%G in ("!w.y!;!w.x!") DO (
                    SET "tokens=!tokens:%\e%[%%~GH%token.e%=!%\e%[!d.y!;!d.x!H%token.e%"
                )
                SET "enem.tokens=!enem.tokens: %%1 =! %%2 "
                SET "board.elem=%\e%[!w.y!;!w.x!H %\e%[33;27H───Your Turn───"
                FOR %%Q in (!board.enem!) DO (
                    IF not "!wins.chk:.%%Q.=!" == "!wins.chk!" (
                        CALL :END lose
                    )
                )
            )
            DEL /F /Q turn.txt turn_cpy.txt
            
        )
    )
    IF defined input (
        IF "!input!" == "P" (
            IF "!mode!" == "0" (
                SET /A "bit.chk=board.play & (1 << ((cur.y * 5) + cur.x))"
                IF not "!bit.chk!" == "0" (
                    SET "board.elem=%\e%[!sq.y!;!sq.x!H%sq.sel%"
                    SET /A "t.x=cur.x", "t.y=cur.y", "mode=1"
                )
            ) else IF "!mode!" == "1" (
                IF "!t.x!.!t.y!" == "!cur.x!.!cur.y!" (
                    SET "board.elem="
                    SET "mode=0"
                ) else (
                    SET /A "check=0", "bit.chk=(cur.y * 5) + cur.x"
                    FOR %%X in (-6 -5 -4 -1 1 4 5 6) DO (
                        SET /A "bit.pos=(t.y * 5) + t.x + %%X"
                        IF "!bit.pos!" == "!bit.chk!" (
                            SET /A "play.chk=(board.play | board.enem) & (1 << bit.pos)"
                            IF "!play.chk!" == "0" (
                                IF not "!t.x!!cur.x!" == "51" ( IF not "!t.x!!cur.x!" == "15" (
                                    SET "check=1"
                                ))
                            )
                        )
                    )
                    IF "!check!" == "1" (
                        SET /A "v.x=%offset.x:n=t.x% + 1", ^
                               "v.y=%offset.y:n=t.y% + 1", ^
                               "d.x=%offset.x:n=cur.x% + 1", ^
                               "d.y=%offset.y:n=cur.y% + 1", ^
                               "bit.pos=(t.y * 5) + t.x", ^
                               "board.play|=(1 << ((cur.y * 5) + cur.x))", ^
                               "board.play&=~(1 << ((t.y * 5) + t.x))", ^
                               "mode=2", ^
                               "dia.r=!RANDOM! %% dia.n"
                        SET "dia="
                        FOR /F "tokens=1-3" %%1 in ("!v.y!;!v.x! !bit.pos! !dia.r!") DO (
                            SET "tokens=!tokens:%\e%[%%~1H%token.p%=!%\e%[!d.y!;!d.x!H%token.p%"
                            SET "play.tokens=!play.tokens: %%~2 =! !bit.chk! "
                            SET "dia.cur=!dia.%%3!"
                        )
                        
                        FOR %%Q in (!board.play!) DO (
                            IF not "!wins.chk:.%%Q.=!" == "!wins.chk!" (
                                CALL :END win
                            )
                        )
                        SET "board.elem="
                        ECHO %\e%[!v.y!;!v.x!H%up:n=1%%bk:n=1%%sq.norm%%\e%[!v.y!;!v.x!H %\e%[33;%person.offset%H%person%'s Turn
                        START /B "" %0 ENEM_AI >NUL
                    )
                )
            )
        ) else (
            FOR %%E in (!input!) DO (
                SET /A "d.x=cur.x", "d.y=cur.y", "!mov.%%E!"
                IF !d.x! GEQ 1 ( IF !d.x! LEQ %dim% (
                    IF !d.y! GEQ 1 ( IF !d.y! LEQ %dim% (
                        SET /A "p.x=%offset.x:n=cur.x%", ^
                               "p.y=%offset.y:n=cur.y%", ^
                               "cur.x=d.x", ^
                               "cur.y=d.y", ^
                               "sq.x=%offset.x:n=d.x%", ^
                               "sq.y=%offset.y:n=d.y%"
                    ))
                ))
            )
        )
        SET "input="
    )
    %$get_time% "t2=(((1%%A*60)+1%%B)*60+1%%C)*100+1%%D-36610100", "dt=t2-t1"
    IF !dt! GTR 1 (
        SET /A "t1=t2", "frame=(frame + 1) %% 0x7FFFFFFF", "add.rain=frame %% 10"
        ECHO !rain!%col:c=204;204;204%%\e%[!p.y!;!p.x!H%sq.norm%%\e%[!sq.y!;!sq.x!H%sq.hover%!board.elem!%\e%[35;16H%\e%[38X!dia!!tokens!%col:c=204;204;204%
        %$rain%
        IF "!add.rain!" == "0" (
            SET /A "rain.side=!RANDOM! %% 2", "rand=!RANDOM! %% 2"
            IF "!rain.side!" == "1" (
                SET /A "rain.x=!RANDOM! %% 7"
            ) else (
                SET /A "rain.x=!RANDOM! %% 8 + 61"
            )
            IF "!rain.type!" == "0" (
                SET "rain.par=!rain.par! "!rain.x! 1 %col:c=74;101;131%.""
            ) else (
                SET "rain.par=!rain.par! "!rain.x! 1 %col:c=108;128;148%^│""
            )
        )
        IF defined dia.cur (
            SET "dia=!dia!!dia.cur:~0,1!"
            SET "dia.cur=!dia.cur:~1!"
        )
    )
    
)
GOTO :EOF

:ENEM_AI <type> <cur> <depth> <alpha> <beta>
FOR %%Q in (%board.play%) DO (
    IF not "!wins.chk:.%%Q.=!" == "!wins.chk!" (
        SET /A "test.score=-1000+%2"
        EXIT /B !test.score!
    )
)
FOR %%Q in (%board.enem%) DO (
    IF not "!wins.chk:.%%Q.=!" == "!wins.chk!" (
        SET /A "test.score=1000-%2"
        EXIT /B !test.score!
    )
)
IF "%2" == "%3" (
    SET /A "score=!heuristic!"
    EXIT /B !score!
)
IF "%1" == "enem" (
    SET "best.score=-2000"
    SET "check.tokens=%enem.tokens%"
) else (
    SET "best.score=2000"
    SET "check.tokens=%play.tokens%"
)
SET /A "alpha=%4", "beta=%5"
FOR %%G in (%check.tokens%) DO (
    FOR /F "tokens=1-2 delims=." %%A in ("%%~G") DO (
        FOR %%X in (-6 -5 -4 -1 1 4 5 6) DO (
            SET /A "bit.pos=%%G + %%X", "play.chk=(board.play | board.enem) & (1 << bit.pos)", "wrap.old=(%%G-6) %% 5", "wrap.new=(bit.pos-6) %% 5", "check=0"
            
            IF not "!play.chk!" == "0" (
                SET "check=1"
            ) else (
                IF "!wrap.old!" == "0" ( IF "!wrap.new!" == "4" (
                    SET "check=1"
                ))
                IF "!wrap.old!" == "4" ( IF "!wrap.new!" == "0" (
                    SET "check=1"
                ))
            )
            IF !bit.pos! GEQ 6 (
                IF !bit.pos! LEQ 30 (
                    IF "!check!" == "0" (
                        SET /A "nex.turn=%2+1"
                        IF "%1" == "enem" (
                            SETLOCAL
                            SET /A "board.enem|=(1 << !bit.pos!)", ^
                                   "board.enem&=~(1 << %%G)"
                            SET "enem.tokens=!enem.tokens: %%G =! !bit.pos! "
                            CALL :ENEM_AI player !nex.turn! %3 !alpha! !beta!
                            ENDLOCAL & SET "test.score=!ERRORLEVEL!"
                            IF !test.score! GTR !best.score! (
                                SET /A "best.old=%%G", "best.new=bit.pos", "best.score=test.score"
                            )
                            IF !test.score! GTR !alpha! (
                                SET "alpha=!test.score!"
                                IF !alpha! GEQ !beta! (
                                    IF "%2" == "0" (
                                        ECHO !best.old! !best.new!>turn.txt
                                    )
                                    EXIT /B !best.score!
                                )
                            )
                        ) else (
                            SETLOCAL
                            SET /A "board.play|=(1 << !bit.pos!)", ^
                                   "board.play&=~(1 << %%G)"
                            SET "play.tokens=!play.tokens: %%G =! !bit.pos! "
                            CALL :ENEM_AI enem !nex.turn! %3 !alpha! !beta!
                            ENDLOCAL & SET "test.score=!ERRORLEVEL!"
                            IF !test.score! LSS !best.score! (
                                SET "best.score=!test.score!"
                            )
                            IF !test.score! LSS !beta! (
                                SET "beta=!test.score!"
                                IF !alpha! GEQ !beta! (
                                    IF "%2" == "0" (
                                        ECHO !best.old! !best.new!>turn.txt
                                    )
                                    EXIT /B !best.score!
                                )
                            )
                        )
                    )
                )
            )

        )

    )
)
IF "%2" == "0" (
    ECHO !best.old! !best.new!>turn.txt
)
EXIT /B !best.score!

:POP_RAND_BOARD
SET /A "rand=%RANDOM% %% 5"
IF "!rand!" == "0" (
    CALL :SET_TOKEN_POSITION 2 2
    CALL :SET_TOKEN_POSITION 4 2
    CALL :SET_TOKEN_POSITION 4 4
    CALL :SET_TOKEN_POSITION 2 4
    CALL :SET_ENEM_POSITION 3 2
    CALL :SET_ENEM_POSITION 3 4
    CALL :SET_ENEM_POSITION 2 3
    CALL :SET_ENEM_POSITION 4 3
) else IF "!rand!" == "1" (
    CALL :SET_TOKEN_POSITION 1 1
    CALL :SET_TOKEN_POSITION 5 1
    CALL :SET_TOKEN_POSITION 1 5
    CALL :SET_TOKEN_POSITION 5 5
    CALL :SET_ENEM_POSITION 1 3
    CALL :SET_ENEM_POSITION 3 1
    CALL :SET_ENEM_POSITION 3 5
    CALL :SET_ENEM_POSITION 5 3
) else IF "!rand!" == "2" (
    CALL :SET_TOKEN_POSITION 2 1
    CALL :SET_TOKEN_POSITION 5 2
    CALL :SET_TOKEN_POSITION 4 5
    CALL :SET_TOKEN_POSITION 1 4
    CALL :SET_ENEM_POSITION 1 2
    CALL :SET_ENEM_POSITION 4 1
    CALL :SET_ENEM_POSITION 5 4
    CALL :SET_ENEM_POSITION 2 5
) else IF "!rand!" == "3" (
    CALL :SET_TOKEN_POSITION 1 5
    CALL :SET_TOKEN_POSITION 2 2
    CALL :SET_TOKEN_POSITION 4 4
    CALL :SET_TOKEN_POSITION 5 1
    CALL :SET_ENEM_POSITION 1 1
    CALL :SET_ENEM_POSITION 4 2
    CALL :SET_ENEM_POSITION 2 4
    CALL :SET_ENEM_POSITION 5 5
) else IF "!rand!" == "4" (
    CALL :SET_TOKEN_POSITION 1 3
    CALL :SET_TOKEN_POSITION 5 3
    CALL :SET_TOKEN_POSITION 3 2
    CALL :SET_TOKEN_POSITION 3 4
    CALL :SET_ENEM_POSITION 3 1
    CALL :SET_ENEM_POSITION 2 3
    CALL :SET_ENEM_POSITION 4 3
    CALL :SET_ENEM_POSITION 3 5
)
GOTO :EOF

:LOAD_DIA <person>
SET "dia.n=0"
FOR /F "tokens=*" %%A in (story\ingame\%1\!%1.branch!.txt) DO (
    SET "dia.!dia.n!=%%A"
    SET /A "dia.n+=1"
)
GOTO :EOF

:END <type>
ECHO %\e%[33;27H────Press A────%board.elem%%\e%[!v.y!;!v.x!H%up:n=1%%bk:n=1%%sq.norm%%\e%[!v.y!;!v.x!H %tokens%%col:c=118;188;204%%\e%[35;16H%\e%[38X%\e%[35;31HYou %1
COPY NUL "%~dpn0.quit" >NUL
EXIT

:SET_ENEM_POSITION <x> <y>
SET /A "bit.pos=(%2 * 5) + %1", ^
       "board.enem|=(1 << bit.pos)", ^
       "d.x=!offset.x:n=%1! + 1", ^
       "d.y=!offset.y:n=%2! + 1"
SET "tokens=!tokens!%\e%[!d.y!;!d.x!H%token.e%"
SET "enem.tokens=!enem.tokens! !bit.pos! "
GOTO :EOF

:SET_TOKEN_POSITION <x> <y>
SET /A "bit.pos=(%2 * 5) + %1", ^
       "board.play|=(1 << bit.pos)", ^
       "d.x=!offset.x:n=%1! + 1", ^
       "d.y=!offset.y:n=%2! + 1"
SET "tokens=!tokens!%\e%[!d.y!;!d.x!H%token.p%"
SET "play.tokens=!play.tokens! !bit.pos! "
GOTO :EOF

:GEN_HEURISTIC <dim>
SET "bit.pos=6"
FOR %%G in (0 1 0 1 0 1 2 2 2 1 0 2 3 2 0 1 2 2 2 1 0 1 0 1 0) DO (
    SET "heuristic=!heuristic!(%%G*^!^!(board.play&(1<<!bit.pos!)))+"
    SET /A "bit.pos+=1"
)
SET "heuristic=!heuristic:~0,-1!"
GOTO :EOF

:MAKE_BOARD <dim>
SET "row.n="
FOR /L %%X in (1, 1, %1) DO (
    SET "row.n=!row.n!%sq.norm%"
)
SET /A "width=3 * %1"
FOR /L %%Y in (1, 1, %1) DO (
    SET "board=!board!!row.n!%dn:n=3%%\e%[!width!D"
)

SET /A "off.x=(70 - (3 * %1))/2", ^
       "off.y=(35 - (3 * %1))/2"
       
GOTO :EOF

:INIT_GAME
SET "mov.W=d.y-=1"
SET "mov.A=d.x-=1"
SET "mov.S=d.y+=1"
SET "mov.D=d.x+=1"
SET "offset.x=(3 * (n - 1)) + off.x"
SET "offset.y=(3 * (n - 1)) + off.y"

SET "token.p=%col:c=118;188;204%▲"
IF "%person%" == "Allison" (
    SET "token.e=%col:c=209;84;140%Ω"
) else IF "%person%" == "Mia" (
    SET "token.e=%col:c=191;143;59%Φ"
) else (
    SET "token.e=%col:c=197;151;230%Θ"
)
SET "sq.norm=┌─┐%bk:n=3%%dn:n=1%│ │%bk:n=3%%dn:n=1%└─┘%up:n=2%"
SET "sq.hover=╔═╗%bk:n=3%%dn:n=1%║ ║%bk:n=3%%dn:n=1%╚═╝%up:n=2%"
SET "sq.sel=╔╦╗%bk:n=3%%dn:n=1%╠ ╣%bk:n=3%%dn:n=1%╚╩╝%up:n=2%"
SET "wins.chk=.960.1920.30720.61440.1966080.983040.31457280.62914560.2013265920.1006632960.71581696.4473856.17043520.1090785280.2236928.143163392.2164800.69273600.138547200.4329600.8659200.277094400.554188800.17318400.34636800.1108377600.1660944384.830472192.415236096.207618048.6488064.12976128.25952256.51904512.1622016.811008.405504.202752.6336.12672.25344.50688."
GOTO :EOF

:CONTROL
FOR /L %%C in () DO (
    FOR /F "tokens=*" %%A in ('CHOICE /C:WASDP /N') DO (
        IF exist "%~dpn0.quit" (
            DEL /F /Q "%~dpn0.quit"
            EXIT
        )
        <NUL SET /P ".=%%A"
    )
)
GOTO :EOF