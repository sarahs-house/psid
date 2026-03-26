****************************
* Sarah Sullivan 
* OG Created: December 27, 2025
* Version Created: March 6, 2026
* Last Updated: March 25, 2026
****************************
/* 
This do file merges together data from each survey wave to create a panel data set of the heads of every household in the PSID between 1968-2023
and inputs individual level data for all individuals ever in the PSID between 1968-2023.
*/
************************************

/* 00. Program Set Up */
    clear all
    set more off
    cap log close

    local version 1

    set maxvar 32767

    cd "$root"

    local date = subinstr("`c(current_date)'", "/", "-", .)
    local time = subinstr("`c(current_time)'", ":", "-", .)
    local datetime = "`date'_`time'"
    log using "$root/_log/A1_complete_v`version'_`datetime'.log", replace

    * Switches
    local part1 1
    local part2 0
    local part3 0
    local part4 0
    local part5 0
    local part6 0

    local qualified "$root/A1_qualified_families_v1.dta"


/* ------------------------------------- */
* PART I: merge together data from each survey 
* wave
/* ------------------------------------- */

if `part1' == 1{

    /* 01. Pull and merge together data from survey waves 1968-2023 */
        /* 1968 survey */
            clear
            set maxvar 32767
            cd "$root"
            use "$root/fam1968/fam1968.dta"
            rename V3 fam
            g yr = 1968

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1968/fam1968_clean.dta", replace


        /* 1969 survey */
            clear
            set maxvar 32767
            cd "$root/fam1969"
            use "$root/fam1969/fam1969.dta"
            rename V442 fam
            g yr = 1969

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1969/fam1969_clean.dta", replace

        /* 1970 survey */
            clear
            set maxvar 32767
            cd "$root/fam1970"
            use "$root/fam1970/fam1970.dta"
            rename V1102 fam
            g yr = 1970

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1970/fam1970_clean.dta", replace

        /* 1971 survey */
            clear
            set maxvar 32767
            cd "$root/fam1971"
            use "$root/fam1971/fam1971.dta"
            rename V1802 fam
            g yr = 1971

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1971/fam1971_clean.dta", replace


        /* 1972 survey */
            clear
            set maxvar 32767
            cd "$root/fam1972"
            use "$root/fam1972/fam1972.dta"
            rename V2402 fam
            g yr = 1972

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1972/fam1972_clean.dta", replace

        /* 1973 survey */
            clear
            set maxvar 32767
            cd "$root/fam1973"
            use "$root/fam1973/fam1973.dta"
            rename V3002 fam
            g yr = 1973

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1973/fam1973_clean.dta", replace

        /* 1974 survey */
            clear
            set maxvar 32767
            cd "$root/fam1974"
            use "$root/fam1974/fam1974.dta"
            rename V3402 fam
            g yr = 1974

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1974/fam1974_clean.dta", replace

        /* 1975 survey */
            clear
            set maxvar 32767
            cd "$root/fam1975"
            use "$root/fam1975/fam1975.dta"
            rename V3802 fam
            g yr = 1975

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1975/fam1975_clean.dta", replace

        /* 1976 survey */
            clear
            set maxvar 32767
            cd "$root/fam1976"
            use "$root/fam1976/fam1976.dta"
            rename V4302 fam
            g yr = 1976

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1976/fam1976_clean.dta", replace

        /* 1977 survey */
            clear
            set maxvar 32767
            cd "$root/fam1977"
            use "$root/fam1977/fam1977.dta"
            rename V5202 fam
            g yr = 1977

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1977/fam1977_clean.dta", replace

        /* 1978 survey */
            clear
            set maxvar 32767
            cd "$root/fam1978"
            use "$root/fam1978/fam1978.dta"
            rename V5702 fam
            g yr = 1978

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1978/fam1978_clean.dta", replace

        /* 1979 survey */
            clear 
            set maxvar 32767
            cd "$root/fam1979"
            use "$root/fam1979/fam1979.dta"
            rename V6302 fam
            g yr = 1979

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1979/fam1979_clean.dta", replace


        /* 1980 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1980
            use "fam1980.dta"
            rename V6902 fam
            g yr = 1980
            
            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"
    
            save "$root/fam1980/fam1980_clean.dta", replace


        /* 1981 survey */
            clear 
            set maxvar 32767
            cd ..
            cd fam1981
            use "fam1981.dta"
            rename V7502 fam
            g yr = 1981
                
            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"
    
            save "$root/fam1981/fam1981_clean.dta", replace


        /* 1982 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1982

            use "fam1982.dta"
            rename V8202 fam
            
            g yr = 1982
            
            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1982/fam1982_clean.dta", replace

        /* 1983 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1983
            use "fam1983.dta"
            rename V8802 fam
            g yr = 1983
            
            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"
    
            save "$root/fam1983/fam1983_clean.dta", replace

        /* 1984 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1984
            use "fam1984.dta"
            rename V10002 fam
            g yr = 1984
            
            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"
    
            save "$root/fam1984/fam1984_clean.dta", replace

        /* 1985 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1985
            use "fam1985.dta"
            rename V11102 fam
            g yr = 1985
            
            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

    
            save "$root/fam1985/fam1985_clean.dta", replace

        /* 1986 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1986
            use "fam1986.dta"
            rename V12502 fam
            g yr = 1986
            
            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1986/fam1986_clean.dta", replace


        /* 1987 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1987
            use "fam1987.dta"
            rename V13702 fam

            g yr = 1987
            
            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"
    
            save "$root/fam1987/fam1987_clean.dta", replace

        /* 1988 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1988
            use "fam1988.dta"
            rename V14802 fam
            g yr = 1988
            
            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"
    
            save "$root/fam1988/fam1988_clean.dta", replace

        /* 1989 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1989
            use "fam1989.dta"
            rename V16302 fam
            g yr = 1989
            
            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"
    
            save "$root/fam1989/fam1989_clean.dta", replace

        /* 1990 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1990
            use "fam1990.dta"
            rename V17702 fam
            g yr = 1990
            
            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"
    
            save "$root/fam1990/fam1990_clean.dta", replace
            
        /* 1991 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1991
            use "fam1991.dta"
            rename V19002 fam
            g yr = 1991
            
            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"
    
            save "$root/fam1991/fam1991_clean.dta", replace 


        /* 1992 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1992
            use "fam1992.dta"
            rename V20302 fam
            g yr = 1992

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1992/fam1992_clean.dta", replace

        /* 1993 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1993
            use "fam1993.dta"
            rename V21602 fam
            g yr = 1993

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1993/fam1993_clean.dta", replace

        /* 1994 survey */
            clear 
            set maxvar 32767
            cd .. 
            cd fam1994er
            use "fam1994.dta"
            rename ER2002 fam
            g yr = 1994

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1994er/fam1994_clean.dta", replace

        /* 1995 survey */
            clear 
            cd .. 
            set maxvar 32767
            cd fam1995er
            use "fam1995.dta"
            rename ER5002 fam
            g yr = 1995

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1995er/fam1995_clean.dta", replace

        /* 1996 survey */
            clear 
            cd .. 
            set maxvar 32767
            cd fam1996er
            use "fam1996.dta"
            rename ER7002 fam
            g yr = 1996

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1996er/fam1996_clean.dta", replace


        /* 1997 survey */
            clear 
            cd .. 
            set maxvar 32767
            cd fam1997er
            use "fam1997.dta"
            rename ER10002 fam
            g yr = 1997

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1997er/fam1997_clean.dta", replace


        /* 1999 survey */
            clear 
            cd .. 
            set maxvar 32767
            cd fam1999er
            use "fam1999.dta"
            rename ER13002 fam
            g yr = 1999

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam1999er/fam1999_clean.dta", replace


        /* 2001 survey */
            clear 
            cd .. 
            set maxvar 32767
            cd fam2001er
            use "fam2001.dta"
            rename ER17002 fam
            g yr = 2001

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam2001er/fam2001_clean.dta", replace


        /* 2003 survey */
            clear 
            cd .. 
            cd fam2003er
            set maxvar 32767
            use "fam2003.dta"
            rename ER21002 fam
            g yr = 2003

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam2003er/fam2003_clean.dta", replace


        /* 2005 survey */
            clear 
            cd .. 
            cd fam2005er
            set maxvar 32767
            use "fam2005.dta"
            rename ER25002 fam
            g yr = 2005

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam2005er/fam2005_clean.dta", replace


        /* 2007 survey */
            clear 
            cd .. 
            cd fam2007er
            set maxvar 32767
            use "fam2007.dta"
            rename ER36002 fam
            g yr = 2007

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam2007er/fam2007_clean.dta", replace


        /* 2009 survey */
            clear 
            cd .. 
            cd fam2009er
            set maxvar 32767
            use "fam2009.dta"
            rename ER42002 fam
            g yr = 2009

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam2009er/fam2009_clean.dta", replace


        /* 2011 survey */
            clear 
            cd .. 
            cd fam2011er
            set maxvar 32767
            use "fam2011.dta"
            rename ER47302 fam
            g yr = 2011

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam2011er/fam2011_clean.dta", replace


        /* 2013 survey */
            clear 
            cd .. 
            cd fam2013er
            set maxvar 32767
            use "fam2013.dta"
            rename ER53002 fam
            g yr = 2013

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam2013er/fam2013_clean.dta", replace


        /* 2015 survey */
            clear 
            cd .. 
            cd fam2015er
            set maxvar 32767
            use "fam2015.dta"
            rename ER60002 fam
            g yr = 2015

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam2015er/fam2015_clean.dta", replace


        /* 2017 survey */
            clear 
            cd .. 
            cd fam2017er
            set maxvar 32767
            use "fam2017.dta"
            rename ER66002 fam
            g yr = 2017

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam2017er/fam2017_clean.dta", replace


        /* 2019 survey */
            clear 
            cd .. 
            cd fam2019er
            set maxvar 32767
            use "fam2019.dta"
            rename ER72002 fam
            g yr = 2019

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam2019er/fam2019_clean.dta", replace


        /* 2021 survey */
            clear 
            cd .. 
            cd fam2021er
            set maxvar 32767
            use "fam2021.dta"
            rename ER78002 fam
            g yr = 2021

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam2021er/fam2021_clean.dta", replace


        /* 2023 survey */
            clear 
            cd .. 
            cd fam2023er
            use "fam2023.dta"
            g yr = 2023

            * keep wanted variables only 
            do "$root/00_RENAMING_V1.do"

            save "$root/fam2023er/fam2023_clean.dta", replace


    /* 02. Merge together */

        append using "$root/fam2021er/fam2021_clean.dta"
        append using "$root/fam2019er/fam2019_clean.dta"
        append using "$root/fam2017er/fam2017_clean.dta"
        append using "$root/fam2015er/fam2015_clean.dta"
        append using "$root/fam2013er/fam2013_clean.dta"
        append using "$root/fam2011er/fam2011_clean.dta"
        append using "$root/fam2009er/fam2009_clean.dta"
        append using "$root/fam2007er/fam2007_clean.dta"
        append using "$root/fam2005er/fam2005_clean.dta"
        append using "$root/fam2003er/fam2003_clean.dta"
        append using "$root/fam2001er/fam2001_clean.dta"
        append using "$root/fam1999er/fam1999_clean.dta"
        append using "$root/fam1997er/fam1997_clean.dta"
        append using "$root/fam1996er/fam1996_clean.dta"
        append using "$root/fam1995er/fam1995_clean.dta"
        append using "$root/fam1994er/fam1994_clean.dta"
        append using "$root/fam1993/fam1993_clean.dta"
        append using "$root/fam1992/fam1992_clean.dta"
        append using "$root/fam1991/fam1991_clean.dta"
        append using "$root/fam1990/fam1990_clean.dta"
        append using "$root/fam1989/fam1989_clean.dta"
        append using "$root/fam1988/fam1988_clean.dta"
        append using "$root/fam1987/fam1987_clean.dta"
        append using "$root/fam1986/fam1986_clean.dta"
        append using "$root/fam1985/fam1985_clean.dta"
        append using "$root/fam1984/fam1984_clean.dta"
        append using "$root/fam1983/fam1983_clean.dta"
        append using "$root/fam1982/fam1982_clean.dta"
        append using "$root/fam1981/fam1981_clean.dta" 
        append using "$root/fam1980/fam1980_clean.dta"
        append using "$root/fam1979/fam1979_clean.dta"
        append using "$root/fam1978/fam1978_clean.dta"
        append using "$root/fam1977/fam1977_clean.dta"
        append using "$root/fam1976/fam1976_clean.dta"
        append using "$root/fam1975/fam1975_clean.dta"
        append using "$root/fam1974/fam1974_clean.dta"
        append using "$root/fam1973/fam1973_clean.dta"
        append using "$root/fam1972/fam1972_clean.dta"
        append using "$root/fam1971/fam1971_clean.dta"
        append using "$root/fam1970/fam1970_clean.dta"
        append using "$root/fam1969/fam1969_clean.dta"
        append using "$root/fam1968/fam1968_clean.dta"

        order fam ID yr


        * Panel data set of the heads of every household from 1968-2023
        sort fam yr ID
        save "$root/A1_heads_panel_v2.dta", replace
        count if ID != ID[_n+1]
        * 50 variables
        * N = 320,456 (head-year observations)  
        * n = 14,818 (heads)

}


/* ******************** */
* PART II: Individual File
* inputs individual level data for all 
* individuals ever in the PSID between 
* 1968-2023
/* ******************** */ 


if `part2' == 1{
    local only_counts 1

    /* 03. Individual file */
        * N = n = 85,536
        clear
        use "$d_2023"
        drop ER30000 
        rename ER30002 fam_number
        g ID = (1000*fam) + fam_number
        order fam ID
        count if fam != fam[_n+1]
        * n_families = 8,102
        
    /* 04. Drop variables not needed for counts */
        if `only_counts' ==1{
            preserve
            drop ER30367 ER30393 ER30403 ER30422 ER30433 ER30456 ER30467 ER30491 ER30502 ER30528 ER30539 ER30563 ER30574 ER30599 ER30610 ER30635 ER30646 ER30677 ER30693 ER30720 ER30737 ER30795 ER30810 ER30856 ER32023 ER32025 ER32027 ER32029 ER32031 ER32035 ER32038 ER32040 ER32042 ER32045 ER32047 ER33105 ER33122 ER33205 ER33212 ER33224 ER33263 ER33270 ER33278 ER33305 ER33312 ER33319 ER33405 ER33412 ER33431 ER33505 ER33513 ER33539 ER33605 ER33613 ER33630 ER33705 ER33713 ER33733 ER33805 ER33814 ER33839 ER33905 ER33914 ER33939 ER34005 ER34017 ER34033 ER34105 ER34117 ER34145 ER34205 ER34217 ER34222 ER34225 ER34233 ER34234 ER34252 ER34306 ER34321 ER34324 ER34326 ER34329 ER34332 ER34339 ER34343 ER34353 ER34356 ER34358 ER34361 ER34364 ER34371 ER34375 ER34383 ER34384 ER34402 ER34505 ER34520 ER34523 ER34525 ER34528 ER34531 ER34538 ER34542 ER34552 ER34555 ER34557 ER34560 ER34563 ER34570 ER34574 ER34592 ER34593 ER34641 ER34705 ER34720 ER34723 ER34725 ER34728 ER34731 ER34740 ER34746 ER34756 ER34759 ER34761 ER34764 ER34767 ER34776 ER34782 ER34800 ER34801 ER34850 ER34905 ER34920 ER34923 ER34925 ER34928 ER34931 ER34940 ER34946 ER34956 ER34959 ER34961 ER34964 ER34967 ER34976 ER34982 ER35002 ER35003 ER35051 ER35105 ER35120 ER35123 ER35125 ER35128 ER35131 ER35140 ER35146 ER35156 ER35159 ER35161 ER35164 ER35167 ER35176 ER35182 ER35202 ER35203 ER35251 ER30562 ER30597 ER30633 ER30670 ER30718 ER30763 ER30783 ER30841 ER33142 ER33296 ER33340 ER33537O ER33628O ER33728O ER30425 ER30459 ER30494 ER30531 ER30566 ER30602 ER30638 ER30680 ER30723 ER30798 ER30005 ER30024 ER30047 ER30071 ER30095 ER30121 ER30142 ER30164 ER30192 ER30221 ER30250 ER30287 ER30317 ER30347 ER30377 ER30405 ER30435 ER30469 ER30504 ER30541 ER30726 ER30779 ER30837 ER32034 ER32036 ER32037 ER32039 ER32041 ER32043 ER32044 ER32046 ER32048 ER33138 ER33221 ER33226 ER33273 ER33274 ER33294 ER33336 ER34304 ER30011 ER30012 ER30032 ER30033 ER30056 ER30057 ER30080 ER30081 ER30105 ER30106 ER30129 ER30130 ER30150 ER30151 ER30152 ER30173 ER30175 ER30276 ER30297 ER30298 ER30357 ER30358 ER30385 ER30386 ER30414 ER30415 ER30444 ER30445 ER30479 ER30480 ER30481 ER30490 ER30514 ER30515 ER30516 ER30525 ER30550 ER30551 ER30552 ER30561 ER30585 ER30586 ER30621 ER30622 ER30658 ER30659 ER30704 ER30705 ER30707 ER30750 ER30751 ER30752 ER30753 ER30762 ER30821 ER30822 ER30824 ER30825 ER33837Y ER33837Z ER33838A ER33838B ER33838C ER33838D ER33838E ER33838F ER33838G ER33925Y ER33925Z ER33927 ER33938A ER33938B ER33938C ER33938D ER33938E ER33938F ER33938G ER34029V ER34029W ER34029X ER34029Y ER34032A ER34032B ER34032C ER34032D ER34032E ER34136V ER34136W ER34136X ER34136Y ER34144A ER34144B ER34144C ER34144D ER34144E ER34243V ER34243W ER34243X ER34243Y ER34251A ER34251B ER34251C ER34251D ER34251E ER34393V ER34393W ER34393X ER34393Y ER34401A ER34401B ER34401C ER34401D ER34401E ER34632 ER34633 ER34634 ER34635 ER34636 ER34637 ER34638 ER34639 ER34640 ER34841 ER34842 ER34843 ER34844 ER34845 ER34846 ER34847 ER34848 ER34849 ER35042 ER35043 ER35044 ER35045 ER35046 ER35047 ER35048 ER35049 ER35050 ER35242 ER35243 ER35244 ER35245 ER35246 ER35247 ER35248 ER35249 ER35250 ER30009 ER30028 ER30051 ER30075 ER30099 ER30125 ER30146 ER30168 ER30196 ER30225 ER30254 ER30295 ER30325 ER30355 ER30817 ER30818 ER33112 ER33113 ER33213 ER33220 ER33225 ER33229 ER33230 ER33231 ER33232 ER33233 ER33234 ER33235 ER33236 ER33237 ER33238 ER33239 ER33240 ER33241 ER33242 ER33243 ER33246 ER33264 ER33265 ER33272 ER33313 ER33413 ER33514 ER33614 ER33714 ER33731 ER33732 ER33815 ER33915 ER34018 ER34118 ER34218 ER34219 ER34228 ER34322 ER34325 ER34328 ER34330 ER34347 ER34350 ER34354 ER34357 ER34360 ER34362 ER34379 ER34521 ER34524 ER34527 ER34529 ER34546 ER34549 ER34553 ER34556 ER34559 ER34561 ER34578 ER34721 ER34724 ER34727 ER34729 ER34750 ER34753 ER34757 ER34760 ER34763 ER34765 ER34786 ER34921 ER34924 ER34927 ER34929 ER34950 ER34953 ER34957 ER34960 ER34963 ER34965 ER34986 ER35121 ER35124 ER35127 ER35129 ER35150 ER35153 ER35157 ER35160 ER35163 ER35165 ER35186 ER30052 ER30076 ER30100 ER30126 ER30147 ER30197 ER30226 ER30255 ER33222 ER33227 ER33247 ER33248 ER33249 ER33250 ER33251 ER33252 ER33253 ER33254 ER33255 ER33256 ER33257 ER33258 ER34229 ER34323 ER34348 ER34355 ER34380 ER34522 ER34547 ER34554 ER34579 ER34722 ER34751 ER34758 ER34787 ER34922 ER34951 ER34958 ER34987 ER35122 ER35151 ER35158 ER35187 ER35117 ER35112 ER35113 ER35114 ER35115 ER35116 ER35118 ER35119 ER35126 ER35130 ER35132 ER35133 ER35134 ER35135 ER35136 ER35137 ER35138 ER35139 ER35141 ER35142 ER35143 ER35144 ER35145 ER35147 ER35148 ER35149 ER35152 ER35154 ER35155 ER35162 ER35166 ER35168 ER35169 ER35170 ER35171 ER35172 ER35173 ER35174 ER35175 ER35177 ER35178 ER35179 ER35180 ER35181 ER35183 ER35184 ER35185 ER35188 ER35189 ER35190 ER35191 ER35192 ER35193 ER35194 ER35195 ER35196 ER35197 ER35198 ER35199 ER35200 ER35201 ER35204 ER35205 ER35206 ER35207 ER35208 ER35209 ER35210 ER35211 ER35212 ER35213 ER35214 ER35215 ER35216 ER35217 ER35218 ER35219 ER35220 ER35221 ER35222 ER35223 ER35224 ER35225 ER35226 ER35227 ER35228 ER35229 ER35230 ER35231 ER35232 ER35233 ER35234 ER35235 ER35236 ER35237 ER35238 ER35239 ER35240 ER35241 ER33837E ER33837F ER33837G ER33837H ER33837I ER33837J ER33837K ER33837L ER33837M ER33837N ER33837O ER33837P ER33837Q ER33837R ER33837S ER33837T ER33837U ER33837V ER33837W ER33837X ER33925E ER33925F ER33925G ER33925H ER33925I ER33925J ER33925K ER33925L ER33925M ER33925N ER33925O ER33925P ER33925Q ER33925R ER33925S ER33925T ER33925U ER33925V ER33925W ER33925X ER34029B ER34029C ER34029D ER34029E ER34029F ER34029G ER34029H ER34029I ER34029J ER34029K ER34029L ER34029M ER34029N ER34029O ER34029P ER34029Q ER34029R ER34029S ER34029T ER34029U ER34136B ER34136C ER34136D ER34136E ER34136F ER34136G ER34136H ER34136I ER34136J ER34136K ER34136L ER34136M ER34136N ER34136O ER34136P ER34136Q ER34136R ER34136S ER34136T ER34136U ER34243B ER34243C ER34243D ER34243E ER34243F ER34243G ER34243H ER34243I ER34243J ER34243K ER34243L ER34243M ER34243N ER34243O ER34243P ER34243Q ER34243R ER34243S ER34243T ER34243U ER34393B ER34393C ER34393D ER34393E ER34393F ER34393G ER34393H ER34393I ER34393J ER34393K ER34393L ER34393M ER34393N ER34393O ER34393P ER34393Q ER34393R ER34393S ER34393T ER34393U ER34612 ER34613 ER34614 ER34615 ER34616 ER34617 ER34618 ER34619 ER34620 ER34621 ER34622 ER34623 ER34624 ER34625 ER34626 ER34627 ER34628 ER34629 ER34630 ER34631 ER34821 ER34822 ER34823 ER34824 ER34825 ER34826 ER34827 ER34828 ER34829 ER34830 ER34831 ER34832 ER34833 ER34834 ER34835 ER34836 ER34837 ER34838 ER34839 ER34840 ER35022 ER35023 ER35024 ER35025 ER35026 ER35027 ER35028 ER35029 ER35030 ER35031 ER35032 ER35033 ER35034 ER35035 ER35036 ER35037 ER35038 ER35039 ER35040 ER35041 ER30030 ER30054 ER30078 ER30103 ER33260 ER34137 ER34140 ER34244 ER34247 ER34394 ER34397 ER34603 ER34606 ER34812 ER34815 ER35013 ER35016 ER30016 ER30199 ER30228 ER30263 ER30264 ER30014 ER30035 ER30059 ER30083 ER30108 ER30029 ER30034 ER30053 ER30077 ER30102 ER30148 ER30153 ER30177 ER30178 ER30179 ER30180 ER30198 ER30204 ER30205 ER30206 ER30207 ER30227 ER30233 ER30234 ER30235 ER30236 ER30256 ER30271 ER30272 ER30273 ER30291 ER30300 ER30301 ER30302 ER30303 ER30360 ER30361 ER30362 ER30388 ER30389 ER30417 ER30418 ER30447 ER30448 ER30482 ER30483 ER30517 ER30518 ER30553 ER30554 ER30588 ER30589 ER30624 ER30625 ER30661 ER30662 ER30709 ER30710 ER30754 ER30755 ER30823 ER33536Q ER33627Q ER33827U ER33827V ER33927C ER33927D ER33245 ER30010 ER30013 ER30058 ER30082 ER30107 ER30131 ER30270 ER30330 ER30331 ER30332 ER30333 ER33727Q ER30110 ER30181 ER30384 ER30413 ER30478 ER30513 ER30549 ER30748 ER30326 ER30296 ER34377 ER34576 ER34784 ER34984 ER34318 ER34517 ER34717 ER34917 ER33616 ER33716 ER33817 ER33917 ER34020 ER34119 ER34230 ER34349 ER34548 ER34752 ER34952 ER33215 ER33315 ER33415 ER33516 ER34345 ER34544 ER34748 ER34948 ER30820 ER30169 ER33223 ER34223 ER34226 ER34340 ER34344 ER34372 ER34376 ER34539 ER34543 ER34571 ER34575 ER34741 ER34747 ER34777 ER34783 ER34941 ER34947 ER34977 ER34983 ER30174 ER30176 ER30203 ER30210 ER30232 ER30239 ER30269 ER30299 ER30306 ER30329 ER30336 ER30359 ER30363 ER30366 ER30387 ER30392 ER30416 ER30421 ER30446 ER30452 ER30454 ER30487 ER30489 ER30522 ER30524 ER30558 ER30560 ER30587 ER30593 ER30595 ER30623 ER30629 ER30631 ER30660 ER30666 ER30668 ER30706 ER30708 ER30714 ER30716 ER30759 ER30761 ER33532Z ER33623Z ER33826C ER33827T ER33837C ER33925C ER33926C ER33927B ER34032 ER34144 ER34251 ER34401 ER34610 ER34819 ER35000 ER35020 ER30171 ER33827 ER33827A ER33827B ER33827C ER33827D ER33827E ER33827F ER33827G ER33827H ER33827I ER33827J ER33827K ER33827L ER33827M ER33827N ER33827O ER33827P ER33827Q ER33827R ER30172 ER30208 ER30209 ER30237 ER30238 ER30304 ER30305 ER30334 ER30335 ER30364 ER30365 ER30390 ER30391 ER30419 ER30420 ER30449 ER30453 ER30455 ER30484 ER30519 ER30555 ER30590 ER30626 ER30663 ER30711 ER30756 ER30127 ER30321 ER30351 ER30409 ER30439 ER30473 ER30508 ER30787 ER30789 ER30845 ER30847 ER33146 ER33148 ER33298 ER33299 ER33344 ER33346 ER30201 ER30202 ER30230 ER30231 ER30267 ER30268 ER30327 ER30328 ER30101 ER30257 ER33536C ER33627C ER33727C ER33827S ER33832 ER33927A ER33932 ER30259 ER30598 ER30634 ER30671 ER30719 ER30727 ER30764 ER30780 ER30782 ER30784 ER30786 ER30788 ER30790 ER30827 ER30838 ER30840 ER30842 ER30844 ER30846 ER30848 ER33117 ER33128 ER33139 ER33141 ER33143 ER33145 ER33147 ER33149 ER33217 ER33284 ER33294A ER33295A ER33296A ER33297A ER33298A ER33299A ER33317 ER33326 ER33337 ER33339 ER33341 ER33343 ER33345 ER33347 ER33417 ER33517 ER33518 ER33519 ER33520 ER33521 ER33617 ER33618 ER33619 ER33620 ER33621 ER33717 ER33718 ER33719 ER33720 ER33721 ER33818 ER33819 ER33820 ER33821 ER33822 ER33918 ER33919 ER33920 ER33921 ER33922 ER34021 ER34022 ER34023 ER34024 ER34025 ER34120 ER34121 ER34122 ER34123 ER34124 ER34129 ER34130 ER34131 ER34231 ER34236 ER34237 ER34238 ER34381 ER34386 ER34387 ER34388 ER34580 ER34595 ER34596 ER34597 ER34788 ER34803 ER34804 ER34805 ER34988 ER35005 ER35006 ER35007 ER30475 ER30476 ER30510 ER30511 ER30546 ER30547 ER30581 ER30582 ER30617 ER30618 ER30654 ER30655 ER30700 ER30701 ER30745 ER30746 ER30451 ER30486 ER30521 ER30557 ER30592 ER30628 ER30665 ER30713 ER30758 ER33532J ER33532K ER33532Y ER33623J ER33623K ER33623Y ER33627A ER33826A ER33837B ER33925B ER33926A ER33938 ER34031 ER34143 ER34250 ER34400 ER34609 ER34818 ER35019 ER30293 ER30323 ER30353 ER30382 ER30411 ER30441 ER30474 ER30509 ER30545 ER30580 ER30616 ER30652 ER30653 ER30699 ER30743 ER30744 ER30816 ER33111 ER33211 ER33311 ER33411 ER33512 ER33537A ER33537B ER33537C ER33537D ER33537E ER33537F ER33537G ER33537H ER33537I ER33537J ER33537K ER33537L ER33537M ER33612 ER33628A ER33628B ER33628C ER33628D ER33628E ER33628F ER33628G ER33628H ER33628I ER33628J ER33628K ER33628L ER33628M ER33712 ER33728A ER33728B ER33728C ER33728D ER33728E ER33728F ER33728G ER33728H ER33728I ER33728J ER33728K ER33728L ER33728M ER33813 ER33913 ER33927E ER33927F ER33927G ER33927H ER33927I ER33927J ER33927K ER33927L ER33927M ER33927N ER33927O ER33927P ER34016 ER34116 ER34216 ER34317 ER34516 ER34716 ER34916 ER30294 ER30324 ER30354 ER30383 ER30412 ER30442 ER30477 ER30512 ER30548 ER30583 ER30619 ER30656 ER30702 ER30747 ER30819 ER33114 ER33214 ER33314 ER33414 ER33515 ER33615 ER33715 ER33816 ER33916 ER34019 ER30274 ER30275 ER30488 ER30523 ER30559 ER30760 ER33844 ER33845 ER30265 ER30260 ER30261 ER30793 ER30851 ER30526 ER30683 ER30725 ER30800 ER30826 ER30861 ER33116 ER33118 ER33216 ER33218 ER33316 ER33416 ER33826 ER33926 ER34029 ER34136 ER34243 ER34393 ER34602 ER34811 ER35012
        }

    /* 05. Entered in immigrant or Latino samples */
        g entered_imm_latino = 1 if (fam >= 3001 & fam <= 3511)
        replace entered_imm_latino = 1 if (fam >= 4001 & fam <= 4851)
        replace entered_imm_latino = 1 if (fam >= 7001 & fam <= 9308)
        replace entered_imm_latino = 0 if entered_imm_latino == .
        label var entered_imm_latino "Entered in immigrant or Latino samples"

    /* 06. Original PSID sample members  */
        g original_sample_1968 = 1 if fam_number >= 1 & fam_number <= 19 & entered_imm_latino == 0
        replace original_sample_1968 = 0 if original_sample_1968 == .
        label var original_sample_1968 "Original PSID sample members in FU in 1968" 
        * 20-26 is spouse (20) and children (21-26) living in institutions in any sample. 
        * I could just put them in the original sample but they aren't coresident
        * < 1%

    /* 07. Born to original PSID sample families */
        g child_1968 = 1 if fam_number >= 30 & fam_number <= 169 & entered_imm_latino == 0
        replace child_1968 = 0 if child_1968 == .
        label var child_1968 "Children born to original PSID sample families"

    /* 08. Born to immigrant and latino oversample families */
        g child_imm_latino = 1 if fam_number >= 30 & fam_number <= 169 & entered_imm_latino == 1
        replace child_imm_latino = 0 if child_imm_latino == .
        label var child_imm_latino "Children born to latino or immigrant oversample families"

    /* 09. Which waves are you in?*/
        forvalues i = 1968/1997{
            g in_`i' = . 
            label var in_`i' "In FU `i'"
        }

        forvalues i=1999(2)2023{
            g in_`i' = . 
            label var in_`i' "In FU `i'"
        }

        local year_vars 1968 ER30018 1969 ER30041 1970 ER30065 1971 ER30089 1972 ER30115 1973 ER30136 1974 ER30158 1975 ER30186 1976 ER30215 1977 ER30244 1978 ER30281 1979 ER30311 1980 ER30341 1981 ER30371 1982 ER30397 1983 ER30427 1984 ER30461 1985 ER30496 1986 ER30533 1987 ER30568 1988 ER30604 1989 ER30640 1990 ER30685 1991 ER30729 1992 ER30802 1993 ER30863 1994 ER33127 1995 ER33283 1996 ER33325 1997 ER33437 1999 ER33545 2001 ER33636 2003 ER33739 2005 ER33847 2007 ER33949 2009 ER34044 2011 ER34153 2013 ER34267 2015 ER34412 2017 ER34649 2019 ER34862 2021 ER35063 2023 ER35263
        
        local i = 1
        while `i' <= `: word count `year_vars'' {
            local yr : word `i' of `year_vars'
            local var : word `= `i' + 1' of `year_vars'
            replace in_`yr' = 1 if `var' == 0
            *replace in_`yr' = 0 if `var' == 97
            local i = `i' + 2
        }


    /* 10. AGES IN YEARS ACTUALLY OBSERVED 
            the variables in_1968, in_1969, ..., in_1997, in_1999, ..., in_2023 
            take the value 1 during the years they are observed and missing otherwise.
            I multiply each year's age variable by that year's in_ variable to get ages in each year 
            only among people observed in that year.  
            */

        forvalues i = 1968/1997{
            g age_`i' = . 
            label var age_`i' "Age in FU `i'"
        }

        forvalues i=1999(2)2023{
            g age_`i' = . 
            label var age_`i' "Age in FU `i'"
        }

        local age_vars 1968 ER30004 1969 ER30023 1970 ER30046 1971 ER30070 1972 ER30094 1973 ER30120 1974 ER30141 1975 ER30163 1976 ER30191 1977 ER30220 1978 ER30249 1979 ER30286 1980 ER30316 1981 ER30346 1982 ER30376 1983 ER30402 1984 ER30432 1985 ER30466 1986 ER30501 1987 ER30538 1988 ER30573 1989 ER30609 1990 ER30645 1991 ER30692 1992 ER30736 1993 ER30809 1994 ER33104 1995 ER33204 1996 ER33304 1997 ER33404 1999  ER33504 2001 ER33604 2003 ER33704 2005 ER33804 2007 ER33904 2009 ER34004 2011 ER34104 2013 ER34204 2015 ER34305 2017 ER34504 2019 ER34704 2021 ER34904 2023 ER35104      
        
        local i = 1
        while `i' <= `: word count `age_vars'' {
            local yr : word `i' of `age_vars'
            local var : word `= `i' + 1' of `age_vars'
            replace age_`yr' = `var' * in_`yr'
            local i = `i' + 2
        }


    /* 11. Age first observed */
        tempfile age 
        save `age'
        reshape long age_, i(ID) j(yr)
        drop if age_ == .
        by ID (yr), sort: egen age_first_observed = min(age_)
        label var age_first_observed "Age first observed in PSID"

    /* 12. Drop individuals who never have age recorded */
        * (i.e., age_first_obsered = 999)
        drop if age_first_observed == 999
        * .00109726 of observations
        drop if age == . 
        * doing this dropped a few people never age recorded. 
        /* QUESTION: why might someone never have an age recorded in the PSID, 
        not even as 999? */

    /* 13. Waves & waves under 18 */
        bysort ID (yr): g wave_count = _n
        egen wave1 = max(wave_count), by(ID)
        drop wave_count
        rename wave1 wave_count
        label var wave_count "Number of waves observed in PSID"
        
        g waves_18_under = age_
        replace waves_18_under = 0 if age_ > 18
        egen wave2 = max(waves_18_under), by(ID)
        drop waves_18_under
        rename wave2 waves_18_under
        label var waves_18_under "Waves in PSID at or before age 18"

    /* 14. Reshape again */
        tempfile longage 
        save `longage'
        reshape wide age_, i(ID) j(yr)

        order ID fam fam_number age_first_observed

    /* 15. Identify ANYONE observed in the PSID before age 18 */
        g observed_18 = 1 if age_first_observed <= 18
        replace observed_18 = 0 if observed_18 == .
        label var observed_18 "Observed in PSID before age 18"

    /* 16. Identify ANYONE observed at least twice in the PSID at or before age 18 */
        g observed_18_twice = 1 if waves_18_under >= 2
        replace observed_18_twice = 0 if observed_18_twice == .
        label var observed_18_twice "Observed at least twice in PSID at or before age 18"

    
    /* 17. Identify SPLITOFF FAMILIES */
        local splits 1968 ER30006 1969 ER30025 1970 ER30048 1971 ER30072 1972 ER30096 1973 ER30122 1974 ER30143 1975 ER30165 1976 ER30193 1977 ER30222 1978 ER30251 1979 ER30288 1980 ER30318 1981 ER30348 1982 ER30378 1983 ER30406 1984 ER30436 1985 ER30470 1986 ER30505 1987 ER30542 1988 ER30577 1989 ER30613 1990 ER30649 1991 ER30696 1992 ER30740 1993 ER30813 1994 ER33108 1995 ER33208 1996 ER33308 1997 ER33408 1999 ER33508 2001 ER33608 2003 ER33708 2005 ER33808 2007 ER33908 2009 ER34008 2011 ER34108 2013 ER34208 2015 ER34309 2017 ER34508 2019 ER34708 2021 ER34908 2023 ER35108
        local months 1968 ER30007 1969 ER30026 1970 ER30049 1971 ER30073 1972 ER30097 1973 ER30123 1974 ER30144 1975 ER30166 1976 ER30194 1977 ER30223 1978 ER30252 1979 ER30289 1980 ER30319 1981 ER30349 1982 ER30379 1983 ER30407 1984 ER30437 1985 ER30471 1986 ER30506 1987 ER30543 1988 ER30578 1989 ER30614 1990 ER30650 1991 ER30697 1992 ER30741 1993 ER30814 1994 ER33109 1995 ER33209 1996 ER33309 1997 ER33409 1999 ER33509 2001 ER33609 2003 ER33709 2005 ER33809 2007 ER33909 2009 ER34009 2011 ER34109 2013 ER34209 2015 ER34310 2017 ER34509 2019 ER34709 2021 ER34909 2023 ER35109

        local i = 1
        while `i' <= `: word count `splits'' {
            local yr : word `i' of `splits'
            local var : word `= `i' + 1' of `splits'
            g splitoff_`yr' = .
            replace splitoff_`yr' = 1 if `var' == 1
            label var splitoff_`yr' "Splitoff family in FU `yr'"
            local i = `i' + 2
        }

        local j = 1
        while `j' <= `: word count `months'' {
            local yr : word `j' of `months'
            local var : word `= `j' + 1' of `months'
            replace splitoff_`yr' = . if `var' != 0
            label var splitoff_`yr' "Splitoff family in FU `yr'"
            local j = `j' + 2
        }

    
    /* 18. Splitoff Ages */
        local k = 1 
        while `k' <= `: word count `splits'' {
            local yr : word `k' of `splits'
            local var : word `= `k' + 1' of `splits'
            g splitoff_age_`yr' = .
            replace splitoff_age_`yr' = age_`yr' if splitoff_`yr' == 1
            label var splitoff_age_`yr' "Age in FU `yr' if splitoff family"
            local k = `k' + 2
        }
        tempfile splits
        save `splits'

    /* 19. FIMS 
            Merging on FIMS adds approximately 20,000 individuals born to PSID 
            sample members not in individual file... */
        * Merge on grandparents FIMS file (note--this also has the parent variables)
        
        merge 1:1 ID using "${root}/00_fims_gpars_v1.dta"
        drop _merge

        * Merge on siblings FIMS file
        merge 1:1 ID using "${root}/00_fims_sib_v1.dta"


    /* 20. Reshape */
        reshape long in_, i(ID) j(yr)

    /* 20. Splitoff Family IDs */
        local families 1968 fam 1969 ER30020 1970 ER30043 1971 ER30067 1972 ER30091 1973 ER30117 1974 ER30138 1975 ER30160 1976 ER30188 1977 ER30217 1978 ER30246 1979 ER30283 1980 ER30313 1981 ER30343 1982 ER30373 1983 ER30399 1984 ER30429 1985 ER30463 1986 ER30498 1987 ER30535 1988 ER30570 1989 ER30606 1990 ER30642 1991 ER30689 1992 ER30733 1993 ER30806 1994 ER33101 1995 ER33201 1996 ER33301 1997 ER33401 1999 ER33501 2001 ER33601 2003 ER33701 2005 ER33801 2007 ER33901 2009 ER34001 2011 ER34101 2013 ER34201 2015 ER34301 2017 ER34501 2019 ER34701 2021 ER34901 2023 ER35101
        g family_year_id = .
        local l = 1
        while `l' <= `: word count `families'' {
            local yr : word `l' of `families'
            local var : word `= `l' + 1' of `families'
            replace family_year_id = `var' if yr == `yr'
            local l = `l' + 2
        }
        label var family_year_id "Family-year ID in FU in year"

        tempfile largetemp
        save `largetemp', replace

        /* 21. Household Roster */
        g hhr = ""
        replace hhr = "NA" if in_ == .

        * Reduce file size
        drop if hhr == "NA"

        sort fam yr family_year_id ID

        * for each year in each family, replace hhr with a list of the IDs of the family members with the same value of family_year_ID in that year. 
        g str_id = string(ID)
        bysort fam yr family_year_id (ID): replace hhr = str_id[1]
        bysort fam yr family_year_id (ID): replace hhr = hhr[_n-1] + " " + str_id if _n > 1
        bysort fam yr family_year_id (ID): replace hhr = hhr[_N]
        drop str_id

        * without self
        g hhr_padded = " " + hhr + " "
        g hhr_no_self = strtrim(itrim(subinstr(hhr_padded, " " + string(ID) + " ", " ", .)))
        drop hhr_padded

    /* 21. Clean / reshape again */
        drop ER*


        drop if age_first_observed > 16
        drop if observed_16_twice == 0

        sort fam id yr
        count if ID != ID[_n+1]
        * 43,845 unique individuals observed at or before age 16
        * 41,411 unique individuals observed at least twice at or before age 16



        order ID fam fam_number age_first_observed

        







}






    




    /* 16. PRESERVE */

        tempfile temp1
        save `temp1'

        preserve

        merge m:1 ID using "${root}/00_fims_gpars_v1.dta"
        drop if kid_sample == .
        drop _merge
        merge m:1 ID using "${root}/00_fims_sib_v1.dta"
        drop if kid_sample == .




    /* 17. AGES OF PEOPLE IN HH ROSTER, CREATE VARIABLES ages1968, ages1969, ..., ages2023 */

        local ages ER30004 ER30023 ER30046 ER30070 ER30094 ER30120 ER30141 ER30163 ER30191 ER30220 ER30249 ER30286 ER30316 ER30346 ER30376 ER30402 ER30432 ER30466 ER30501 ER30538 ER30573 ER30609 ER30645 ER30692 ER30809 ER33104 ER33204 ER33304 ER33404 ER33504 ER33604 ER33704 ER33804 ER33904 ER34004 ER34104 ER34204 ER34305 ER34504 ER34704 ER34904 ER35104

        levelsof fam, local(famlist)
        forvalues yr = 1968/1997 {
            capture confirm variable ages`yr'
            if _rc {
                gen strL ages`yr' = ""
            }
            foreach f of local famlist {
                levelsof ID if fam==`f' & in_`yr'==1, local(idlist)
                if "`idlist'" != "" {
                    local ageslist ""
                    local idx = `= `yr' - 1967'
                    local agevar : word `idx' of `ages'
                    if "`agevar'" != "" {
                        foreach id of local idlist {
                            quietly su `agevar' if ID==`id', meanonly
                            local ag = r(mean)
                            if "`ag'" != "" & `ag' < . {
                                local ageslist "`ageslist' `ag'"
                            }
                        }
                    }
                    local ageslist : subinstr local ageslist " " ",", all
                    replace ages`yr' = "`ageslist'" if fam==`f'
                }
            }
        }

        levelsof fam, local(famlist)
        forvalues yr = 1999(2)2021 {
            capture confirm variable ages`yr'
            if _rc {
                gen strL ages`yr' = ""
            }
            foreach f of local famlist {
                levelsof ID if fam==`f' & in_`yr'==1, local(idlist)
                if "`idlist'" != "" {
                    local ageslist ""
                    foreach id of local idlist {
                        quietly su birth_year if ID==`id', meanonly
                        local byear = r(mean)
                        if "`byear'" != "" & `byear' < . {
                            local age = `yr' - `byear'
                            local ageslist "`ageslist' `age'"
                        }
                    }
                    local ageslist : subinstr local ageslist " " ",", all
                    replace ages`yr' = "`ageslist'" if fam==`f'
                }
            }
        }

        * remove leading commas/spaces from ages_* string variables
        foreach v of varlist ages* {
            replace `v' = regexr(`v', "^[, ]+", "") if `v' != ""
            }

    
    
    
    
    
    

    /* 19. CLEAN */

        keep in_* hh* ages* ed* birth_year fam fam_number ID kid_sample yr_first_observed yr_last_observed bio_mom_id bio_dad_id a_mom_id a_dad_id


    /* 20. Reshape */
            reshape long hhr_ ages ed, i(ID) j(yr)
            drop if kid_sample != 1

            forvalues yr = 1968/1997{
                drop if yr == `yr' & in_`yr' != 1
            }

            forvalues yr = 1999(2)2021{
                drop if yr == `yr' & in_`yr' != 1
            }

    /* 21. Age */
        g Age = yr - birth_year
        label var Age "Age"


    /* 22. Drop */
        bysort ID: g wave_count =  _n
        egen max_wave = max(wave_count), by(ID)
        drop if max_wave == 1
        drop max_wave wave_count 


        merge m:1 ID using "${root}/00_fims_gpars_v1.dta"
        drop if kid_sample == .
        drop _merge
        merge m:1 ID using "${root}/00_fims_sib_v1.dta"
        drop if kid_sample == .


    /* 24. Save and export to python */
        tempfile temp2
        save `temp2'
        label drop _all
        save "$root/A1_try_pyth_v1.dta", replace

}








/*

/* ------------------------------------- */
* PART V: merge on individual data and clean
/* ------------------------------------- */

if `part5' == 1{

    /* 26. Merge on individual data */
        use "$d_2023", clear
        g ID = fam * 1000 + ER30002
        
        merge 1:m ID using "$root/A1_heads_kids_panel_v1.dta", generate(new_merge)
        drop if yr == .


    /* 27. Clean up  */

        drop ER30000

        sort fam yr ID
        order kid_sample fam ID yr V6209

        egen race = min(V6209), by(fam yr)
        egen race1 = min(V6209), by(fam)
        replace race = race1 if race == .
        drop race1
        label var race "Race/Ethnicity of Ref Person"


        egen head_ed = min(V6157), by(fam yr)
        g head_ed0 = head_ed 
        replace head_ed0 = 0 if head_ed0 == .
        egen head_ed1 = max(head_ed0), by(fam)
        replace head_ed = head_ed1 if head_ed == .
        label var head_ed "Highest Education of Ref Person"
        drop head_ed0 head_ed1


        g head_ed_cat = ""
        replace head_ed_cat = "< High School" if head_ed < 12
        replace head_ed_cat = "HS Graduate" if head_ed == 12
        replace head_ed_cat = "Some College" if head_ed > 12 & head_ed < 16
        replace head_ed_cat = "College+" if head_ed >= 16
        replace head_ed_cat = "Unknown" if head_ed == 99
        label var head_ed_cat "Education of Reference Person"

        cap rename ER32000 sex
        label var sex "Sex of Individual"

        egen no_adults = min(V6191), by(fam yr)
        label var no_adults "Number of Adults in Family Unit"

        egen family_weight = min(V6212), by(fam yr)
        label var family_weight "Family Weight"

        egen family_size = min(V5755), by(fam yr)
        label var family_size "Family Size"

        egen no_in = min(V5711), by(fam yr)
        label var no_in "Number of Adults entered in FU from V5753"

        egen no_out = min(V5713), by(fam yr)
        label var no_out "Number of Adults left FU from V5713" 

        egen who_in = min(V5712), by(fam yr)
        label var who_in "Who came into FU from V5712 HEAD"

        egen who_out = min(V5714), by(fam yr)
        label var who_out "Who left FU from V5714, HEAD"

        egen rent = min(V5723), by(fam yr)
        label var rent "Rent"

        egen homevalue = min(V5717), by(fam yr)
        label var homevalue "Home Value"

        egen own_rent = min(V5864), by(fam yr)
        label var own_rent "Own or Rent"

        egen head_mar = min(V6034), by(fam yr)
        label var head_mar "Marital Status of Head"

        egen age_head = min(V5850), by(fam yr)
        label var age_head "Age of Head"   

        egen sex_head = min(V5851), by(fam yr)
        label var sex_head "Sex of Head"

        egen region = min(V6180), by(fam yr)
        label var region "Region of Residence"

        egen state = min(V5703), by(fam yr)
        label var state "State of Residence"


        drop V*
        drop _merge


        g d1 = 1 if yr >= 1968 & yr <= 1977
        g d2 = 1 if yr >= 1978 & yr <= 1987
        g d3 = 1 if yr >= 1988 & yr <= 1997
        g d4 = 1 if yr >= 1998 & yr <= 2007
        g d5 = 1 if yr >= 2008 & yr <= 2017
        g d6 = 1 if yr >= 2018 & yr <= 2023


        order kid_sample fam ID yr age race sex head_ed FU_income adult_came adult_left n_adults_left n_adults_came who_left who_came ages_left ages_came

        g fu_change = 0 if who_left == "[]" & who_came == "[]"
        replace fu_change = 1 if who_left != "[]" | who_came != "[]"
        label var fu_change "Change in FU"

        g adult_change = 1 if adult_left ==1 | adult_came ==1
        replace adult_change = 0 if adult_left !=1 & adult_came !=1
        label var adult_change "Change in Adults in FU"


        /* SARAH--THIS SHOULD PROBABLY GO IN WHEN I HAVE EVERYONE IN THE INDIVIDUAL FILE PRESENT NO? 
        WHAT DOES IT ADD HERE? */

        * Relationship to head
        local head_rel ER30003 ER30022 ER30045 ER30069 ER30093 ER30119 ER30140 ER30162 ER30190 ER30219 ER30248 ER30285 ER30315 ER30345 ER30375 ER30401 ER30431 ER30465 ER30500 ER30537 ER30572 ER30608 ER30644 ER30691 ER30735 ER30808 ER33103 ER33203 ER33303 ER33403 ER33503 ER33603 ER33703 ER33803 ER33903 ER34003 ER34103 ER34203 ER34303 ER34503 ER34703 ER34903 ER35103

        g head_rel = .
        local i = 1

        forvalues year = 1968/1997 {
            local var : word `i' of `head_rel'
            replace head_rel = `var' if yr == `year'
            local ++i
        }

        forvalues year = 1999(2)2023 {
            local var : word `i' of `head_rel'
            replace head_rel = `var' if yr == `year'
            local ++i
        }

        * Individual Weight
        local indiv_weight ER30019 ER30042 ER30066 ER30090 ER30116 ER30137 ER30159 ER30187 ER30216 ER30245 ER30282 ER30312 ER30342 ER30372 ER30398 ER30428 ER30462 ER30497 ER30534 ER30569 ER30605 ER30641
            *1968-1989
        local core_indiv_weight ER30686 ER30730 ER30803 ER30864 ER33119 ER33275 ER33318
            *1990-1996
        local core_imm_indiv_weight ER33430 ER33546 ER33637 ER33740 ER33848 ER33950 ER34045 ER34154 ER34268 ER34413 ER34650 ER34863 ER35064 ER35264
            *1997-2023

        g indiv_weight = . 
        local i = 1

        forvalues year = 1968/1989 {
            local var : word `i' of `indiv_weight'
            replace indiv_weight = `var' if yr == `year'
            local ++i
        }

        local i = 1
        forvalues year = 1990/1996 {
            local var : word `i' of `core_indiv_weight'
            replace indiv_weight = `var' if yr == `year'
            local ++i
        }

        local i = 1
        forvalues year = 1997(2)2023 {
            local var : word `i' of `core_imm_indiv_weight'
            replace indiv_weight = `var' if yr == `year'
            local ++i
        }

        label var indiv_weight "Individual Weight"

        * Stopped ed
            g stopped_ed = .
            replace stopped_ed = ER30028 if yr == 1969
            replace stopped_ed = ER30051 if yr == 1970
            replace stopped_ed = ER30075 if yr == 1971
            replace stopped_ed = ER30099 if yr == 1972
            replace stopped_ed = ER30125 if yr == 1973
            replace stopped_ed = ER30146 if yr == 1974
            replace stopped_ed = ER30168 if yr == 1975
            replace stopped_ed = ER30196 if yr == 1976
            replace stopped_ed = ER30225 if yr == 1977
            replace stopped_ed = ER30254 if yr == 1978

        * Years of education completed 
            g school_completed  = ER30010 if yr == 1968
            replace school_completed = ER30052 if yr == 1970
            replace school_completed = ER30076 if yr == 1971
            replace school_completed = ER30100 if yr == 1972
            replace school_completed = ER30126 if yr == 1973
            replace school_completed = ER30147 if yr == 1974
            replace school_completed = ER30169 if yr == 1975
            replace school_completed = ER30197 if yr == 1976
            replace school_completed = ER30226 if yr == 1977
            replace school_completed = ER30255 if yr == 1978
            replace school_completed = ER30296 if yr == 1979
            replace school_completed = ER30326 if yr == 1980
            replace school_completed = ER30356 if yr == 1981
            replace school_completed = ER30384 if yr == 1982
            replace school_completed = ER30413 if yr == 1983
            replace school_completed = ER30443 if yr == 1984
            replace school_completed = ER30478 if yr == 1985
            replace school_completed = ER30513 if yr == 1986
            replace school_completed = ER30549 if yr == 1987
            replace school_completed = ER30584 if yr == 1988
            replace school_completed = ER30620 if yr == 1989
            replace school_completed = ER30657 if yr == 1990
            replace school_completed = ER30703 if yr == 1991
            replace school_completed = ER30748 if yr == 1992
            replace school_completed = ER30820 if yr == 1993
            replace school_completed = ER33115 if yr == 1994
            replace school_completed = ER33215 if yr == 1995
            replace school_completed = ER33315 if yr == 1996
            replace school_completed = ER33415 if yr == 1997
            replace school_completed = ER33516 if yr == 1999
            replace school_completed = ER33616 if yr == 2001
            replace school_completed = ER33716 if yr == 2003
            replace school_completed = ER33817 if yr == 2005
            replace school_completed = ER33917 if yr == 2007
            replace school_completed = ER34020 if yr == 2009
            replace school_completed = ER34119 if yr == 2011
            replace school_completed = ER34230 if yr == 2013
            replace school_completed = ER34349 if yr == 2015
            replace school_completed = ER34548 if yr == 2017
            replace school_completed = ER34752 if yr == 2019
            replace school_completed = ER34952 if yr == 2021
    }


/* ------------------------------------- */
* PART VI: Clean save
/* ------------------------------------- */

if `part6' == 1{
    drop if kid_sample != 1

    drop ER* qualified_family kid_sample 

    label var ID "Individual ID"
    label var who_left "ID's of indivs who left FU"
    label var who_came "ID's of indivs who came into FU"
    label var ages_left "Ages of indivs who left FU"
    label var ages_came "Ages of indivs who came into FU"
    label var adult_left "Adult left FU"
    label var adult_came "Adult came into FU"
    label var n_adults_left "Number of adults who left FU"
    label var n_adults_came "Number of adults who came into FU"
    label var hhr_ "Household Roster ID"
    label var ed "Education of individual"
    label var ages "Ages of all individuals in FU"
    label var fam_number "Number in family unit"
    label var birth_year "Birth Year"
    *label var mom_marital_birth "Mother's marital status at birth"
    label var bio_mom_id "Biological Mother's ID"
    label var bio_dad_id "Biological Father's ID"
    label var a_mom_id "Adoptive Mother's ID"
    label var a_dad_id "Adoptive Father's ID"
    *label var bio_md_ever_together "Biological mother & father ever together"
    label var yr_first_observed "Year first observed in sample"
    label var yr_last_observed "Year last observed in sample"  
    label var hhr_prev "Household Roster ID in previous year"
    label var ages_prev "Ages of all individuals in FU in previous year"
    label var child_came "ID's of children who came into FU"
    label var child_left "ID's of children who left FU"  
    label var sib_list "IDs of siblings"
    label var sib_came "Sibling Came into HH"
    label var sib_left "Sibling Left HH"
    label var sib_ages_came "Ages of Siblings who came into HH"
    label var sib_ages_left "Ages of Siblings who left HH"
    label var gpar_list "IDs of Grandparents"
    label var gpar_came "Grandparent Came into HH"
    label var gpar_left "Grandparent Left HH"
    label var par_list "IDs of Parents"
    label var par_came "Parent Came into HH"
    label var par_left "Parent Left HH"
    label var rel_list "IDs of Relatives"
    label var other_came "NON RELATIVE Came into HH"
    label var other_left "NON RELATIVE Left HH"
    label var head_rel "Relationship to H/RP"
    label var stopped_ed "Highest Grade Stopped Education"
    label var school_completed "Years of School Completed"

    order fam ID yr
    sort ID yr

    /* PSID QUESTION: WHAT IS THE CONVENTION FOR RACE THAT CHANGES? */
    save "$root/A1_family_structure_v1.dta", replace
}


    cap log close



/* 

/* ******************** */
* PART I: Family Composition File
* inputs fomby 2021 family composition file
* famcomp6821.dta
* n = 309,602 observations/person-waves
    * i = 33,578 unique individuals
    * t = waves 1968-1997, 1997(2)2021
        * children observed in 2-24 waves
    * j = 642 variables
* This dataset consists of all individuals from every survey 
* wave for children born to original 1968 PSID sample families

/* ******************** */ 

if `part1' == 1 {
    /* 01. Load in family composition data */
        cd "$root"
        use "$fam_comp"

    /* 02. Generate ID Variables and observe */
        destring(FC2), replace
        destring(FC3), replace
        g ID = (FC2*1000)+FC3
        order ID
        label var ID "Person Identification Number"
        rename FC2 fam
        label var fam "Family Identification Number"
        rename FC3 fam_number
        label var fam_number "Person Number within Family"
        drop FC1
        count if ID != ID[_n+1]
            * n = 33,578
        di(_N)
            * _N = 309,602
        * Time
        destring(FC4), replace
        rename FC4 yr
        label var yr "Year of Interview"

        * Children's age at interview & birth year 
        destring(FC8), replace
        rename FC8 Age
        label var Age "Age"

        g birth_year = yr-Age
        egen min_birth_year = min(birth_year), by(ID)  
        replace birth_year = min_birth_year
        drop min_birth_year
        label var birth_year "Individual Birth Year"

        g age = yr - birth_year
        label var age "Age from Birth Year"

    /* 03. DROP ANY KIDS NOT OBSERVED between 0 and 16 */
        egen min_age = min(age), by(ID)
        drop if min_age != 1
        count if ID != ID[_n+1]
            * n = 19,303
        di(_N)
            * _N = 200,328

    /* 04. I TOOK THIS OUT 12/27/25 : Drop observations after age 16 
        drop if age > 16 */

    /* 05. Drop any kids who we only observe once in childhood */
        bysort ID: g wave_count_childhood = _n if age < 16
        bysort ID: egen total_waves_childhood = max(wave_count_childhood)
        replace total_waves_childhood = 0 if total_waves_childhood == .
        count if ID != ID[_n+1] & total_waves_childhood == 1
            * there are 1,157 kids we observe only once in childhood
        drop if total_waves_childhood == 1
            * n = 18,146
        di(_N)
            * _N = 199,171

    /* 06. Mom marital birth */
        rename FC16 mom_marital_birth
        label var mom_marital_birth "Mom's Marital at ID's birth" 


    /* 05. Mom/Dad/A-Mom/A-Dad ID */
        destring(FC17), replace
        destring(FC18), replace
        destring(FC48), replace
        destring(FC49), replace
        destring(FC79), replace
        destring(FC80), replace
        destring(FC141), replace
        destring(FC142), replace

        g bio_mom_id = FC17*1000 + FC18
        label var bio_mom_id "Biological Mother's ID"
        g bio_dad_id = FC48*1000 + FC49
        label var bio_dad_id "Biological Father's ID"
        g a_mom_id = FC79*1000 + FC80
        label var a_mom_id "Adoptive Mother's ID"
        g a_dad_id = FC141*1000 + FC142
        label var a_dad_id "Adoptive Father's ID"
        * Why do some children have 0 for all bio/a IDs? 

    /* 08. Mom S-P/ Dad S-P/ A-Mom S-P/ A-Dad S-P ID */
        destring(FC31), replace
        destring(FC32), replace  
        destring(FC62), replace
        destring(FC63), replace
        destring(FC93), replace
        destring(FC94), replace
        destring(FC155), replace
        destring(FC156), replace

        g sp_bio_mom_id = FC31*1000 + FC32
        label var sp_bio_mom_id "Biological Mother's S/P ID"
        g sp_bio_dad_id = FC62*1000 + FC63
        label var sp_bio_dad_id "Biological Father's S/P ID"
        g sp_a_mom_id = FC93*1000 + FC94
        label var sp_a_mom_id "Adoptive Mother's S/P ID"
        g sp_a_dad_id = FC155*1000 + FC156
        label var sp_a_dad_id "Adoptive Father's S/P ID"

        foreach var in bio_mom_id bio_dad_id a_mom_id a_dad_id sp_bio_mom_id sp_bio_dad_id sp_a_mom_id sp_a_dad_id {
            replace `var' = . if `var' == 0
        }


    /* 09. Bio mom and dad together */ 
        g bio_md_together = 1 if bio_mom_id == sp_bio_mom_id & bio_mom_id != . & sp_bio_mom_id != .
        replace bio_md_together = 1 if bio_dad_id == sp_bio_mom_id & bio_dad_id != . & sp_bio_mom_id != .
        label var bio_md_together "Bio mom and dad together"
        by ID: egen bio_md_ever_together = max(bio_md_together)
        replace bio_md_ever_together = 0 if bio_md_ever_together == .
        label var bio_md_ever_together "Bio mom and dad ever together"
        /* this shows up as 0 even if both parent id's are missing */

    /* 10. Bio mom/dad single */ 
        g bio_mom_single = 1 if sp_bio_mom_id == .
        replace bio_mom_single = 0 if sp_bio_mom_id != .
        replace bio_mom_single = . if bio_mom_id == .
        label var bio_mom_single "Bio mom single"

        g bio_dad_single = 1 if sp_bio_dad_id == .
        replace bio_dad_single = 0 if sp_bio_dad_id != .
        replace bio_dad_single = . if bio_dad_id == .
        label var bio_dad_single "Bio dad single"

        g a_mom_single = 1 if sp_a_mom_id == .
        replace a_mom_single = 0 if sp_a_mom_id != .
        replace a_mom_single = . if a_mom_id == .
        label var a_mom_single "A mom single"

        g a_dad_single = 1 if sp_a_dad_id == .
        replace a_dad_single = 0 if sp_a_dad_id != .
        replace a_dad_single = . if a_dad_id == .
        label var a_dad_single "A dad single"

    /* 11. In Kid Sample */ 
        g kid_sample =1 
        label var kid_sample "Child in Family Composition File"

    /* 12. SARAH: YOU DECIDE NOT TO KEEP SIBLING ID'S HERE??? WHY? 
    YOU DROP THEIR VARS AND MERGE ONTO FIMS LATER--> I GUESS THAT'S FINE?
        Clear */ 
        drop FC*

    /* 11. Year Child first/last observed */
        egen min_yr = min(yr), by(ID) 
        replace min_yr = . if kid_sample == 0
        rename min_yr yr_first_observed
        label var yr_first_observed "Year Child First Observed in Family Composition File"

        egen max_yr = max(yr), by(ID) 
        replace max_yr = . if kid_sample == 0
        rename max_yr yr_last_observed
        label var yr_last_observed "Year Child Last Observed in Family Composition File"

        * DECEMBER 13--> DO I NEED THESE ? LET'S DROP FOR NOW
        replace bio_md_together = 0 if bio_md_together == .
        replace bio_md_ever_together = 0 if bio_md_ever_together == .
        replace bio_mom_single = 0 if bio_mom_single == .
        replace bio_dad_single = 0 if bio_dad_single == .
        replace a_mom_single = 0 if a_mom_single == .
        replace a_dad_single = 0 if a_dad_single == .

    /* 12. Save family composition file */
        save "$root/A1_01_kids_panel_v1.dta", replace
        collapse (firstnm) mom_marital_birth (mean) fam fam_number birth_year bio_mom_id bio_dad_id a_mom_id a_dad_id kid_sample bio_md_ever_together yr_first_observed yr_last_observed, by(ID)
        save "$root/A1_02_qualified_kids_v1.dta", replace

}


/* ------------------------------------- */
* PART III: Identify changes in household
* roster year to year, ages of people who 
* come and leave, relationship to child 
/* ------------------------------------- */
if `part3' == 1{
    
    /* 18. Identify changes in hhr */
    * I do this in python file, A1_python_v1.ipynb * 
    clear
    import delimited "A1_python_v1.csv"
    g rel_came = 1 if who_came != "[]" & other_came != 1
    replace rel_came = 0 if rel_came != 1
    g rel_left = 1 if who_left != "[]" & other_left != 1
    replace rel_left = 0 if rel_left != 1

    /* 19. Save */
    rename id ID 
    save "$root/A1_hhr_v1.dta", replace
    collapse ID fam, by(fam)
    drop ID 
    save "$root/A1_qualified_families_v1.dta", replace
}




    /* 18. Education Completed in Each Year*/
        g fakeed1969 = .
        local ed68_97 ER30010 1969fakeed ER30052 ER30076 ER30100 ER30126 ER30147 ER30169 ER30197 ER30226 ER30255 ER30296 ER30326 ER30356 ER30384 ER30413 ER30443 ER30478 ER30513 ER30549 ER30584 ER30620 ER30657 ER30703 ER30748 ER30820 ER33115 ER33215 ER33315 ER33415
        local ed99_21 ER33516 ER33616 ER33716 ER33817 ER33917 ER34020 ER34119 ER34230 ER34349 ER34548 ER34752 ER34952

        local ed69_97  fakeed1969 ER30052 ER30076 ER30100 ER30126 ER30147 ER30169 ER30197 ER30226 ER30255 ER30296 ER30326 ER30356 ER30384 ER30413 ER30443 ER30478 ER30513 ER30549 ER30584 ER30620 ER30657 ER30703 ER30748 ER30820 ER33115 ER33215 ER33315 ER33415
        local ed99_21 ER33516 ER33616 ER33716 ER33817 ER33917 ER34020 ER34119 ER34230 ER34349 ER34548 ER34752 ER34952

        local i = 1969
        foreach var of local ed69_97 {
            rename `var' ed`i'
            local ++i
        }
        
        local i = 1999
        foreach var of local ed99_21 {
            rename `var' ed`i'
            local i = `i' + 2
        }

 /* 17. Annual HH Roster */
            levelsof fam, local(famlist)
            forvalues yr = 1968/1997{
                capture confirm variable hhr_`yr'
                if _rc {
                    gen strL hhr_`yr' = ""
                }
                foreach f of local famlist {
                    levelsof ID if fam==`f' & in_`yr'==1, local(idlist)
                    if "`idlist'" != "" {
                        local idlist : subinstr local idlist " " ",", all
                        replace hhr_`yr' = "`idlist'" if fam==`f'
                    }
                }
            }

            levelsof fam, local(famlist)
            forvalues yr = 1999(2)2021{
                capture confirm variable hhr_`yr'
                if _rc {
                    gen strL hhr_`yr' = ""
                }
                foreach f of local famlist {
                    levelsof ID if fam==`f' & in_`yr'==1, local(idlist)
                    if "`idlist'" != "" {
                        local idlist : subinstr local idlist " " ",", all
                        replace hhr_`yr' = "`idlist'" if fam==`f'
                    }
                }
            }



