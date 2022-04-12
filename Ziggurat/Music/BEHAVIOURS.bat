SET behav[Slime]=2^>NUL SET /A "^!every:#=3^!" ^&^& (%\n%
    FOR %%J in (x y) DO (%\n%
        ^!checktrack^! %%J Slime%\n%
    )%\n%
)
SET behav[Phoenix]=2^>NUL SET /A "^!every:#=2^!" ^&^& (%\n%
    IF ^^!y[Phoenix]^^! EQU ^^!y[u]^^! (%\n%
        FOR /L %%X in (1, 1, 5) DO (%\n%
            ^!checktrack^! x Phoenix%\n%
            SET display=^^!display^^! "%ESC%[^!y[Phoenix]^!;^!x[Phoenix]^!H^!spri[Phoenix]^!"%\n%
        )%\n%
    ) else (%\n%
        ^!checktrack^! y Phoenix%\n%
    )%\n%
)
SET behav[Seraphim]=2^>NUL SET /A "^!every:#=3^!" ^&^& (%\n%
    IF ^^!x[Seraphim]^^! EQU ^^!x[u]^^! (%\n%
        ^!checktrack^! y Seraphim%\n%
        IF ^^!y[Seraphim]^^! LSS ^^!y[u]^^! (%\n%
            ^!dispseq^! Aqua Seraphim%\n%
        ) else (%\n%
            ^!dispseq^! Fireball Seraphim%\n%
        )%\n%
    ) else (%\n%
        ^!checktrack^! x Seraphim%\n%
    )%\n%
)
SET behav[Minotaur]=2^>NUL SET /A "^!every:#=6^!" ^&^& (%\n%
    FOR /L %%X in (1, 1, 3) DO (%\n%
        ^!checktrack^! y Minotaur%\n%
        FOR /F %%A in ('SET /A "76 * %%X"') DO (%\n%
            SET display=^^!display^^! "^!col:c=%%A;39;15^!%ESC%[^!y[Minotaur]^!;^!x[Minotaur]^!H^!spri[Minotaur]^!"%\n%
        )%\n%
    )%\n%
) ^|^| (%\n%
    ^!checktrack^! x Minotaur%\n%
)
SET behav[Chimera]=SET /A "x[t]=^!x[Chimera]^!","y[t]=^!y[Chimera]^!"%\n%
IF ^^!check^^! EQU 1 (%\n%
    FOR %%C in (7 9 7 8 8 6 6 6) DO (%\n%
        SET /A ^^!dir[%%C]:#=t^^!%\n%
        IF ^^!y[u]^^!^^!x[u]^^! EQU ^^!y[t]^^!^^!x[t]^^! (%\n%
            ^!dispseq^! Miasma Chimera%\n%
        )%\n%
    )%\n%
    FOR %%J in (x y) DO (%\n%
        ^!checktrack^! %%J Chimera%\n%
    )%\n%
    2^>NUL SET /A "^!every:#=10^!" ^&^& (%\n%
        SET check=0%\n%
    )%\n%
) else (%\n%
    FOR %%C in (1 4 3 3 2 2 1 1) DO (%\n%
        SET /A ^^!dir[%%C]:#=t^^!%\n%
        IF ^^!y[u]^^!^^!x[u]^^! EQU ^^!y[t]^^!^^!x[t]^^! (%\n%
            SET check=1%\n%
        )%\n%
    )%\n%
)
SET behav[MadWizard]=SET /A "x[t]=^!x[MadWizard]^!","y[t]=^!y[MadWizard]^!"%\n%
FOR %%C in (1 4 3 3 2 2 1 1) DO (%\n%
    SET /A ^^!dir[%%C]:#=t^^!%\n%
    IF ^^!y[u]^^!^^!x[u]^^! EQU ^^!y[t]^^!^^!x[t]^^! (%\n%
        SET check=1%\n%
        ^!dispseq^! Protect MadWizard%\n%
    )%\n%
)%\n%
IF not ^^!check^^! EQU 1 (%\n%
    2^>NUL SET /A "^!every:#=3^!" ^&^& (%\n%
        FOR %%J in (x y) DO (%\n%
            ^!checktrack^! %%J MadWizard%\n%
        )%\n%
    )%\n%
)%\n%
SET "check="
::"check=" is part of behav[Wizard] macro
SET behav[CrazedMage]=2^>NUL SET /A "^!every:#=7^!" ^&^& (%\n%
    IF ^^!y[CrazedMage]^^! LSS ^^!y[u]^^! (%\n%
        ^!dispseq^! Unearth CrazedMage%\n%
    ) else (%\n%
        ^!dispseq^! DemonHand CrazedMage%\n%
    )%\n%
) ^|^| (%\n%
    FOR /F %%R in ('SET /A "^!RANDOM^! * (2 - 1 + 1) / 32768 + 1"') DO (%\n%
        IF %%R EQU 1 (%\n%
            ^!checktrack^! x CrazedMage%\n%
        ) else (%\n%
            ^!checktrack^! y CrazedMage%\n%
        )%\n%
    )%\n%
)
SET behav[CorruptKing]=FOR %%S in (Serpent Dragon) DO (%\n%
    SET /A "x[t]=^!x[CorruptKing]^!","y[t]=^!y[CorruptKing]^!"%\n%
    FOR /F "tokens=1 delims=;" %%G in ("^!sp[%%S]^!") DO (%\n%
        FOR %%C in (%%G) DO (%\n%
            SET /A ^^!dir[%%C]:#=t^^!%\n%
            IF ^^!y[u]^^!^^!x[u]^^! EQU ^^!y[t]^^!^^!x[t]^^! (%\n%
                FOR %%W in (Protect %%S) DO (%\n%
                    ^!dispseq^! %%W CorruptKing%\n%
                )%\n%
            )%\n%
         )%\n%
    )%\n%
)%\n%
2^>NUL SET /A "^!every:#=3^!" ^&^& (%\n%
    FOR %%J in (x y) DO (%\n%
        ^!checktrack^! %%J CorruptKing%\n%
    )%\n%
)
SET behav[InsaneMaiden]=IF ^^!check^^! EQU 1 (%\n%
    2^>NUL SET /A "^!every:#=10^!" ^&^& (%\n%
        SET "spri[InsaneMaiden]=%col:c=156;55;163%%back:n=1%:Û:%up:n=1%%back:n=3%/:\"%\n%
        SET check=0%\n%
    )%\n%
    FOR %%J in (x y) DO (%\n%
        ^!checktrack^! %%J InsaneMaiden%\n%
    )%\n%
) else (%\n%
    2^>NUL SET /A "^!every:#=6^!" ^&^& (%\n%
        ^!music:t s=Sound InsaneInvisible^! %\n%
        SET "spri[InsaneMaiden]="%\n%
        SET check=1%\n%
    )%\n%
    SET /A "x[t]=^!x[InsaneMaiden]^!","y[t]=^!y[InsaneMaiden]^!"%\n%
    FOR %%C in (1 6 6 6) DO (%\n%
        SET /A ^^!dir[%%C]:#=t^^!%\n%
        IF ^^!y[u]^^!^^!x[u]^^! EQU ^^!y[t]^^!^^!x[t]^^! (%\n%
            ^!dispseq^! Mask InsaneMaiden%\n%
        )%\n%
    )%\n%
)
SET behav[LunaticConsort]=2^>NUL SET /A "^!every:#=7^!" ^&^& (%\n%
    ^!checktrack^! y LunaticConsort%\n%
    ^!music:t s=Sound LunaticBeam^! %\n%
    SET /A "y[Maiden]=^!y[LunaticConsort]^!","x[Maiden]=^!x[LunaticConsort]^!"%\n%
    FOR /L %%X in (1, 1, 10) DO (%\n%
        FOR %%J in (x y) DO (%\n%
            ^!checktrack^! %%J Maiden%\n%
        )%\n%
        SET display=^^!display^^! "^!col:c=157;106;209^!%ESC%[^!y[Maiden]^!;^!x[Maiden]^!H°"%\n%
    )%\n%
    SET "hitspot=^!hitspot^! ^!y[Maiden]^!^!x[Maiden]^!"%\n%
)%\n%
2^>NUL SET /A "^!every:#=6^!" ^&^& (%\n%
    ^!checktrack^! x LunaticConsort%\n%
)
SET behav[Banshee]=2^>NUL SET /A "^!every:#=5^!" ^&^& (%\n%
    SET check=y%\n%
) ^|^| (%\n%
    SET check=x%\n%
)%\n%
FOR /L %%X in (1, 1, 2) DO (%\n%
    ^!checktrack^! ^^!check^^! Banshee%\n%
    SET display=^^!display^^! "%ESC%[^!y[Banshee]^!;^!x[Banshee]^!H^!spri[Banshee]^!"%\n%
)
SET behav[Ghoul]=SET /A "x[t]=^!x[Ghoul]^!","y[t]=^!y[Ghoul]^!"%\n%
FOR %%C in (7 8 6 9 9 6 8) DO (%\n%
    SET /A ^^!dir[%%C]:#=t^^!%\n%
    IF ^^!y[u]^^!^^!x[u]^^! EQU ^^!y[t]^^!^^!x[t]^^! (%\n%
        ^!dispseq^! Tenebrae Ghoul%\n%
    )%\n%
)%\n%
2^>NUL SET /A "^!every:#=7^!" ^&^& (%\n%
    FOR /L %%X in (1, 1, 5) DO (%\n%
        ^!checktrack^! y Ghoul%\n%
        SET display=^^!display^^! "%ESC%[^!y[Ghoul]^!;^!x[Ghoul]^!H^!spri[Ghoul]^!"%\n%
    )%\n%
) ^|^| (%\n%
    2^>NUL SET /A "^!every:#=6^!" ^&^& (%\n%
        ^!checktrack^! x Ghoul%\n%
    )%\n%
)
SET behav[Totem]=IF ^^!check^^! EQU 1 (%\n%
    2^>NUL SET /A "^!every:#=22^!" ^&^& (%\n%
        ^!music:t s=Sound TotemRegen^! %\n%
        SET "spri[Totem]=°%back:n=1%%down:n=1%±%back:n=1%%down:n=1%°%back:n=1%%down:n=1%±"%\n%
        SET check=0%\n%
    )%\n%
    2^>NUL SET /A "^!every:#=10^!" ^&^& (%\n%
        FOR /F %%R in ('SET /A "^!RANDOM^! * (40 - 1 + 1) / 32768 + 1"') DO (%\n%
            SET x[Totem]=%%R%\n%
        )%\n%
    ) ^|^| (%\n%
        ^!checktrack^! y Totem%\n%
    )%\n%
) else (%\n%
    2^>NUL SET /A "^!every:#=5^!" ^&^& (%\n%
        SET "spri[Totem]=Û%back:n=1%%down:n=1%²%back:n=1%%down:n=1%±%back:n=1%%down:n=1%°"%\n%
        SET check=1%\n%
    )%\n%
    SET /A hp[Totem]+=1%\n%
)
SET behav[Demon]=FOR %%S in (DemonHand DemonFeet) DO (%\n%
    SET /A "x[t]=^!x[Demon]^!","y[t]=^!y[Demon]^!"%\n%
    FOR /F "tokens=1 delims=;" %%G in ("^!sp[%%S]^!") DO (%\n%
        FOR %%C in (%%G) DO (%\n%
            SET /A ^^!dir[%%C]:#=t^^!%\n%
            IF ^^!y[u]^^!^^!x[u]^^! EQU ^^!y[t]^^!^^!x[t]^^! (%\n%
                ^!dispseq^! %%S Demon%\n%
            )%\n%
         )%\n%
    )%\n%
)%\n%
2^>NUL SET /A "^!every:#=7^!" ^&^& (%\n%
    FOR /F %%R in ('SET /A "^!RANDOM^! * (2 - 1 + 1) / 32768 + 1"') DO (%\n%
        IF %%R EQU 1 (%\n%
            SET check=x%\n%
        ) else (%\n%
            SET check=y%\n%
        )%\n%
    )%\n%
    FOR /L %%W in (1, 1, 3) DO (%\n%
        ^!checktrack^! ^^!check^^! Demon%\n%
        SET display=^^!display^^! "%ESC%[^!y[Demon]^!;^!x[Demon]^!H^!spri[Demon]^!"%\n%
    )%\n%
)
SET behav[ThePsychic]=2^>NUL SET /A "^!every:#=15^!" ^|^| (%\n%
    SET /A "x[t]=^!x[ThePsychic]^! - 1","y[t]=^!y[ThePsychic]^! - 1"%\n%
    FOR /F %%R in ('SET /A "^!RANDOM^! * (3 - 1 + 1) / 32768 + 1"') DO (%\n%
        FOR %%P in (^^!design%%R^^!) DO (%\n%
            SET /A ^^!dir[%%P]:#=t^^!%\n%
            SET "hitspot=^!hitspot^! ^!y[t]^!^!x[t]^!"%\n%
            SET check=^^!check^^!%ESC%[^^!y[t]^^!;^^!x[t]^^!H°%\n%
        )%\n%
    )%\n%
    SET display=^^!display^^! "^!check^!"%\n%
    SET "check="%\n%
) ^&^& (%\n%
    FOR /F %%R in ('SET /A "^!RANDOM^! * (9 - 1 + 1) / 32768 + 1"') DO (%\n%
        SET /A ^^!dir[%%R]:#=ThePsychic^^!%\n%
    )%\n%
)%\n%
FOR %%S in (StoneHammer Penetrate) DO (%\n%
    SET /A "x[t]=^!x[ThePsychic]^!","y[t]=^!y[ThePsychic]^!"%\n%
    FOR /F "tokens=1 delims=;" %%G in ("^!sp[%%S]^!") DO (%\n%
        FOR %%C in (%%G) DO (%\n%
            SET /A ^^!dir[%%C]:#=t^^!%\n%
            IF ^^!y[u]^^!^^!x[u]^^! EQU ^^!y[t]^^!^^!x[t]^^! (%\n%
                ^!dispseq^! %%S ThePsychic%\n%
            )%\n%
         )%\n%
    )%\n%
)