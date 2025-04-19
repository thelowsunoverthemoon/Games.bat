@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

:MAIN
IF not "%1" == "" ( 
    IF "%1" == "menu" (
        SET "props=%col:c=204;204;204%%\e%[2;3HLowsun 2025%col:c=105;122;140%%\e%[3;3HTurn Volume On%\e%[4;3HDon't Full Screen / Resize%\e%[5;3HRead 'How to Play Teeko' file%col:c=204;204;204%%\e%[15;23H_                 _%dn:n=1%%bk:n=20%^|_^) _  o __  \/   ^| \ _  \/%dn:n=1%%bk:n=27%^| \(_^| ^| ^| ^| /    ^|_/(_^| /%dn:n=1%%bk:n=20%___ _  _ ^|  _%dn:n=1%%bk:n=12%^|_(/_(/_^|^<(_^)%col:c=105;122;140%%\e%[21;32HPress A"
        SET "confirm=%col:c=105;122;140%%\e%[21;31HConfirm A"
    ) else IF "%1" == "end" (
       SET "props=%col:c=204;204;204%%\e%[18;29HT h e   E n d%col:c=105;122;140%%\e%[20;32HPress A"
       SET "confirm=%col:c=105;122;140%%\e%[20;31HConfirm A"
    ) else (
        GOTO :%1
    )
)
"%~F0" CONTROL > "%TEMP%\%~n0_sig.txt" | "%~F0" RAIN < "%TEMP%\%~n0_sig.txt"
TASKKILL /F /IM CHOICE.exe >NUL 2>NUL
DEL /F /Q "%~dpn0.quit"  2>NUL
EXIT /B

:RAIN
ECHO %\e%[2J
%$get_time% "t1=(((1%%A*60)+1%%B)*60+1%%C)*100+1%%D-36610100"
FOR /L %%G in () DO (
    SET /P "input="
    IF defined input (
        ECHO %confirm%
        COPY NUL "%~dpn0.quit" >NUL
        EXIT
    )
    %$get_time% "t2=(((1%%A*60)+1%%B)*60+1%%C)*100+1%%D-36610100", "dt=t2-t1"
    IF !dt! GTR 1 (
        SET /A "t1=t2", "frame=(frame + 1) %% 0x7FFFFFFF", "add.rain=frame %% 9"
        ECHO.!rain!%props%
        %$rain%
        IF "!add.rain!" == "0" (
            SET /A "rain.x=!RANDOM! %% 70", "rain.type=!RANDOM! %% 2"
            IF "!rain.type!" == "0" (
                SET "rain.par=!rain.par! "!rain.x! 1 %col:c=74;101;131%.""
            ) else (
                SET "rain.par=!rain.par! "!rain.x! 1 %col:c=108;128;148%^│""
            )
        )
    )
)
GOTO :EOF

:CONTROL
FOR /L %%C in () DO (
    FOR /F "tokens=*" %%A in ('CHOICE /C:A /N') DO (
        IF exist "%~dpn0.quit" (
            DEL /F /Q "%~dpn0.quit"
            EXIT
        )
        <NUL SET /P ".=%%A"
    )
)
GOTO :EOF