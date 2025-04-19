:: [ = question mark
:: $ dialogue Allison
:: { dialogue Mia
:: + end dialogue

:MAIN
CALL :INIT_NOVEL
IF "%1" == "end" (
    SET "ending.bad="
    IF "%jackie.branch%" == "3" (
        IF "%mia.branch%" == "2" (
            IF "%allison.branch%" == "3" (
                SET "ending.bad=1"
            )
        )
    )
    IF defined ending.bad (
        CALL :START_NOVEL story\end\bad.txt
    ) else (
        CALL :START_NOVEL story\end\good.txt
        CALL :CHECK_GOOD_END jackie
        CALL :CHECK_GOOD_END allison
        CALL :CHECK_GOOD_END mia
    )
) else IF "%1" == "postgame" (
    CALL :START_DIALOGUE story\postgame\%person%\!%person%.day!.txt 1
) else (
    IF not "%1" == "normal" (
        CALL :START_NOVEL story\encounter\%1.txt
    ) else (
        CALL :START_NOVEL story\days\%day%.txt
    )
    FOR %%P in (!person!) DO (
        CALL :START_DIALOGUE story\dialogue\%%P\!%%P.day!.txt !%%P.branch!
    )
)
EXIT /B

:START_NOVEL <path>
SET /A "branch=1", "start=0"
FOR /F "tokens=1,*" %%A in (%1) DO (
    SET "type=%%A"
    FOR %%# in (!branch!) DO (
        IF "!start!" == "0" (
            IF not "!type!" == "!type:-%%#-=!" (
                ECHO %\e%[2J%\e%[3d%margin%%\e%[4m%day%%\e%[0m%col:c=204;204;204%%\e%[5d
                SET "start=1"
            )
        ) else (
            SET "disp.text="
            IF "%%A" == "#" (
                SET disp.text=%%B
            ) else IF "%%A" == "COND" (
                FOR /F "tokens=1,2,*" %%1 in ("%%B") DO (
                    SET "type=%%2"
                    FOR %%X in (!%%1.day!) DO (
                        IF not "!type!" == "!type:-%%X-=!" (
                            SET disp.text=%%3
                        )
                    )
                )
            ) else IF "%%A" == "CLS" (
                ECHO %\e%[2J%\e%[3d%margin%%\e%[4m%day%%\e%[0m%col:c=204;204;204%%\e%[5d
            ) else IF "%%A" == "GAME" (
                SET "person=%%B"
                GOTO :EOF
            ) else (
                SET "start=0"
                CALL :MAKE_CHOICE 10 branch %%B
            )
            IF not "!disp.text!" == "" (
                SET "cur.len=0"
                SET "box.text=%margin%"
                FOR %%L in (!disp.text!) DO (
                    SET "text=%%~L "
                    %$strlen%
                    SET /A "cur.len+=len"
                    CALL :REP_STR %%L
                    IF !cur.len! GTR !max.w! (
                        SET "cur.len=!len!"
                        SET "box.text=!box.text!%dn:n=1%%margin%!rep.str! "
                    ) else (
                        SET "box.text=!box.text!!rep.str! "
                    )
                )
                ECHO !box.text!%dn:n=1%%margin%%col:c=105;122;140%(Press A^)%\e%[0m%col:c=204;204;204%
                PAUSE >NUL
                ECHO %up:n=1%%margin%%\e%[10X
            )
        )
    )
)
GOTO :EOF

:START_DIALOGUE <path> <start>
SET "temp.branch=%2"
CALL :LOAD_PERSON %person%
SET "text= %person% "
%$strlen%
SET /A "person.offset=35 - len / 2", "start=0"
ECHO %\e%[2J%\e%[%offset.body.y%;1H
FOR /L %%A in (1, 1, !%person%.n!) DO (
    ECHO %\e%[%offset.body.x%G!%person%.%%A!
)
ECHO %col:c=204;204;204%%\e%[33;14H%dia.box%
FOR /F "tokens=1,*" %%A in (%1) DO (
    IF "%%A" == "!temp.branch!" (
        SET "start=1"
    ) else IF "!start!" == "1" (
        IF "%%A" == "#" (
            CALL :REP_STR "%%B"
            ECHO %\e%[33;%person.offset%H %person% %person.bkg%%\e%[34;15H%\e%[40X%\e%[35;15H%\e%[40X%\e%[36;15H%\e%[40X%\e%[35;16H!rep.str!%\e%[0m%col:c=204;204;204%
            PAUSE >NUL
        ) else IF "%%A" == "-" (
            CALL :REP_STR "%%B"
            ECHO %\e%[33;31H───You───%\e%[34;15H%\e%[40X%\e%[35;15H%\e%[40X%\e%[36;15H%\e%[40X%\e%[35;16H!rep.str!
            PAUSE >NUL
        ) else IF "%%A" == "@" (
            ECHO %\e%[%offset.head.y%;1H
            FOR /L %%N in (1, 1, !%person%.%%B.n!) DO (
                ECHO %\e%[%offset.head.x%G!%person%.%%B.%%N!%\e%[?25l%col:c=204;204;204%
            )
        ) else IF "%%A" == "CHOICE" (
            SET "start=0"
            ECHO %\e%[33;31H─────────%\e%[34;15H%\e%[40X%\e%[35;15H%\e%[40X%\e%[36;15H%\e%[40X%\e%[33d
            CALL :MAKE_CHOICE 16 temp.branch %%B
        ) else IF "%%A" == "GAME" (
            SET "%person%.branch=%%B"
            GOTO :EOF
        )
    )
)
GOTO :EOF

:CHECK_GOOD_END <person>
IF "!%1.branch!" == "1" (
    IF "!%1.day!" == "6" (
        CALL :START_DIALOGUE story\dialogue\%1\date.txt 1
    )
)
GOTO :EOF
        
:REP_STR <str>
SET "rep.str=%~1"
SET "rep.str=!rep.str:[=?!"
SET "rep.str=!rep.str:$=%col:c=166;50;98%!"
SET "rep.str=!rep.str:{=%col:c=112;56;122%!"
SET "rep.str=!rep.str:+=%\e%[0m%col:c=204;204;204%!"
GOTO :EOF

:MAKE_CHOICE <offset> <var> <choices>
SET /A "offset=%1", "choices=0"
FOR %%? in (%3 %4 %5 %6 %7 %8 %9) DO (
    CALL :REP_STR %%?
    IF "!choices!" == "0" (
        ECHO %\e%[%offset%G!rep.str!
    ) else (
        ECHO %\e%[%offset%G!choices!. !rep.str!
    )
    SET /A "choices+=1"
)
SET /A "choices-=1"
CHOICE /C !choice.str:~0,%choices%! /N >NUL
SET "%2=!%2!%ERRORLEVEL%"
GOTO :EOF

:LOAD_PERSON <person>
IF "%1" == "Jackie" (
    SET /A "offset.body.x=offset.body.y=3", "offset.head.x=22", "offset.head.y=5"
    SET "person.bkg=%bkg:c=112;56;122%"
) else IF "%1" == "Mia" (
    SET /A "offset.body.x=offset.body.y=3", "offset.head.x=14", "offset.head.y=7"
    SET "person.bkg=%bkg:c=128;100;52%"
) else (
    SET /A "offset.body.x=offset.body.y=3", "offset.head.x=18", "offset.head.y=5"
    SET "person.bkg=%bkg:c=166;50;98%"
)
FOR %%Q in (characters\%1\%1*.txt) DO (
    SET "%%~nQ.n=1"
    FOR /F "tokens=* delims=" %%A in (%%Q) DO (
        IF not "%%A" == "" (
            SET "%%~nQ.!%%~nQ.n!=%%A"
            SET /A "%%~nQ.n+=1"
        )
    )
    SET /A "%%~nQ.n-=1"
)
SET "%1.n=1"
FOR /F "tokens=* delims=" %%A in (characters\%1\fits\%day%.txt) DO (
    IF not "%%A" == "" (
        SET "%1.!%1.n!=%%A"
        SET /A "%1.n+=1"
    )
)
SET /A "%1.n-=1"
GOTO :EOF 

:INIT_NOVEL
SET /A "max.w=52", "choice.str=12345", "start=0"
SET "margin=%\e%[10G"
ECHO %\e%[0m%col:c=204;204;204%
GOTO :EOF