<!-- : Begin batch script
::POLISH CODE
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
MODE 64, 45
TITLE Soul Lapse
CALL :MACROS
::MAKE MORE MACROS
::° ± ² Û
::d = dummy, cre = creature, p = display, en = enemy, re = relic, aug = augment
::Inner Realm like earth (east mountains), Outer Realm like heaven (Palace of Stars), Hell
::Health Attack Augment  Character Description
SET "logo=%col:c=145;104;189%%nx:n=2%_____%nx:n=15%.%dn:n=1%%bk:n=22%(%nx:n=8%__.%nx:n=2%,%nx:n=3%.%nx:n=2%^|%dn:n=1%%bk:n=21%`--.%nx:n=2%.'%nx:n=3%\%nx:n=1%^|%nx:n=3%^|%nx:n=2%^|%dn:n=1%%bk:n=18%^|%nx:n=2%^|%nx:n=4%^|%nx:n=1%^|%nx:n=3%^|%nx:n=2%^|%bk:n=23%\___.'%nx:n=3%`._.'%nx:n=1%`._/^|%nx:n=1%/\__%dn:n=1%%col:c=98;209;202%%bk:n=9%^|%nx:n=4%_.._%nx:n=2%__%nx:n=1%_%dn:n=1%%bk:n=15%^|___(_][_)_)%nx:n=1%(/_%dn:n=1%%bk:n=9%^|%ESC%[0m"
::RELICS affect whole team, AUGMENT passive ability
::Ideas for relics, lessen enem strong, enem weak, cre1, cre2 specific
::FOr level strong weak high attakc low attack
::Health, attack, augment, sprite, health to activate, critical, description, (enemy only) style, (character only) space
SET "creatures=Nakabasu Katachi Jimoqo Mei-mei Kaguya PrincessHimako -LightFuyumi- Atsuko Emiko Chizuru NikuyaSan MaidenIchika LadyRenga YamaYami"
SET "cre[LadyRenga]=14$0$Autumn$%col:c=201;247;176%Û%bk:n=1%%dn:n=1%%col:c=86;150;51%ß%up:n=1%%col:c=37;92;6%Í¼%bk:n=4%%up:n=1%%col:c=27;224;126%\%col:c=45;99;72%|%col:c=27;224;126%/%col:c=37;92;6%ÉÎ%col:c=130;207;43%<%up:n=1%%bk:n=2%v%dn:n=2%$6$10$"Once druid-priestess of the Imperial Family" "Brutally beheaded by a Maiden" "Only her soul remains in the Inner Realm" "Forever searching for the intangible"$6"
SET "cre[MaidenIchika]=6$1$Blossom Reform$%col:c=191;166;122%Û %col:c=245;234;113%v%up:n=1%%bk:n=3%< %col:c=115;250;232%+ %col:c=245;234;113%>%up:n=1%%bk:n=3%^%dn:n=3%%bk:n=3%ß%up:n=1%$3$6$"Once a maiden of the Imperial Family" "Exiled, but discovered the Morgenstern" "Took revenge and slaughtered them all"$5"
SET "cre[Emiko]=6$4$Autumn Winter$%bk:n=3%%col:c=64;68;120% Ã%col:c=39;47;130%ÄÛÙ%bk:n=5%%up:n=1%%col:c=66;50;84%[%col:c=65;12;156%Û%col:c=66;50;84%]%dn:n=1%$3$9$"Necromancer hailing from the Dead Citadel" "The husk of a Palace consort"$5"
SET "cre[Atsuko]=5$5$Spring$%col:c=201;147;93%Û%bk:n=1%%up:n=1%%col:c=247;250;102%-%dn:n=1%$4$5$"Blessed Human from the Inner Realm" "Imbued with power of Divine Spirit"$4"
SET "cre[Nakabasu]=7$3$Autumn$%col:c=130;41;186%%bk:n=1%\%col:c=52;24;69%Û%col:c=130;41;186%/%bk:n=2%%up:n=1%v%ESC%[1B$3$12$"Succubus from the Outer Realm" "Known to many dimensions as 'Heart Render'"$6"
SET "cre[Jimoqo]=4$4$Winter$%bk:n=1%%col:c=46;86;112%|%bk:n=1%%up:n=1%%col:c=137;162;171%^%dn:n=1%%col:c=74;72;161%Û%col:c=46;86;112%-%col:c=137;162;171%>$3$8$"Born from the East Hypoborean Mountains" "Wields the twin blades 'Taion' and 'Shimo'" "It is said she has a heart of obsidian"$3"
SET "cre[Katachi]=4$6$Winter$%bk:n=1%%col:c=128;27;18%*%col:c=71;63;56%±%col:c=128;27;18%*%bk:n=2%%dn:n=1%*%up:n=1%$2$7$"Notorious Assassin of the Inner realm" "Cruel and painful deaths crown her fame" "Nothing but a wisp, a soul of cinder and ash"$4"
SET "cre[Mei-mei]=2$5$Summer$%col:c=191;133;61%Û %col:c=57;28;97%|%up:n=1%%bk:n=3%%col:c=165;44;245%<%col:c=57;28;97%|%col:c=39;15;61%Û%col:c=57;28;97%|%col:c=165;44;245%>%bk:n=3%%up:n=1%^%dn:n=2%$1$2$"Angel from the Palace of Stars" "Uses the Tainted Hammer, weapon of Titans" "No man can withstand her beauty"$2"
SET "cre[Kaguya]=9$1$LunarGoddess$%col:c=119;168;50%%bk:n=2%º%bk:n=1%%up:n=1%º%bk:n=1%%up:n=1%Ñ%dn:n=2%%col:c=250;255;199%ÄÛ%col:c=161;199;131%%bk:n=1%%up:n=1%Ê%dn:n=1%$5$10$"Born from glowing bamboo" "Mystical Celestial from the Moon" "Ghosts still yearn for sickly love"$8"
SET "cre[Chizuru]=8$4$ThousandCranes$%bk:n=3%%col:c=232;192;81%|/%col:c=230;220;193%'Û'%col:c=232;192;81%\|%up:n=1%%bk:n=6%/\-/\%dn:n=1%$5$2$"Angel with the rare gift of Wings" "Innocent, never seen outside the Outer Realm" "Folds paper cranes in her spare time"$5"
SET "cre[PrincessHimako]=5$2$BloodSword$%bk:n=1%%col:c=242;224;172%|²_%col:c=156;151;138%|%bk:n=4%%up:n=1%%col:c=96;191;155%.%nx:n=2%%col:c=156;151;138%|%col:c=255;255;255%%bcl:c=96;191;155%*%ESC%[0m%col:c=156;151;138%>%bk:n=5%%dn:n=2%%col:c=83;110;100%Û %col:c=156;151;138%|%up:n=1%$2$3$"From the Shinqu'i Imperial Family" "Highly trained demigod" "Tragic events have left her emotionless" "Bones of demons adorn her robe"$6"
SET "cre[-LightFuyumi-]=6$2$Yin Reform$%col:c=108;184;164%%bk:n=2%' %col:c=101;110;105%Û%col:c=108;184;164%'>%bk:n=4%%up:n=1%^'%bk:n=3%%dn:n=2%<' 'v%up:n=1%$3$9$"Half Golem carved from Celestial stones" "Guardian of the Inner Realm for eons" "Etched with arcane runes of bygone magic" "Dual spirited, Dual nature"$5"
SET "cre[NikuyaSan]=6$5$Summer Winter$%bk:n=3% %col:c=145;44;84%Ý %col:c=84;44;145%±%up:n=1%%bk:n=4%%col:c=166;87;35%_%bcl:c=97;24;46%_%ESC%[0m%col:c=166;87;35%_%up:n=1%%bk:n=2%%col:c=97;24;46%Û%dn:n=2%$5$4$"The famed 'Demon Slayer' from Imperial Court" "Drenched in the blood of Hell beings" "Carries the Titan-crafted Butcher Blade"$5"
SET "cre[YamaYami]=3$4$Spring$%bk:n=2%%col:c=124;72;168%Ç%col:c=221;232;21%Û %col:c=212;25;202%ÛÄ%col:c=249;255;97%{%up:n=1%%bk:n=6%%col:c=124;72;168%Î%dn:n=1%$3$5$"Twin sisters of Death" "Raised in the Void after the Celestial War"$3"

SET "en[Absque-Sozo]=40$4$Ryujin$%bk:n=1%%col:c=158;24;9%Û%col:c=27;37;69%Û%col:c=99;26;92%Û%dn:n=1%%bk:n=3%%col:c=117;84;114%ÈÎ¼%dn:n=1%%bk:n=2%%col:c=212;95;201%Ê$15$15$"%bk:n=2% " "%col:c=131;24;181%Primordial God of the Void%ESC%[0m" "%bk:n=2%[ %col:c=48;54;43%IRON%ESC%[0m ]"$at L"
SET "en[Tamamo-no-Mae]=25$3$NineTails$%bk:n=1%%col:c=179;44;27%/%col:c=217;208;141%Û%col:c=179;44;27%\%bk:n=3%%dn:n=1%%bcl:c=99;46;34%ÇÄ·%ESC%[0m%bk:n=3%%dn:n=1%%col:c=217;208;141%ß%nx:N=1%ß$13$6$"Fox spirit of 9 tails" "Unearthly beauty, fat with desire" "Courtesan to many an emperor"$at G"
SET "en[Omukade]=10$3$Winter Reform$%col:c=168;162;50%Û%up:n=1%%bk:n=1%^%dn:n=1%%col:c=83;122;28%²%col:c=168;162;50%Û%col:c=83;122;28%²%col:c=168;162;50%Û%col:c=83;122;28%²$5$5$"Man-eating centipedes formed by Necromancers" "Weaponized in the Celestial Wars" "Left behind for the Inner Realm"$hp G"
SET "en[Nukekubi]=5$4$Extend$%col:c=245;199;135%Û%bk:n=1%%dn:n=1%%col:c=173;99;64%²$5$7$"Rejoice in the drinking of blood" "Necks that stretch for miles on end" "Corrupted villagers from the Inner Realm"$at G"
SET "en[Amanozako]=20$6$Proliferate Reform$%bk:n=2%%col:c=227;25;25%'>%bcl:c=150;6;6%%col:c=33;4;4%Î%ESC%[0m%col:c=227;25;25%<'%bk:n=4%%up:n=1%±%bk:n=2%%dn:n=2%°±v±°$20$20$"Monstrous Goddess born from blood and vomit" "Once Courtesan of the Palace of Stars" "Insidious nature"$at L"
SET "en[LesserKitsune]=6$1$Morph$%col:c=219;107;33%ÛÌ$3$5$"Young fox spirits" "Shapeshift into ethereal women"$hp L"
SET "en[GreaterKitsune]=8$2$Morph$%col:c=219;107;33%ÛÌÍ%bk:n=2%%up:n=1%º/%bk:n=2%%dn:n=2%º\$3$4$"Elder fox spirit with five tails" "Sly, cunning, mischievous"$hp L"
SET "en[Chimera]=12$5$Beast$%col:c=188;20;20%%bk:n=1%}Û{%col:c=117;186;20%-%bk:n=3%%dn:n=1%%col:c=119;24;9%| |%col:c=117;186;20%\_<$5$13$"Fallen beasts from the Palace of Stars" "Head of a Lion, tail of a Snake" "Terrorize the Inner Realm"$at G"
SET "en[Oni]=7$3$Autumn$%bk:n=1%%col:c=110;46;10%<%col:c=50;168;82%Û%col:c=110;46;10%>$2$12$"Hulking creatures of Hell" "Carry spiked iron clubs" "Footsoldiers of General Ketsueki"$hp G"
SET "en[Ningyo]=6$4$Spring$%bk:n=2%%col:c=93;112;98%|%col:c=53;120;109%_Û%up:n=1%%bk:n=3%%col:c=130;194;164%v%dn:n=2%%bk:n=1%%col:c=93;112;98%|%nx:n=1%%col:c=53;120;109%²±<$2$5$"Mer-creatures from the Ocean of Tears" "Treacherous golden scales adorn it's back" "Suffered greatly in the Celestial Wars"$hp G"
SET "en[Jami]=9$1$Mountain Summer$%col:c=127;177;186%Û%col:c=31;195;224%%bk:n=2%%dn:n=1%Ä²Ä%bk:n=2%%dn:n=1%|$4$12$"Corrupt manifestations of Nature" "Harbingers of plague and disease" "Torture Angels from the Outer Realm"$hp L"
SET "en[Titan]=35$10$Shatter$%bk:n=4%%col:c=128;51;15%±   %col:c=15;32;128%Û  %col:c=55;75;189%³%col:c=115;55;189%\%bk:n=9%%dn:n=1%%col:c=55;75;189%<%col:c=115;55;189%²ÄÒÍÒÄ¾ \%bk:n=10%%dn:n=1%%col:c=128;51;15%±%col:c=115;55;189%  ÈÑ¼%bk:n=5%%dn:n=1%± É²»%bk:n=4%%dn:n=1%%col:c=128;51;15%Ä%col:c=115;55;189%¼ È%col:c=128;51;15%Ä%bk:n=6%%up:n=5%±     %col:c=192;64;227%\$10$10$"Eternal enemy of the Gods" "Bound to Hell after the Celestial War" "Said to be Fallen Angels consumed by the Citadel" "Immense strength, power over the very Stars" "%bk:n=2% "$at G"

SET "aug[Reform]="act]=""
SET "aug[Shrivel]="char]=%col:c=27;37;69%Û%bk:n=1%%dn:n=1%%col:c=30;23;128%ß""
SET "aug[Ryujin]="act]=" "sty]=hp L" "#turn]+=1" "#at]+=1" "#hp]=40" "aug]=InkVeins" "char]=%bk:n=1%%col:c=65;74;128%^>%col:c=158;24;9%Û%col:c=74;59;140%%dn:n=1%%bk:n=1%È%col:c=212;95;201%Í%col:c=74;59;140%»%dn:n=1%%bk:n=4%%col:c=74;59;140%É%col:c=212;95;201%Í%col:c=74;59;140%Í%col:c=212;95;201%¼ Ë%dn:n=1%%bk:n=6%%col:c=74;59;140%È%col:c=212;95;201%Í%col:c=74;59;140%Í%col:c=212;95;201%Í%col:c=74;59;140%Í%col:c=212;95;201%¼""
SET "aug[InkVeins]="act]=" "sty]=at G" "#crit]=5" "#turn]=1" "#hp]=40" "aug]=Shrivel" "desc]=%ESC%[s%ESC%[u%ESC%[B%ESC%[s- %col:c=131;24;181%Primordial God of the Void%ESC%[0m%ESC%[u%ESC%[B%ESC%[s[ %col:c=255;95;46%FLAME%ESC%[0m ]%ESC%[u%ESC%[B" "char]=%bk:n=2%%col:c=212;95;201%ÌÎ%col:c=27;37;69%Û%col:c=212;95;201%Î¹%up:n=1%%bk:n=4%ÉÎ»%up:n=1%%bk:n=2%Ë%dn:n=3%%bk:n=2%ÈÎ¼%dn:n=1%%bk:n=2%Ê""
SET "aug[Shatter]="]=FallenAngel" "char]=%col:c=67;40;94%%bk:n=2%ÔÊÛÊ¾%up:n=1%%bk:n=4%¶ Ç%up:n=1%%bk:n=3%%col:c=138;11;32%· Ö" "#at]=5" "#turn]+=2" "hp]=15" "desc]=%ESC%[s- True form of the Titan%ESC%[u%ESC%[B%ESC%[s- Snapped bones jut out of rotten wings%ESC%[u%ESC%[B""
SET "aug[Mountain]="]=EnragedJami" "sty]=at G" "char]=%col:c=194;101;101%Û%col:c=207;27;27%%bk:n=2%%dn:n=1%Ô²¾%bk:n=3%%dn:n=1%ÕÑ¸""
SET "aug[DarkEmbrace]="#tim]+=1" "#at]=3+#tim]" "#hp]=7" "]=%col:c=186;71;161%Shinigami%ESC%[0m""
SET "aug[NineTails]="#at]=2" "#crit]-=2" "#turn]+=1" "]=%bcl:c=179;44;27%%col:c=255;255;255%Tamamo-no-Mae%ESC%[0m" "char]=%bk:n=1%%col:c=179;44;27%/%bcl:c=217;208;141%%col:c=247;71;52%v%ESC%[0m%col:c=179;44;27%\%bk:n=4%%dn:n=1%%col:c=247;71;52%¶%bcl:c=99;46;34%ÇÄ·%ESC%[0m%col:c=247;71;52%Ç%bk:n=4%%dn:n=1%%col:c=217;208;141%ß%col:c=247;71;52%×%col:c=217;208;141%ß""
SET "aug[Blossom]="#tim]+=1" "#hp]=6+#tim]" "#at]=1" "]=OrchidIchika""
SET "aug[Extend]="#turn]+=1" "char]=%col:c=245;199;135%%nx:n=1%/%bk:n=2%%dn:n=1%%col:c=173;99;64%²%col:c=245;199;135%%up:n=2%\%bk:n=3%%up:n=1%`Û`""
SET "aug[ThousandCranes]="#hp]=0" "#turn]+=2" "#at]-=1" "char]=%col:c=230;220;193%%bk:n=1%'Û' %col:c=255;255;255%-v-%up:n=1%%bk:n=9%-v-  -v-%dn:n=2%%bk:n=9%-v- -v-%up:n=1%""
SET "aug[Proliferate]="#hp]+=2"
SET "aug[Yang]="#turn]=1" "#at]=2" "#hp]=6" "#crit]=4" "]=-LightFuyumi-" "aug]=Yin Reform" "char]=%col:c=108;184;164%%bk:n=2%' %col:c=101;110;105%Û%col:c=108;184;164%'^>%bk:n=4%%up:n=1%^^'%bk:n=3%%dn:n=2%^<' 'v%up:n=1%""
SET "aug[Yin]="#turn]+=1" "#at]+=3" "#hp]=6" "#crit]-=2" "]=~DarkFuyumi~" "aug]=Yang Reform" "char]=%col:c=110;32;30%%bk:n=2%' %col:c=101;110;105%Û%col:c=110;32;30%'~%bk:n=4%%up:n=1%~'%bk:n=3%%dn:n=2%~' '~%up:n=1%""
SET "aug[LunarGoddess]="#turn]+=2" "#at]+=5" "]=%bcl:c=222;178;58%%col:c=66;58;36%Tsuki-Yomi%ESC%[0m" "char]=%col:c=204;230;208%%bk:n=1%-%col:c=245;245;127%Û%col:c=204;230;208%-%bk:n=3%%up:n=1%\^|/%bk:n=3%%dn:n=2%/^|\%up:n=1%""
SET "aug[Morph]="#at]+=4" "sty]=hp G" "char]=%col:c=191;40;29%%bk:n=1%/%col:c=227;189;143%Û%col:c=191;40;29%\""
SET "aug[BloodSword]="#hp]+=3" "#at]+=5" "#crit]-=1" "]=%col:c=79;227;200%QueenHimako%ESC%[0m" "char]=%bk:n=1%%col:c=79;227;200%^|²_%col:c=156;151;138%^|%bk:n=4%%up:n=1%%col:c=96;191;155%.M %col:c=156;151;138%{%col:c=255;255;255%%bcl:c=96;191;155%-%ESC%[0m%col:c=156;151;138%^>%bk:n=6%%dn:n=2%%col:c=79;227;200%/%col:c=83;110;100%Û%col:c=79;227;200%\%col:c=156;151;138%^|%up:n=1%""
SET "aug[Beast]="#at]+=4""
SET "aug[Autumn]="#at]+=3" "#crit]+=1""
SET "aug[Winter]="#hp]+=3" "#at]-=1""
SET "aug[Spring]="#crit]-=1" "#at]-=1""
SET "aug[Summer]="#turn]+=1" "#crit]+=1""

SET "rel[BindingSigil]="cre@crit]-=1" "cre@at]+=2" "cre@hp]+=3" "en@turn]+=1"$%col:c=212;2;2%Ú%col:c=143;0;0% Ö·%bk:n=4%%dn:n=1%Ã¸¾º%bk:n=4%%dn:n=1%Õµ %col:c=212;2;2%Ï$Used by early Necromancers to constrict Death"
SET "rel[Pandora'sBox]="cre@hp]-=3" "en@hp]-=3"$%col:c=171;36;79%²%bcl:c=196;110;137%%col:c=68;34;156%:%col:c=171;36;79%²%dn:n=1%%bk:n=3%%bcl:c=230;172;190% %bcl:c=230;172;190%v %bcl:c=0;0;0%$Ancient horrors reside within"
SET "rel[HolyStaff]="en@pa]=0" "en@hp]+=1" "cre@at]-=1"$%col:c=27;154;222%ÃÛ´%col:c=108;134;148%%bk:n=2%%dn:n=1%Î%bk:n=1%%dn:n=1%º%bk:n=1%%dn:n=1%º$Celestial meteor fashioned into weapon"
SET "rel[GobletOfDesire]="en@at]-=2" "cre@at]-=1"$%col:c=196;153;43%ÛÛÛ%dn:n=1%%bk:n=3%%col:c=196;43;43%²%col:c=196;153;43%Û%col:c=122;64;189%²%dn:n=1%%bk:n=3%%col:c=196;153;43%_Û_$From the Palace of Stars"
SET "rel[FrostChakra]="en@hp]-=1" "cre@pa]-=1"$%col:c=51;208;212%°±²Û%dn:n=1%%bk:n=4%Û%col:c=137;240;235%ÛÛ%col:c=51;208;212%²%dn:n=1%%bk:n=4%²±°±$Blinding vortex of ice"
SET "rel[SoulAmulet]="cre@at]-=1" "en@at]-=1"$%col:c=255;255;255%ÍËÍ%dn:n=1%%bk:n=2%%col:c=199;163;163%Û$A confined Titan soul"
SET "rel[HealingPendant]="cre@hp]+=1" "cre@at]-=1"$%col:c=92;48;24%²°²%dn:n=1%%bk:n=2%%col:c=245;242;66%Û$Imbued with sunlight"
SET "rel[BloodOfFukushu]="cre@hp]-=1" "cre@at]+=1"$%col:c=71;47;47%°±°%dn:n=1%%bk:n=3%±%col:c=128;9;9%Û%col:c=71;47;47%±%dn:n=1%%bk:n=3%°±°$Bitter, flacking, blood"
SET "rel[FallenDemonHeart]="cre@turn]+=1" "cre@hp]-=3" "cre@at]-=1"$%col:c=74;18;31%Û%bk:n=1%%dn:n=1%%col:c=38;25;23%^<%col:c=80;55;240%±%col:c=74;18;31%Û%bk:n=3%%dn:n=1%Û%col:c=70;14;107%²%col:c=38;25;23%^>%dn:n=1%%bk:n=2%v$Beware to all those who possess it"

SET "ev[1]=%col:c=255;95;46%FLAME$at$2$^!cre[%%@at]^!$Chance for Insane (+10^)"
SET "ev[2]=%col:c=48;54;43%IRON$hp$2$3$Damage taken is one less and immune to Critical"
SET "ev[3]=%col:c=137;70;176%VOID$hp$-^!cre[%%@hp]^!$^!cre[%%@hp]^!$Sacrifice all for Otherwordly power"
ECHO %ESC%[?25l

:SET
SET "rel[image]=#"
SET /A "d[cre]=d[run]=0"
PUSHD DATA 2>NUL
IF exist SAVE.sav (
    < SAVE.sav (
        SET /P cre[can]=
        SET /P souls=
        SET /P level=
    )
    POPD
    FOR /F "tokens=* skip=1" %%A in (Characters.txt) DO (
        SET "cre[all]=%%A"
    )
    PUSHD DATA
    FOR %%Q in (!cre[all]!) DO (
        SET /A d[cre]+=1", "d[num]=1"
        FOR %%C in (!cre[can]!) DO (
            IF "%%Q" == "%%C" (
                SET "d[num]="
            )
        )
    )
    CALL :MAKESTATS cre
    CALL :ERROR !d[run]! "GTR 20" "Party too Full, !d[run]!/20"
    CALL :ERROR defined "d[num]" "Wrong Characters"
    CALL :ERROR !d[cre]! "GTR 5" "Too many Characters"
    CALL :ERROR !d[cre]! "EQU 0" "Too little Characters"
) else (
    SET "level=1"
    SET "cre[can]=Jimoqo Katachi Emiko" & SET "cre[all]=Jimoqo Katachi Emiko"
    CALL :MAKESTATS cre
    CALL :STORY "5;5HThe Inner Realm." "6;7HThe Outer Realm." "12;10HThe ignorant ones name the Inner Realm as Hell," "9;3HThe Outer Realm as Heaven." "14;10HYet, there is a real Hell," "16;11Hfar from the Earthly despairs of the Inner." "19;2HOur sages tell us that this Hell is the true Void, true Chaos;" "3;4Hthey herald the coming of an age of Darkness." "23;9HOnly fools would scoff at such wise men..."
)
FOR /F "tokens=1-3 delims=; skip=%level%" %%A in (Levels.sav) DO (
    SET "en[all]=%%A"
    SET "rel[all]=%%B"
    SET "dia[all]=%%C"
    GOTO :LOAD
)

:LOAD
FOR %%R in (%rel[all]%) DO (
    SET /A "rel[num]+=1"
    SET "rel[!rel[num]!]=%%R"
    SET "rel[choice]=!rel[choice]!!rel[num]!"
    FOR /F "tokens=1-3 delims=$" %%1 in ("!rel[%%R]!") DO (
        SET "%%R[eff]=%%1"
        SET "rel[image]=!rel[image]:#=!%margin%!rel[num]!) %%R%ESC%[1B%ESC%[12G- %%3%ESC%[s%margin%%%2#%ESC%[2B%ESC%[0m"
        FOR %%Q in (%%1) DO (
            FOR /F "tokens=1-4 delims=@]=" %%1 in ("%%~Q") DO (
                IF "%%1" == "cre" (
                    SET "rel[image]=!rel[image]:#=%ESC%[u%ESC%[1B%ESC%[12GCREATURE : %%2 %%3%%4%ESC%[s#!"
                ) else (
                    SET "rel[image]=!rel[image]:#=%ESC%[u%ESC%[1B%ESC%[12GENEMY : %%2 %%3%%4%ESC%[s#!"
                )
            )
        )
    )
)
CALL :MAKESTATS en
SET "p[stats]=%p[stats]:~2%%ESC%[1B%margin%Relic : None%bk:n=4%^!rel[cur]^!"
%music:t s=Music ColourfulMind%

:MENU
ECHO %ESC%[2J%ESC%[12;15H%logo%%ESC%[24;28HA) Battle%ESC%[26;28HB) Gacha%ESC%[28;28HC) Credits%ESC%[30;28HD) Reload%ESC%[32;28HE) Exit%ESC%[1B
CHOICE /C ABCDE /N>NUL
%music:t s=Sound Confirm%
IF !errorlevel! EQU 1 (
    SET /A "d[rand]=!RANDOM! * (3 - 1 + 1) / 32768 + 1"
    FOR %%X in (!d[rand]!) DO (
        SET "ev[cur]=!ev[%%X]!"
    )
    CALL :DIALOGUE
    %kill%
    IF %level% EQU 15 (
        %music:t s=Music NorthernLightsOvertheTwinCities%
    ) else (
        %music:t s=Music TheMayanCycleBorgia%
    )
    GOTO :ROUND
) else IF !errorlevel! EQU 2 (
    IF !souls! GEQ 100 (
        CALL :GACHA
    ) else (
        ECHO %ESC%[25GNot enough Souls
    )
) else IF !errorlevel! EQU 3 (
    CALL :CREDITS
) else IF !errorlevel! EQU 4 (
    %kill%
    CALL :RINSE
    GOTO :SET
) else (
    %kill%
    EXIT
)
PAUSE>NUL
GOTO :MENU

:ROUND
FOR /L %%# in () DO (
    SET "p[message]=Press any key to continue"
    ECHO %ESC%[2J%p[en]%%ESC%[5;6H%p[cre]%%ESC%[0m%p[stats]%%ESC%[1B%margin%A^) Attack, B^) Switch Relic, C^) Evolve, D^) End Turn%ESC%[s
    CHOICE /C ABCD /N>NUL
    %music:t s=Sound Confirm%
    IF !errorlevel! EQU 1 (
        ECHO %margin%Choose Character!en[pnum]!%ESC%[4;6H!cre[pnum]!%ESC%[u%margin%
        %disploop:?=cre%
                CHOICE /C AB /N>NUL
                IF !errorlevel! EQU 1 (
                    %music:t s=Sound Confirm%
                    IF !cre[%%@us]! LSS !cre[%%@turn]! (
                        ECHO %ESC%[1B%margin%Choose Monster%up:n=1%
                        %disploop:?=en%
                                CHOICE /C AB /N>NUL
                                IF !errorlevel! EQU 1 (
                                    %music:t s=Sound Confirm%
                                    FOR %%Q in (!cre[error]!) DO (
                                        SET /A "cre[%%Qus]+=1"
                                        CALL :DAMAGE "en[%%@" "cre[%%Q"
                                        CALL :MOVEANIM "2+(3*%%Q)" "6" "!pos[%%@y]!" "!pos[%%@x]!" "cre" "%%Q"
                                        CALL :CHECKDEAD en
                                    )
                                )
                            ) else (
                                SET "p[message]=%ESC%[1B!en[%%@]! is dead"
                            )
                        )
                    ) else (
                        SET "p[message]=!cre[%%@]! has attacked !cre[%%@turn]! time already"
                    )
                )
            ) else (
                SET "p[message]=%ESC%[1B!cre[%%@]! is dead"
            )
        )
    ) else IF !errorlevel! EQU 2 (
        ECHO %ESC%[1B!rel[image]:#=!%margin%Q^) None
        CHOICE /C %rel[choice]%Q /N>NUL
        FOR %%C in (!errorlevel!) DO (
            SET "rel[cur]=!rel[%%C]!"
        )
    ) else IF !errorlevel! EQU 3 (
        ECHO %margin%Choose Evolve%ESC%[4;6H!cre[pnum]!%ESC%[u%margin%
        %disploop:?=cre%
                SET "d[cre]=!cre[error]!"
                CHOICE /C AB /N>NUL
                IF !errorlevel! EQU 1 (
                    ECHO %margin%%ESC%[1BChoose Drain%up:n=1%
                    %disploop:?=cre%
                            CHOICE /C AB /N>NUL
                            IF !errorlevel! EQU 1 (
                                IF !d[cre]! NEQ !cre[error]! (
                                    FOR /F "tokens=1-5 delims=$" %%1 in ("%ev[cur]%") DO (
                                        FOR %%X in (!d[cre]!) DO (
                                            IF "!cre[%%Xdesc]:%%1%ESC%[0m ]=!" == "!cre[%%Xdesc]!" (
                                                SET /A "d[min]=cre[%%X%%2]+%%3", "d[max]=cre[%%@%%2]-%%4"
                                                ECHO %ESC%[1B%margin%[ %%1%ESC%[0m ] : %%5%ESC%[1B%margin%%ESC%[1m!cre[%%X]!%ESC%[0m %%2 (!cre[%%X%%2]! ---^> !d[min]!^)%ESC%[1B%margin%%ESC%[1m!cre[%%@]!%ESC%[0m %%2 (!cre[%%@%%2]! ---^> !d[max]!^)%ESC%[2B%margin%A^) Confirm, B^) Back
                                                CHOICE /C AB /N>NUL
                                                IF !errorlevel! EQU 1 (
                                                    %music:t s=Sound Evolve%
                                                    SET /A "cre[%%X%%2]=d[min]", "cre[%%@%%2]=d[max]"
                                                    SET "cre[%%Xdesc]=!cre[%%Xdesc]!%ESC%[s[ %%1%ESC%[0m ]%ESC%[u%ESC%[B"
                                                    IF "%%1" == "%col:c=137;70;176%VOID" (
                                                        SET "cre[%%Xaug]=!cre[%%Xaug]! DarkEmbrace Reform"
                                                        SET "cre[%%Xpa]=5"
                                                    )
                                                    SET "p[message]=!cre[%%X]! has evolved to %%1%ESC%[0m"
                                                )
                                            ) else (
                                                SET "p[message]=!cre[%%X]! has already evolved"
                                            )
                                        )
                                    )
                                ) else (
                                    SET "p[message]=Cannot have same unit"
                                )
                            )
                        )
                    )
                )
            )
        )
    ) else (
        FOR %%E in (!en[list]!) DO (
            FOR /L %%Q in (1, 1, !en[%%Eturn]!) DO (
                CALL :ENEMOVE %%E
            )
        )
        IF defined rel[cur] (
            SET "p[message]=!p[message]!, !rel[cur]! activated"
            FOR %%R in ("!rel[cur]!") DO (
                FOR %%K in (!%%~R[eff]!) DO (
                    SET "d[relic]=%%~K"
                    FOR %%Q in (!cre[list]!) DO (
                        SET /A "!d[relic]:@=[%%Q!"
                    )
                )
            )
            SET "rel[cur]="
        )
        FOR %%X in (%cre[era]%) DO (
            SET "%%X="
        )
        CALL :CHECKDEAD cre
    )
    ECHO %margin%%ESC%[0m!p[message]!^^!
    PAUSE>NUL
)

:STORY
FOR %%S in (%*) DO (
    ECHO %col:c=145;104;189%%ESC%[!d[sty]!%col:c=98;209;202%%ESC%[%%~S
    SET "d[sty]=%%~S"
    PAUSE>NUL
)
GOTO :EOF

:GACHA
FOR /L %%G in (1, 1, 28) DO (
    ECHO %ESC%[2J!col:c=240;%%G0;115!%ESC%[%%G;30H%nx:n=2%^^^%dn:n=1%%bk:n=2%\²/%dn:n=1%%bk:n=4%^<²Û²^>%dn:n=1%%bk:n=4%/²\%dn:n=1%%bk:n=2%v
    %framerate%
)
ECHO %ESC%[2J%ESC%[28;29H%nx:n=3%^^^%dn:n=1%%bk:n=2%\²/%dn:n=2%%bk:n=5%^<² Û ²^>%dn:n=2%%bk:n=5%/²\%dn:n=1%%bk:n=2%v
SET /A "d[rand]=!RANDOM! * (14 - 1 + 1) / 32768 + 1","souls-=100"
FOR /F "tokens=%d[rand]%" %%A in ("%creatures%") DO (
    IF "!cre[can]:%%A=!" == "!cre[can]!" (
        SET "cre[can]=!cre[can]! %%A"
    ) else (
        ECHO %ESC%[28G%col:c=255;255;255%Duplicate
    )
    FOR /F "tokens=1-4 delims=$" %%1 in ("!cre[%%A]!") DO (
        SET "d[cre]=%%4"
        ECHO %ESC%[32G%ESC%[2B!d[cre]!%col:c=255;255;255%%ESC%[1m%ESC%[32G%ESC%[2B:%ESC%[s%bk:n=16%%%A^^!%ESC%[u %%3, %%1, %%2%ESC%[0m
    )
)
CALL :SAVE
GOTO :EOF

:RINSE
REM POLISH
FOR %%W in (en cre) DO (
    FOR /L %%N in (1, 1, !%%W[num]!) DO (
        SET "%%W[%%Ndesc]="
        SET "%%W[%%Nact]="
        SET "%%W[%%Nus]="
    ) 
)
FOR %%Q in (en[num] cre[num] cre[list] en[list] cre[choice] en[choice] cre[era] p[stats] p[cre] cre[pnum] en[pnum] p[en] rel[image] rel[choice] rel[num]) DO (
    SET "%%Q="
)
GOTO :EOF

:ERROR
IF %1 %~2 (
    ECHO %ESC%[2;4H[ %~3 ]%ESC%[4;4HPlease edit Character Sheet :^)
    PAUSE>NUL
    EXIT
)
GOTO :EOF

:DIALOGUE
FOR /F "tokens=1-2 delims=$" %%A in ("%dia[all]:,=^,%") DO (
    TITLE Soul Lapse : %%~A
    ECHO %ESC%[2J%p[en]%%ESC%[5;6H%p[cre]%%col:c=255;255;255%%ESC%[1m%%~A%ESC%[0m%ESC%[s
    FOR /F "tokens=1 delims=$" %%1 in ("%ev[cur]%") DO (
        FOR %%Q in ("Evolution Path : [ %%1%ESC%[0m ]" %%B) DO (
            <NUL SET /P "=%ESC%[u%ESC%[1B%margin%%ESC%[0J%%~Q"
            PAUSE>NUL
        )
    )
)
GOTO :EOF

:MAKESTATS
FOR %%V in (!%1[all]!) DO (
    SET /A "%1[num]+=1"
    SET "%1[!%1[num]!]=%%~V"
    SET "%1[list]=!%1[list]! !%1[num]!"
    SET "%1[choice]=!%1[choice]!!%1[num]!"
    FOR /F "tokens=1-8 delims=$" %%A in ("!%1[%%~V]!") DO (
        FOR %%O in (!%1[num]!) DO (
            SET /A "%1[%%Ohp]=%%A","%1[%%Oat]=%%B","%1[%%Opa]=%%E","%1[%%Oturn]=1","%1[%%Ocrit]=%%F"
            SET "%1[%%Oaug]=%%C"
            SET "%1[%%Ochar]=%%D"
            IF "%1" == "cre" (
                SET /A "d[run]+=%%H"
                SET "cre[era]=!cre[era]! cre[!cre[num]!us]"
                SET "p[stats]=!p[stats]!, ^^^!cre[%%O]^^^! : ^^^!cre[%%Ohp]^^^!"
                SET "p[cre]=!p[cre]!^^^!cre[%%Ochar]^^^!%ESC%[3B%margin%"
                SET "cre[pnum]=!cre[pnum]!%%O)%ESC%[3B%margin%"
            ) else (
                SET /A "pos[%%Ox]=!RANDOM! * (62 - 20 + 1) / 32768 + 20","pos[%%Oy]=!RANDOM! * ((2+(3*cre[num])) - 5 + 1) / 32768 + 5"
                SET "en[pnum]=!en[pnum]!%ESC%[!pos[%%Oy]!;!pos[%%Ox]!H%up:n=1%!en[num]!)
                SET "p[en]=!p[en]!%ESC%[!pos[%%Oy]!;!pos[%%Ox]!H^^^!en[%%Ochar]^^^!"
                SET "en[%%Osty]=%%H"
            )
            FOR %%W in (%%G) DO (
                SET "%1[%%Odesc]=!%1[%%Odesc]!%ESC%[s- %%~W%ESC%[u%ESC%[B"
            )
        )
    )
)
GOTO :EOF

:DAMAGE <attacked> <attacker>
SET "d[rand]="
IF "!%~1desc]:IRON%ESC%[0m ]=!" == "!%~1desc]!" (
    SET /A "%~1hp]-=!%~2at]!","d[rand]=!RANDOM! * (%~2crit] - 1 + 1) / 32768 + 1"
) else (
    SET /A "%~1hp]-=(!%~2at]!-1)"
)
IF !d[rand]! EQU 1 (
    IF "!%~2desc]:FLAME%ESC%[0m ]=!" == "!%~2desc]!" (
        SET /A "%~1hp]-=5"
        SET "p[message]=Critical (+5)"
    ) else (
        SET /A "%~1hp]-=10"
        SET "p[message]=Insane (+10)"
    )
)
SET "p[message]=!%~2]! did !%~2at]! damage to !%~1]!, !p[message]!"
GOTO :EOF

:CREDITS
FOR %%W in ("Lowsun : Idea, Code, Graphics" "ASCII Font : http://patorjk.com/" "DOStips & IcarusLives : Inspiration" "Marika Takeuchi : ColourfulMind" "ToneDock, SoundSnap : Sound Effects" "Jeremy Haladyna et al : TheMayanCycleBorgia" "Innova 2010 : NorthernLightsOvertheTwinCities") DO (
    ECHO %ESC%[18G%%~W
    %framerate%
)
GOTO :EOF

:CHECKDEAD
FOR %%G in (!%1[list]!) DO (
    IF !%1[%%Ghp]! LEQ 0 (
        SET "%1[%%Gchar]="
        SET "%1[list]=!%1[list]:%%G=!"
        SET "%1[pnum]=!%1[pnum]:%%G)=!"
        SET "p[message]=!%1[%%G]! has died, !p[message]!"
        IF "!%1[list]: =!" == "" (
            IF "%1" == "en" (
                SET /A "souls+=50", "level+=1"
                SET "p[message]=!p[message]!%ESC%[2B%ESC%[29G%col:c=245;235;61%VICTORY"
                IF %level% EQU 15 (
                    SET "level=1"
                    SET "p[message]=!p[message]!%ESC%[1B%ESC%[23G%col:c=145;201;198%Prophecies Of Sakuru%col:c=121;140;139%%ESC%[1B%ESC%[5GShards of dark, congealed matter splinter from the Earth.%ESC%[1B%ESC%[5GThe Void is collapsing.%ESC%[1B%ESC%[5GThe unlikely heroes turn towards the Void...%ESC%[1B%ESC%[5GAnd make the ultimate sacrifice.%ESC%[1B%ESC%[5G"
                )
                CALL :SAVE
            ) else (
                SET "p[message]=!p[message]!%ESC%[2B%ESC%[30G%col:c=201;34;34%DEFEAT"
            )
            ECHO %margin%%ESC%[0m!p[message]!
            CALL :RINSE
            PAUSE>NUL
            %kill%
            %music:t s=Music ColourfulMind%
            GOTO :SET
        )
    ) else (
        IF !%1[%%Ghp]! LEQ !%1[%%Gpa]! (
            IF not defined %1[%%Gact] (
                %music:t s=Sound Passive%
                FOR %%A in (!%1[%%Gaug]!) DO (
                    SET "p[message]=!%1[%%G]! activated %%A, !p[message]!"
                    SET "%1[%%Gact]=1"
                    FOR %%Q in (!aug[%%A]!) DO (
                        SET "d[pa]=%%~Q"
                        IF "!d[pa]:#=!" == "!d[pa]!" (
                            SET "%1[%%G!d[pa]!"
                        ) else (
                            SET /A "!d[pa]:#=%1[%%G!"
                        )
                    )
                )
            )
        )
    )
)
GOTO :EOF

:SAVE
SET "d[cre]="
FOR %%G in (%cre[can]%) DO (
    FOR /F "tokens=8 delims=$" %%Q in ("!cre[%%G]!") DO (
        SET "d[cre]=!d[cre]!%%G (%%Q^^), "
    )
)
POPD
(
    ECHO Availible Creatures (20^): %d[cre]:~0,-2%
    ECHO %cre[all]%
) > Characters.txt
PUSHD DATA
(
    ECHO %cre[can]%
    ECHO %souls%
    ECHO %level%
) > SAVE.sav
GOTO :EOF

:ENEMOVE
REM All these extra variables bleck. But it was the best way to facilitate the function
FOR /F "tokens=1-2" %%A in ("!en[%1sty]!") DO (
    SET "d[equ]=%%B"
    SET "d[sty]=%%A"
    IF "%%B" == "L" (
        SET "d[num]=10000"
    ) else (
        SET "d[num]=0"
    )
)
FOR %%Q in (%cre[list]%) DO (
    IF !cre[%%Qhp]! GTR 0 (
        IF !cre[%%Q%d[sty]%]! %d[equ]%EQ !d[num]! (
            SET /A "d[num]=!cre[%%Q%d[sty]%]!","d[cre]=%%Q"
        )
    )
)
CALL :DAMAGE "cre[%d[cre]%" "en[%1"
CALL :MOVEANIM "!pos[%1y]!" "!pos[%1x]!" "2+(3*d[cre])" "6" "en" "%1"
GOTO :EOF

REM Prefix and number are seperated since some characters are poisonous to command line arguments
:MOVEANIM <y> <x> <enemyy> <enemyx> <prefix> <number>
SET /A "d[y]=%~1","d[x]=%~2","d[ysm]=(%~3-d[y])+(1|((%~3-d[y])>>7))*-1","d[xsm]=%~4-d[x]"
SET "d[cre]=!%~5[%~6char]!"
SET "%~5[%~6char]="
FOR %%Q in (x y) DO (
    IF !d[%%Qsm]! LSS 0 (
        SET "d[run]=-1"
    ) else IF !d[%%Qsm]! GTR 0 (
        SET "d[run]=1"
    ) else (
        SET "d[run]=0"
    )
    SET "d[%%Qsm]=!d[%%Qsm]:-=!"
    FOR /L %%$ in (1, 1, !d[%%Qsm]!) DO (
        SET /A "d[%%Q]+=d[run]"
        ECHO %ESC%[2J%p[en]%%ESC%[5;6H%p[cre]%%ESC%[0m%p[stats]%%ESC%[s%ESC%[!d[y]!;!d[x]!H!d[cre]!%ESC%[u
        %framerate%
    )
)
SET "%~5[%~6char]=!d[cre]!"
%music:t s=Sound Damage%
GOTO :EOF

:MACROS
FOR /F %%A in ('ECHO prompt $E^| cmd') DO SET "ESC=%%A"
SET ^"LF=^

^" Above empty line is required - do not remove
SET ^"\n=^^^%LF%%LF%^%LF%%LF%^^"
SET margin=%ESC%[6G
SET up=%ESC%[nA
SET dn=%ESC%[nB
SET bk=%ESC%[nD
SET nx=%ESC%[nC
SET col=%ESC%[38;2;cm
SET bcl=%ESC%[48;2;cm
SET framerate=FOR /L %%J in (1,50,1000000) DO REM
SET "kill=TASKKILL /F /IM CSCRIPT.exe >NUL 2>&1"
SET "music=START /B CSCRIPT //NOLOGO "%~f0?.wsf" //JOB:t s.mp3 >NUL"
SET disploop=CHOICE /C ^^^!?[choice]^^^! /N^>NUL%\n%
SET "?[error]=^!errorlevel^!"%\n%
FOR %%@ in (^^!errorlevel^^!) DO (%\n%
IF defined ?[%%@char] (%\n%
    ECHO %margin%%ESC%[1B%ESC%[1m^^!?[%%@]^^!%ESC%[0m : %ESC%[s^^!?[%%@aug]^^!, ^^!?[%%@hp]^^!, ^^!?[%%@at]^^!, ^^!?[%%@turn]^^!, ^^!?[%%@pa]^^!, 1 in ^^!?[%%@crit]^^!%ESC%[2B%ESC%[8G^^!?[%%@char]^^!%ESC%[0m%ESC%[u%ESC%[1B^^!?[%%@desc]^^!%ESC%[1B%margin%A^^^^) Confirm, B^^^^) Back

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
