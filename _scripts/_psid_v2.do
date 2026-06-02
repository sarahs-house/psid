****************************
* Sarah Sullivan 
* OG Created: December 27, 2025
* Version Created: March 6, 2026
* Last Updated: June 1, 2026
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

    set maxvar 32767

    cd "$root"

    local datetime = string(year(today()), "%04.0f") + string(month(today()), "%02.0f") + string(day(today()), "%02.0f") + "_" + subinstr("`c(current_time)'", ":", "", .)
    log using "$log/_psid_`datetime'.log", replace
    
    * Switches
    local part1 0
    local part2 1
    local part3 0
    local part4 0
    local part5 0
    local part6 0


/* ******************** */
* PART I: Merge data 
* from across survey waves
/* ******************** */

if `part1' == 1{

    /* 01. Pull and merge together data from survey waves 1968-2023 */
        /* 1968 survey */
            clear
            clear mata
            set maxvar 32767
            cd "$raw"
            use "$raw/fam1968/fam1968.dta"
            g yr = 1968

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

            save "$output/fam1968_clean_v2.dta", replace


        /* 1969 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1969"
            use "$raw/fam1969/fam1969.dta"
            g yr = 1969

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

            save "$output/fam1969_clean_v2.dta", replace

        /* 1970 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1970"
            use "$raw/fam1970/fam1970.dta"
            g yr = 1970

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

            save "$output/fam1970_clean_v2.dta", replace

        /* 1971 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1971"
            use "$raw/fam1971/fam1971.dta"
            g yr = 1971

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

            save "$output/fam1971_clean_v2.dta", replace


        /* 1972 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1972"
            use "$raw/fam1972/fam1972.dta"
            g yr = 1972

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

            save "$output/fam1972_clean_v2.dta", replace

        /* 1973 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1973"
            use "$raw/fam1973/fam1973.dta"
            g yr = 1973

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

            save "$output/fam1973_clean_v2.dta", replace

        /* 1974 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1974"
            use "$raw/fam1974/fam1974.dta"
            g yr = 1974

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

            save "$output/fam1974_clean_v2.dta", replace

        /* 1975 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1975"
            use "$raw/fam1975/fam1975.dta"
            g yr = 1975

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*


            save "$output/fam1975_clean_v2.dta", replace

        /* 1976 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1976"
            use "$raw/fam1976/fam1976.dta"
            g yr = 1976

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*


            save "$output/fam1976_clean_v2.dta", replace

        /* 1977 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1977"
            use "$raw/fam1977/fam1977.dta"
            g yr = 1977

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*


            save "$output/fam1977_clean_v2.dta", replace

        /* 1978 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1978"
            use "$raw/fam1978/fam1978.dta"
            g yr = 1978

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

            save "$output/fam1978_clean_v2.dta", replace

        /* 1979 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1979"
            use "$raw/fam1979/fam1979.dta"
            g yr = 1979

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

            save "$output/fam1979_clean_v2.dta", replace


        /* 1980 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1980"
            use "$raw/fam1980/fam1980.dta"
            g yr = 1980
            
            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

    
            save "$output/fam1980_clean_v2.dta", replace


        /* 1981 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1981"
            use "$raw/fam1981/fam1981.dta"
            g yr = 1981
                
            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

    
            save "$output/fam1981_clean_v2.dta", replace


        /* 1982 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1982"
            use "$raw/fam1982/fam1982.dta"
            
            g yr = 1982
            
            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*


            save "$output/fam1982_clean_v2.dta", replace

        /* 1983 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1983"
            use "$raw/fam1983/fam1983.dta"
            g yr = 1983
            
            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
    
            drop V*


            save "$output/fam1983_clean_v2.dta", replace

        /* 1984 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1984"
            use "$raw/fam1984/fam1984.dta"
            g yr = 1984
            
            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

    
            save "$output/fam1984_clean_v2.dta", replace

        /* 1985 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1985"
            use "$raw/fam1985/fam1985.dta"
            g yr = 1985
            
            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

    
            save "$output/fam1985_clean_v2.dta", replace

        /* 1986 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1986"
            use "$raw/fam1986/fam1986.dta"
            g yr = 1986
            
            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*


            save "$output/fam1986_clean_v2.dta", replace


        /* 1987 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1987"
            use "$raw/fam1987/fam1987.dta"

            g yr = 1987
            
            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
    
            drop V*

    
            save "$output/fam1987_clean_v2.dta", replace

        /* 1988 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1988"
            use "$raw/fam1988/fam1988.dta"
            g yr = 1988
            
            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

    
            save "$output/fam1988_clean_v2.dta", replace

        /* 1989 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1989"
            use "$raw/fam1989/fam1989.dta"
            g yr = 1989
            
            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

    
            save "$output/fam1989_clean_v2.dta", replace

        /* 1990 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1990"
            use "$raw/fam1990/fam1990.dta"
            g yr = 1990
            
            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*


            save "$output/fam1990_clean_v2.dta", replace
            
        /* 1991 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1991"
            use "$raw/fam1991/fam1991.dta"
            g yr = 1991
            
            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*

    
            save "$output/fam1991_clean_v2.dta", replace 


        /* 1992 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1992"
            use "$raw/fam1992/fam1992.dta"
            g yr = 1992

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*


            save "$output/fam1992_clean_v2.dta", replace

        /* 1993 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1993"
            use "$raw/fam1993/fam1993.dta"
            g yr = 1993

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop V*


            save "$output/fam1993_clean_v2.dta", replace

        /* 1994 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1994er"
            use "$raw/fam1994er/fam1994.dta"
            g yr = 1994

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop ER*


            save "$output/fam1994_clean_v2.dta", replace

        /* 1995 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1995er"
            use "$raw/fam1995er/fam1995.dta"
            g yr = 1995

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop ER*


            save "$output/fam1995_clean_v2.dta", replace

        /* 1996 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1996er"
            use "$raw/fam1996er/fam1996.dta"
            g yr = 1996

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop ER*


            save "$output/fam1996_clean_v2.dta", replace


        /* 1997 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1997er"
            use "$raw/fam1997er/fam1997.dta"
            g yr = 1997

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"

            drop ER*

            save "$output/fam1997_clean_v2.dta", replace


        /* 1999 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1999er"
            use "$raw/fam1999er/fam1999.dta"
            g yr = 1999

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*

            save "$output/fam1999_clean_v2.dta", replace


        /* 2001 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam2001er"
            use "$raw/fam2001er/fam2001.dta"
            g yr = 2001

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*

            save "$output/fam2001_clean_v2.dta", replace


        /* 2003 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam2003er"
            use "$raw/fam2003er/fam2003.dta"
            g yr = 2003

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*

            save "$output/fam2003_clean_v2.dta", replace


        /* 2005 survey */
            clear 
            cd "$raw/fam2005er"
            set maxvar 32767
            use "$raw/fam2005er/fam2005.dta"
            g yr = 2005

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*

            save "$output/fam2005_clean_v2.dta", replace


        /* 2007 survey */
            clear 
            cd "$raw/fam2007er"
            set maxvar 32767
            use "$raw/fam2007er/fam2007.dta"
            g yr = 2007

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*


            save "$output/fam2007_clean_v2.dta", replace


        /* 2009 survey */
            clear 
            cd "$raw/fam2009er"
            set maxvar 32767
            use "$raw/fam2009er/fam2009.dta"
            g yr = 2009

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*


            save "$output/fam2009_clean_v2.dta", replace


        /* 2011 survey */
            clear 
            cd .. 
            cd "$raw/fam2011er"
            set maxvar 32767
            use "$raw/fam2011er/fam2011.dta"
            g yr = 2011

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*


            save "$output/fam2011_clean_v2.dta", replace


        /* 2013 survey */
            clear 
            cd "$raw/fam2013er"
            set maxvar 32767
            use "$raw/fam2013er/fam2013.dta"
            g yr = 2013

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*


            save "$output/fam2013_clean_v2.dta", replace


        /* 2015 survey */
            clear 
            cd "$raw/fam2015er"
            set maxvar 32767
            use "$raw/fam2015er/fam2015.dta"
            g yr = 2015

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*


            save "$output/fam2015_clean_v2.dta", replace


        /* 2017 survey */
            clear 
            cd "$raw/fam2017er"
            set maxvar 32767
            use "$raw/fam2017er/fam2017.dta"
            g yr = 2017

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*


            save "$output/fam2017_clean_v2.dta", replace


        /* 2019 survey */
            clear 
            cd "$raw/fam2019er"
            set maxvar 32767
            use "$raw/fam2019er/fam2019.dta"
            g yr = 2019

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*

            save "$output/fam2019_clean_v2.dta", replace


        /* 2021 survey */
            clear 
            cd "$raw/fam2021er"
            set maxvar 32767
            use "$raw/fam2021er/fam2021.dta"
            g yr = 2021

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*

            save "$output/fam2021_clean_v2.dta", replace


        /* 2023 survey */
            clear 
            cd "$raw/fam2023er"
            use "$raw/fam2023er/fam2023.dta"
            g yr = 2023
            rename fam ER82002

            * keep wanted variables only 
            do "$scripts/_renaming_v2.do"
            drop ER*

            save "$output/fam2023_clean_v2.dta", replace


    /* 02. Merge together */

        append using "$output/fam2021_clean_v2.dta"
        append using "$output/fam2019_clean_v2.dta"
        append using "$output/fam2017_clean_v2.dta"
        append using "$output/fam2015_clean_v2.dta"
        append using "$output/fam2013_clean_v2.dta"
        append using "$output/fam2011_clean_v2.dta"
        append using "$output/fam2009_clean_v2.dta"
        append using "$output/fam2007_clean_v2.dta"
        append using "$output/fam2005_clean_v2.dta"
        append using "$output/fam2003_clean_v2.dta"
        append using "$output/fam2001_clean_v2.dta"
        append using "$output/fam1999_clean_v2.dta"
        append using "$output/fam1997_clean_v2.dta"
        append using "$output/fam1996_clean_v2.dta"
        append using "$output/fam1995_clean_v2.dta"
        append using "$output/fam1994_clean_v2.dta"
        append using "$output/fam1993_clean_v2.dta"
        append using "$output/fam1992_clean_v2.dta"
        append using "$output/fam1991_clean_v2.dta"
        append using "$output/fam1990_clean_v2.dta"
        append using "$output/fam1989_clean_v2.dta"
        append using "$output/fam1988_clean_v2.dta"
        append using "$output/fam1987_clean_v2.dta"
        append using "$output/fam1986_clean_v2.dta"
        append using "$output/fam1985_clean_v2.dta"
        append using "$output/fam1984_clean_v2.dta"
        append using "$output/fam1983_clean_v2.dta"
        append using "$output/fam1982_clean_v2.dta"
        append using "$output/fam1981_clean_v2.dta" 
        append using "$output/fam1980_clean_v2.dta"
        append using "$output/fam1979_clean_v2.dta"
        append using "$output/fam1978_clean_v2.dta"
        append using "$output/fam1977_clean_v2.dta"
        append using "$output/fam1976_clean_v2.dta"
        append using "$output/fam1975_clean_v2.dta"
        append using "$output/fam1974_clean_v2.dta"
        append using "$output/fam1973_clean_v2.dta"
        append using "$output/fam1972_clean_v2.dta"
        append using "$output/fam1971_clean_v2.dta"
        append using "$output/fam1970_clean_v2.dta"
        append using "$output/fam1969_clean_v2.dta"
        append using "$output/fam1968_clean_v2.dta"

        * Panel data set of the heads of every household from 1968-2023
        rename yr year
        sort fam  year fam_id_
        order fam  year fam_id_
        save "$output/_heads_panel.dta", replace

        * 22 variables
        * N = 320,456 (head-year observations)  
        * n = 14,818 (heads)

}



/* ******************** */
* PART I: Individual File
* inputs individual level data for all 
* individuals ever in the PSID between 
* 1968-2023
/* ******************** */ 


if `part1' == 1{
    /*
    - Create list of kept variables for analysis. 
    - Define which sample entered: immigrant/latino, original psid, born to og psid, born to immigrant/latino.
    */

    /* 01. Individual file */
        * N = n = 85,536
        clear
        use "${raw}/ind2023er/ind2023er.dta", clear

        drop ER30000 
        label var fam "ER30001 Family ID 1968"
        rename ER30002 person_number
        label var person_number "Person number 68 ER30002"
        g ID = (1000*fam) + person_number
        label var ID "Individual ID (ER30001*1000 + ER30002)"
        order fam ID
        count if fam != fam[_n+1]
        * n_families = 8,102

    /* 02. Define needed variables for analysis */
        local keep fam ID person_number ER30003 ER30004 ER30006 ER30007 ER30008 ER30015 ER30017 ER30018 ER30019 ER30020 ER30021 ER30022 ER30023 ER30025 ER30026 ER30027 ER30031 ER30036 ER30037 ER30038 ER30039 ER30040 ER30041 ER30042 ER30043 ER30044 ER30045 ER30046 ER30048 ER30049 ER30050 ER30055 ER30060 ER30061 ER30062 ER30063 ER30064 ER30065 ER30066 ER30067 ER30068 ER30069 ER30070 ER30072 ER30073 ER30074 ER30079 ER30084 ER30085 ER30086 ER30087 ER30088 ER30089 ER30090 ER30091 ER30092 ER30093 ER30094 ER30096 ER30097 ER30098 ER30104 ER30109 ER30111 ER30112 ER30113 ER30114 ER30115 ER30116 ER30117 ER30118 ER30119 ER30120 ER30122 ER30123 ER30124 ER30128 ER30132 ER30133 ER30134 ER30135 ER30136 ER30137 ER30138 ER30139 ER30140 ER30141 ER30143 ER30144 ER30145 ER30149 ER30154 ER30155 ER30156 ER30157 ER30158 ER30159 ER30160 ER30161 ER30162 ER30163 ER30165 ER30166 ER30167 ER30170 ER30182 ER30183 ER30184 ER30185 ER30186 ER30187 ER30188 ER30189 ER30190 ER30191 ER30193 ER30194 ER30195 ER30200 ER30211 ER30212 ER30213 ER30214 ER30215 ER30216 ER30217 ER30218 ER30219 ER30220 ER30222 ER30223 ER30224 ER30229 ER30240 ER30241 ER30242 ER30243 ER30244 ER30245 ER30246 ER30247 ER30248 ER30249 ER30251 ER30252 ER30253 ER30258 ER30262 ER30266 ER30277 ER30278 ER30279 ER30280 ER30281 ER30282 ER30283 ER30284 ER30285 ER30286 ER30288 ER30289 ER30290 ER30292 ER30307 ER30308 ER30309 ER30310 ER30311 ER30312 ER30313 ER30314 ER30315 ER30316 ER30318 ER30319 ER30320 ER30322 ER30337 ER30338 ER30339 ER30340 ER30341 ER30342 ER30343 ER30344 ER30345 ER30346 ER30348 ER30349 ER30350 ER30352 ER30356 ER30368 ER30369 ER30370 ER30371 ER30372 ER30373 ER30374 ER30375 ER30376 ER30378 ER30379 ER30380 ER30381 ER30394 ER30395 ER30396 ER30397 ER30398 ER30399 ER30400 ER30401 ER30402 ER30404 ER30406 ER30407 ER30408 ER30410 ER30423 ER30424 ER30426 ER30427 ER30428 ER30429 ER30430 ER30431 ER30432 ER30434 ER30436 ER30437 ER30438 ER30440 ER30443 ER30450 ER30457 ER30458 ER30460 ER30461 ER30462 ER30463 ER30464 ER30465 ER30466 ER30468 ER30470 ER30471 ER30472 ER30485 ER30492 ER30493 ER30495 ER30496 ER30497 ER30498 ER30499 ER30500 ER30501 ER30503 ER30505 ER30506 ER30507 ER30529 ER30530 ER30532 ER30533 ER30534 ER30535 ER30536 ER30537 ER30538 ER30540 ER30542 ER30543 ER30544 ER30564 ER30565 ER30567 ER30568 ER30569 ER30570 ER30571 ER30572 ER30573 ER30575 ER30576 ER30577 ER30578 ER30579 ER30600 ER30601 ER30603 ER30604 ER30605 ER30606 ER30607 ER30608 ER30609 ER30611 ER30612 ER30613 ER30614 ER30615 ER30620 ER30636 ER30637 ER30639 ER30640 ER30641 ER30642 ER30643 ER30644 ER30645 ER30647 ER30648 ER30649 ER30650 ER30651 ER30657 ER30673 ER30678 ER30679 ER30681 ER30682 ER30684 ER30685 ER30686 ER30687 ER30688 ER30689 ER30690 ER30691 ER30692 ER30694 ER30695 ER30696 ER30697 ER30698 ER30703 ER30721 ER30722 ER30724 ER30728 ER30729 ER30730 ER30731 ER30732 ER30733 ER30734 ER30735 ER30736 ER30738 ER30739 ER30740 ER30741 ER30742 ER30796 ER30797 ER30799 ER30801 ER30802 ER30803 ER30804 ER30805 ER30806 ER30807 ER30808 ER30809 ER30811 ER30812 ER30813 ER30814 ER30815 ER30857 ER30858 ER30859 ER30860 ER30862 ER30863 ER30864 ER30865 ER30866 ER31987 ER31988 ER31989 ER31990 ER31991 ER31992 ER31993 ER31994 ER31995 ER31996 ER31997 ER32000 ER32001 ER32002 ER32003 ER32004 ER32005 ER32006 ER32007 ER32008 ER32009 ER32010 ER32011 ER32012 ER32013 ER32014 ER32015 ER32016 ER32017 ER32018 ER32019 ER32020 ER32021 ER32022 ER32024 ER32026 ER32028 ER32030 ER32032 ER32033 ER32049 ER32050 ER32051 ER32052 ER32053 ER32054 ER33101 ER33102 ER33103 ER33104 ER33106 ER33107 ER33108 ER33109 ER33110 ER33115 ER33119 ER33120 ER33121 ER33123 ER33124 ER33125 ER33126 ER33127 ER33150 ER33201 ER33202 ER33203 ER33204 ER33206 ER33207 ER33208 ER33209 ER33210 ER33219 ER33275 ER33276 ER33277 ER33279 ER33280 ER33281 ER33282 ER33283 ER33299B ER33301 ER33302 ER33303 ER33304 ER33306 ER33307 ER33308 ER33309 ER33310 ER33318 ER33320 ER33321 ER33322 ER33323 ER33324 ER33325 ER33401 ER33402 ER33403 ER33404 ER33406 ER33407 ER33408 ER33409 ER33410 ER33418 ER33419 ER33420 ER33421 ER33422 ER33423 ER33424 ER33425 ER33426 ER33427 ER33428 ER33429 ER33430 ER33432 ER33433 ER33434 ER33435 ER33436 ER33437 ER33438 ER33501 ER33502 ER33503 ER33504 ER33506 ER33507 ER33508 ER33509 ER33510 ER33511 ER33524 ER33525 ER33526 ER33527 ER33528 ER33529 ER33530 ER33531 ER33532 ER33540 ER33541 ER33542 ER33543 ER33544 ER33545 ER33546 ER33547 ER33601 ER33602 ER33603 ER33604 ER33606 ER33607 ER33608 ER33609 ER33610 ER33611 ER33631 ER33632 ER33633 ER33634 ER33635 ER33636 ER33637 ER33638 ER33639 ER33701 ER33702 ER33703 ER33704 ER33706 ER33707 ER33708 ER33709 ER33710 ER33711 ER33734 ER33735 ER33736 ER33737 ER33738 ER33739 ER33740 ER33741 ER33742 ER33801 ER33802 ER33803 ER33804 ER33806 ER33807 ER33808 ER33809 ER33810 ER33811 ER33840 ER33841 ER33842 ER33843 ER33846 ER33847 ER33848 ER33849 ER33901 ER33902 ER33903 ER33904 ER33906 ER33907 ER33908 ER33909 ER33910 ER33911 ER33940 ER33941 ER33942 ER33943 ER33948 ER33949 ER33950 ER33951 ER34001 ER34002 ER34003 ER34004 ER34006 ER34007 ER34008 ER34009 ER34010 ER34011 ER34034 ER34035 ER34036 ER34037 ER34043 ER34044 ER34045 ER34046 ER34101 ER34102 ER34103 ER34104 ER34106 ER34107 ER34108 ER34109 ER34110 ER34111 ER34146 ER34147 ER34148 ER34149 ER34152 ER34153 ER34154 ER34155 ER34201 ER34202 ER34203 ER34204 ER34206 ER34207 ER34208 ER34209 ER34210 ER34211 ER34253 ER34254 ER34255 ER34256 ER34266 ER34267 ER34268 ER34269 ER34301 ER34302 ER34303 ER34305 ER34307 ER34308 ER34309 ER34310 ER34311 ER34312 ER34403 ER34404 ER34405 ER34406 ER34407 ER34408 ER34409 ER34410 ER34411 ER34412 ER34413 ER34414 ER34501 ER34502 ER34503 ER34504 ER34506 ER34507 ER34508 ER34509 ER34510 ER34511 ER34642 ER34643 ER34644 ER34645 ER34646 ER34647 ER34648 ER34649 ER34650 ER34651 ER34701 ER34702 ER34703 ER34704 ER34706 ER34707 ER34708 ER34709 ER34710 ER34711 ER34851 ER34852 ER34853 ER34854 ER34855 ER34856 ER34857 ER34858 ER34859 ER34860 ER34861 ER34862 ER34863 ER34864 ER34901 ER34902 ER34903 ER34904 ER34906 ER34907 ER34908 ER34909 ER34910 ER34911 ER35052 ER35053 ER35054 ER35055 ER35062 ER35063 ER35064 ER35065 ER35101 ER35102 ER35103 ER35104 ER35106 ER35107 ER35108 ER35109 ER35110 ER35111 ER35252 ER35253 ER35254 ER35255 ER35262 ER35263 ER35264 ER35265 ER30010 ER30052 ER30076 ER30100 ER30126 ER30147 ER30169 ER30197 ER30226 ER30255 ER30296 ER30326 ER30356 ER30384 ER30413 ER30443 ER30478 ER30513 ER30549 ER30584 ER30620 ER30657 ER30703 ER30748 ER30820 ER33115 ER33215 ER33315 ER33415 ER33516 ER33616 ER33716 ER33817 ER33917 ER34020 ER34119 ER34230 ER34349 ER34548 ER34752 ER34952 ER35152 ER30403 ER30433 ER30467 ER30502 ER30539 ER30574 ER30610 ER30646 ER30693 ER30737 ER30810 ER33105 ER33205 ER33305 ER33405 ER33505 ER33605 ER33705 ER33805 ER33905 ER34005 ER34105 ER34205 ER34306 ER34505 ER34705 ER34905 ER35105

        keep `keep'


    /* 03. Identify family sample: original PSID vs. immigrant-latino */
        * 1968 family
        g og_1968_family = 1 if fam >= 1 & fam <= 2930
        replace og_1968_family = 1 if fam >= 5001 & fam <= 6872
        label var og_1968_family "Original PSID family"

        * immigrant latino family
        g imm_latino_family = 1 if (fam >= 3001 & fam <= 3511)
        replace imm_latino_family = 1 if (fam >= 4001 & fam <= 4851)
        replace imm_latino_family = 1 if (fam >= 7001 & fam <= 9308)
        label var imm_latino_family "Immigrant-Latino family"

        * sample
        g fam_sample = "Original 1968" if og_1968_family == 1
        replace fam_sample = "Immigrant-Latino" if imm_latino_family == 1
        label var fam_sample "Original 1968 or Imm/Latino Sample"

    /* 04. Waves observed dummies: in_1968, in_1969, ..., in_2023 */
        forvalues i = 1968/1997{
            g in_`i' = 0
            label var in_`i' "In FU `i'"
        }

        forvalues i=1999(2)2023{
            g in_`i' = 0
            label var in_`i' "In FU `i'"
        }

        local year_vars 1968 ER30018 1969 ER30041 1970 ER30065 1971 ER30089 1972 ER30115 1973 ER30136 1974 ER30158 1975 ER30186 1976 ER30215 1977 ER30244 1978 ER30281 1979 ER30311 1980 ER30341 1981 ER30371 1982 ER30397 1983 ER30427 1984 ER30461 1985 ER30496 1986 ER30533 1987 ER30568 1988 ER30604 1989 ER30640 1990 ER30685 1991 ER30729 1992 ER30802 1993 ER30863 1994 ER33127 1995 ER33283 1996 ER33325 1997 ER33437 1999 ER33545 2001 ER33636 2003 ER33739 2005 ER33847 2007 ER33949 2009 ER34044 2011 ER34153 2013 ER34267 2015 ER34412 2017 ER34649 2019 ER34862 2021 ER35063 2023 ER35263

        local i = 1
        while `i' <= `: word count `year_vars'' {
            local yr : word `i' of `year_vars'
            local var : word `= `i' + 1' of `year_vars'
            replace in_`yr' = 1 if `var' == 0
            local i = `i' + 2
        }

    /* 05. Ages in waves observed 



            The variables in_1968, in_1969, ..., in_1997, in_1999, ..., in_2023 
            take the value 1 during the years they are observed and missing otherwise.
            
            You can have a recorded age but not be observed in the family unit that year (e.g., 423 ppl in 1968)

            Therefore, I replace each year's age variable with missing if the person is not observed in that year.
            
            ** No person is age "0". The nascent codes 0 and 999 are 

            */

        local birthinterview
        if `birthinterview' == 1{
            local birthmonth 1985 ER30403 1986 ER30433 1987 ER30467 1988 ER30502 1989 ER30539 1990 ER30574 1991 ER30610 1992 ER30646 1993 ER30693 1994 ER30737 1995 ER30810 1996 ER33105 1997 ER33205 1999 ER33305 2001 ER33405 2003 ER33505 2005 ER33605 2007 ER33705 2009 ER33805 2011 ER33905 2013 ER34005 2015 ER34105 2017 ER34205 2019 ER34306 2021 ER34505 2023 ER34705


        }




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
            replace age_`yr' = `var' 
            local i = `i' + 2
        }

        forvalues i = 1968/1997{
            replace age_`i' = . if age_`i' == 0 | age_`i' == 999
        }

        forvalues i=1999(2)2023{
            replace age_`i' = . if age_`i' == 0 | age_`i' == 999
        }

        forvalues i=1968/1997{
            replace age_`i' = . if in_`i' == 0
        }

        forvalues i=1999(2)2023{
            replace age_`i' = . if in_`i' == 0
        }

    /* 06. Age first observed */
        g age_first_observed = age_1968 if age_1968 != .

        forvalues i=1969/1997{
            replace age_first_observed = age_`i' if age_first_observed == . & age_`i' != .
        }

        forvalues i=1999(2)2023{
            replace age_first_observed = age_`i' if age_first_observed == . & age_`i' != .
        }

        label var age_first_observed "Age first observed in PSID"

        /* 06a. Check 1 */
            local check1 0

            if `check1' == 1{
                g age_first_observed2 = age_1968 if age_1968 != .

                forvalues i=1969/1997{
                    replace age_first_observed2 = age_`i' if age_first_observed2 == . & age_`i' != . & in_`i' == 1
                }

                forvalues i=1999(2)2023{
                    replace age_first_observed2 = age_`i' if age_first_observed2 == . & age_`i' != . & in_`i' == 1
                }
            }

    /* 07. Waves & waves under 18 & waves under AND at 18*/
        g waves = in_1968 + in_1969 + in_1970 + in_1971 + in_1972 + in_1973 + in_1974 + in_1975 + in_1976 + in_1977 + in_1978 + in_1979 + in_1980 + in_1981 + in_1982 + in_1983 + in_1984 + in_1985 + in_1986 + in_1987 + in_1988 + in_1989 + in_1990 + in_1991 + in_1992 + in_1993 + in_1994 + in_1995 + in_1996 + in_1997 + in_1999  + in_2001  + in_2003  + in_2005  + in_2007  + in_2009  + in_2011  + in_2013  + in_2015  + in_2017  + in_2019  + in_2021  + in_2023
        label var waves "Number of waves observed in PSID"
        
        g waves_18_under = (!missing(age_1968) & age_1968 <= 18) + (!missing(age_1969) & age_1969 <= 18) + (!missing(age_1970) & age_1970 <= 18) + (!missing(age_1971) & age_1971 <= 18) + (!missing(age_1972) & age_1972 <= 18) + (!missing(age_1973) & age_1973 <= 18) + (!missing(age_1974) & age_1974 <= 18) + (!missing(age_1975) & age_1975 <= 18) + (!missing(age_1976) & age_1976 <= 18) + (!missing(age_1977) & age_1977 <= 18) + (!missing(age_1978) & age_1978 <= 18) + (!missing(age_1979) & age_1979 <= 18) + (!missing(age_1980) & age_1980 <= 18) + (!missing(age_1981) & age_1981 <= 18) + (!missing(age_1982) & age_1982 <= 18) + (!missing(age_1983) & age_1983 <= 18) + (!missing(age_1984) & age_1984 <= 18) + (!missing(age_1985) & age_1985 <= 18) + (!missing(age_1986) & age_1986 <= 18) + (!missing(age_1987) & age_1987 <= 18) + (!missing(age_1988) & age_1988 <= 18) + (!missing(age_1989) & age_1989 <= 18) + (!missing(age_1990) & age_1990 <= 18) + (!missing(age_1991) & age_1991 <= 18) + (!missing(age_1992) & age_1992 <= 18) + (!missing(age_1993) & age_1993 <= 18) + (!missing(age_1994) & age_1994 <= 18) + (!missing(age_1995) & age_1995 <= 18) + (!missing(age_1996) & age_1996 <= 18) + (!missing(age_1997) & age_1997 <= 18) + (!missing(age_1999) & age_1999 <= 18) + (!missing(age_2001) & age_2001 <= 18) + (!missing(age_2003) & age_2003 <= 18) + (!missing(age_2005) & age_2005 <= 18) + (!missing(age_2007) & age_2007 <= 18) + (!missing(age_2009) & age_2009 <= 18) + (!missing(age_2011) & age_2011 <= 18) + (!missing(age_2013) & age_2013 <= 18) + (!missing(age_2015) & age_2015 <= 18) + (!missing(age_2017) & age_2017 <= 18) + (!missing(age_2019) & age_2019 <= 18) + (!missing(age_2021) & age_2021 <= 18) + (!missing(age_2023) & age_2023 <= 18)
        label var waves_18_under "Waves in PSID at or before age 18"


        g waves_17_under = (!missing(age_1968) & age_1968 < 18) + (!missing(age_1969) & age_1969 < 18) + (!missing(age_1970) & age_1970 < 18) + (!missing(age_1971) & age_1971 < 18) + (!missing(age_1972) & age_1972 < 18) + (!missing(age_1973) & age_1973 < 18) + (!missing(age_1974) & age_1974 < 18) + (!missing(age_1975) & age_1975 < 18) + (!missing(age_1976) & age_1976 < 18) + (!missing(age_1977) & age_1977 < 18) + (!missing(age_1978) & age_1978 < 18) + (!missing(age_1979) & age_1979 < 18) + (!missing(age_1980) & age_1980 < 18) + (!missing(age_1981) & age_1981 < 18) + (!missing(age_1982) & age_1982 < 18) + (!missing(age_1983) & age_1983 < 18) + (!missing(age_1984) & age_1984 < 18) + (!missing(age_1985) & age_1985 < 18) + (!missing(age_1986) & age_1986 < 18) + (!missing(age_1987) & age_1987 < 18) + (!missing(age_1988) & age_1988 < 18) + (!missing(age_1989) & age_1989 < 18) + (!missing(age_1990) & age_1990 < 18) + (!missing(age_1991) & age_1991 < 18) + (!missing(age_1992) & age_1992 < 18) + (!missing(age_1993) & age_1993 < 18) + (!missing(age_1994) & age_1994 < 18) + (!missing(age_1995) & age_1995 < 18) + (!missing(age_1996) & age_1996 < 18) + (!missing(age_1997) & age_1997 < 18) + (!missing(age_1999) & age_1999 < 18) + (!missing(age_2001) & age_2001 < 18) + (!missing(age_2003) & age_2003 < 18) + (!missing(age_2005) & age_2005 < 18) + (!missing(age_2007) & age_2007 < 18) + (!missing(age_2009) & age_2009 < 18) + (!missing(age_2011) & age_2011 < 18) + (!missing(age_2013) & age_2013 < 18) + (!missing(age_2015) & age_2015 < 18) + (!missing(age_2017) & age_2017 < 18) + (!missing(age_2019) & age_2019 < 18) + (!missing(age_2021) & age_2021 < 18) + (!missing(age_2023) & age_2023 < 18)
        label var waves_17_under "Waves in PSID UNDER age 18 (17 and less)"



    /* 08. Relationships roster - load in relhist.dta */
        tempfile waves
        save `waves', replace
        clear
        use "${output}/relhist.dta", clear

        sort V1 V2 V3
        rename V1 fam
        label var fam "V1/ER30001 Family ID 1968"

        rename V2 person_number
        label var person_number "V2/ER30002 Person number 68"

        g ID = (1000*fam) + person_number
        label var ID "Individual ID (V1*1000 + V2)"

        rename V3 person_number_y
        label var person_number_y "V3/ER30002 Person number 68 (y)"
    
        g ID_y = (1000*fam) + person_number_y
        label var ID_y "Individual ID (V1*1000 + V3)"

        order fam ID person_number ID_y person_number_y

        rename V100 birth_year_x
        rename V101 sex_x
        rename V200 birth_year_y
        rename V201 sex_y

    /* 08a. Renaming in relhist */
        forvalues i=301(1)318{
            local varname = "V`i'"
            rename `varname' psid_status_x_`=1968 + (`i'-301)'
        }
        forvalues i=401(1)418{
            local varname = "V`i'"
            rename `varname' psid_status_y_`=1968 + (`i'-401)'
        }
        forvalues i=501(1)518{
            local varname = "V`i'"
            rename `varname' coresidence_status_`=1968 + (`i'-501)'
        }
        forvalues i=601(1)618{
            local varname = "V`i'"
            rename `varname' rv_8_rel_`=1968 + (`i'-601)'
        }
        forvalues i=701(1)718{
            local varname = "V`i'"
            rename `varname' rv_8_his_`=1968 + (`i'-701)'

        }
        forvalues i=801(1)818{
            local varname = "V`i'"
            rename `varname' rv_5_rel_`=1968 + (`i'-801)'

        }
        forvalues i=901(1)918{
            local varname = "V`i'"
            rename `varname' rv_5_his_`=1968 + (`i'-901)'

        }

        * 40,474  9.5% --> no relationship derived. 
        rename V4 relationship_3
        rename V6 relationship_5
        rename V5 rel_3_changed
        rename V7 rel_5_changed


    /* 08b. RELATIONSHIP for static */
        * replace relationship with modal relationship if relationship never changed.
        g relationship = relationship_5 if rel_5_changed == "1"

    /* 08c. Drop dyads for whom we have no relationship data */
        * ~ 9.5% of dyads have no relationship data (relationship_5 == "00000")        
        drop if relationship_5 == "00000"

    /* 08d. Deal with changing dyads -- DO THIS ANOTHER TIME 
    RIGHT NOW, JUST KEEP EVERYONE'S RELATIONSHIP AS MOST COMMONLY REPORTED. 
        forvalues i = 1968/1985{
            replace rv_5_rel_`i' = "" if rel_5_changed == "1"
            replace rv_5_his_`i' = "" if rel_5_changed == "1"
        }

        * Compress yearly relationship sequence into distinct states and change years.
        * max_changes = 17 implies up to 18 distinct relationships (rel_1 ... rel_18).
        * in reality, the maximum number of changes is only 5, so I can hardcode that.
        local max_changes = 5

        forvalues j = 1/`=`max_changes' + 1' {
            g str5 rel_`j' = ""
        }
        forvalues j = 1/`max_changes' {
            g int change_`j' = .
        }

        g str5 _prev_rel = ""
        g byte _rel_slot = 0
        g byte _new_rel = 0

        forvalues y = 1968/1985 {
            replace _new_rel = (rv_5_rel_`y' != "" & rv_5_rel_`y' != _prev_rel)
            replace _rel_slot = _rel_slot + 1 if _new_rel == 1

            forvalues j = 1/`=`max_changes' + 1' {
                replace rel_`j' = rv_5_rel_`y' if _new_rel == 1 & _rel_slot == `j'
            }

            forvalues j = 1/`max_changes' {
                replace change_`j' = `y' if _new_rel == 1 & _rel_slot == `=`j' + 1' & missing(change_`j')
            }

            replace _prev_rel = rv_5_rel_`y' if _new_rel == 1
        }

        drop _prev_rel _rel_slot _new_rel


    /* 08f. Repeat for rel_his */
        local max_changes = 5

        forvalues j = 1/`=`max_changes' + 1' {
            g str5 rel2_`j' = ""
        }
        forvalues j = 1/`max_changes' {
            g int change2_`j' = .
        }

        g str5 _prev_rel = ""
        g byte _rel_slot = 0
        g byte _new_rel = 0

        forvalues y = 1968/1985 {
            replace _new_rel = (rv_5_his_`y' != "" & rv_5_his_`y' != _prev_rel)
            replace _rel_slot = _rel_slot + 1 if _new_rel == 1

            forvalues j = 1/`=`max_changes' + 1' {
                replace rel2_`j' = rv_5_his_`y' if _new_rel == 1 & _rel_slot == `j'
            }

            forvalues j = 1/`max_changes' {
                replace change2_`j' = `y' if _new_rel == 1 & _rel_slot == `=`j' + 1' & missing(change2_`j')
            }

            replace _prev_rel = rv_5_his_`y' if _new_rel == 1
        }
        drop _prev_rel _rel_slot _new_rel


    /* 08e. Standardize */
        replace rel2_1 = "" if rel2_1 == rel_1
        replace rel2_2 = "" if rel2_2 == rel_2
        replace rel2_3 = "" if rel2_3 == rel_3
        replace rel2_4 = "" if rel2_4 == rel_4
        replace rel2_5 = "" if rel2_5 == rel_5

        replace rel_1 = relationship if rel_5_changed == "1"

    */
    /* 8f. Encode relationship */
        replace relationship = relationship_5
        keep fam ID person_number ID_y person_number_y relationship

        g rel_coded_A = ""
        replace rel_coded_A = "Other" if relationship == "00098" 
        replace rel_coded_A = "Spouse" if relationship == "00131" 
        replace rel_coded_A = "Spouse" if relationship == "00132" 
        replace rel_coded_A = "Spouse" if relationship == "00133" 
        replace rel_coded_A = "Spouse" if relationship == "00134" 
        replace rel_coded_A = "Spouse" if relationship == "00135" 
        replace rel_coded_A = "Spouse" if relationship == "00137" 
        replace rel_coded_A = "Spouse" if relationship == "00138" 
        replace rel_coded_A = "Spouse" if relationship == "00139" 
        replace rel_coded_A = "Spouse" if relationship == "00151" 
        replace rel_coded_A = "Spouse" if relationship == "00152" 
        replace rel_coded_A = "Spouse" if relationship == "00153" 
        replace rel_coded_A = "Spouse" if relationship == "00154" 
        replace rel_coded_A = "Spouse" if relationship == "00155" 
        replace rel_coded_A = "Spouse" if relationship == "00156" 
        replace rel_coded_A = "Spouse" if relationship == "00157" 
        replace rel_coded_A = "Spouse" if relationship == "00158" 
        replace rel_coded_A = "Spouse" if relationship == "00159" 
        replace rel_coded_A = "Spouse" if relationship == "00160" 
        replace rel_coded_A = "Spouse" if relationship == "00161" 
        replace rel_coded_A = "Spouse" if relationship == "00162" 
        replace rel_coded_A = "Spouse" if relationship == "00163" 
        replace rel_coded_A = "Spouse" if relationship == "00164" 
        replace rel_coded_A = "Spouse" if relationship == "00199" 
        replace rel_coded_A = "Sibling" if relationship == "00231" 
        replace rel_coded_A = "Sibling" if relationship == "00232" 
        replace rel_coded_A = "Sibling" if relationship == "00233" 
        replace rel_coded_A = "Sibling" if relationship == "00234" 
        replace rel_coded_A = "Sibling" if relationship == "00235" 
        replace rel_coded_A = "Sibling" if relationship == "00236" 
        replace rel_coded_A = "Sibling" if relationship == "00238" 
        replace rel_coded_A = "Sibling" if relationship == "00251" 
        replace rel_coded_A = "Sibling" if relationship == "00252" 
        replace rel_coded_A = "Sibling" if relationship == "00253" 
        replace rel_coded_A = "Sibling" if relationship == "00254" 
        replace rel_coded_A = "Sibling" if relationship == "00255" 
        replace rel_coded_A = "Sibling" if relationship == "00256" 
        replace rel_coded_A = "Sibling" if relationship == "00257" 
        replace rel_coded_A = "Sibling" if relationship == "00258" 
        replace rel_coded_A = "Sibling" if relationship == "00259" 
        replace rel_coded_A = "Sibling" if relationship == "00260" 
        replace rel_coded_A = "Sibling" if relationship == "00261" 
        replace rel_coded_A = "Sibling" if relationship == "00262" 
        replace rel_coded_A = "Sibling" if relationship == "00263" 
        replace rel_coded_A = "Sibling" if relationship == "00264" 
        replace rel_coded_A = "Sibling" if relationship == "00299" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00351" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00352" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00353" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00354" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00355" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00356" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00357" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00358" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00359" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00360" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00361" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00362" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00363" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00364" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00365" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00366" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00367" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00368" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00369" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00370" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00371" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00372" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00373" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00374" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00375" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00376" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00377" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00378" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00379" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00380" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00381" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00382" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00383" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00384" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00385" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00386" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00387" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00388" 
        replace rel_coded_A = "Sibling-in-law" if relationship == "00399" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00431" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00432" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00433" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00434" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00451" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00452" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00453" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00454" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00455" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00456" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00457" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00458" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00459" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00460" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00461" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00462" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00463" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00464" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00465" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00466" 
        replace rel_coded_A = "Spouse of sibling-in-law" if relationship == "00499" 
        replace rel_coded_A = "Sibling or cousin" if relationship == "00531" 
        replace rel_coded_A = "Sibling or cousin" if relationship == "00532" 
        replace rel_coded_A = "Sibling or cousin" if relationship == "00551" 
        replace rel_coded_A = "Sibling or cousin" if relationship == "00552" 
        replace rel_coded_A = "Cousin" if relationship == "00631" 
        replace rel_coded_A = "Cousin" if relationship == "00632" 
        replace rel_coded_A = "Cousin" if relationship == "00633" 
        replace rel_coded_A = "Cousin" if relationship == "00634" 
        replace rel_coded_A = "Cousin" if relationship == "00635" 
        replace rel_coded_A = "Cousin" if relationship == "00651" 
        replace rel_coded_A = "Cousin" if relationship == "00652" 
        replace rel_coded_A = "Cousin" if relationship == "00653" 
        replace rel_coded_A = "Cousin" if relationship == "00654" 
        replace rel_coded_A = "Cousin" if relationship == "00655" 
        replace rel_coded_A = "Cousin" if relationship == "00656" 
        replace rel_coded_A = "Cousin" if relationship == "00657" 
        replace rel_coded_A = "Cousin" if relationship == "00658" 
        replace rel_coded_A = "Cousin" if relationship == "00659" 
        replace rel_coded_A = "Cousin" if relationship == "00660" 
        replace rel_coded_A = "Cousin" if relationship == "00661" 
        replace rel_coded_A = "Cousin" if relationship == "00662" 
        replace rel_coded_A = "Cousin" if relationship == "00663" 
        replace rel_coded_A = "Cousin" if relationship == "00664" 
        replace rel_coded_A = "Cousin" if relationship == "00665" 
        replace rel_coded_A = "Cousin" if relationship == "00666" 
        replace rel_coded_A = "Cousin" if relationship == "00699" 
        replace rel_coded_A = "Sibling of sibling-in-law" if relationship == "00731" 
        replace rel_coded_A = "Sibling of sibling-in-law" if relationship == "00732" 
        replace rel_coded_A = "Sibling of sibling-in-law" if relationship == "00799" 
        replace rel_coded_A = "Sibling-in-law of sibling-in-law" if relationship == "00851" 
        replace rel_coded_A = "Sibling-in-law of sibling-in-law" if relationship == "00852" 
        replace rel_coded_A = "Sibling-in-law of sibling-in-law" if relationship == "00853" 
        replace rel_coded_A = "Sibling-in-law of sibling-in-law" if relationship == "00854" 
        replace rel_coded_A = "Sibling-in-law of sibling-in-law" if relationship == "00899" 
        replace rel_coded_A = "Cousin of spouse" if relationship == "00951" 
        replace rel_coded_A = "Cousin of spouse" if relationship == "00952" 
        replace rel_coded_A = "Cousin of spouse" if relationship == "00999" 
        replace rel_coded_A = "Parent of child-in-law" if relationship == "01031" 
        replace rel_coded_A = "Parent of child-in-law" if relationship == "01032" 
        replace rel_coded_A = "Parent of child-in-law" if relationship == "01099" 
        replace rel_coded_A = "Other" if relationship == "10098" 
        replace rel_coded_A = "Parent" if relationship == "10101" 
        replace rel_coded_A = "Parent" if relationship == "10102" 
        replace rel_coded_A = "Parent" if relationship == "10103" 
        replace rel_coded_A = "Parent" if relationship == "10104" 
        replace rel_coded_A = "Parent" if relationship == "10105" 
        replace rel_coded_A = "Parent" if relationship == "10106" 
        replace rel_coded_A = "Parent" if relationship == "10107" 
        replace rel_coded_A = "Parent" if relationship == "10108" 
        replace rel_coded_A = "Parent" if relationship == "10109" 
        replace rel_coded_A = "Parent" if relationship == "10110" 
        replace rel_coded_A = "Parent" if relationship == "10111" 
        replace rel_coded_A = "Parent" if relationship == "10112" 
        replace rel_coded_A = "Parent" if relationship == "10113" 
        replace rel_coded_A = "Parent" if relationship == "10114" 
        replace rel_coded_A = "Parent" if relationship == "10115" 
        replace rel_coded_A = "Parent" if relationship == "10116" 
        replace rel_coded_A = "Parent" if relationship == "10117" 
        replace rel_coded_A = "Parent" if relationship == "10118" 
        replace rel_coded_A = "Parent" if relationship == "10119" 
        replace rel_coded_A = "Parent" if relationship == "10199" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10201" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10202" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10203" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10204" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10205" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10206" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10207" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10208" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10209" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10210" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10211" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10212" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10213" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10215" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10216" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10217" 
        replace rel_coded_A = "Parent-in-law" if relationship == "10299" 
        replace rel_coded_A = "Parent or aunt/uncle" if relationship == "10301" 
        replace rel_coded_A = "Parent or aunt/uncle" if relationship == "10302" 
        replace rel_coded_A = "Parent or aunt/uncle" if relationship == "10303" 
        replace rel_coded_A = "Parent or aunt/uncle" if relationship == "10304" 
        replace rel_coded_A = "Parent or aunt/uncle" if relationship == "10305" 
        replace rel_coded_A = "Parent or aunt/uncle" if relationship == "10306" 
        replace rel_coded_A = "Parent or aunt/uncle" if relationship == "10307" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10401" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10402" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10403" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10404" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10405" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10406" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10407" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10408" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10409" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10411" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10412" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10413" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10414" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10415" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10416" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10417" 
        replace rel_coded_A = "Aunt/uncle" if relationship == "10499" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10501" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10502" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10503" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10504" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10505" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10506" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10507" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10509" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10510" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10511" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10513" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10514" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10515" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10516" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10519" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10520" 
        replace rel_coded_A = "Spouse of aunt/uncle" if relationship == "10599" 
        replace rel_coded_A = "Aunt/uncle of spouse" if relationship == "10601" 
        replace rel_coded_A = "Aunt/uncle of spouse" if relationship == "10602" 
        replace rel_coded_A = "Aunt/uncle of spouse" if relationship == "10603" 
        replace rel_coded_A = "Aunt/uncle of spouse" if relationship == "10699" 
        replace rel_coded_A = "Spouse of aunt/uncle of spouse" if relationship == "10701" 
        replace rel_coded_A = "Spouse of aunt/uncle of spouse" if relationship == "10799" 
        replace rel_coded_A = "Cousin of parent" if relationship == "10801" 
        replace rel_coded_A = "Cousin of parent" if relationship == "10802" 
        replace rel_coded_A = "Cousin of parent" if relationship == "10899" 
        replace rel_coded_A = "Sibling or spouse of aunt/uncle" if relationship == "10901" 
        replace rel_coded_A = "Sibling or spouse of aunt/uncle" if relationship == "10902" 
        replace rel_coded_A = "Sibling or spouse of aunt/uncle" if relationship == "10999" 
        replace rel_coded_A = "Parent-in-law of sibling" if relationship == "11001" 
        replace rel_coded_A = "Parent-in-law of sibling" if relationship == "11002" 
        replace rel_coded_A = "Parent-in-law of sibling" if relationship == "11099" 
        replace rel_coded_A = "Parent-in-law of sibling of spouse" if relationship == "11101" 
        replace rel_coded_A = "Parent-in-law of sibling of spouse" if relationship == "11102" 
        replace rel_coded_A = "Parent-in-law of sibling of spouse" if relationship == "11199" 
        replace rel_coded_A = "Grandparent of child-in-law" if relationship == "11299" 
        replace rel_coded_A = "Other" if relationship == "15098" 
        replace rel_coded_A = "Child" if relationship == "15101" 
        replace rel_coded_A = "Child" if relationship == "15102" 
        replace rel_coded_A = "Child" if relationship == "15103" 
        replace rel_coded_A = "Child" if relationship == "15104" 
        replace rel_coded_A = "Child" if relationship == "15105" 
        replace rel_coded_A = "Child" if relationship == "15106" 
        replace rel_coded_A = "Child" if relationship == "15107" 
        replace rel_coded_A = "Child" if relationship == "15108" 
        replace rel_coded_A = "Child" if relationship == "15109" 
        replace rel_coded_A = "Child" if relationship == "15110" 
        replace rel_coded_A = "Child" if relationship == "15111" 
        replace rel_coded_A = "Child" if relationship == "15112" 
        replace rel_coded_A = "Child" if relationship == "15113" 
        replace rel_coded_A = "Child" if relationship == "15114" 
        replace rel_coded_A = "Child" if relationship == "15115" 
        replace rel_coded_A = "Child" if relationship == "15116" 
        replace rel_coded_A = "Child" if relationship == "15117" 
        replace rel_coded_A = "Child" if relationship == "15118" 
        replace rel_coded_A = "Child" if relationship == "15119" 
        replace rel_coded_A = "Child" if relationship == "15199" 
        replace rel_coded_A = "Child-in-law" if relationship == "15201" 
        replace rel_coded_A = "Child-in-law" if relationship == "15202" 
        replace rel_coded_A = "Child-in-law" if relationship == "15203" 
        replace rel_coded_A = "Child-in-law" if relationship == "15204" 
        replace rel_coded_A = "Child-in-law" if relationship == "15205" 
        replace rel_coded_A = "Child-in-law" if relationship == "15206" 
        replace rel_coded_A = "Child-in-law" if relationship == "15207" 
        replace rel_coded_A = "Child-in-law" if relationship == "15208" 
        replace rel_coded_A = "Child-in-law" if relationship == "15209" 
        replace rel_coded_A = "Child-in-law" if relationship == "15210" 
        replace rel_coded_A = "Child-in-law" if relationship == "15211" 
        replace rel_coded_A = "Child-in-law" if relationship == "15212" 
        replace rel_coded_A = "Child-in-law" if relationship == "15213" 
        replace rel_coded_A = "Child-in-law" if relationship == "15215" 
        replace rel_coded_A = "Child-in-law" if relationship == "15216" 
        replace rel_coded_A = "Child-in-law" if relationship == "15217" 
        replace rel_coded_A = "Child-in-law" if relationship == "15299" 
        replace rel_coded_A = "Child or Niece/nephew" if relationship == "15301" 
        replace rel_coded_A = "Child or Niece/nephew" if relationship == "15302" 
        replace rel_coded_A = "Child or Niece/nephew" if relationship == "15303" 
        replace rel_coded_A = "Child or Niece/nephew" if relationship == "15304" 
        replace rel_coded_A = "Child or Niece/nephew" if relationship == "15305" 
        replace rel_coded_A = "Child or Niece/nephew" if relationship == "15306" 
        replace rel_coded_A = "Child or Niece/nephew" if relationship == "15307" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15401" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15402" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15403" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15404" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15405" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15406" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15407" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15408" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15409" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15411" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15412" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15413" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15414" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15415" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15416" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15417" 
        replace rel_coded_A = "Niece/nephew" if relationship == "15499" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15501" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15502" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15503" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15504" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15505" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15506" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15507" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15509" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15510" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15511" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15513" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15514" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15515" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15516" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15519" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15520" 
        replace rel_coded_A = "Niece/nephew of spouse" if relationship == "15599" 
        replace rel_coded_A = "Spouse of niece/nephew" if relationship == "15601" 
        replace rel_coded_A = "Spouse of niece/nephew" if relationship == "15602" 
        replace rel_coded_A = "Spouse of niece/nephew" if relationship == "15603" 
        replace rel_coded_A = "Spouse of niece/nephew" if relationship == "15699" 
        replace rel_coded_A = "Spouse of niece/nephew of spouse" if relationship == "15701" 
        replace rel_coded_A = "Spouse of niece/nephew of spouse" if relationship == "15799" 
        replace rel_coded_A = "Child of cousin" if relationship == "15801" 
        replace rel_coded_A = "Child of cousin" if relationship == "15802" 
        replace rel_coded_A = "Child of cousin" if relationship == "15899" 
        replace rel_coded_A = "Niece/nephew of spouse of sibling" if relationship == "15901" 
        replace rel_coded_A = "Niece/nephew of spouse of sibling" if relationship == "15902" 
        replace rel_coded_A = "Niece/nephew of spouse of sibling" if relationship == "15999" 
        replace rel_coded_A = "Sibling of child-in-law" if relationship == "16001" 
        replace rel_coded_A = "Sibling of child-in-law" if relationship == "16002" 
        replace rel_coded_A = "Sibling of child-in-law" if relationship == "16099" 
        replace rel_coded_A = "Spouse of sibling of child-in-law" if relationship == "16101" 
        replace rel_coded_A = "Spouse of sibling of child-in-law" if relationship == "16102" 
        replace rel_coded_A = "Spouse of sibling of child-in-law" if relationship == "16199" 
        replace rel_coded_A = "Parent-in-law of grandchild" if relationship == "16299" 
        replace rel_coded_A = "Grandparent" if relationship == "20098" 
        replace rel_coded_A = "Grandparent" if relationship == "20101" 
        replace rel_coded_A = "Grandparent" if relationship == "20102" 
        replace rel_coded_A = "Grandparent" if relationship == "20103" 
        replace rel_coded_A = "Grandparent" if relationship == "20104" 
        replace rel_coded_A = "Grandparent" if relationship == "20105" 
        replace rel_coded_A = "Grandparent" if relationship == "20106" 
        replace rel_coded_A = "Grandparent" if relationship == "20107" 
        replace rel_coded_A = "Grandparent" if relationship == "20108" 
        replace rel_coded_A = "Grandparent" if relationship == "20109" 
        replace rel_coded_A = "Grandparent" if relationship == "20110" 
        replace rel_coded_A = "Grandparent" if relationship == "20111" 
        replace rel_coded_A = "Grandparent" if relationship == "20112" 
        replace rel_coded_A = "Grandparent" if relationship == "20113" 
        replace rel_coded_A = "Grandparent" if relationship == "20114" 
        replace rel_coded_A = "Grandparent" if relationship == "20199" 
        replace rel_coded_A = "Grandparent of spouse" if relationship == "20201" 
        replace rel_coded_A = "Grandparent of spouse" if relationship == "20202" 
        replace rel_coded_A = "Grandparent of spouse" if relationship == "20203" 
        replace rel_coded_A = "Grandparent of spouse" if relationship == "20299" 
        replace rel_coded_A = "Grandparent or Grandaunt/uncle" if relationship == "20301" 
        replace rel_coded_A = "Grandaunt/uncle" if relationship == "20401" 
        replace rel_coded_A = "Grandaunt/uncle" if relationship == "20402" 
        replace rel_coded_A = "Grandaunt/uncle" if relationship == "20499" 
        replace rel_coded_A = "Grandparent or Great-grandparent" if relationship == "20501" 
        replace rel_coded_A = "Grandparent or Great-grandparent" if relationship == "20502" 
        replace rel_coded_A = "Grandparent or Great-grandparent" if relationship == "20503" 
        replace rel_coded_A = "Grandparent or Great-grandparent" if relationship == "20504" 
        replace rel_coded_A = "Grandparent or Great-grandparent" if relationship == "20505" 
        replace rel_coded_A = "Great-grandparent" if relationship == "20601" 
        replace rel_coded_A = "Great-grandparent" if relationship == "20602" 
        replace rel_coded_A = "Great-grandparent" if relationship == "20603" 
        replace rel_coded_A = "Great-grandparent" if relationship == "20604" 
        replace rel_coded_A = "Great-grandparent" if relationship == "20699" 
        replace rel_coded_A = "Great-great-grandparent" if relationship == "20799" 
        replace rel_coded_A = "Great-grandaunt/uncle" if relationship == "20899" 
        replace rel_coded_A = "Gaunt/guncle or parent of a/u by m" if relationship == "20901" 
        replace rel_coded_A = "Gaunt/guncle or parent of a/u by m" if relationship == "20902" 
        replace rel_coded_A = "Gaunt/guncle or parent of a/u by m" if relationship == "20903" 
        replace rel_coded_A = "Gaunt/guncle or parent of a/u by m" if relationship == "20904" 
        replace rel_coded_A = "Gaunt/guncle or parent of a/u by m" if relationship == "20999" 
        replace rel_coded_A = "Grandparent of spouse of sibling" if relationship == "21099" 
        replace rel_coded_A = "Great-grandparent of spouse" if relationship == "21199" 
        replace rel_coded_A = "Grandaunt/uncle of spouse" if relationship == "21299" 
        replace rel_coded_A = "Grandchild" if relationship == "25098" 
        replace rel_coded_A = "Grandchild" if relationship == "25101" 
        replace rel_coded_A = "Grandchild" if relationship == "25102" 
        replace rel_coded_A = "Grandchild" if relationship == "25103" 
        replace rel_coded_A = "Grandchild" if relationship == "25104" 
        replace rel_coded_A = "Grandchild" if relationship == "25105" 
        replace rel_coded_A = "Grandchild" if relationship == "25106" 
        replace rel_coded_A = "Grandchild" if relationship == "25107" 
        replace rel_coded_A = "Grandchild" if relationship == "25108" 
        replace rel_coded_A = "Grandchild" if relationship == "25109" 
        replace rel_coded_A = "Grandchild" if relationship == "25110" 
        replace rel_coded_A = "Grandchild" if relationship == "25111" 
        replace rel_coded_A = "Grandchild" if relationship == "25112" 
        replace rel_coded_A = "Grandchild" if relationship == "25113" 
        replace rel_coded_A = "Grandchild" if relationship == "25114" 
        replace rel_coded_A = "Grandchild" if relationship == "25199" 
        replace rel_coded_A = "Spouse of grandchild" if relationship == "25201" 
        replace rel_coded_A = "Spouse of grandchild" if relationship == "25202" 
        replace rel_coded_A = "Spouse of grandchild" if relationship == "25203" 
        replace rel_coded_A = "Spouse of grandchild" if relationship == "25299" 
        replace rel_coded_A = "Grandchild or Grandniece/nephew" if relationship == "25301" 
        replace rel_coded_A = "Grandniece/nephew" if relationship == "25401" 
        replace rel_coded_A = "Grandniece/nephew" if relationship == "25402" 
        replace rel_coded_A = "Grandniece/nephew" if relationship == "25499" 
        replace rel_coded_A = "Grandchild or Great-grandchild" if relationship == "25501" 
        replace rel_coded_A = "Grandchild or Great-grandchild" if relationship == "25502" 
        replace rel_coded_A = "Grandchild or Great-grandchild" if relationship == "25503" 
        replace rel_coded_A = "Grandchild or Great-grandchild" if relationship == "25504" 
        replace rel_coded_A = "Grandchild or Great-grandchild" if relationship == "25505" 
        replace rel_coded_A = "Great-grandchild" if relationship == "25601" 
        replace rel_coded_A = "Great-grandchild" if relationship == "25602" 
        replace rel_coded_A = "Great-grandchild" if relationship == "25603" 
        replace rel_coded_A = "Great-grandchild" if relationship == "25604" 
        replace rel_coded_A = "Great-grandchild" if relationship == "25699" 
        replace rel_coded_A = "Great-great-grandchild" if relationship == "25799" 
        replace rel_coded_A = "Great-grandniece/nephew" if relationship == "25899" 
        replace rel_coded_A = "Gniece/neph or niece/neph by m of child" if relationship == "25901" 
        replace rel_coded_A = "Gniece/neph or niece/neph by m of child" if relationship == "25902" 
        replace rel_coded_A = "Gniece/neph or niece/neph by m of child" if relationship == "25903" 
        replace rel_coded_A = "Gniece/neph or niece/neph by m of child" if relationship == "25904" 
        replace rel_coded_A = "Gniece/neph or niece/neph by m of child" if relationship == "25999" 
        replace rel_coded_A = "Sibling of spouse of grandchild" if relationship == "26099" 
        replace rel_coded_A = "Spouse of great-grandchild" if relationship == "26199" 
        replace rel_coded_A = "Spouse of grandniece/nephew" if relationship == "26299" 
        replace rel_coded_A = "Other relative" if relationship == "99731" 
        replace rel_coded_A = "Other non-relative" if relationship == "99831" 

        label var rel_coded_A "Relationship btwn person X and Y"

        keep ID ID_y rel_coded_A fam


    /* 09. Reshape*/
    bysort ID (ID_y): g index = _n
    reshape wide rel_coded_A ID_y, i(ID) j(index)            
    tempfile relmatrix
    save `relmatrix', replace
    * 386,134

    /* 10. FIMS: merge on family identification mapping system files that allow us to identify parents, gpars, and sibs */

        * Merge on grandparents FIMS file (note--this also has the parent variables)
        merge 1:1 ID using "${output}/_fims_gpars_clean_v2.dta"
        * N = 103,701
        drop if _merge == 2
        * N= 85,836
        drop _merge

        * Merge on siblings FIMS file
        merge 1:1 ID using "${output}/_fims_sib_clean_v2.dta"
        * N = 85,836

        * Merge on waves
        drop _merge
        merge 1:1 ID using "`waves'"

    
    /* 11. CREATE ANALYTIC SAMPLES & SAVE tempfile pre_cut1: 
        * sample N: all PSID children. Anyone observed for any number of waves before age 18.
        * sample A: two-wave children. Anyone observed for at least two waves before age 18.
        * sample B: full childhood. Anyone observed continuously from birth to age 18. 
        * before drop, n=85,836 sample people; 8,102 families (distinct values of fam); n=103,701 total ppl if we keep gpars/pars
        */
        replace waves_18_under = 0 if waves_18_under == .
        g analytic_sample_indiv = 1 if waves_18_under >= 1
        replace analytic_sample_indiv = 0 if waves_18_under == 0
        egen analytic_sample_family = max(analytic_sample_indiv), by(fam)
        label var analytic_sample_indiv "Binary: In Sample N, A, or B"
        label var analytic_sample_family "Binary: Family with at least one child in Sample N, A, or B"

        tempfile pre_cut1
        save `pre_cut1', replace

    /* 10. Drop unqualified families 
        * 5,640 families
        * 80,396 sample people in qualified families
        * 46,351 qualified children (children in sample N, A, or B)
        */

        drop if analytic_sample_family == 0

    /* 11. Define each sample: N, A, B 
        N: 46,351 children; 80,396 sample people; 5,640 families
        A: 39,285 children; 77,504 sample people; 5,038 families
        B: 1,990 children; 35,552 sample people; 1,137 families
        */

        g sample_indiv_N = 1 if waves_18_under >= 1
        replace sample_indiv_N = 0 if waves_18_under == 0
        label var sample_indiv_N "Binary: In Sample N (at least one wave observed at or before age 18)"
        egen sample_family_N = max(sample_indiv_N), by(fam)
        label var sample_family_N "Binary: Family with at least one child in Sample N"

        g sample_indiv_A = 1 if waves_18_under >= 2
        replace sample_indiv_A = 0 if waves_18_under < 2
        label var sample_indiv_A "Binary: In Sample A (at least two waves observed at or before age 18)"
        egen sample_family_A = max(sample_indiv_A), by(fam)
        label var sample_family_A "Binary: Family with at least one child in Sample A"

        g sample_indiv_B = 1 if waves_18_under >= 19
        replace sample_indiv_B = 0 if waves_18_under < 19
        label var sample_indiv_B "Binary: In Sample B (observed in all waves from birth to age 18)"
        egen sample_family_B = max(sample_indiv_B), by(fam)
        label var sample_family_B "Binary: Family with at least one child in Sample B"


    /* 12. Why each FIMS non-sample member is here */ 
        g fims_has_sample_parent = 1 if ID_aM != . | ID_bM != . | ID_aD != . | ID_bD != .
        replace fims_has_sample_parent = 0 if fims_has_sample_parent == .
        replace fims_has_sample_parent = 0 if ER30003 != .
        label var fims_has_sample_parent "Is FIMS person and has parent in sample"
  
        /* 
        Note to future Sarah: here is where we could consider variables for has non-sample sibling + by type. 
        The fims sibling file is long by sample members, not long by all IDs, so this variable always zeros out. 
            g fims_has_sample_sibling = 1 if ID_S01 != . | ID_S02 != . | ID_S03 != . | ID_S04 != . | ID_S05 != . | ID_S06 != . | ID_S07 != . | ID_S08 != . | ID_S09 != . | ID_S10 != . | ID_S11 != . | ID_S12 != . | ID_S13 != . | ID_S14 != . | ID_S15 != . | ID_S16 != . 
            replace fims_has_sample_sibling = 0 if fims_has_sample_sibling == .
            replace fims_has_sample_sibling = 0 if ER30003 != .
            label var fims_has_sample_sibling "Is FIMS person and has sibling in sample"
        */

        g fims_has_sample_gpar = 1 if ID_aM_aM != . | ID_aM_bM != . | ID_aM_aD != . | ID_aM_bD != . | ID_bM_aM != . | ID_bM_bM != . | ID_bM_aD != . | ID_bM_bD != . | ID_aD_aM != . | ID_aD_bM != . | ID_aD_aD != . | ID_aD_bD != . | ID_bD_aM != . | ID_bD_bM != . | ID_bD_aD != . | ID_bD_bD != .
        replace fims_has_sample_gpar = 0 if fims_has_sample_gpar == . 
        replace fims_has_sample_gpar = 0 if ER30003 != .
        label var fims_has_sample_gpar "Is FIMS person and has grandparent in sample"

    /* 13. Sex */
        rename ER32000 sex 
        label var sex "Sex of Individual"

    /* TEMPFILE: POST CUT */
        tempfile post_cut1
        save `post_cut1', replace

    /* 14. Split offs */
        local who 1968 ER30003 1969 ER30022 1970 ER30045 1971 ER30069 1972 ER30093 1973 ER30119 1974 ER30140 1975 ER30162 1976 ER30190 1977 ER30219 1978 ER30248 1979 ER30285 1980 ER30315 1981 ER30345 1982 ER30375 1983 ER30401 1984 ER30431 1985 ER30465 1986 ER30500 1987 ER30537 1988 ER30572 1989 ER30608 1990 ER30644 1991 ER30691 1992 ER30735 1993 ER30808 1994 ER33103 1995 ER33203 1996 ER33303 1997 ER33403 1999 ER33503 2001 ER33603 2003 ER33703 2005 ER33803 2007 ER33903 2009 ER34003 2011 ER34103 2013 ER34203 2015 ER34303 2017 ER34503 2019 ER34703 2021 ER34903 2023 ER35103
        local splits 1968 ER30006 1969 ER30025 1970 ER30048 1971 ER30072 1972 ER30096 1973 ER30122 1974 ER30143 1975 ER30165 1976 ER30193 1977 ER30222 1978 ER30251 1979 ER30288 1980 ER30318 1981 ER30348 1982 ER30378 1983 ER30406 1984 ER30436 1985 ER30470 1986 ER30505 1987 ER30542 1988 ER30577 1989 ER30613 1990 ER30649 1991 ER30696 1992 ER30740 1993 ER30813 1994 ER33108 1995 ER33208 1996 ER33308 1997 ER33408 1999 ER33508 2001 ER33608 2003 ER33708 2005 ER33808 2007 ER33908 2009 ER34008 2011 ER34108 2013 ER34208 2015 ER34309 2017 ER34508 2019 ER34708 2021 ER34908 2023 ER35108
        local months 1968 ER30007 1969 ER30026 1970 ER30049 1971 ER30073 1972 ER30097 1973 ER30123 1974 ER30144 1975 ER30166 1976 ER30194 1977 ER30223 1978 ER30252 1979 ER30289 1980 ER30319 1981 ER30349 1982 ER30379 1983 ER30407 1984 ER30437 1985 ER30471 1986 ER30506 1987 ER30543 1988 ER30578 1989 ER30614 1990 ER30650 1991 ER30697 1992 ER30741 1993 ER30814 1994 ER33109 1995 ER33209 1996 ER33309 1997 ER33409 1999 ER33509 2001 ER33609 2003 ER33709 2005 ER33809 2007 ER33909 2009 ER34009 2011 ER34109 2013 ER34209 2015 ER34310 2017 ER34509 2019 ER34709 2021 ER34909 2023 ER35109
        local families 1968 fam 1969 ER30020 1970 ER30043 1971 ER30067 1972 ER30091 1973 ER30117 1974 ER30138 1975 ER30160 1976 ER30188 1977 ER30217 1978 ER30246 1979 ER30283 1980 ER30313 1981 ER30343 1982 ER30373 1983 ER30399 1984 ER30429 1985 ER30463 1986 ER30498 1987 ER30535 1988 ER30570 1989 ER30606 1990 ER30642 1991 ER30689 1992 ER30733 1993 ER30806 1994 ER33101 1995 ER33201 1996 ER33301 1997 ER33401 1999 ER33501 2001 ER33601 2003 ER33701 2005 ER33801 2007 ER33901 2009 ER34001 2011 ER34101 2013 ER34201 2015 ER34301 2017 ER34501 2019 ER34701 2021 ER34901 2023 ER35101


        local i = 1
        while `i' <= `: word count `splits'' {
            local yr : word `i' of `splits'
            local var : word `= `i' + 1' of `splits'
            g splitoff_`yr' = .
            replace splitoff_`yr' = 1 if `var' == 1
            local i = `i' + 2
        }

        local j = 1
        while `j' <= `: word count `months'' {
            local yr : word `j' of `months'
            local var : word `= `j' + 1' of `months'
            replace splitoff_`yr' = . if `var' != 0
            local j = `j' + 2
        }

        local k = 1
        while `k' <= `: word count `who'' {
            local yr : word `k' of `who'
            local var : word `= `k' + 1' of `who'
            replace splitoff_`yr' = . if `var' != 1
            label var splitoff_`yr' "Splitoff family in FU `yr'"
            local k = `k' + 2
        }

        forvalues i = 1968/1997{
            g fam_id_`i' = .
            label var fam_id_`i' "Family ID in FU `i'"
        }
        forvalues i=1999(2)2023{
            g fam_id_`i' = .
            label var fam_id_`i' "Family ID in FU `i'"
        }

        local l = 1
        while `l' <= `: word count `families'' {
            local yr : word `l' of `families'
            local var : word `= `l' + 1' of `families'
            replace fam_id_`yr' = `var'
            local l = `l' + 2
        }

    /* 15. Head relationship */ 
        * Relationship to head
        local head_rel 1968 ER30003 1969 ER30022 1970 ER30045 1971 ER30069 1972 ER30093 1973 ER30119 1974 ER30140 1975 ER30162 1976 ER30190 1977 ER30190 1978 ER30219 1979 ER30248 1980 ER30285 1981 ER30315 1982 ER30345 1983 ER30375 1984 ER30401 1985 ER30431 1986 ER30465 1987 ER30500 1988 ER30537 1989 ER30572 1990 ER30608 1991 ER30644 1992 ER30691 1993 ER30735 1994 ER30808 1995 ER33103 1996 ER33203 1997 ER33303 1999 ER33403 2001 ER33503 2003 ER33603 2005 ER33703 2007 ER33803 2009 ER33903 2011 ER34003 2013 ER34103 2015 ER34203 2017 ER34303 2019 ER34503 2021 ER34703 2023 ER34903

        forvalues m = 1968/1997 {
            g head_rel_`m' = .
            label var head_rel_`m' "Relationship to head in year `m'"
        }

        forvalues m = 1999(2)2023 {
            g head_rel_`m' = .
            label var head_rel_`m' "Relationship to head in year `m'"
        }

        local n = 1
        while `n' <= `: word count `head_rel'' {
            local yr : word `n' of `head_rel'
            local var : word `= `n' + 1' of `head_rel'
            replace head_rel_`yr' = `var'
            local n = `n' + 2
        }

    /* 15. Clean before reshape - May 18, 2026 */
        keep fam ID person_number sex  ID_bM ID_bD age_first_observed sample_indiv_N sample_family_N sample_indiv_A sample_family_A sample_indiv_B sample_family_B og_1968_family imm_latino_family fam_sample in_1968 in_1969 in_1970 in_1971 in_1972 in_1973 in_1974 in_1975 in_1976 in_1977 in_1978 in_1979 in_1980 in_1981 in_1982 in_1983 in_1984 in_1985 in_1986 in_1987 in_1988 in_1989 in_1990 in_1991 in_1992 in_1993 in_1994 in_1995 in_1996 in_1997 in_1999 in_2001 in_2003 in_2005 in_2007 in_2009 in_2011 in_2013 in_2015 in_2017 in_2019 in_2021 in_2023 age_1968 age_1969 age_1970 age_1971 age_1972 age_1973 age_1974 age_1975 age_1976 age_1977 age_1978 age_1979 age_1980 age_1981 age_1982 age_1983 age_1984 age_1985 age_1986 age_1987 age_1988 age_1989 age_1990 age_1991 age_1992 age_1993 age_1994 age_1995 age_1996 age_1997 age_1999 age_2001 age_2003 age_2005 age_2007 age_2009 age_2011 age_2013 age_2015 age_2017 age_2019 age_2021 age_2023 waves waves_18_under ID_aM ID_aD ID_aM_aM ID_aM_aD ID_aM_bM ID_aM_bD ID_aD_aM ID_aD_aD ID_aD_bM ID_aD_bD ID_bM_aM ID_bM_aD ID_bM_bM ID_bM_bD ID_bD_aM ID_bD_aD ID_bD_bM ID_bD_bD analytic_sample_indiv analytic_sample_family fims_has_sample_parent fims_has_sample_gpar  splitoff_1973 splitoff_1968 splitoff_1969 splitoff_1970 splitoff_1971 splitoff_1972 splitoff_1974 splitoff_1975 splitoff_1976 splitoff_1977 splitoff_1978 splitoff_1979 splitoff_1980 splitoff_1981 splitoff_1982 splitoff_1983 splitoff_1984 splitoff_1985 splitoff_1986 splitoff_1987 splitoff_1988 splitoff_1989 splitoff_1990 splitoff_1991 splitoff_1992 splitoff_1993 splitoff_1994 splitoff_1995 splitoff_1996 splitoff_1997 splitoff_1999 splitoff_2001 splitoff_2003 splitoff_2005 splitoff_2007 splitoff_2009 splitoff_2011 splitoff_2013 splitoff_2015 splitoff_2017 splitoff_2019 splitoff_2021 splitoff_2023 fam_id_1968 fam_id_1969 fam_id_1970 fam_id_1971 fam_id_1972 fam_id_1973 fam_id_1974 fam_id_1975 fam_id_1976 fam_id_1977 fam_id_1978 fam_id_1979 fam_id_1980 fam_id_1981 fam_id_1982 fam_id_1983 fam_id_1984 fam_id_1985 fam_id_1986 fam_id_1987 fam_id_1988 fam_id_1989 fam_id_1990 fam_id_1991 fam_id_1992 fam_id_1993 fam_id_1994 fam_id_1995 fam_id_1996 fam_id_1997 fam_id_1999 fam_id_2001 fam_id_2003 fam_id_2005 fam_id_2007 fam_id_2009 fam_id_2011 fam_id_2013 fam_id_2015 fam_id_2017 fam_id_2019 fam_id_2021 fam_id_2023 ID_S01 ID_S02 ID_S03 ID_S04 ID_S05 ID_S06 ID_S07 ID_S08 ID_S09 ID_S10 ID_S11 ID_S12 ID_S13 ID_S14 ID_S15 ID_S16 head_rel_1968 head_rel_1969 head_rel_1970 head_rel_1971 head_rel_1972 head_rel_1973 head_rel_1974 head_rel_1975 head_rel_1976 head_rel_1977 head_rel_1978 head_rel_1979 head_rel_1980 head_rel_1981 head_rel_1982 head_rel_1983 head_rel_1984 head_rel_1985 head_rel_1986 head_rel_1987 head_rel_1988 head_rel_1989 head_rel_1990 head_rel_1991 head_rel_1992 head_rel_1993 head_rel_1994 head_rel_1995 head_rel_1996 head_rel_1997 head_rel_1999 head_rel_2001 head_rel_2003 head_rel_2005 head_rel_2007 head_rel_2009 head_rel_2011 head_rel_2013 head_rel_2015 head_rel_2017 head_rel_2019 head_rel_2021 head_rel_2023

    /* 16. RESHAPE LONG and save tempfile `long-file1'*/ 
        reshape long age_ in_ splitoff_ fam_id_ head_rel_, i(ID) j(year)
        order ID fam fam_id_ person_number age_first_observed sex
        label var year "Year"
        label var fam_id_ "Family ID in year"
        label var age_ "Age in year"
        label var in_ "Present in year"
        label var splitoff_ "Splitoff family in year"
        label var head_rel_ "Relationship to head in year"
        * 3,457,028 person-year observations --> INCLUDING BLANKS
        * 80,396 people
        * 46,351 of them sample members
        tempfile long_file1
        save `long_file1', replace


    /* 17. Drop rows when person not interviewed PROVIDED IT IS NOT THE OBSERVATION
        AFTER THE LAST OBSERVATION FOR THAT PERSON 
        keep one after each person's last observation to understand why they attrited*/
        sort ID year
        by ID: replace in_ = 2 if in_ == 0 & in_[_n-1] == 1 & in_[_n+1]  == 0        
        drop if in_ == 0
        label var in_ "Present in year (1) or year after last observation (2)"

        * now: 930,453 person-years, 
        * 80,016 people
        * 46,351 of them sample members 


    /* 18. Household Roster */
        g hhr = ""
        sort fam year fam_id_ ID
        label var hhr "Household roster: IDs of family members in the same family-year"

        * for each year in each family, replace hhr with a list of the IDs of the family members with the same value of fam_id_ in that year. 
        * if hhr = "", that means it is the row capturing the year AFTER the individual left the study (the year after their last observation)
        * count if hhr == "" & ID == ID[_n+1] --> 0

        g str_id = string(ID)
        bysort fam year fam_id_ (ID): replace hhr = str_id[1]
        bysort fam year fam_id_ (ID): replace hhr = hhr[_n-1] + " " + str_id if _n > 1
        bysort fam year fam_id_ (ID): replace hhr = hhr[_N]
        drop str_id
        replace hhr = "" if in_ == 2

        * without self
        g hhr_padded = " " + hhr + " "
        g hhr_no_self = strtrim(itrim(subinstr(hhr_padded, " " + string(ID) + " ", " ", .)))
        drop hhr_padded
        label var hhr_no_self "HHR without self: IDs of family members in the same family-year excluding self"


    /* 19. Ages Roster */
        g ages_hhr = ""
        sort fam year fam_id_ ID
        g str_age = string(age_)
        replace str_age = "" if str_age == "."
        bysort fam year fam_id_ (ID): replace ages_hhr = str_age[1]
        bysort fam year fam_id_ (ID): replace ages_hhr = ages_hhr[_n-1] + " " + str_age if _n > 1
        bysort fam year fam_id_ (ID): replace ages_hhr = ages_hhr[_N]
        drop str_age
        replace ages_hhr = "" if in_ == 2
        label var ages_hhr "Ages of family members in the same family-year"

        g ages_padded = " " + ages_hhr + " "
        g ages_no_self = strtrim(itrim(subinstr(ages_padded, " " + string(age_) + " ", " ", .)))
        drop ages_padded
        label var ages_no_self "Ages without self: Ages of family members in the same family-year excluding self"



    /* 20. Relationships Roster */
        g rel_hhr = ""
        sort fam year fam_id_ ID
        g str_rel = string(head_rel_)
        bysort fam year fam_id_ (ID): replace rel_hhr = str_rel[1]
        bysort fam year fam_id_ (ID): replace rel_hhr = rel_hhr[_n-1] + " " + str_rel if _n > 1
        bysort fam year fam_id_ (ID): replace rel_hhr = rel_hhr[_N]
        drop str_rel
        replace rel_hhr = "" if in_ == 2

        label var rel_hhr "Relationships of family members in the same family-year"

        g rel_padded = " " + rel_hhr + " "
        g rel_no_self = strtrim(itrim(subinstr(rel_padded, " " + string(head_rel_) + " ", " ", .)))
        drop rel_padded
        label var rel_no_self "Rel no self: Relationships of family members in the same family-year excluding self"

    /* 21. List of siblings - time invariant*/
        egen sib_list = concat(ID_S01 ID_S02 ID_S03 ID_S04 ID_S05 ID_S06 ID_S07 ID_S08 ID_S09 ID_S10 ID_S11 ID_S12 ID_S13 ID_S14 ID_S15 ID_S16), punct(" ")
        replace sib_list = subinstr(sib_list, ".", "", .)
        replace sib_list = strtrim(sib_list)
        replace sib_list = stritrim(sib_list)
        label var sib_list "List of siblings (time invariant)"

    /* 22. List of parents - time invariant */
        egen par_list = concat(ID_aM ID_bM ID_aD ID_bD), punct(" ")
        replace par_list = subinstr(par_list, ".", "", .)
        replace par_list = strtrim(par_list)
        replace par_list = stritrim(par_list)
        label var par_list "List of parents (time invariant)"

    /* 23. List of grandparents - time invariant */
        egen gpar_list = concat(ID_aM_aM ID_aM_bM ID_aM_aD ID_aM_bD ID_bM_aM ID_bM_bM ID_bM_aD ID_bM_bD ID_aD_aM ID_aD_bM ID_aD_aD ID_aD_bD ID_bD_aM ID_bD_bM ID_bD_aD ID_bD_bD), punct(" ")
        replace gpar_list = subinstr(gpar_list, ".", "", .)
        replace gpar_list = strtrim(gpar_list)
        replace gpar_list = stritrim(gpar_list)
        label var gpar_list "List of grandparents (time invariant)"

    /* 24. Save and export full */
        save "$output/_psid_long.dta", replace
    
    /* 25. Trim further - long lean */
        /* a. Drop year after last observation for each person */
            drop if in_ == 2
            * 867,731 observations
            * 80,016 people. 46,351 in N, 39,285 in A, 1,990 in B. 

        /* b. DROP non-sample members and OBSERVATIONS after 18: 
            We preserve family members of non-sample members because we use them 
            to construct family rosters and later to add race and ethnicity info. 
            but we don't care about HHR changes among non-sample members. 
            We only care about HHR changes for sample members during childhood. 
            Therefore, we drop observations after 18.
        */
            drop if analytic_sample_indiv == 0
            * 545,084 observations, same Ns. 
            drop if age_ >= 18
            * 316,734 observations, same Ns. 

        /* c. Drop variables */ 
            keep ID fam_id_ year hhr_no_self ages_no_self rel_no_self sib_list par_list gpar_list fam age_ sample_indiv_N sample_indiv_A sample_indiv_B 
            order fam ID year hhr_no_self ages_no_self rel_no_self sib_list par_list gpar_list age_ sample_indiv_N sample_indiv_A sample_indiv_B  
            sort fam ID year

        save "${output}/_psid_long_lean.dta", replace

}




/* ------------------------------------- */
* PART III: Merge three datasets: 
* 1. Long data: _psid_long.dta
* 2. Long data with hhr changes: _hhr.csv
* 3. Panel data of heads: _heads_panel.dta
/* ------------------------------------- */

if `part3' == 1{
    /* 01. Load _hhr.csv */
        import delimited "$output/_hhr.csv", clear
        drop is_first is_last
        local truefalse adult_came child_came adult_left child_left sib_came sib_left
        foreach var of local truefalse {
            g `var'1 = 1 if `var' == "True"
            replace `var'1 = 0 if `var' == "False"
            drop `var'
            rename `var'1 `var'
        }
        rename id ID 

    /* 02. Merge on _psid_long.dta */
        merge 1:m ID year using "$output/_psid_long.dta"
        sort ID year

        * clean a little (python vars not case sensitive)
        drop _merge sample_indiv_n sample_indiv_a sample_indiv_b

        * drop observations for children after age 18
        drop if age_ >= 18 & analytic_sample_indiv == 1
        sort fam year fam_id_ ID

        * drop family-years when child not observed 
        bysort fam year fam_id_: egen any_kid = max(analytic_sample_indiv == 1)
        drop if any_kid == 0
        drop any_kid
        * 505,472 person-year observations,
        sort ID year

        * CLEAN 
        drop hhr_no_self ages_no_self rel_no_self splitoff_ 
        drop ID_*
        local vars hhr ages_hhr rel_hhr siblings parents grandparents hhr_prev ages_prev  
        foreach var of local vars {
            replace `var' = "" if analytic_sample_indiv == 0
        }

        * sort
        sort fam year fam_id_ ID
        tempfile allfam
        save `allfam'

        * drop non-sample members
        drop if analytic_sample_indiv == 0
        tempfile onlysample
        save `onlysample'

    /* 03. Merge on _heads_panel.dta */
        merge m:1 fam_id_ year using "$output/_heads_panel.dta"
        sort fam year fam_id_ ID

        drop if _merge == 1 & analytic_sample_indiv != 1
        sort fam year fam_id_ ID
        
    /* 04. drop non-sample members*/
        drop if analytic_sample_indiv == .
        sort fam year fam_id_ ID
        
    }


/* ------------------------------------- */
* PART IV: Clean save
/* ------------------------------------- */

if `part4' == 1{
    /* 01. Clean */
    sort fam year fam_id_ ID
    * Sarah: go in and add labels. 
    save "$output/_psid_analytic_sample.dta", replace

    /* Lean version for tables */ 
    drop hhr ages_hhr rel_hhr siblings parents grandparents hhr_prev ages_prev rel_prev ids_left ids_came ages_left ages_came rel_left rel_came sib_ages_came sib_ages_left
    * I dropped in_ = 2 for kids-- why? and when 
    drop in_ analytic_sample_indiv analytic_sample_family fims_has_sample_parent fims_has_sample_gpar sib_list par_list gpar_list rel_to_head _merge
    drop sample_family_N sample_family_A sample_family_B

    sort ID year

    /* 02. Education */
    g education = "Less than HS" if head_education == 0 | head_education == 1 | head_education == 2 | head_education == 3 & year <= 1990
    replace education = "High School Graduate" if head_education == 4 & year <= 1990
    replace education = "Some College" if head_education == 5 | head_education == 6 & year <= 1990
    replace education = "College +" if head_education == 7 | head_education == 8 & year <= 1990
    replace education = "Unknown" if head_education == 9 & year <= 1990
    
    replace education = "Less than HS" if head_yrs_school >= 0 & head_yrs_school <= 11 & year > 1990 & year <= 2023 & head_yrs_school != . 
    replace education = "High School Graduate" if head_yrs_school == 12 & year > 1990 & year <= 2023 & head_yrs_school != . 
    replace education = "Some College" if head_yrs_school >= 13 & head_yrs_school <= 15 & year > 1990 & year <= 2023 & head_yrs_school != . 
    replace education = "College +" if head_yrs_school ==16 | head_yrs_school == 17 & year > 1990 & year <= 2023 & head_yrs_school != . 
    replace education = "Unknown" if head_yrs_school == 99 & year > 1990 & year <= 2023 & head_yrs_school != . 
    label var education "Education of Reference Person - Time Varying"


    /* 03. Birth year & Re do samples ? */
    g birth_year = year - age_
    label var birth_year "Birth Year of Individual"
    drop if age_first_observed > 18

    /* 04. Waves 18 Adjusted */
    g waves_18_adjusted = 1
    replace waves_18_adjusted = 2 if year >= 1997
    replace waves_18_adjusted = 1 if year == 2023
    egen waves_18_adjusted_sum = total(waves_18_adjusted), by(ID)
    drop waves_18_adjusted
    rename waves_18_adjusted_sum waves_18_adjusted
    label var waves_18_adjusted "Number of Waves Observed under Age 18 - ADJUSTED for biannual surveys"


    /* 05. Sample_indiv_B */ 
    drop sample_indiv_B
    g sample_indiv_B = 1 if waves_18_adjusted >= 18
    replace sample_indiv_B = 0 if waves_18_adjusted < 18
    label var sample_indiv_B "Binary: In Sample B (observed in all waves from birth to age 18)"

    /* 06. Save */
    save "$output/_psid_analytic_sample_leaner.dta", replace


    /* 04. Collapse for tables */
    drop head_yrs_school head_education age_ head_rel_ fam_sample waves head_marital own_rent home_value fu_new_head wife_yrs_school mortgage rent pub_housing
    replace og_1968_family = 0 if og_1968_family == .
    replace imm_latino_family = 0 if imm_latino_family == .

    decode sex, g(sex1)
    drop sex
    rename sex1 sex

    tostring(state), replace
    tostring(head_race), replace
    tostring(head_sex), replace

    /* 05. Collapse (but save first) */
    save "$output/_psid_analytic_sample_leanest_long.dta", replace

    local maxvars par_came par_left gpar_came gpar_left hhr_change hhr_in hhr_out adult_came adult_left child_came child_left sib_came sib_left person_number og_1968_family imm_latino_family 
    local minvars age_first_observed birth_year
    local firstnm state head_race head_sex
    local lastnm sex education
    local mean waves_18_under sample_indiv_N sample_indiv_A sample_indiv_B 

    collapse (max) `maxvars' (min) `minvars' (first) `firstnm' (last) `lastnm' (mean) `mean', by(ID)

    /* 06. Make Tables - May 19, 2026 Meeting for 20th */

        /* Table 1: Descriptives */ 
        g Race = "White" if head_race == "1"
        replace Race = "Black" if head_race == "2"
        replace Race = "Hispanic" if head_race == "5"
        replace Race = "Other" if head_race == "3" | head_race == "4" | head_race == "6" | head_race == "7"
        replace Race = "Unknown" if head_race == "9" | head_race == "0"
        label var Race "Race of Head"

        rename education Education
        label var Education "Education of Head"

        /* Birth Cohort */
        g birth_cohort = "pre 1960" if birth_year < 1960
        replace birth_cohort = "1960-1965" if birth_year >= 1960 & birth_year < 1965
        replace birth_cohort = "1965-1970" if birth_year >= 1965 & birth_year < 1970
        replace birth_cohort = "1970-1975" if birth_year >= 1970 & birth_year < 1975
        replace birth_cohort = "1975-1980" if birth_year >= 1975 & birth_year < 1980
        replace birth_cohort = "1980-1985" if birth_year >= 1980 & birth_year < 1985
        replace birth_cohort = "1985-1990" if birth_year >= 1985 & birth_year < 1990
        replace birth_cohort = "1990-1995" if birth_year >= 1990 & birth_year < 1995
        replace birth_cohort = "1995-2000" if birth_year >= 1995 & birth_year < 2000
        replace birth_cohort = "2000-2005" if birth_year >= 2000 & birth_year < 2005
        replace birth_cohort = "after 2005" if birth_year >= 2005
        label var birth_cohort "Birth Cohort of Individual"

}



/* 07. Make Tables - May 28th meeting for 29th */

    drop hhr ages_hhr rel_hhr siblings parents grandparents hhr_prev ages_prev rel_prev ids_left ids_came ages_left ages_came rel_left rel_came sib_ages_came sib_ages_left
    drop in_ analytic_sample_indiv analytic_sample_family fims_has_sample_parent fims_has_sample_gpar sib_list par_list gpar_list rel_to_head _merge
    drop sample_family_N sample_family_A sample_family_B
    sort ID year

    /* 02. Education */
    g education = "Less than HS" if head_education == 0 | head_education == 1 | head_education == 2 | head_education == 3 & year <= 1990
    replace education = "High School Graduate" if head_education == 4 & year <= 1990
    replace education = "Some College" if head_education == 5 | head_education == 6 & year <= 1990
    replace education = "College +" if head_education == 7 | head_education == 8 & year <= 1990
    replace education = "Unknown" if head_education == 9 & year <= 1990
    
    replace education = "Less than HS" if head_yrs_school >= 0 & head_yrs_school <= 11 & year > 1990 & year <= 2023 & head_yrs_school != . 
    replace education = "High School Graduate" if head_yrs_school == 12 & year > 1990 & year <= 2023 & head_yrs_school != . 
    replace education = "Some College" if head_yrs_school >= 13 & head_yrs_school <= 15 & year > 1990 & year <= 2023 & head_yrs_school != . 
    replace education = "College +" if head_yrs_school ==16 | head_yrs_school == 17 & year > 1990 & year <= 2023 & head_yrs_school != . 
    replace education = "Unknown" if head_yrs_school == 99 & year > 1990 & year <= 2023 & head_yrs_school != . 
    label var education "Education of Reference Person - Time Varying"

    /* 03. Education lean */ 
    g education_lean = "Less than College" if education == "Less than HS" | education == "High School Graduate" | education == "Some College"
    replace education_lean = "College +" if education == "College +"
    replace education_lean = "Unknown" if education == "Unknown"

    /* 03. Birth year & Re do samples ? */
    g birth_year = year - age_
    label var birth_year "Birth Year of Individual"
    drop if age_first_observed > 18

    /* 04. Waves 18 Adjusted */
    g waves_18_adjusted = 1
    replace waves_18_adjusted = 2 if year >= 1997
    replace waves_18_adjusted = 1 if year == 2023
    egen waves_18_adjusted_sum = total(waves_18_adjusted), by(ID)
    drop waves_18_adjusted
    rename waves_18_adjusted_sum waves_18_adjusted
    label var waves_18_adjusted "Number of Waves Observed under Age 18 - ADJUSTED for biannual surveys"


    /* 05. Sample_indiv_B */ 
    drop sample_indiv_B
    g sample_indiv_B = 1 if waves_18_adjusted >= 18
    replace sample_indiv_B = 0 if waves_18_adjusted < 18
    label var sample_indiv_B "Binary: In Sample B (observed in all waves from birth to age 18)"

    /* 06. Save */
    save "$output/_psid_analytic_sample_leaner.dta", replace


    /* 04. Collapse for tables */
    drop head_yrs_school head_education age_ head_rel_ fam_sample waves head_marital own_rent home_value fu_new_head wife_yrs_school mortgage rent pub_housing
    replace og_1968_family = 0 if og_1968_family == .
    replace imm_latino_family = 0 if imm_latino_family == .

    decode sex, g(sex1)
    drop sex
    rename sex1 sex

    tostring(state), replace
    tostring(head_race), replace
    tostring(head_sex), replace

    /* 05. Collapse (but save first) */
    local maxvars par_came par_left gpar_came gpar_left hhr_change hhr_in hhr_out adult_came adult_left child_came child_left sib_came sib_left person_number og_1968_family imm_latino_family 
    local minvars age_first_observed birth_year
    local firstnm state head_race head_sex
    local lastnm sex education education_lean
    local mean waves_18_under sample_indiv_N sample_indiv_A sample_indiv_B 

    collapse (max) `maxvars' (min) `minvars' (first) `firstnm' (last) `lastnm' (mean) `mean', by(ID)

        /* Table 1: Descriptives */ 
        g Race = "White" if head_race == "1"
        replace Race = "Black" if head_race == "2"
        replace Race = "Hispanic" if head_race == "5"
        replace Race = "Other" if head_race == "3" | head_race == "4" | head_race == "6" | head_race == "7"
        replace Race = "Unknown" if head_race == "9" | head_race == "0"
        label var Race "Race of Head"

        rename education Education
        label var Education "Education of Head"

        /* Birth Cohort */
        
        
        g birth_cohort = "pre 1955" if birth_year < 1955
        replace birth_cohort = "1955-1965" if birth_year >= 1955 & birth_year < 1965
        replace birth_cohort = "1965-1975" if birth_year >= 1965 & birth_year < 1975
        replace birth_cohort = "1975-1985" if birth_year >= 1975 & birth_year < 1985
        replace birth_cohort = "1985-1995" if birth_year >= 1985 & birth_year < 1995
        replace birth_cohort = "1995-2005" if birth_year >= 1995 & birth_year < 2005
        replace birth_cohort = "2005-2015" if birth_year >= 2005 & birth_year < 2015
        replace birth_cohort = "after 2015" if birth_year >= 2015
        label var birth_cohort "Birth Cohort of Individual"


















/* 

 g r_is_head = 1 if rel_to_head == 1
    replace r_is_head = 0 if r_is_head == .
    g r_is_rp = 1 if rel_to_head == 2
    replace r_is_rp = 0 if r_is_rp == .

    g kid_sample = 1 if waves_18_under >= 2
    replace hhr = "" if kid_sample == .

    drop if age_ == 999
    drop if kid_sample == 1 & age_ > 18
    * only observations during a child's childhood (age 0-18)

    * keep only family-years where the child (kid_sample == 1) is observed

    bysort fam family_year_id: egen any_kid = max(kid_sample == 1)
    order fam ID family_year_id kid_sample yr age_ any_kid
    sort fam ID yr
    keep if any_kid == 1
    * 530,417 person-years
    * 68,207 people
    *  39,285 in sample

    sort fam family_year_id ID




    /* Clean */
        egen race = min(head_race), by(fam yr family_year_id)
        replace head_race = race
        label var head_race "Race/Ethnicity of Ref Person"


        egen head_ed = min(head_education), by(fam yr family_year_id)
        g head_ed0 = head_ed 
        replace head_ed0 = 0 if head_ed0 == .
        egen head_ed1 = max(head_ed0), by(fam yr family_year_id)
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

        /*
        egen no_adults = min(V6191), by(fam yr)
        label var no_adults "Number of Adults in Family Unit"
        */

        egen fam_weight = min(family_weight), by(fam yr family_year_id)
        label var fam_weight "Family Weight"
        drop family_weight

        egen family_size = min(V5755), by(fam yr family_year_id)
        label var family_size "Family Size"

        egen no_in = min(V5711), by(fam yr family_year_id)
        label var no_in "Number of Adults entered in FU from V5753"

        egen no_out = min(V5713), by(fam yr family_year_id)
        label var no_out "Number of Adults left FU from V5713" 

        egen who_in = min(V5712), by(fam yr family_year_id)
        label var who_in "Who came into FU from V5712 HEAD"

        egen who_out = min(V5714), by(fam yr family_year_id)
        label var who_out "Who left FU from V5714, HEAD"

        /*
        egen rent = min(V5723), by(fam yr)
        label var rent "Rent"

        egen homevalue = min(V5717), by(fam yr)
        label var homevalue "Home Value"

        egen own_rent = min(V5864), by(fam yr)
        label var own_rent "Own or Rent"

        egen region = min(V6180), by(fam yr)
        label var region "Region of Residence"

        egen state = min(V5703), by(fam yr)
        label var state "State of Residence"
        */

        egen head_mar = min(head_marital), by(fam yr)
        label var head_mar "Marital Status of Head"
        drop head_marital

        egen head_age1 = min(head_age), by(fam yr)
        replace head_age = head_age1
        drop head_age1
        label var head_age "Age of Head"   

        egen sex_head = min(head_sex), by(fam yr)
        replace head_sex = sex_head
        drop sex_head
        label var head_sex "Sex of Head"

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





    /* 22. in fam
        g in_fam = ""
        groupby(fam yr family_year_id): replace in_fam = "A" if _n == 1
    */


    /* drop */
        drop ER* 
        sort fam ID yr
        drop if hhr == ""
        * 325,050 person-year observations
        * 39,285 people 
    save "$root/_psid_out_v2.dta", replace



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








/* 22. Export */
    save "$root/_psid_out_v1.dta", replace

/*
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
    label var person_number "Number in family unit"
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
            replace school_completed = ER34952 

/* ******************** */
* PART II: Individual File
* inputs individual level data for all 
* individuals ever in the PSID between 
* 1968-2023
/* ******************** */ 


if `part2' == 1{
    local only_counts 1

    /* 01. Individual file */
        * N = n = 85,536
        clear
        use "$d_2023"
        drop ER30000 
        rename ER30002 person_number
        g ID = (1000*fam) + person_number
        order fam ID
        count if fam != fam[_n+1]
        * n_families = 8,102
        
    /* 02. Drop variables not needed for counts */
        if `only_counts' ==1{
            preserve
            drop ER30367 ER30393 ER30403 ER30422 ER30433 ER30456 ER30467 ER30491 ER30502 ER30528 ER30539 ER30563 ER30574 ER30599 ER30610 ER30635 ER30646 ER30677 ER30693 ER30720 ER30737 ER30795 ER30810 ER30856 ER32023 ER32025 ER32027 ER32029 ER32031 ER32035 ER32038 ER32040 ER32042 ER32045 ER32047 ER33105 ER33122 ER33205 ER33212 ER33224 ER33263 ER33270 ER33278 ER33305 ER33312 ER33319 ER33405 ER33412 ER33431 ER33505 ER33513 ER33539 ER33605 ER33613 ER33630 ER33705 ER33713 ER33733 ER33805 ER33814 ER33839 ER33905 ER33914 ER33939 ER34005 ER34017 ER34033 ER34105 ER34117 ER34145 ER34205 ER34217 ER34222 ER34225 ER34233 ER34234 ER34252 ER34306 ER34321 ER34324 ER34326 ER34329 ER34332 ER34339 ER34343 ER34353 ER34356 ER34358 ER34361 ER34364 ER34371 ER34375 ER34383 ER34384 ER34402 ER34505 ER34520 ER34523 ER34525 ER34528 ER34531 ER34538 ER34542 ER34552 ER34555 ER34557 ER34560 ER34563 ER34570 ER34574 ER34592 ER34593 ER34641 ER34705 ER34720 ER34723 ER34725 ER34728 ER34731 ER34740 ER34746 ER34756 ER34759 ER34761 ER34764 ER34767 ER34776 ER34782 ER34800 ER34801 ER34850 ER34905 ER34920 ER34923 ER34925 ER34928 ER34931 ER34940 ER34946 ER34956 ER34959 ER34961 ER34964 ER34967 ER34976 ER34982 ER35002 ER35003 ER35051 ER35105 ER35120 ER35123 ER35125 ER35128 ER35131 ER35140 ER35146 ER35156 ER35159 ER35161 ER35164 ER35167 ER35176 ER35182 ER35202 ER35203 ER35251 ER30562 ER30597 ER30633 ER30670 ER30718 ER30763 ER30783 ER30841 ER33142 ER33296 ER33340 ER33537O ER33628O ER33728O ER30425 ER30459 ER30494 ER30531 ER30566 ER30602 ER30638 ER30680 ER30723 ER30798 ER30005 ER30024 ER30047 ER30071 ER30095 ER30121 ER30142 ER30164 ER30192 ER30221 ER30250 ER30287 ER30317 ER30347 ER30377 ER30405 ER30435 ER30469 ER30504 ER30541 ER30726 ER30779 ER30837 ER32034 ER32036 ER32037 ER32039 ER32041 ER32043 ER32044 ER32046 ER32048 ER33138 ER33221 ER33226 ER33273 ER33274 ER33294 ER33336 ER34304 ER30011 ER30012 ER30032 ER30033 ER30056 ER30057 ER30080 ER30081 ER30105 ER30106 ER30129 ER30130 ER30150 ER30151 ER30152 ER30173 ER30175 ER30276 ER30297 ER30298 ER30357 ER30358 ER30385 ER30386 ER30414 ER30415 ER30444 ER30445 ER30479 ER30480 ER30481 ER30490 ER30514 ER30515 ER30516 ER30525 ER30550 ER30551 ER30552 ER30561 ER30585 ER30586 ER30621 ER30622 ER30658 ER30659 ER30704 ER30705 ER30707 ER30750 ER30751 ER30752 ER30753 ER30762 ER30821 ER30822 ER30824 ER30825 ER33837Y ER33837Z ER33838A ER33838B ER33838C ER33838D ER33838E ER33838F ER33838G ER33925Y ER33925Z ER33927 ER33938A ER33938B ER33938C ER33938D ER33938E ER33938F ER33938G ER34029V ER34029W ER34029X ER34029Y ER34032A ER34032B ER34032C ER34032D ER34032E ER34136V ER34136W ER34136X ER34136Y ER34144A ER34144B ER34144C ER34144D ER34144E ER34243V ER34243W ER34243X ER34243Y ER34251A ER34251B ER34251C ER34251D ER34251E ER34393V ER34393W ER34393X ER34393Y ER34401A ER34401B ER34401C ER34401D ER34401E ER34632 ER34633 ER34634 ER34635 ER34636 ER34637 ER34638 ER34639 ER34640 ER34841 ER34842 ER34843 ER34844 ER34845 ER34846 ER34847 ER34848 ER34849 ER35042 ER35043 ER35044 ER35045 ER35046 ER35047 ER35048 ER35049 ER35050 ER35242 ER35243 ER35244 ER35245 ER35246 ER35247 ER35248 ER35249 ER35250 ER30009 ER30028 ER30051 ER30075 ER30099 ER30125 ER30146 ER30168 ER30196 ER30225 ER30254 ER30295 ER30325 ER30355 ER30817 ER30818 ER33112 ER33113 ER33213 ER33220 ER33225 ER33229 ER33230 ER33231 ER33232 ER33233 ER33234 ER33235 ER33236 ER33237 ER33238 ER33239 ER33240 ER33241 ER33242 ER33243 ER33246 ER33264 ER33265 ER33272 ER33313 ER33413 ER33514 ER33614 ER33714 ER33731 ER33732 ER33815 ER33915 ER34018 ER34118 ER34218 ER34219 ER34228 ER34322 ER34325 ER34328 ER34330 ER34347 ER34350 ER34354 ER34357 ER34360 ER34362 ER34379 ER34521 ER34524 ER34527 ER34529 ER34546 ER34549 ER34553 ER34556 ER34559 ER34561 ER34578 ER34721 ER34724 ER34727 ER34729 ER34750 ER34753 ER34757 ER34760 ER34763 ER34765 ER34786 ER34921 ER34924 ER34927 ER34929 ER34950 ER34953 ER34957 ER34960 ER34963 ER34965 ER34986 ER35121 ER35124 ER35127 ER35129 ER35150 ER35153 ER35157 ER35160 ER35163 ER35165 ER35186 ER30052 ER30076 ER30100 ER30126 ER30147 ER30197 ER30226 ER30255 ER33222 ER33227 ER33247 ER33248 ER33249 ER33250 ER33251 ER33252 ER33253 ER33254 ER33255 ER33256 ER33257 ER33258 ER34229 ER34323 ER34348 ER34355 ER34380 ER34522 ER34547 ER34554 ER34579 ER34722 ER34751 ER34758 ER34787 ER34922 ER34951 ER34958 ER34987 ER35122 ER35151 ER35158 ER35187 ER35117 ER35112 ER35113 ER35114 ER35115 ER35116 ER35118 ER35119 ER35126 ER35130 ER35132 ER35133 ER35134 ER35135 ER35136 ER35137 ER35138 ER35139 ER35141 ER35142 ER35143 ER35144 ER35145 ER35147 ER35148 ER35149 ER35152 ER35154 ER35155 ER35162 ER35166 ER35168 ER35169 ER35170 ER35171 ER35172 ER35173 ER35174 ER35175 ER35177 ER35178 ER35179 ER35180 ER35181 ER35183 ER35184 ER35185 ER35188 ER35189 ER35190 ER35191 ER35192 ER35193 ER35194 ER35195 ER35196 ER35197 ER35198 ER35199 ER35200 ER35201 ER35204 ER35205 ER35206 ER35207 ER35208 ER35209 ER35210 ER35211 ER35212 ER35213 ER35214 ER35215 ER35216 ER35217 ER35218 ER35219 ER35220 ER35221 ER35222 ER35223 ER35224 ER35225 ER35226 ER35227 ER35228 ER35229 ER35230 ER35231 ER35232 ER35233 ER35234 ER35235 ER35236 ER35237 ER35238 ER35239 ER35240 ER35241 ER33837E ER33837F ER33837G ER33837H ER33837I ER33837J ER33837K ER33837L ER33837M ER33837N ER33837O ER33837P ER33837Q ER33837R ER33837S ER33837T ER33837U ER33837V ER33837W ER33837X ER33925E ER33925F ER33925G ER33925H ER33925I ER33925J ER33925K ER33925L ER33925M ER33925N ER33925O ER33925P ER33925Q ER33925R ER33925S ER33925T ER33925U ER33925V ER33925W ER33925X ER34029B ER34029C ER34029D ER34029E ER34029F ER34029G ER34029H ER34029I ER34029J ER34029K ER34029L ER34029M ER34029N ER34029O ER34029P ER34029Q ER34029R ER34029S ER34029T ER34029U ER34136B ER34136C ER34136D ER34136E ER34136F ER34136G ER34136H ER34136I ER34136J ER34136K ER34136L ER34136M ER34136N ER34136O ER34136P ER34136Q ER34136R ER34136S ER34136T ER34136U ER34243B ER34243C ER34243D ER34243E ER34243F ER34243G ER34243H ER34243I ER34243J ER34243K ER34243L ER34243M ER34243N ER34243O ER34243P ER34243Q ER34243R ER34243S ER34243T ER34243U ER34393B ER34393C ER34393D ER34393E ER34393F ER34393G ER34393H ER34393I ER34393J ER34393K ER34393L ER34393M ER34393N ER34393O ER34393P ER34393Q ER34393R ER34393S ER34393T ER34393U ER34612 ER34613 ER34614 ER34615 ER34616 ER34617 ER34618 ER34619 ER34620 ER34621 ER34622 ER34623 ER34624 ER34625 ER34626 ER34627 ER34628 ER34629 ER34630 ER34631 ER34821 ER34822 ER34823 ER34824 ER34825 ER34826 ER34827 ER34828 ER34829 ER34830 ER34831 ER34832 ER34833 ER34834 ER34835 ER34836 ER34837 ER34838 ER34839 ER34840 ER35022 ER35023 ER35024 ER35025 ER35026 ER35027 ER35028 ER35029 ER35030 ER35031 ER35032 ER35033 ER35034 ER35035 ER35036 ER35037 ER35038 ER35039 ER35040 ER35041 ER30030 ER30054 ER30078 ER30103 ER33260 ER34137 ER34140 ER34244 ER34247 ER34394 ER34397 ER34603 ER34606 ER34812 ER34815 ER35013 ER35016 ER30016 ER30199 ER30228 ER30263 ER30264 ER30014 ER30035 ER30059 ER30083 ER30108 ER30029 ER30034 ER30053 ER30077 ER30102 ER30148 ER30153 ER30177 ER30178 ER30179 ER30180 ER30198 ER30204 ER30205 ER30206 ER30207 ER30227 ER30233 ER30234 ER30235 ER30236 ER30256 ER30271 ER30272 ER30273 ER30291 ER30300 ER30301 ER30302 ER30303 ER30360 ER30361 ER30362 ER30388 ER30389 ER30417 ER30418 ER30447 ER30448 ER30482 ER30483 ER30517 ER30518 ER30553 ER30554 ER30588 ER30589 ER30624 ER30625 ER30661 ER30662 ER30709 ER30710 ER30754 ER30755 ER30823 ER33536Q ER33627Q ER33827U ER33827V ER33927C ER33927D ER33245 ER30010 ER30013 ER30058 ER30082 ER30107 ER30131 ER30270 ER30330 ER30331 ER30332 ER30333 ER33727Q ER30110 ER30181 ER30384 ER30413 ER30478 ER30513 ER30549 ER30748 ER30326 ER30296 ER34377 ER34576 ER34784 ER34984 ER34318 ER34517 ER34717 ER34917 ER33616 ER33716 ER33817 ER33917 ER34020 ER34119 ER34230 ER34349 ER34548 ER34752 ER34952 ER33215 ER33315 ER33415 ER33516 ER34345 ER34544 ER34748 ER34948 ER30820 ER30169 ER33223 ER34223 ER34226 ER34340 ER34344 ER34372 ER34376 ER34539 ER34543 ER34571 ER34575 ER34741 ER34747 ER34777 ER34783 ER34941 ER34947 ER34977 ER34983 ER30174 ER30176 ER30203 ER30210 ER30232 ER30239 ER30269 ER30299 ER30306 ER30329 ER30336 ER30359 ER30363 ER30366 ER30387 ER30392 ER30416 ER30421 ER30446 ER30452 ER30454 ER30487 ER30489 ER30522 ER30524 ER30558 ER30560 ER30587 ER30593 ER30595 ER30623 ER30629 ER30631 ER30660 ER30666 ER30668 ER30706 ER30708 ER30714 ER30716 ER30759 ER30761 ER33532Z ER33623Z ER33826C ER33827T ER33837C ER33925C ER33926C ER33927B ER34032 ER34144 ER34251 ER34401 ER34610 ER34819 ER35000 ER35020 ER30171 ER33827 ER33827A ER33827B ER33827C ER33827D ER33827E ER33827F ER33827G ER33827H ER33827I ER33827J ER33827K ER33827L ER33827M ER33827N ER33827O ER33827P ER33827Q ER33827R ER30172 ER30208 ER30209 ER30237 ER30238 ER30304 ER30305 ER30334 ER30335 ER30364 ER30365 ER30390 ER30391 ER30419 ER30420 ER30449 ER30453 ER30455 ER30484 ER30519 ER30555 ER30590 ER30626 ER30663 ER30711 ER30756 ER30127 ER30321 ER30351 ER30409 ER30439 ER30473 ER30508 ER30787 ER30789 ER30845 ER30847 ER33146 ER33148 ER33298 ER33299 ER33344 ER33346 ER30201 ER30202 ER30230 ER30231 ER30267 ER30268 ER30327 ER30328 ER30101 ER30257 ER33536C ER33627C ER33727C ER33827S ER33832 ER33927A ER33932 ER30259 ER30598 ER30634 ER30671 ER30719 ER30727 ER30764 ER30780 ER30782 ER30784 ER30786 ER30788 ER30790 ER30827 ER30838 ER30840 ER30842 ER30844 ER30846 ER30848 ER33117 ER33128 ER33139 ER33141 ER33143 ER33145 ER33147 ER33149 ER33217 ER33284 ER33294A ER33295A ER33296A ER33297A ER33298A ER33299A ER33317 ER33326 ER33337 ER33339 ER33341 ER33343 ER33345 ER33347 ER33417 ER33517 ER33518 ER33519 ER33520 ER33521 ER33617 ER33618 ER33619 ER33620 ER33621 ER33717 ER33718 ER33719 ER33720 ER33721 ER33818 ER33819 ER33820 ER33821 ER33822 ER33918 ER33919 ER33920 ER33921 ER33922 ER34021 ER34022 ER34023 ER34024 ER34025 ER34120 ER34121 ER34122 ER34123 ER34124 ER34129 ER34130 ER34131 ER34231 ER34236 ER34237 ER34238 ER34381 ER34386 ER34387 ER34388 ER34580 ER34595 ER34596 ER34597 ER34788 ER34803 ER34804 ER34805 ER34988 ER35005 ER35006 ER35007 ER30475 ER30476 ER30510 ER30511 ER30546 ER30547 ER30581 ER30582 ER30617 ER30618 ER30654 ER30655 ER30700 ER30701 ER30745 ER30746 ER30451 ER30486 ER30521 ER30557 ER30592 ER30628 ER30665 ER30713 ER30758 ER33532J ER33532K ER33532Y ER33623J ER33623K ER33623Y ER33627A ER33826A ER33837B ER33925B ER33926A ER33938 ER34031 ER34143 ER34250 ER34400 ER34609 ER34818 ER35019 ER30293 ER30323 ER30353 ER30382 ER30411 ER30441 ER30474 ER30509 ER30545 ER30580 ER30616 ER30652 ER30653 ER30699 ER30743 ER30744 ER30816 ER33111 ER33211 ER33311 ER33411 ER33512 ER33537A ER33537B ER33537C ER33537D ER33537E ER33537F ER33537G ER33537H ER33537I ER33537J ER33537K ER33537L ER33537M ER33612 ER33628A ER33628B ER33628C ER33628D ER33628E ER33628F ER33628G ER33628H ER33628I ER33628J ER33628K ER33628L ER33628M ER33712 ER33728A ER33728B ER33728C ER33728D ER33728E ER33728F ER33728G ER33728H ER33728I ER33728J ER33728K ER33728L ER33728M ER33813 ER33913 ER33927E ER33927F ER33927G ER33927H ER33927I ER33927J ER33927K ER33927L ER33927M ER33927N ER33927O ER33927P ER34016 ER34116 ER34216 ER34317 ER34516 ER34716 ER34916 ER30294 ER30324 ER30354 ER30383 ER30412 ER30442 ER30477 ER30512 ER30548 ER30583 ER30619 ER30656 ER30702 ER30747 ER30819 ER33114 ER33214 ER33314 ER33414 ER33515 ER33615 ER33715 ER33816 ER33916 ER34019 ER30274 ER30275 ER30488 ER30523 ER30559 ER30760 ER33844 ER33845 ER30265 ER30260 ER30261 ER30793 ER30851 ER30526 ER30683 ER30725 ER30800 ER30826 ER30861 ER33116 ER33118 ER33216 ER33218 ER33316 ER33416 ER33826 ER33926 ER34029 ER34136 ER34243 ER34393 ER34602 ER34811 ER35012
        }

    /* 03. Entered in immigrant or Latino samples */
        g entered_imm_latino = 1 if (fam >= 3001 & fam <= 3511)
        replace entered_imm_latino = 1 if (fam >= 4001 & fam <= 4851)
        replace entered_imm_latino = 1 if (fam >= 7001 & fam <= 9308)
        replace entered_imm_latino = 0 if entered_imm_latino == .
        label var entered_imm_latino "Entered in immigrant or Latino samples"

    /* 04. Original PSID sample members  */
        g original_sample_1968 = 1 if person_number >= 1 & person_number <= 19 & entered_imm_latino == 0
        replace original_sample_1968 = 0 if original_sample_1968 == .
        label var original_sample_1968 "Original PSID sample members in FU in 1968" 
        * 20-26 is spouse (20) and children (21-26) living in institutions in any sample. 
        * I could just put them in the original sample but they aren't coresident
        * < 1%

    /* 05. Born to original PSID sample families */
        g child_1968 = 1 if person_number >= 30 & person_number <= 169 & entered_imm_latino == 0
        replace child_1968 = 0 if child_1968 == .
        label var child_1968 "Children born to original PSID sample families"

    /* 06. Born to immigrant and latino oversample families */
        g child_imm_latino = 1 if person_number >= 30 & person_number <= 169 & entered_imm_latino == 1
        replace child_imm_latino = 0 if child_imm_latino == .
        label var child_imm_latino "Children born to latino or immigrant oversample families"

    /* 07. Which waves are you in?*/
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


    /* 08. AGES IN YEARS ACTUALLY OBSERVED 
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


    /* 09. Age first observed */
        tempfile age 
        save `age'
        reshape long age_, i(ID) j(yr)
        drop if age_ == .
        by ID (yr), sort: egen age_first_observed = min(age_)
        label var age_first_observed "Age first observed in PSID"

    /* 10. Drop individuals who never have age recorded */
        * (i.e., age_first_obsered = 999)
        drop if age_first_observed == 999
        * .00109726 of observations
        drop if age_ == . 
        * doing this dropped a few people never age recorded. 
        /* QUESTION: why might someone never have an age recorded in the PSID, 
        not even as 999? */

    /* 11. Waves & waves under 18 */
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


    
    /* 15. Identify SPLITOFF FAMILIES */
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

    
    /* 16. Splitoff Ages */
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

    /* 17. FIMS 
            Merging on FIMS adds approximately 20,000 individuals born to PSID 
            sample members not in individual file... */
        * Merge on grandparents FIMS file (note--this also has the parent variables)
        
        merge 1:1 ID using "${root}/00_fims_gpars_v1.dta"
        drop _merge

        * Merge on siblings FIMS file
        merge 1:1 ID using "${root}/00_fims_sib_v1.dta"


    /* 18. Reshape */
        reshape long in_, i(ID) j(yr)

    /* 19. Splitoff Family IDs */
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

    /* 20. Clean / reshape again */
        drop ER*

        drop if age_first_observed > 16
        drop if observed_16_twice == 0

        sort fam id yr
        count if ID != ID[_n+1]
        * 43,845 unique individuals observed at or before age 16
        * 41,411 unique individuals observed at least twice at or before age 16

        order ID fam person_number age_first_observed

        







}

    /* 12. Reshape again */
        tempfile longage 
        save `longage'
        reshape wide age_, i(ID) j(yr)

        order ID fam person_number age_first_observed

    /* 13. Identify ANYONE observed in the PSID before age 18 */
        g observed_18 = 1 if age_first_observed <= 18
        replace observed_18 = 0 if observed_18 == .
        label var observed_18 "Observed in PSID before age 18"

    /* 14. Identify ANYONE observed at least twice in the PSID at or before age 18 */
        g observed_18_twice = 1 if waves_18_under >= 2
        replace observed_18_twice = 0 if observed_18_twice == .
        label var observed_18_twice "Observed at least twice in PSID at or before age 18"


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

        keep in_* hh* ages* ed* birth_year fam person_number ID kid_sample yr_first_observed yr_last_observed bio_mom_id bio_dad_id a_mom_id a_dad_id


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
    label var person_number "Number in family unit"
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
        rename FC3 person_number
        label var person_number "Person Number within Family"
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
        collapse (firstnm) mom_marital_birth (mean) fam person_number birth_year bio_mom_id bio_dad_id a_mom_id a_dad_id kid_sample bio_md_ever_together yr_first_observed yr_last_observed, by(ID)
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



