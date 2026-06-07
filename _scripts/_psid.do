****************************
* Sarah Sullivan 
* OG Created: December 27, 2025
* Version Created: March 6, 2026
* Last Updated: June 7, 2026

* _psid.do

****************************
/* 

This do file was developed for the project, Cohort Family Instability in the United States, 1968-2023. 
This project is being conducted by Sarah Sullivan and Pamela Smock, PhD at the University of Michigan, Department of Sociology. 
Funding for this project is provided by the National Institute of Child Health and Human Development (NICHD) and the University of Michigan. 

All data analyzed in this file is publicly available from the Panel Study of Income Dynamics (PSID) and can be accessed at https://psidonline.isr.umich.edu/.

Questions about the code should be directed to Sarah Sullivan.

The file is organized as follows:
Part 0: Program Setup, initialize log, set switches for running different parts of code.
Part I: Input and cleaning of individual level PSID data
Part II: Harmonization and cleaning of year level PSID data for waves 1968-2023. 
Part III: Construction of family rosters
Part IV: Merging of data sets
Part V: Cleaning and output for various deliverables 

To do June 7, 2026: 
- pull relevant tables
- write a little about cases where RP becomes wife/husband or self. (e.g., move out at 16)

Done June 7, 2026: 
- renamed sample B sample A
- dropped all funny people

Questions/overall to do: 
- why do some people have no age data ever observed? same with marital status? 
- write up logic for hhr, ages_hhr, rel_hhr
- how granular of relationships do we care about? --> using fims vs. 1985 relhist, etc. 
    - in _hhr, want something like "family adult came, family adult left, other adult came/left, etc."

*/

************************************

/* ******************** */
*
* PART 0: PROGRAM SET UP
*
/* ******************** */

    clear all
    set more off
    cap log close

    set maxvar 32767

    cd "$root"

    local datetime = string(year(today()), "%04.0f") + string(month(today()), "%02.0f") + string(day(today()), "%02.0f") + "_" + subinstr("`c(current_time)'", ":", "", .)
    log using "$log/_psid_`datetime'.log", replace
    
    * Switches
    local part1 0
    local part2 0
    local part3 0
    local part4 1
    local part5 1
    local part6 0


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
        * to do later: verify that I need all of these, see what I might also want to keep. 
        local keep fam ID person_number ER30003 ER30004 ER30006 ER30007 ER30008 ER30015 ER30017 ER30018 ER30019 ER30020 ER30021 ER30022 ER30023 ER30025 ER30026 ER30027 ER30031 ER30036 ER30037 ER30038 ER30039 ER30040 ER30041 ER30042 ER30043 ER30044 ER30045 ER30046 ER30048 ER30049 ER30050 ER30055 ER30060 ER30061 ER30062 ER30063 ER30064 ER30065 ER30066 ER30067 ER30068 ER30069 ER30070 ER30072 ER30073 ER30074 ER30079 ER30084 ER30085 ER30086 ER30087 ER30088 ER30089 ER30090 ER30091 ER30092 ER30093 ER30094 ER30096 ER30097 ER30098 ER30104 ER30109 ER30111 ER30112 ER30113 ER30114 ER30115 ER30116 ER30117 ER30118 ER30119 ER30120 ER30122 ER30123 ER30124 ER30128 ER30132 ER30133 ER30134 ER30135 ER30136 ER30137 ER30138 ER30139 ER30140 ER30141 ER30143 ER30144 ER30145 ER30149 ER30154 ER30155 ER30156 ER30157 ER30158 ER30159 ER30160 ER30161 ER30162 ER30163 ER30165 ER30166 ER30167 ER30170 ER30182 ER30183 ER30184 ER30185 ER30186 ER30187 ER30188 ER30189 ER30190 ER30191 ER30193 ER30194 ER30195 ER30200 ER30211 ER30212 ER30213 ER30214 ER30215 ER30216 ER30217 ER30218 ER30219 ER30220 ER30222 ER30223 ER30224 ER30229 ER30240 ER30241 ER30242 ER30243 ER30244 ER30245 ER30246 ER30247 ER30248 ER30249 ER30251 ER30252 ER30253 ER30258 ER30262 ER30266 ER30277 ER30278 ER30279 ER30280 ER30281 ER30282 ER30283 ER30284 ER30285 ER30286 ER30288 ER30289 ER30290 ER30292 ER30307 ER30308 ER30309 ER30310 ER30311 ER30312 ER30313 ER30314 ER30315 ER30316 ER30318 ER30319 ER30320 ER30322 ER30337 ER30338 ER30339 ER30340 ER30341 ER30342 ER30343 ER30344 ER30345 ER30346 ER30348 ER30349 ER30350 ER30352 ER30356 ER30368 ER30369 ER30370 ER30371 ER30372 ER30373 ER30374 ER30375 ER30376 ER30378 ER30379 ER30380 ER30381 ER30394 ER30395 ER30396 ER30397 ER30398 ER30399 ER30400 ER30401 ER30402 ER30404 ER30406 ER30407 ER30408 ER30410 ER30423 ER30424 ER30426 ER30427 ER30428 ER30429 ER30430 ER30431 ER30432 ER30434 ER30436 ER30437 ER30438 ER30440 ER30443 ER30450 ER30457 ER30458 ER30460 ER30461 ER30462 ER30463 ER30464 ER30465 ER30466 ER30468 ER30470 ER30471 ER30472 ER30485 ER30492 ER30493 ER30495 ER30496 ER30497 ER30498 ER30499 ER30500 ER30501 ER30503 ER30505 ER30506 ER30507 ER30529 ER30530 ER30532 ER30533 ER30534 ER30535 ER30536 ER30537 ER30538 ER30540 ER30542 ER30543 ER30544 ER30564 ER30565 ER30567 ER30568 ER30569 ER30570 ER30571 ER30572 ER30573 ER30575 ER30576 ER30577 ER30578 ER30579 ER30600 ER30601 ER30603 ER30604 ER30605 ER30606 ER30607 ER30608 ER30609 ER30611 ER30612 ER30613 ER30614 ER30615 ER30620 ER30636 ER30637 ER30639 ER30640 ER30641 ER30642 ER30643 ER30644 ER30645 ER30647 ER30648 ER30649 ER30650 ER30651 ER30657 ER30673 ER30678 ER30679 ER30681 ER30682 ER30684 ER30685 ER30686 ER30687 ER30688 ER30689 ER30690 ER30691 ER30692 ER30694 ER30695 ER30696 ER30697 ER30698 ER30703 ER30721 ER30722 ER30724 ER30728 ER30729 ER30730 ER30731 ER30732 ER30733 ER30734 ER30735 ER30736 ER30738 ER30739 ER30740 ER30741 ER30742 ER30796 ER30797 ER30799 ER30801 ER30802 ER30803 ER30804 ER30805 ER30806 ER30807 ER30808 ER30809 ER30811 ER30812 ER30813 ER30814 ER30815 ER30857 ER30858 ER30859 ER30860 ER30862 ER30863 ER30864 ER30865 ER30866 ER31987 ER31988 ER31989 ER31990 ER31991 ER31992 ER31993 ER31994 ER31995 ER31996 ER31997 ER32000 ER32001 ER32002 ER32003 ER32004 ER32005 ER32006 ER32007 ER32008 ER32009 ER32010 ER32011 ER32012 ER32013 ER32014 ER32015 ER32016 ER32017 ER32018 ER32019 ER32020 ER32021 ER32022 ER32024 ER32026 ER32028 ER32030 ER32032 ER32033 ER32049 ER32050 ER32051 ER32052 ER32053 ER32054 ER33101 ER33102 ER33103 ER33104 ER33106 ER33107 ER33108 ER33109 ER33110 ER33115 ER33119 ER33120 ER33121 ER33123 ER33124 ER33125 ER33126 ER33127 ER33150 ER33201 ER33202 ER33203 ER33204 ER33206 ER33207 ER33208 ER33209 ER33210 ER33219 ER33275 ER33276 ER33277 ER33279 ER33280 ER33281 ER33282 ER33283 ER33299B ER33301 ER33302 ER33303 ER33304 ER33306 ER33307 ER33308 ER33309 ER33310 ER33318 ER33320 ER33321 ER33322 ER33323 ER33324 ER33325 ER33401 ER33402 ER33403 ER33404 ER33406 ER33407 ER33408 ER33409 ER33410 ER33418 ER33419 ER33420 ER33421 ER33422 ER33423 ER33424 ER33425 ER33426 ER33427 ER33428 ER33429 ER33430 ER33432 ER33433 ER33434 ER33435 ER33436 ER33437 ER33438 ER33501 ER33502 ER33503 ER33504 ER33506 ER33507 ER33508 ER33509 ER33510 ER33511 ER33524 ER33525 ER33526 ER33527 ER33528 ER33529 ER33530 ER33531 ER33532 ER33540 ER33541 ER33542 ER33543 ER33544 ER33545 ER33546 ER33547 ER33601 ER33602 ER33603 ER33604 ER33606 ER33607 ER33608 ER33609 ER33610 ER33611 ER33631 ER33632 ER33633 ER33634 ER33635 ER33636 ER33637 ER33638 ER33639 ER33701 ER33702 ER33703 ER33704 ER33706 ER33707 ER33708 ER33709 ER33710 ER33711 ER33734 ER33735 ER33736 ER33737 ER33738 ER33739 ER33740 ER33741 ER33742 ER33801 ER33802 ER33803 ER33804 ER33806 ER33807 ER33808 ER33809 ER33810 ER33811 ER33840 ER33841 ER33842 ER33843 ER33846 ER33847 ER33848 ER33849 ER33901 ER33902 ER33903 ER33904 ER33906 ER33907 ER33908 ER33909 ER33910 ER33911 ER33940 ER33941 ER33942 ER33943 ER33948 ER33949 ER33950 ER33951 ER34001 ER34002 ER34003 ER34004 ER34006 ER34007 ER34008 ER34009 ER34010 ER34011 ER34034 ER34035 ER34036 ER34037 ER34043 ER34044 ER34045 ER34046 ER34101 ER34102 ER34103 ER34104 ER34106 ER34107 ER34108 ER34109 ER34110 ER34111 ER34146 ER34147 ER34148 ER34149 ER34152 ER34153 ER34154 ER34155 ER34201 ER34202 ER34203 ER34204 ER34206 ER34207 ER34208 ER34209 ER34210 ER34211 ER34253 ER34254 ER34255 ER34256 ER34266 ER34267 ER34268 ER34269 ER34301 ER34302 ER34303 ER34305 ER34307 ER34308 ER34309 ER34310 ER34311 ER34312 ER34403 ER34404 ER34405 ER34406 ER34407 ER34408 ER34409 ER34410 ER34411 ER34412 ER34413 ER34414 ER34501 ER34502 ER34503 ER34504 ER34506 ER34507 ER34508 ER34509 ER34510 ER34511 ER34642 ER34643 ER34644 ER34645 ER34646 ER34647 ER34648 ER34649 ER34650 ER34651 ER34701 ER34702 ER34703 ER34704 ER34706 ER34707 ER34708 ER34709 ER34710 ER34711 ER34851 ER34852 ER34853 ER34854 ER34855 ER34856 ER34857 ER34858 ER34859 ER34860 ER34861 ER34862 ER34863 ER34864 ER34901 ER34902 ER34903 ER34904 ER34906 ER34907 ER34908 ER34909 ER34910 ER34911 ER35052 ER35053 ER35054 ER35055 ER35062 ER35063 ER35064 ER35065 ER35101 ER35102 ER35103 ER35104 ER35106 ER35107 ER35108 ER35109 ER35110 ER35111 ER35252 ER35253 ER35254 ER35255 ER35262 ER35263 ER35264 ER35265 ER30010 ER30052 ER30076 ER30100 ER30126 ER30147 ER30169 ER30197 ER30226 ER30255 ER30296 ER30326 ER30356 ER30384 ER30413 ER30443 ER30478 ER30513 ER30549 ER30584 ER30620 ER30657 ER30703 ER30748 ER30820 ER33115 ER33215 ER33315 ER33415 ER33516 ER33616 ER33716 ER33817 ER33917 ER34020 ER34119 ER34230 ER34349 ER34548 ER34752 ER34952 ER35152 ER30403 ER30433 ER30467 ER30502 ER30539 ER30574 ER30610 ER30646 ER30693 ER30737 ER30810 ER33105 ER33205 ER33305 ER33405 ER33505 ER33605 ER33705 ER33805 ER33905 ER34005 ER34105 ER34205 ER34306 ER34505 ER34705 ER34905 ER35105
        local age_reported ER30004 ER30023 ER30046 ER30070 ER30094 ER30120 ER30141 ER30163 ER30191 ER30220 ER30249 ER30286 ER30316 ER30346 ER30376 ER30402 ER30432 ER30466 ER30501 ER30538 ER30573 ER30609 ER30645 ER30692 ER30736 ER30809 ER33104 ER33204 ER33304 ER33404 ER33504 ER33604 ER33704 ER33804 ER33904 ER34004 ER34104 ER34204 ER34305 ER34504 ER34704 ER34904 ER35104
        local age_bday ER30425 ER30459 ER30494 ER30531 ER30566 ER30602 ER30638 ER30680 ER30723 ER30798
        local month_born ER30403 ER30433 ER30467 ER30502 ER30539 ER30574 ER30610 ER30646 ER30693 ER30737 ER30810 ER33105 ER33205 ER33305 ER33405 ER33505 ER33605 ER33705 ER33805 ER33905 ER34005 ER34105 ER34205 ER34306 ER34505 ER34705 ER34905 ER35105
        local year_born ER30404 ER30434 ER30468 ER30503 ER30540 ER30575 ER30611 ER30647 ER30694 ER30738 ER30811 ER33106 ER33206 ER33306 ER33406 ER33506 ER33606 ER33706 ER33806 ER33906 ER34006 ER34106 ER34206 ER34307 ER34506 ER34706 ER34906 ER35106
    
        keep `keep' `age_reported' `age_bday' `month_born' `year_born'

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
        * The variables in_1968, ..., in_2023 are indicators for whether the person was observed in that wave of the PSID, using values of the variable "WHY NONRESPONSE"

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
    
    /* 05. AGE --> 
        I use respondent-reported age variables to determine each individual's age at each wave. The respondent in each wave of the PSID is typically 
        the "Head/Reference Person" (hereafter RP) of the family unit but may also be that individual's spouse or partner or someone else responding in their stead. 
        The RP is most often a parent of the children in the household but may be another adult in the household. The RP reports ages for every household member in each 
        wave.
        
        Because families are interviewed at different points throughout the year, some people are observed at the same age for more than one wave. For example, someone aged 
        9 in 1968 may be observed again at age 9 in 1969 if their birthday falls after the interview date for that year. I do not use a granular age variable because date of birth 
        is not available for all individuals observed in the PSID. 

        What does this mean for our analysis? 

        For this project, we create three samples using age-based criteria.
            1. Sample N: anyone observed in the PSID before age 18.
            2. Sample A: anyone observed in the PSID for the duration of childhood (0-17).
            3. Sample B: anyone observed in the PSID at least twice before age 18.

        Therefore, for those observed at age 17, some are reporting their experience during 0-17 years of life, while others are reporting experience from 0-17.9999... years of life. 
        **** No person is ever reported as age "0". The nascent codes 0 and 999 are both for missing age. Children aged 0-1 at the time of interview are reported as age 1.

        It is possible to have a recorded age in the PSID individual level data but not be observed in the family unit in that year (e.g., 423 ppl in 1968)
        For that reason, I replace each year's age variable with missing if the person is not observed in that year.
        
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
        * Age first observed is calculated as, age in 1968 if observed in 1968, age in 1969 if not observed in 1968 and observed in 1969, ... 
        * If not observed in any wave, age first observed is coded as 999.

        g age_first_observed = age_1968 if age_1968 != .

        forvalues i=1969/1997{
            replace age_first_observed = age_`i' if age_first_observed == . & age_`i' != .
        }

        forvalues i=1999(2)2023{
            replace age_first_observed = age_`i' if age_first_observed == . & age_`i' != .
        }

        replace age_first_observed = 999 if age_first_observed == .

        label var age_first_observed "Age first observed in PSID"


     /* 07. Count number of waves observed in the PSID & number of waves observed in the PSID before age 18.*/

        g waves = in_1968 + in_1969 + in_1970 + in_1971 + in_1972 + in_1973 + in_1974 + in_1975 + in_1976 + in_1977 + in_1978 + in_1979 + in_1980 + in_1981 + in_1982 + in_1983 + in_1984 + in_1985 + in_1986 + in_1987 + in_1988 + in_1989 + in_1990 + in_1991 + in_1992 + in_1993 + in_1994 + in_1995 + in_1996 + in_1997 + in_1999  + in_2001  + in_2003  + in_2005  + in_2007  + in_2009  + in_2011  + in_2013  + in_2015  + in_2017  + in_2019  + in_2021  + in_2023
        label var waves "Number of waves observed in PSID"

        g waves_17_under = (!missing(age_1968) & age_1968 < 18) + (!missing(age_1969) & age_1969 < 18) + (!missing(age_1970) & age_1970 < 18) + (!missing(age_1971) & age_1971 < 18) + (!missing(age_1972) & age_1972 < 18) + (!missing(age_1973) & age_1973 < 18) + (!missing(age_1974) & age_1974 < 18) + (!missing(age_1975) & age_1975 < 18) + (!missing(age_1976) & age_1976 < 18) + (!missing(age_1977) & age_1977 < 18) + (!missing(age_1978) & age_1978 < 18) + (!missing(age_1979) & age_1979 < 18) + (!missing(age_1980) & age_1980 < 18) + (!missing(age_1981) & age_1981 < 18) + (!missing(age_1982) & age_1982 < 18) + (!missing(age_1983) & age_1983 < 18) + (!missing(age_1984) & age_1984 < 18) + (!missing(age_1985) & age_1985 < 18) + (!missing(age_1986) & age_1986 < 18) + (!missing(age_1987) & age_1987 < 18) + (!missing(age_1988) & age_1988 < 18) + (!missing(age_1989) & age_1989 < 18) + (!missing(age_1990) & age_1990 < 18) + (!missing(age_1991) & age_1991 < 18) + (!missing(age_1992) & age_1992 < 18) + (!missing(age_1993) & age_1993 < 18) + (!missing(age_1994) & age_1994 < 18) + (!missing(age_1995) & age_1995 < 18) + (!missing(age_1996) & age_1996 < 18) + (!missing(age_1997) & age_1997 < 18) + (!missing(age_1999) & age_1999 < 18) + (!missing(age_2001) & age_2001 < 18) + (!missing(age_2003) & age_2003 < 18) + (!missing(age_2005) & age_2005 < 18) + (!missing(age_2007) & age_2007 < 18) + (!missing(age_2009) & age_2009 < 18) + (!missing(age_2011) & age_2011 < 18) + (!missing(age_2013) & age_2013 < 18) + (!missing(age_2015) & age_2015 < 18) + (!missing(age_2017) & age_2017 < 18) + (!missing(age_2019) & age_2019 < 18) + (!missing(age_2021) & age_2021 < 18) + (!missing(age_2023) & age_2023 < 18)
        label var waves_17_under "Waves in PSID UNDER age 18 (17 and less)"
       
        tempfile waves
        save `waves', replace
    
    /* 07. FIMS: merge on family identification mapping system files that allow us to identify parents, gpars, and sibs */
        * Family Identification Mapping System (FIMS) files are created by the PSID team and allow us to identify family relationships between individuals in the PSID.
        * These files are preprocessed and cleaned by me in separate do files. The cleaned FIMS files are saved in the output folder with the following names: 
            * _fims_pars_clean.dta
            * _fims_gpars_clean.dta
            * _fims_sib_clean.dta

        * Merge on grandparents FIMS file (note--this also has the parent variables)
        merge 1:1 ID using "${output}/_fims_gpars_clean.dta"
        * N = 103,701
        drop if _merge == 2
        * N= 85,536
        drop _merge

        * Merge on siblings FIMS file
        merge 1:1 ID using "${output}/_fims_sib_clean.dta"
        drop _merge
        * N = 85,536

    /* 08. CREATE ANALYTIC SAMPLE INDICATOR --> ANYONE OBSERVED DURING CHILDHOOD FOR ANY NUMBER OF WAVES.
        * Sample N: all PSID children. Anyone observed for any number of waves BEFORE age 18.
        
        LATER:
            * Sample A: full childhood. Anyone observed continuously from birth to age 18. 
            * Sample B: two-wave+ children. Anyone observed for at least two waves BEFORE age 18.
        */

        g analytic_sample_indiv = 1 if waves_17_under >= 1
        replace analytic_sample_indiv = 0 if waves_17_under == 0
        label var analytic_sample_indiv "Binary: In Sample N, A, or B. Observed before age 18."
        * n = 45,057 (out of 85,536 total individuals)

    /* 09. Some erroneous sample people 
            There are 12 people observed at least once before age 18 (analytic_sample_indiv==1)
            but whose age at first observation is >= 18 (age_first_observed >= 18). 
            I checked these people by hand and observed the following: 
            * P1: ID= 1830184 --> age first observed = 52. waves observed = 2009, 2011, 2013, 2015; ages: 52, X, 13, X, 14, X, 17
            * P2: ID= 5535171 --> age first observed = 30. waves observed = 1989, 1990, 1991, 1992; ages: 30, 17, 18, 18
            * P3: ID= 5129170 --> age first observed = 18. waves observed = 1975-1984; ages: 18, 17, 18, 19, 21, 22, 22, 23, 24, 26
            * P4: ID= 5349174 --> age first observed = 18. waves observed = 1985-1989; ages: 18, 17, 17, 18, 20
            * P5: ID= 5876003 --> age first observed = 18. waves observed = 1968-1970, 1973-2019; ages: 18, 17, 18
            * P6: ID= 8190002 --> age first observed = 18. waves observed = 1990-1994; ages: 18, 17, 19, 20, 20
            * P7: ID= 9045004 --> age first observed = 18. waves observed = 1992-1995; ages: 18, 17, 18, 19
            * P8: ID= 1841003 --> age first observed = 19. waves observed = 1968-1972, 1974-2015; ages: 19, 14, 15, 16, 17
            * P9: ID= 5128182 --> age first observed = 19. waves observed = 1992-1996; ages: 19, 14, 15, 16, 17
            * P10: ID= 5442171 --> age first observed = 19. waves observed = 1971, 1973-1974; ages: 19, X, 16, 17
            * P11: ID= 5449170 --> age first observed = 19. waves observed = 1971-2023; ages: 19, 17, 18, 18, 19, 21, ...
            * P12: ID= 9296170 --> age first observed = 19. waves observed = 1993-1995; ages: 19, 17, 18
        
        I opt to drop these individuals from the sample due to perceived errors in age reporting or recording. 
        */

        replace analytic_sample_indiv = 0 if ID == 1830184 | ID == 5535171 | ID == 5129170 | ID == 5349174 | ID == 5876003 | ID == 8190002 | ID == 9045004 | ID == 1841003 | ID == 5128182 | ID == 5442171 | ID == 5449170 | ID == 9296170

    /* 10. Flag Analytic Sample Families & Drop unqualified families 
        * 5,565 families
        * 80,125 sample people in qualified families
        * 45,045 qualified children (children in sample N, A, or B)
        */

        * analytic_sample_family = 1 if at least one person in the original 1968 family unit is in the analytic sample (analytic_sample_indiv == 1)
        egen analytic_sample_family = max(analytic_sample_indiv), by(fam)
        label var analytic_sample_indiv "Binary: In Sample N, A, or B"
        label var analytic_sample_family "Binary: Family with at least one child in Sample N, A, or B"

        * Save a tempfile of the cleaned individual data before we cut off non-sample families
        tempfile pre_cut1
        save `pre_cut1', replace

        * Drop families that do not have at least one child in the analytic sample (analytic_sample_family == 0)
        drop if analytic_sample_family == 0


    /* 11. Waves observed, adjusted for skipped years of data collection 
        The PSID was collected annually from 1968 to 1997 and biennially from 1999 to 2023. 
        To determine who is observed continuously from birth to age 17 (inclusive), we need to adjust for skipped years.
        */
        
        g waves_preskip = in_1968 + in_1969 + in_1970 + in_1971 + in_1972 + in_1973 + in_1974 + in_1975 + in_1976 + in_1977 + in_1978 + in_1979 + in_1980 + in_1981 + in_1982 + in_1983 + in_1984 + in_1985 + in_1986 + in_1987 + in_1988 + in_1989 + in_1990 + in_1991 + in_1992 + in_1993 + in_1994 + in_1995 + in_1996 + in_1997
        g waves_postskip = in_1999  + in_2001  + in_2003  + in_2005  + in_2007  + in_2009  + in_2011  + in_2013  + in_2015  + in_2017  + in_2019  + in_2021  + in_2023
        g waves_skipadjusted = waves_preskip + (waves_postskip*2)
        label var waves_skipadjusted "Number of waves observed in PSID, adjusted for skipping years"

        g waves17_preskip = (!missing(age_1968) & age_1968 < 18) + (!missing(age_1969) & age_1969 < 18) + (!missing(age_1970) & age_1970 < 18) + (!missing(age_1971) & age_1971 < 18) + (!missing(age_1972) & age_1972 < 18) + (!missing(age_1973) & age_1973 < 18) + (!missing(age_1974) & age_1974 < 18) + (!missing(age_1975) & age_1975 < 18) + (!missing(age_1976) & age_1976 < 18) + (!missing(age_1977) & age_1977 < 18) + (!missing(age_1978) & age_1978 < 18) + (!missing(age_1979) & age_1979 < 18) + (!missing(age_1980) & age_1980 < 18) + (!missing(age_1981) & age_1981 < 18) + (!missing(age_1982) & age_1982 < 18) + (!missing(age_1983) & age_1983 < 18) + (!missing(age_1984) & age_1984 < 18) + (!missing(age_1985) & age_1985 < 18) + (!missing(age_1986) & age_1986 < 18) + (!missing(age_1987) & age_1987 < 18) + (!missing(age_1988) & age_1988 < 18) + (!missing(age_1989) & age_1989 < 18) + (!missing(age_1990) & age_1990 < 18) + (!missing(age_1991) & age_1991 < 18) + (!missing(age_1992) & age_1992 < 18) + (!missing(age_1993) & age_1993 < 18) + (!missing(age_1994) & age_1994 < 18) + (!missing(age_1995) & age_1995 < 18) + (!missing(age_1996) & age_1996 < 18) + (!missing(age_1997) & age_1997 < 18)
        g waves17_postskip = (!missing(age_1999) & age_1999 < 18) + (!missing(age_2001) & age_2001 < 18) + (!missing(age_2003) & age_2003 < 18) + (!missing(age_2005) & age_2005 < 18) + (!missing(age_2007) & age_2007 < 18) + (!missing(age_2009) & age_2009 < 18) + (!missing(age_2011) & age_2011 < 18) + (!missing(age_2013) & age_2013 < 18) + (!missing(age_2015) & age_2015 < 18) + (!missing(age_2017) & age_2017 < 18) + (!missing(age_2019) & age_2019 < 18) + (!missing(age_2021) & age_2021 < 18) + (!missing(age_2023) & age_2023 < 18)
        g waves_17_skipadjusted = waves17_preskip + (2*waves17_postskip)
        label var waves_17_skipadjusted "Waves in PSID under age 18, adjusted for skipping years"
        drop *_preskip *_postskip

    /* 12. Define each sample: N, A, B -->
        For samples N and B, we use waves_17_under. For sample A, we use waves_17_skipadjusted.

        Sample A is counting who is observed continously throughout childhood, using the rule of being observed for at least 17 waves before age 18, adjusted for skipping years. 

        Sample B counts who is observed at least twice before 17. This is a more inclusive sample than sample A but less inclusive than sample N. It is more inclusive than sample A because it allows for some skipping of waves in childhood.
        If a kid is observed only once before 17 but after 1997, their waves_17_skipadjusted will be 2, so they will fall in sample A erroneously. For that reason, we use waves_17_under.

        Sample N counts children simply observed in childhood. This is the most inclusive sample and necessarily includes all people in samples A and B. 
        Comparing samples A and B to sample N allows us to understand what is lost when we require more waves of observation in childhood.

        Sample A: 8,823 children; 55,924 family members; 2,047 families
        Sample B: 38,430 children; 77,283 family members;  4,987 families
        Sample N: 45,056 children; 80,125 family members; 5,565 families

        */

        g sample_indiv_N = 1 if waves_17_under >= 1
        replace sample_indiv_N = 0 if waves_17_under == 0
        label var sample_indiv_N "Binary: In Sample N (at least one wave before age 18)"
        egen sample_family_N = max(sample_indiv_N), by(fam)
        label var sample_family_N "Binary: Family with at least one child in Sample N"

        g sample_indiv_A= 1 if waves_17_skipadjusted >= 17
        replace sample_indiv_A = 0 if waves_17_skipadjusted < 17
        label var sample_indiv_A "Binary: In Sample A (observed in all waves from birth to age 18)"
        egen sample_family_A = max(sample_indiv_A), by(fam)
        label var sample_family_A "Binary: Family with at least one child in Sample A"

        g sample_indiv_B = 1 if waves_17_under >= 2
        replace sample_indiv_B = 0 if waves_17_under < 2
        label var sample_indiv_B "Binary: In Sample B (at least two waves before age 18)"
        egen sample_family_B = max(sample_indiv_B), by(fam)
        label var sample_family_B "Binary: Family with at least one child in Sample B"

    /* 14. Sex */
        rename ER32000 sex 
        label var sex "Sex of Individual"

    /* 15. Split offs 
        * Split off families are created when someone in the original family unit leaves to create a new family unit. For example, a child in the original family unit may grow up and leave to create their own family unit with a spouse and children.
        * The variables family_id_YEAR are year-specific family ID variables that allow us to distinguish between households in the same original family unit observed in the same year (e.g., original parents (now grandparents) household vs. son and child's household)
        
        */
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
            label var fam_id_`i' "Family ID `i'"
        }
        forvalues i=1999(2)2023{
            g fam_id_`i' = .
            label var fam_id_`i' "Family ID `i'"
        }

        replace fam_id_1968 = fam 
        replace fam_id_1969 = ER30020 
        replace fam_id_1970 = ER30043 
        replace fam_id_1971 = ER30067 
        replace fam_id_1972 = ER30091 
        replace fam_id_1973 = ER30117 
        replace fam_id_1974 = ER30138 
        replace fam_id_1975 = ER30160 
        replace fam_id_1976 = ER30188 
        replace fam_id_1977 = ER30217
        replace fam_id_1978 = ER30246 
        replace fam_id_1979 = ER30283 
        replace fam_id_1980 = ER30313 
        replace fam_id_1981 = ER30343 
        replace fam_id_1982 = ER30373 
        replace fam_id_1983 = ER30399 
        replace fam_id_1984 = ER30429 
        replace fam_id_1985 = ER30463 
        replace fam_id_1986 = ER30498 
        replace fam_id_1987 = ER30535 
        replace fam_id_1988 = ER30570 
        replace fam_id_1989 = ER30606 
        replace fam_id_1990 = ER30642 
        replace fam_id_1991 = ER30689 
        replace fam_id_1992 = ER30733 
        replace fam_id_1993 = ER30806 
        replace fam_id_1994 = ER33101 
        replace fam_id_1995 = ER33201 
        replace fam_id_1996 = ER33301 
        replace fam_id_1997 = ER33401 
        replace fam_id_1999 = ER33501 
        replace fam_id_2001 = ER33601 
        replace fam_id_2003 = ER33701 
        replace fam_id_2005 = ER33801 
        replace fam_id_2007 = ER33901 
        replace fam_id_2009 = ER34001 
        replace fam_id_2011 = ER34101 
        replace fam_id_2013 = ER34201 
        replace fam_id_2015 = ER34301 
        replace fam_id_2017 = ER34501 
        replace fam_id_2019 = ER34701 
        replace fam_id_2021 = ER34901 
        replace fam_id_2023 = ER35101


    /* 16. Head relationship 
        * Variable recording the relationship between the individual and the Head/Reference Person in each wave. 
        = 0 if the person is not observed in that year. 
        */ 
        local head_rel 1968 ER30003 1969 ER30022 1970 ER30045 1971 ER30069 1972 ER30093	1973 ER30119 1974 ER30140 1975 ER30162 1976 ER30190	1977 ER30219 1978 ER30248 1979 ER30285 1980 ER30315 1981 ER30345 1982 ER30375 1983 ER30401 1984 ER30431 1985 ER30465 1986 ER30500 1987 ER30537 1988 ER30572 1989 ER30608 1990 ER30644 1991 ER30691 1992 ER30735 1993 ER30808 1994 ER33103 1995 ER33203 1996 ER33303	1997 ER33403 1999 ER33503 2001 ER33603 2003 ER33703 2005 ER33803 2007 ER33903 2009 ER34003 2011 ER34103 2013 ER34203 2015 ER34303 2017 ER34503 2019 ER34703 2021 ER34903 2023 ER35103
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

    /* 17. Why nonresponse 
        Recode variables that capture why a person was a nonresponse in that year prior to reshape
        */
        local year_vars 1968 ER30018 1969 ER30041 1970 ER30065 1971 ER30089 1972 ER30115 1973 ER30136 1974 ER30158 1975 ER30186 1976 ER30215 1977 ER30244 1978 ER30281 1979 ER30311 1980 ER30341 1981 ER30371 1982 ER30397 1983 ER30427 1984 ER30461 1985 ER30496 1986 ER30533 1987 ER30568 1988 ER30604 1989 ER30640 1990 ER30685 1991 ER30729 1992 ER30802 1993 ER30863 1994 ER33127 1995 ER33283 1996 ER33325 1997 ER33437 1999 ER33545 2001 ER33636 2003 ER33739 2005 ER33847 2007 ER33949 2009 ER34044 2011 ER34153 2013 ER34267 2015 ER34412 2017 ER34649 2019 ER34862 2021 ER35063 2023 ER35263
        
        forvalues q = 1968/1997 {
            g why_nonresponse_`q' = .
            label var why_nonresponse_`q' "Why nonresponse in year `q'"
        }

        forvalues q = 1999(2)2023 {
            g why_nonresponse_`q' = .
            label var why_nonresponse_`q' "Why nonresponse in year `q'"
        }

        local r = 1
        while `r'  <= `: word count `year_vars'' {
            local yr: word `r'  of `year_vars'
            local var: word `= `r' + 1' of `year_vars'
            replace why_nonresponse_`yr' = `var'
            local r = `r' + 2
        }
        

    /* 18. Clean and save tempfile before reshape */
        /* TEMPFILE: POST CUT */
        tempfile post_cut1
        save `post_cut1', replace

        local ids fam ID 
        local demos sex age_first_observed
        local sample analytic_sample_indiv analytic_sample_family sample_indiv_N sample_family_N sample_indiv_A sample_family_A sample_indiv_B sample_family_B og_1968_family imm_latino_family fam_sample 
        local ins in_1968 in_1969 in_1970 in_1971 in_1972 in_1973 in_1974 in_1975 in_1976 in_1977 in_1978 in_1979 in_1980 in_1981 in_1982 in_1983 in_1984 in_1985 in_1986 in_1987 in_1988 in_1989 in_1990 in_1991 in_1992 in_1993 in_1994 in_1995 in_1996 in_1997 in_1999 in_2001 in_2003 in_2005 in_2007 in_2009 in_2011 in_2013 in_2015 in_2017 in_2019 in_2021 in_2023 
        local ages age_1968 age_1969 age_1970 age_1971 age_1972 age_1973 age_1974 age_1975 age_1976 age_1977 age_1978 age_1979 age_1980 age_1981 age_1982 age_1983 age_1984 age_1985 age_1986 age_1987 age_1988 age_1989 age_1990 age_1991 age_1992 age_1993 age_1994 age_1995 age_1996 age_1997 age_1999 age_2001 age_2003 age_2005 age_2007 age_2009 age_2011 age_2013 age_2015 age_2017 age_2019 age_2021 age_2023 
        local waves waves waves_skipadjusted waves_17_under waves_17_skipadjusted 
        local parents_gpars ID_bM ID_bD ID_aM ID_aD ID_aM_aM ID_aM_aD ID_aM_bM ID_aM_bD ID_aD_aM ID_aD_aD ID_aD_bM ID_aD_bD ID_bM_aM ID_bM_aD ID_bM_bM ID_bM_bD ID_bD_aM ID_bD_aD ID_bD_bM ID_bD_bD 
        local siblings ID_S01 ID_S02 ID_S03 ID_S04 ID_S05 ID_S06 ID_S07 ID_S08 ID_S09 ID_S10 ID_S11 ID_S12 ID_S13 ID_S14 ID_S15 ID_S16 
        local fam_id fam_id_1968 fam_id_1969 fam_id_1970 fam_id_1971 fam_id_1972 fam_id_1973 fam_id_1974 fam_id_1975 fam_id_1976 fam_id_1977 fam_id_1978 fam_id_1979 fam_id_1980 fam_id_1981 fam_id_1982 fam_id_1983 fam_id_1984 fam_id_1985 fam_id_1986 fam_id_1987 fam_id_1988 fam_id_1989 fam_id_1990 fam_id_1991 fam_id_1992 fam_id_1993 fam_id_1994 fam_id_1995 fam_id_1996 fam_id_1997 fam_id_1999 fam_id_2001 fam_id_2003 fam_id_2005 fam_id_2007 fam_id_2009 fam_id_2011 fam_id_2013 fam_id_2015 fam_id_2017 fam_id_2019 fam_id_2021 fam_id_2023 
        local head_rel head_rel_1968 head_rel_1969 head_rel_1970 head_rel_1971 head_rel_1972 head_rel_1973 head_rel_1974 head_rel_1975 head_rel_1976 head_rel_1977 head_rel_1978 head_rel_1979 head_rel_1980 head_rel_1981 head_rel_1982 head_rel_1983 head_rel_1984 head_rel_1985 head_rel_1986 head_rel_1987 head_rel_1988 head_rel_1989 head_rel_1990 head_rel_1991 head_rel_1992 head_rel_1993 head_rel_1994 head_rel_1995 head_rel_1996 head_rel_1997 head_rel_1999 head_rel_2001 head_rel_2003 head_rel_2005 head_rel_2007 head_rel_2009 head_rel_2011 head_rel_2013 head_rel_2015 head_rel_2017 head_rel_2019 head_rel_2021 head_rel_2023
        local why_nonresponse why_nonresponse_1968 why_nonresponse_1969 why_nonresponse_1970 why_nonresponse_1971 why_nonresponse_1972 why_nonresponse_1973 why_nonresponse_1974 why_nonresponse_1975 why_nonresponse_1976 why_nonresponse_1977 why_nonresponse_1978 why_nonresponse_1979 why_nonresponse_1980 why_nonresponse_1981 why_nonresponse_1982 why_nonresponse_1983 why_nonresponse_1984 why_nonresponse_1985 why_nonresponse_1986 why_nonresponse_1987 why_nonresponse_1988 why_nonresponse_1989 why_nonresponse_1990 why_nonresponse_1991 why_nonresponse_1992 why_nonresponse_1993 why_nonresponse_1994 why_nonresponse_1995 why_nonresponse_1996 why_nonresponse_1997 why_nonresponse_1999 why_nonresponse_2001 why_nonresponse_2003 why_nonresponse_2005 why_nonresponse_2007 why_nonresponse_2009 why_nonresponse_2011 why_nonresponse_2013 why_nonresponse_2015 why_nonresponse_2017 why_nonresponse_2019 why_nonresponse_2021 why_nonresponse_2023
        keep `ids' `demos' `sample' `ins' `ages' `waves' `parents_gpars' `siblings' `fam_id' `head_rel' `why_nonresponse'

    /* 19. RESHAPE LONG and save tempfile `long-file1'
        This creates a long file with one row per person-year, including blank rows for years when the person is not observed. (AKA a perfect panel)
        * 3,445,375 person-year observations --> INCLUDING BLANKS. 2,071,258 person-year observations with non-missing fam_id_ (i.e., observed in that year)
        * 80,125 people
        * 45,056 of them sample members (the rest are family members of sample members)

        */ 
        reshape long age_ in_ fam_id_ head_rel_ why_nonresponse_,  i(ID) j(year)
        order ID fam fam_id_ age_first_observed sex
        label var year "Year"
        label var fam_id_ "Family ID in year"
        label var age_ "Age in year"
        label var in_ "Present in year"
        label var head_rel_ "Relationship to head/RP in year"
        label var why_nonresponse_ "Why nonresponse in year"

        tempfile long_file1
        save `long_file1', replace

    /* 20. Drop rows when person not interviewed PROVIDED IT IS NOT THE OBSERVATION
        AFTER THE LAST OBSERVATION FOR THAT PERSON 
        keep one after each person's last observation to understand why they attrited */

        sort ID year 
        bysort ID (year): replace in_ = 2 if in_ == 0 & in_[_n-1] == 1 & in_[_n+1]  == 0        
        drop if in_ == 0
        label var in_ "Present in year (1) or year after last observation (2)"

        * 866,035 rows with in_ == 1 (person observed in that year)
        * 62,463 rows with in_ == 2 (person not observed in that year but observed in the previous year and not observed in the next year, so this is the year after their last observation)

    /* 21. Use attrit rows to develop why left survey variable and year left survey variable 
        to do later: something is weird with year_left_survey, aka in_ is not 2 for years 2021, 2023. fix this. */
        egen year_left_survey = max(year), by(ID)
        g why_left_survey = why_nonresponse_ if in_ == 2
        replace why_left_survey = 0 if why_left_survey == .
        egen why_left_survey_max = max(why_left_survey), by(ID)
        drop why_left_survey
        rename why_left_survey_max why_left_survey
        label var why_left_survey "Why left survey, based on attrit row"
        label var year_left_survey "Year left survey, based on attrit row"

    /* 22. DROP ATTRIT ROWS */
        drop if in_ == 2 
        * N = 866,035 person-year observations with in_ == 1 (person observed in that year)
    
    /* 23. Household Roster */
        g hhr = ""
        sort fam year fam_id_ ID
        label var hhr "Household roster: IDs of family members in the same family-year"

        * for each year in each family (fam_id_), replace hhr with a list of the IDs of the family members with the same value of fam_id_ in that year. 
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

    /* 24. Ages Roster */
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


    /* 25. Relationships Roster */
        g rel_hhr = ""
        sort fam year fam_id_ ID
        g str_rel = string(head_rel_)
        bysort fam year fam_id_ (ID): replace rel_hhr = str_rel[1]
        bysort fam year fam_id_ (ID): replace rel_hhr = rel_hhr[_n-1] + " " + str_rel if _n > 1
        bysort fam year fam_id_ (ID): replace rel_hhr = rel_hhr[_N]
        drop str_rel
        replace rel_hhr = "" if in_ == 2

        label var rel_hhr "Relationships of family members TO HEAD/RP in the same family-year"

        g rel_padded = " " + rel_hhr + " "
        g rel_no_self = strtrim(itrim(subinstr(rel_padded, " " + string(head_rel_) + " ", " ", .)))
        drop rel_padded
        label var rel_no_self "Rel no self: Relationships of family members TO HEAD/RP in the same family-year excluding self"

    /* 26. List of siblings - time invariant*/
        egen sib_list = concat(ID_S01 ID_S02 ID_S03 ID_S04 ID_S05 ID_S06 ID_S07 ID_S08 ID_S09 ID_S10 ID_S11 ID_S12 ID_S13 ID_S14 ID_S15 ID_S16), punct(" ")
        replace sib_list = subinstr(sib_list, ".", "", .)
        replace sib_list = strtrim(sib_list)
        replace sib_list = stritrim(sib_list)
        label var sib_list "List of siblings (time invariant)"

    /* 27. List of parents - time invariant */
        egen par_list = concat(ID_aM ID_bM ID_aD ID_bD), punct(" ")
        replace par_list = subinstr(par_list, ".", "", .)
        replace par_list = strtrim(par_list)
        replace par_list = stritrim(par_list)
        label var par_list "List of parents (time invariant)"

    /* 28. List of grandparents - time invariant */
        egen gpar_list = concat(ID_aM_aM ID_aM_bM ID_aM_aD ID_aM_bD ID_bM_aM ID_bM_bM ID_bM_aD ID_bM_bD ID_aD_aM ID_aD_bM ID_aD_aD ID_aD_bD ID_bD_aM ID_bD_bM ID_bD_aD ID_bD_bD), punct(" ")
        replace gpar_list = subinstr(gpar_list, ".", "", .)
        replace gpar_list = strtrim(gpar_list)
        replace gpar_list = stritrim(gpar_list)
        label var gpar_list "List of grandparents (time invariant)"

    /* 29. Save and export full */
        save "$output/_psid_long.dta", replace
    
    /* 30. TRIM TO HEADS AND THEN SAMPLE HEADS */
        /* INTERMEDIATE FILE OF HEADS IN YEARS -- USED TO MERGE LATER */
            g flag = 1 if head_rel_ == 1 | head_rel_ == 10
            drop if flag != 1
            g head = 1
            label var head "Binary: Is head in year"
            keep ID fam year fam_id_ head
            save "${output}/_psid_long_heads.dta", replace


    /* 31. Drop non-sample members and observations after 17 */
        /* 
            We preserve family members of non-sample members because we use them 
            to construct family rosters and later to add race and ethnicity info. 
            but we don't care about HHR changes among non-sample members. 
            We only care about HHR changes for sample members during childhood. 
            Therefore, we drop observations after 17.
        */
            clear
            use "$output/_psid_long.dta"
            drop if analytic_sample_indiv == 0
            * 531,885 observations, n = 45,045
            drop if age_ >= 18
            * 316,712 observations, n = 45,045

    /* 32. Clean up and save */ 
            local ids ID fam_id_ year fam age_ 
            local rosters hhr_no_self ages_no_self rel_no_self
            local lists sib_list par_list gpar_list
            local sample sample_indiv_N sample_indiv_A sample_indiv_B
            local attrit year_left_survey why_left_survey

            keep `ids' `rosters' `lists' `sample' `attrit'

            order fam ID year hhr_no_self ages_no_self rel_no_self sib_list par_list gpar_list age_ sample_indiv_N sample_indiv_A sample_indiv_B  
            sort fam ID year
    
            save "${output}/_psid_long_lean.dta", replace
}

/* ------------------------------------- */
* PART IA: RUN _PSID_LONG_LEAN.DTA THROUGH 
* _HHR.IPYNB TO IDENTIFY HHR CHANGES
/* ------------------------------------- */

/* ------------------------------------- */
* PART II: merge together data from each survey 
* wave
/* ------------------------------------- */

if `part2' == 1{

    /* 01. Pull and merge together data from survey waves 1968-2023 */
        /* 1968 survey */
            clear
            clear mata
            set maxvar 32767
            cd "$raw"
            use "$raw/fam1968/fam1968.dta"
            g yr = 1968

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

            save "$output/fam1968_clean.dta", replace


        /* 1969 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1969"
            use "$raw/fam1969/fam1969.dta"
            g yr = 1969

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

            save "$output/fam1969_clean.dta", replace

        /* 1970 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1970"
            use "$raw/fam1970/fam1970.dta"
            g yr = 1970

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

            save "$output/fam1970_clean.dta", replace

        /* 1971 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1971"
            use "$raw/fam1971/fam1971.dta"
            g yr = 1971

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

            save "$output/fam1971_clean.dta", replace


        /* 1972 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1972"
            use "$raw/fam1972/fam1972.dta"
            g yr = 1972

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

            save "$output/fam1972_clean.dta", replace

        /* 1973 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1973"
            use "$raw/fam1973/fam1973.dta"
            g yr = 1973

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

            save "$output/fam1973_clean.dta", replace

        /* 1974 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1974"
            use "$raw/fam1974/fam1974.dta"
            g yr = 1974

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

            save "$output/fam1974_clean.dta", replace

        /* 1975 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1975"
            use "$raw/fam1975/fam1975.dta"
            g yr = 1975

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*


            save "$output/fam1975_clean.dta", replace

        /* 1976 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1976"
            use "$raw/fam1976/fam1976.dta"
            g yr = 1976

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*


            save "$output/fam1976_clean.dta", replace

        /* 1977 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1977"
            use "$raw/fam1977/fam1977.dta"
            g yr = 1977

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*


            save "$output/fam1977_clean.dta", replace

        /* 1978 survey */
            clear
            set maxvar 32767
            cd "$raw/fam1978"
            use "$raw/fam1978/fam1978.dta"
            g yr = 1978

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

            save "$output/fam1978_clean.dta", replace

        /* 1979 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1979"
            use "$raw/fam1979/fam1979.dta"
            g yr = 1979

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

            save "$output/fam1979_clean.dta", replace


        /* 1980 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1980"
            use "$raw/fam1980/fam1980.dta"
            g yr = 1980
            
            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

    
            save "$output/fam1980_clean.dta", replace


        /* 1981 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1981"
            use "$raw/fam1981/fam1981.dta"
            g yr = 1981
                
            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

    
            save "$output/fam1981_clean.dta", replace


        /* 1982 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1982"
            use "$raw/fam1982/fam1982.dta"
            
            g yr = 1982
            
            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*


            save "$output/fam1982_clean.dta", replace

        /* 1983 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1983"
            use "$raw/fam1983/fam1983.dta"
            g yr = 1983
            
            * keep wanted variables only 
            do "$scripts/_renaming.do"
    
            drop V*


            save "$output/fam1983_clean.dta", replace

        /* 1984 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1984"
            use "$raw/fam1984/fam1984.dta"
            g yr = 1984
            
            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

    
            save "$output/fam1984_clean.dta", replace

        /* 1985 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1985"
            use "$raw/fam1985/fam1985.dta"
            g yr = 1985
            
            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

    
            save "$output/fam1985_clean.dta", replace

        /* 1986 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1986"
            use "$raw/fam1986/fam1986.dta"
            g yr = 1986
            
            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*


            save "$output/fam1986_clean.dta", replace


        /* 1987 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1987"
            use "$raw/fam1987/fam1987.dta"

            g yr = 1987
            
            * keep wanted variables only 
            do "$scripts/_renaming.do"
    
            drop V*

    
            save "$output/fam1987_clean.dta", replace

        /* 1988 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1988"
            use "$raw/fam1988/fam1988.dta"
            g yr = 1988
            
            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

    
            save "$output/fam1988_clean.dta", replace

        /* 1989 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1989"
            use "$raw/fam1989/fam1989.dta"
            g yr = 1989
            
            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

    
            save "$output/fam1989_clean.dta", replace

        /* 1990 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1990"
            use "$raw/fam1990/fam1990.dta"
            g yr = 1990
            
            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*


            save "$output/fam1990_clean.dta", replace
            
        /* 1991 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1991"
            use "$raw/fam1991/fam1991.dta"
            g yr = 1991
            
            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*

    
            save "$output/fam1991_clean.dta", replace 


        /* 1992 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1992"
            use "$raw/fam1992/fam1992.dta"
            g yr = 1992

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*


            save "$output/fam1992_clean.dta", replace

        /* 1993 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1993"
            use "$raw/fam1993/fam1993.dta"
            g yr = 1993

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop V*


            save "$output/fam1993_clean.dta", replace

        /* 1994 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1994er"
            use "$raw/fam1994er/fam1994.dta"
            g yr = 1994

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop ER*


            save "$output/fam1994_clean.dta", replace

        /* 1995 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1995er"
            use "$raw/fam1995er/fam1995.dta"
            g yr = 1995

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop ER*


            save "$output/fam1995_clean.dta", replace

        /* 1996 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1996er"
            use "$raw/fam1996er/fam1996.dta"
            g yr = 1996

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop ER*


            save "$output/fam1996_clean.dta", replace


        /* 1997 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1997er"
            use "$raw/fam1997er/fam1997.dta"
            g yr = 1997

            * keep wanted variables only 
            do "$scripts/_renaming.do"

            drop ER*

            save "$output/fam1997_clean.dta", replace


        /* 1999 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam1999er"
            use "$raw/fam1999er/fam1999.dta"
            g yr = 1999

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*

            save "$output/fam1999_clean.dta", replace


        /* 2001 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam2001er"
            use "$raw/fam2001er/fam2001.dta"
            g yr = 2001

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*

            save "$output/fam2001_clean.dta", replace


        /* 2003 survey */
            clear 
            set maxvar 32767
            cd "$raw/fam2003er"
            use "$raw/fam2003er/fam2003.dta"
            g yr = 2003

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*

            save "$output/fam2003_clean.dta", replace


        /* 2005 survey */
            clear 
            cd "$raw/fam2005er"
            set maxvar 32767
            use "$raw/fam2005er/fam2005.dta"
            g yr = 2005

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*

            save "$output/fam2005_clean.dta", replace


        /* 2007 survey */
            clear 
            cd "$raw/fam2007er"
            set maxvar 32767
            use "$raw/fam2007er/fam2007.dta"
            g yr = 2007

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*


            save "$output/fam2007_clean.dta", replace


        /* 2009 survey */
            clear 
            cd "$raw/fam2009er"
            set maxvar 32767
            use "$raw/fam2009er/fam2009.dta"
            g yr = 2009

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*


            save "$output/fam2009_clean.dta", replace


        /* 2011 survey */
            clear 
            cd .. 
            cd "$raw/fam2011er"
            set maxvar 32767
            use "$raw/fam2011er/fam2011.dta"
            g yr = 2011

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*


            save "$output/fam2011_clean.dta", replace


        /* 2013 survey */
            clear 
            cd "$raw/fam2013er"
            set maxvar 32767
            use "$raw/fam2013er/fam2013.dta"
            g yr = 2013

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*


            save "$output/fam2013_clean.dta", replace


        /* 2015 survey */
            clear 
            cd "$raw/fam2015er"
            set maxvar 32767
            use "$raw/fam2015er/fam2015.dta"
            g yr = 2015

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*


            save "$output/fam2015_clean.dta", replace


        /* 2017 survey */
            clear 
            cd "$raw/fam2017er"
            set maxvar 32767
            use "$raw/fam2017er/fam2017.dta"
            g yr = 2017

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*


            save "$output/fam2017_clean.dta", replace


        /* 2019 survey */
            clear 
            cd "$raw/fam2019er"
            set maxvar 32767
            use "$raw/fam2019er/fam2019.dta"
            g yr = 2019

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*

            save "$output/fam2019_clean.dta", replace


        /* 2021 survey */
            clear 
            cd "$raw/fam2021er"
            set maxvar 32767
            use "$raw/fam2021er/fam2021.dta"
            g yr = 2021

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*

            save "$output/fam2021_clean.dta", replace


        /* 2023 survey */
            clear 
            cd "$raw/fam2023er"
            use "$raw/fam2023er/fam2023.dta"
            g yr = 2023
            rename fam ER82002

            * keep wanted variables only 
            do "$scripts/_renaming.do"
            drop ER*
            save "$output/fam2023_clean.dta", replace

    /* 02. Merge together */
        append using "$output/fam2021_clean.dta"
        append using "$output/fam2019_clean.dta"
        append using "$output/fam2017_clean.dta"
        append using "$output/fam2015_clean.dta"
        append using "$output/fam2013_clean.dta"
        append using "$output/fam2011_clean.dta"
        append using "$output/fam2009_clean.dta"
        append using "$output/fam2007_clean.dta"
        append using "$output/fam2005_clean.dta"
        append using "$output/fam2003_clean.dta"
        append using "$output/fam2001_clean.dta"
        append using "$output/fam1999_clean.dta"
        append using "$output/fam1997_clean.dta"
        append using "$output/fam1996_clean.dta"
        append using "$output/fam1995_clean.dta"
        append using "$output/fam1994_clean.dta"
        append using "$output/fam1993_clean.dta"
        append using "$output/fam1992_clean.dta"
        append using "$output/fam1991_clean.dta"
        append using "$output/fam1990_clean.dta"
        append using "$output/fam1989_clean.dta"
        append using "$output/fam1988_clean.dta"
        append using "$output/fam1987_clean.dta"
        append using "$output/fam1986_clean.dta"
        append using "$output/fam1985_clean.dta"
        append using "$output/fam1984_clean.dta"
        append using "$output/fam1983_clean.dta"
        append using "$output/fam1982_clean.dta"
        append using "$output/fam1981_clean.dta" 
        append using "$output/fam1980_clean.dta"
        append using "$output/fam1979_clean.dta"
        append using "$output/fam1978_clean.dta"
        append using "$output/fam1977_clean.dta"
        append using "$output/fam1976_clean.dta"
        append using "$output/fam1975_clean.dta"
        append using "$output/fam1974_clean.dta"
        append using "$output/fam1973_clean.dta"
        append using "$output/fam1972_clean.dta"
        append using "$output/fam1971_clean.dta"
        append using "$output/fam1970_clean.dta"
        append using "$output/fam1969_clean.dta"
        append using "$output/fam1968_clean.dta"

        * Panel data set of the heads of every household from 1968-2023
        rename yr year
        sort fam year fam_id_
        order fam year fam_id_
        replace fam_id_ = fam if year == 1968

        * THIS IS WHERE I WOULD RECODE DATE_INTERVIEW IF I WANT TO USE REAL DOBS TO CONSTRUCT AGES. 
        drop date_interview 

        drop fu_new_head
        rename rel_to_head resp_to_head_rel
        save "$output/_heads_panel.dta", replace

        * 11 variables
        * N = 320,456 (respondent-year observations)  
        * n = 14,818 (respondents)
}

/* ------------------------------------- */
* PART III: Relationships Roster
/* ------------------------------------- */

if `part3' == 1{
    /* 01. Relationships roster - load in relhist.dta */
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

    /* 02. Renaming in relhist */
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

    /* 03. Drop dyads for whom we have no relationship data */
        * ~ 9.5% of dyads have no relationship data (relationship_5 == "00000")        
        drop if relationship_5 == "00000"
        * drop other vars for now
        drop rv_8* relationship_3 rel_3_changed
        rename relationship_5 relationship

    /* 04. Relationship in year -- choose rv_5_rel when they don't match */
        forvalues i = 1968/1985{
            g relationship_`i' = ""
        }
        
        forvalues i = 1968/1985{
            replace relationship_`i' = rv_5_rel_`i' if rv_5_rel_`i' == rv_5_his_`i'
            replace relationship_`i' = rv_5_rel_`i' if rv_5_rel_`i' != "" & rv_5_his_`i' == ""
            replace relationship_`i' = rv_5_his_`i' if rv_5_his_`i' != "" & rv_5_rel_`i' == ""
            replace relationship_`i' = rv_5_rel_`i' if rv_5_rel_`i' != "" & rv_5_his_`i' != "" & relationship_`i' == ""
        }

    /* 05. Reshape */
        drop rv_5_rel_* rv_5_his_*
        reshape long relationship_ coresidence_status_ psid_status_x_ psid_status_y_, i(ID ID_y) j(yr)

    /* 06. Encode relationship */
        * drop the most commonly recorded
        drop relationship
        * rename relationship in year correctly 
        rename relationship_ relationship
        drop if relationship == ""
        g relationship_coded = ""
        replace relationship_coded = "Other" if relationship == "00098" 
        replace relationship_coded = "Spouse" if relationship == "00131" 
        replace relationship_coded = "Spouse" if relationship == "00132" 
        replace relationship_coded = "Spouse" if relationship == "00133" 
        replace relationship_coded = "Spouse" if relationship == "00134" 
        replace relationship_coded = "Spouse" if relationship == "00135" 
        replace relationship_coded = "Spouse" if relationship == "00137" 
        replace relationship_coded = "Spouse" if relationship == "00138" 
        replace relationship_coded = "Spouse" if relationship == "00139" 
        replace relationship_coded = "Spouse" if relationship == "00151" 
        replace relationship_coded = "Spouse" if relationship == "00152" 
        replace relationship_coded = "Spouse" if relationship == "00153" 
        replace relationship_coded = "Spouse" if relationship == "00154" 
        replace relationship_coded = "Spouse" if relationship == "00155" 
        replace relationship_coded = "Spouse" if relationship == "00156" 
        replace relationship_coded = "Spouse" if relationship == "00157" 
        replace relationship_coded = "Spouse" if relationship == "00158" 
        replace relationship_coded = "Spouse" if relationship == "00159" 
        replace relationship_coded = "Spouse" if relationship == "00160" 
        replace relationship_coded = "Spouse" if relationship == "00161" 
        replace relationship_coded = "Spouse" if relationship == "00162" 
        replace relationship_coded = "Spouse" if relationship == "00163" 
        replace relationship_coded = "Spouse" if relationship == "00164" 
        replace relationship_coded = "Spouse" if relationship == "00199" 
        replace relationship_coded = "Sibling" if relationship == "00231" 
        replace relationship_coded = "Sibling" if relationship == "00232" 
        replace relationship_coded = "Sibling" if relationship == "00233" 
        replace relationship_coded = "Sibling" if relationship == "00234" 
        replace relationship_coded = "Sibling" if relationship == "00235" 
        replace relationship_coded = "Sibling" if relationship == "00236" 
        replace relationship_coded = "Sibling" if relationship == "00238" 
        replace relationship_coded = "Sibling" if relationship == "00251" 
        replace relationship_coded = "Sibling" if relationship == "00252" 
        replace relationship_coded = "Sibling" if relationship == "00253" 
        replace relationship_coded = "Sibling" if relationship == "00254" 
        replace relationship_coded = "Sibling" if relationship == "00255" 
        replace relationship_coded = "Sibling" if relationship == "00256" 
        replace relationship_coded = "Sibling" if relationship == "00257" 
        replace relationship_coded = "Sibling" if relationship == "00258" 
        replace relationship_coded = "Sibling" if relationship == "00259" 
        replace relationship_coded = "Sibling" if relationship == "00260" 
        replace relationship_coded = "Sibling" if relationship == "00261" 
        replace relationship_coded = "Sibling" if relationship == "00262" 
        replace relationship_coded = "Sibling" if relationship == "00263" 
        replace relationship_coded = "Sibling" if relationship == "00264" 
        replace relationship_coded = "Sibling" if relationship == "00299" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00351" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00352" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00353" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00354" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00355" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00356" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00357" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00358" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00359" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00360" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00361" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00362" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00363" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00364" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00365" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00366" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00367" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00368" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00369" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00370" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00371" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00372" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00373" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00374" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00375" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00376" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00377" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00378" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00379" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00380" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00381" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00382" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00383" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00384" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00385" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00386" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00387" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00388" 
        replace relationship_coded = "Sibling-in-law" if relationship == "00399" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00431" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00432" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00433" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00434" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00451" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00452" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00453" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00454" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00455" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00456" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00457" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00458" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00459" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00460" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00461" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00462" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00463" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00464" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00465" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00466" 
        replace relationship_coded = "Spouse of sibling-in-law" if relationship == "00499" 
        replace relationship_coded = "Sibling or cousin" if relationship == "00531" 
        replace relationship_coded = "Sibling or cousin" if relationship == "00532" 
        replace relationship_coded = "Sibling or cousin" if relationship == "00551" 
        replace relationship_coded = "Sibling or cousin" if relationship == "00552" 
        replace relationship_coded = "Cousin" if relationship == "00631" 
        replace relationship_coded = "Cousin" if relationship == "00632" 
        replace relationship_coded = "Cousin" if relationship == "00633" 
        replace relationship_coded = "Cousin" if relationship == "00634" 
        replace relationship_coded = "Cousin" if relationship == "00635" 
        replace relationship_coded = "Cousin" if relationship == "00651" 
        replace relationship_coded = "Cousin" if relationship == "00652" 
        replace relationship_coded = "Cousin" if relationship == "00653" 
        replace relationship_coded = "Cousin" if relationship == "00654" 
        replace relationship_coded = "Cousin" if relationship == "00655" 
        replace relationship_coded = "Cousin" if relationship == "00656" 
        replace relationship_coded = "Cousin" if relationship == "00657" 
        replace relationship_coded = "Cousin" if relationship == "00658" 
        replace relationship_coded = "Cousin" if relationship == "00659" 
        replace relationship_coded = "Cousin" if relationship == "00660" 
        replace relationship_coded = "Cousin" if relationship == "00661" 
        replace relationship_coded = "Cousin" if relationship == "00662" 
        replace relationship_coded = "Cousin" if relationship == "00663" 
        replace relationship_coded = "Cousin" if relationship == "00664" 
        replace relationship_coded = "Cousin" if relationship == "00665" 
        replace relationship_coded = "Cousin" if relationship == "00666" 
        replace relationship_coded = "Cousin" if relationship == "00699" 
        replace relationship_coded = "Sibling of sibling-in-law" if relationship == "00731" 
        replace relationship_coded = "Sibling of sibling-in-law" if relationship == "00732" 
        replace relationship_coded = "Sibling of sibling-in-law" if relationship == "00799" 
        replace relationship_coded = "Sibling-in-law of sibling-in-law" if relationship == "00851" 
        replace relationship_coded = "Sibling-in-law of sibling-in-law" if relationship == "00852" 
        replace relationship_coded = "Sibling-in-law of sibling-in-law" if relationship == "00853" 
        replace relationship_coded = "Sibling-in-law of sibling-in-law" if relationship == "00854" 
        replace relationship_coded = "Sibling-in-law of sibling-in-law" if relationship == "00899" 
        replace relationship_coded = "Cousin of spouse" if relationship == "00951" 
        replace relationship_coded = "Cousin of spouse" if relationship == "00952" 
        replace relationship_coded = "Cousin of spouse" if relationship == "00999" 
        replace relationship_coded = "Parent of child-in-law" if relationship == "01031" 
        replace relationship_coded = "Parent of child-in-law" if relationship == "01032" 
        replace relationship_coded = "Parent of child-in-law" if relationship == "01099" 
        replace relationship_coded = "Other" if relationship == "10098" 
        replace relationship_coded = "Parent" if relationship == "10101" 
        replace relationship_coded = "Parent" if relationship == "10102" 
        replace relationship_coded = "Parent" if relationship == "10103" 
        replace relationship_coded = "Parent" if relationship == "10104" 
        replace relationship_coded = "Parent" if relationship == "10105" 
        replace relationship_coded = "Parent" if relationship == "10106" 
        replace relationship_coded = "Parent" if relationship == "10107" 
        replace relationship_coded = "Parent" if relationship == "10108" 
        replace relationship_coded = "Parent" if relationship == "10109" 
        replace relationship_coded = "Parent" if relationship == "10110" 
        replace relationship_coded = "Parent" if relationship == "10111" 
        replace relationship_coded = "Parent" if relationship == "10112" 
        replace relationship_coded = "Parent" if relationship == "10113" 
        replace relationship_coded = "Parent" if relationship == "10114" 
        replace relationship_coded = "Parent" if relationship == "10115" 
        replace relationship_coded = "Parent" if relationship == "10116" 
        replace relationship_coded = "Parent" if relationship == "10117" 
        replace relationship_coded = "Parent" if relationship == "10118" 
        replace relationship_coded = "Parent" if relationship == "10119" 
        replace relationship_coded = "Parent" if relationship == "10199" 
        replace relationship_coded = "Parent-in-law" if relationship == "10201" 
        replace relationship_coded = "Parent-in-law" if relationship == "10202" 
        replace relationship_coded = "Parent-in-law" if relationship == "10203" 
        replace relationship_coded = "Parent-in-law" if relationship == "10204" 
        replace relationship_coded = "Parent-in-law" if relationship == "10205" 
        replace relationship_coded = "Parent-in-law" if relationship == "10206" 
        replace relationship_coded = "Parent-in-law" if relationship == "10207" 
        replace relationship_coded = "Parent-in-law" if relationship == "10208" 
        replace relationship_coded = "Parent-in-law" if relationship == "10209" 
        replace relationship_coded = "Parent-in-law" if relationship == "10210" 
        replace relationship_coded = "Parent-in-law" if relationship == "10211" 
        replace relationship_coded = "Parent-in-law" if relationship == "10212" 
        replace relationship_coded = "Parent-in-law" if relationship == "10213" 
        replace relationship_coded = "Parent-in-law" if relationship == "10215" 
        replace relationship_coded = "Parent-in-law" if relationship == "10216" 
        replace relationship_coded = "Parent-in-law" if relationship == "10217" 
        replace relationship_coded = "Parent-in-law" if relationship == "10299" 
        replace relationship_coded = "Parent or aunt/uncle" if relationship == "10301" 
        replace relationship_coded = "Parent or aunt/uncle" if relationship == "10302" 
        replace relationship_coded = "Parent or aunt/uncle" if relationship == "10303" 
        replace relationship_coded = "Parent or aunt/uncle" if relationship == "10304" 
        replace relationship_coded = "Parent or aunt/uncle" if relationship == "10305" 
        replace relationship_coded = "Parent or aunt/uncle" if relationship == "10306" 
        replace relationship_coded = "Parent or aunt/uncle" if relationship == "10307" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10401" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10402" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10403" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10404" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10405" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10406" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10407" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10408" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10409" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10411" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10412" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10413" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10414" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10415" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10416" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10417" 
        replace relationship_coded = "Aunt/uncle" if relationship == "10499" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10501" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10502" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10503" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10504" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10505" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10506" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10507" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10509" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10510" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10511" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10513" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10514" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10515" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10516" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10519" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10520" 
        replace relationship_coded = "Spouse of aunt/uncle" if relationship == "10599" 
        replace relationship_coded = "Aunt/uncle of spouse" if relationship == "10601" 
        replace relationship_coded = "Aunt/uncle of spouse" if relationship == "10602" 
        replace relationship_coded = "Aunt/uncle of spouse" if relationship == "10603" 
        replace relationship_coded = "Aunt/uncle of spouse" if relationship == "10699" 
        replace relationship_coded = "Spouse of aunt/uncle of spouse" if relationship == "10701" 
        replace relationship_coded = "Spouse of aunt/uncle of spouse" if relationship == "10799" 
        replace relationship_coded = "Cousin of parent" if relationship == "10801" 
        replace relationship_coded = "Cousin of parent" if relationship == "10802" 
        replace relationship_coded = "Cousin of parent" if relationship == "10899" 
        replace relationship_coded = "Sibling or spouse of aunt/uncle" if relationship == "10901" 
        replace relationship_coded = "Sibling or spouse of aunt/uncle" if relationship == "10902" 
        replace relationship_coded = "Sibling or spouse of aunt/uncle" if relationship == "10999" 
        replace relationship_coded = "Parent-in-law of sibling" if relationship == "11001" 
        replace relationship_coded = "Parent-in-law of sibling" if relationship == "11002" 
        replace relationship_coded = "Parent-in-law of sibling" if relationship == "11099" 
        replace relationship_coded = "Parent-in-law of sibling of spouse" if relationship == "11101" 
        replace relationship_coded = "Parent-in-law of sibling of spouse" if relationship == "11102" 
        replace relationship_coded = "Parent-in-law of sibling of spouse" if relationship == "11199" 
        replace relationship_coded = "Grandparent of child-in-law" if relationship == "11299" 
        replace relationship_coded = "Other" if relationship == "15098" 
        replace relationship_coded = "Child" if relationship == "15101" 
        replace relationship_coded = "Child" if relationship == "15102" 
        replace relationship_coded = "Child" if relationship == "15103" 
        replace relationship_coded = "Child" if relationship == "15104" 
        replace relationship_coded = "Child" if relationship == "15105" 
        replace relationship_coded = "Child" if relationship == "15106" 
        replace relationship_coded = "Child" if relationship == "15107" 
        replace relationship_coded = "Child" if relationship == "15108" 
        replace relationship_coded = "Child" if relationship == "15109" 
        replace relationship_coded = "Child" if relationship == "15110" 
        replace relationship_coded = "Child" if relationship == "15111" 
        replace relationship_coded = "Child" if relationship == "15112" 
        replace relationship_coded = "Child" if relationship == "15113" 
        replace relationship_coded = "Child" if relationship == "15114" 
        replace relationship_coded = "Child" if relationship == "15115" 
        replace relationship_coded = "Child" if relationship == "15116" 
        replace relationship_coded = "Child" if relationship == "15117" 
        replace relationship_coded = "Child" if relationship == "15118" 
        replace relationship_coded = "Child" if relationship == "15119" 
        replace relationship_coded = "Child" if relationship == "15199" 
        replace relationship_coded = "Child-in-law" if relationship == "15201" 
        replace relationship_coded = "Child-in-law" if relationship == "15202" 
        replace relationship_coded = "Child-in-law" if relationship == "15203" 
        replace relationship_coded = "Child-in-law" if relationship == "15204" 
        replace relationship_coded = "Child-in-law" if relationship == "15205" 
        replace relationship_coded = "Child-in-law" if relationship == "15206" 
        replace relationship_coded = "Child-in-law" if relationship == "15207" 
        replace relationship_coded = "Child-in-law" if relationship == "15208" 
        replace relationship_coded = "Child-in-law" if relationship == "15209" 
        replace relationship_coded = "Child-in-law" if relationship == "15210" 
        replace relationship_coded = "Child-in-law" if relationship == "15211" 
        replace relationship_coded = "Child-in-law" if relationship == "15212" 
        replace relationship_coded = "Child-in-law" if relationship == "15213" 
        replace relationship_coded = "Child-in-law" if relationship == "15215" 
        replace relationship_coded = "Child-in-law" if relationship == "15216" 
        replace relationship_coded = "Child-in-law" if relationship == "15217" 
        replace relationship_coded = "Child-in-law" if relationship == "15299" 
        replace relationship_coded = "Child or Niece/nephew" if relationship == "15301" 
        replace relationship_coded = "Child or Niece/nephew" if relationship == "15302" 
        replace relationship_coded = "Child or Niece/nephew" if relationship == "15303" 
        replace relationship_coded = "Child or Niece/nephew" if relationship == "15304" 
        replace relationship_coded = "Child or Niece/nephew" if relationship == "15305" 
        replace relationship_coded = "Child or Niece/nephew" if relationship == "15306" 
        replace relationship_coded = "Child or Niece/nephew" if relationship == "15307" 
        replace relationship_coded = "Niece/nephew" if relationship == "15401" 
        replace relationship_coded = "Niece/nephew" if relationship == "15402" 
        replace relationship_coded = "Niece/nephew" if relationship == "15403" 
        replace relationship_coded = "Niece/nephew" if relationship == "15404" 
        replace relationship_coded = "Niece/nephew" if relationship == "15405" 
        replace relationship_coded = "Niece/nephew" if relationship == "15406" 
        replace relationship_coded = "Niece/nephew" if relationship == "15407" 
        replace relationship_coded = "Niece/nephew" if relationship == "15408" 
        replace relationship_coded = "Niece/nephew" if relationship == "15409" 
        replace relationship_coded = "Niece/nephew" if relationship == "15411" 
        replace relationship_coded = "Niece/nephew" if relationship == "15412" 
        replace relationship_coded = "Niece/nephew" if relationship == "15413" 
        replace relationship_coded = "Niece/nephew" if relationship == "15414" 
        replace relationship_coded = "Niece/nephew" if relationship == "15415" 
        replace relationship_coded = "Niece/nephew" if relationship == "15416" 
        replace relationship_coded = "Niece/nephew" if relationship == "15417" 
        replace relationship_coded = "Niece/nephew" if relationship == "15499" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15501" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15502" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15503" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15504" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15505" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15506" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15507" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15509" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15510" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15511" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15513" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15514" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15515" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15516" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15519" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15520" 
        replace relationship_coded = "Niece/nephew of spouse" if relationship == "15599" 
        replace relationship_coded = "Spouse of niece/nephew" if relationship == "15601" 
        replace relationship_coded = "Spouse of niece/nephew" if relationship == "15602" 
        replace relationship_coded = "Spouse of niece/nephew" if relationship == "15603" 
        replace relationship_coded = "Spouse of niece/nephew" if relationship == "15699" 
        replace relationship_coded = "Spouse of niece/nephew of spouse" if relationship == "15701" 
        replace relationship_coded = "Spouse of niece/nephew of spouse" if relationship == "15799" 
        replace relationship_coded = "Child of cousin" if relationship == "15801" 
        replace relationship_coded = "Child of cousin" if relationship == "15802" 
        replace relationship_coded = "Child of cousin" if relationship == "15899" 
        replace relationship_coded = "Niece/nephew of spouse of sibling" if relationship == "15901" 
        replace relationship_coded = "Niece/nephew of spouse of sibling" if relationship == "15902" 
        replace relationship_coded = "Niece/nephew of spouse of sibling" if relationship == "15999" 
        replace relationship_coded = "Sibling of child-in-law" if relationship == "16001" 
        replace relationship_coded = "Sibling of child-in-law" if relationship == "16002" 
        replace relationship_coded = "Sibling of child-in-law" if relationship == "16099" 
        replace relationship_coded = "Spouse of sibling of child-in-law" if relationship == "16101" 
        replace relationship_coded = "Spouse of sibling of child-in-law" if relationship == "16102" 
        replace relationship_coded = "Spouse of sibling of child-in-law" if relationship == "16199" 
        replace relationship_coded = "Parent-in-law of grandchild" if relationship == "16299" 
        replace relationship_coded = "Grandparent" if relationship == "20098" 
        replace relationship_coded = "Grandparent" if relationship == "20101" 
        replace relationship_coded = "Grandparent" if relationship == "20102" 
        replace relationship_coded = "Grandparent" if relationship == "20103" 
        replace relationship_coded = "Grandparent" if relationship == "20104" 
        replace relationship_coded = "Grandparent" if relationship == "20105" 
        replace relationship_coded = "Grandparent" if relationship == "20106" 
        replace relationship_coded = "Grandparent" if relationship == "20107" 
        replace relationship_coded = "Grandparent" if relationship == "20108" 
        replace relationship_coded = "Grandparent" if relationship == "20109" 
        replace relationship_coded = "Grandparent" if relationship == "20110" 
        replace relationship_coded = "Grandparent" if relationship == "20111" 
        replace relationship_coded = "Grandparent" if relationship == "20112" 
        replace relationship_coded = "Grandparent" if relationship == "20113" 
        replace relationship_coded = "Grandparent" if relationship == "20114" 
        replace relationship_coded = "Grandparent" if relationship == "20199" 
        replace relationship_coded = "Grandparent of spouse" if relationship == "20201" 
        replace relationship_coded = "Grandparent of spouse" if relationship == "20202" 
        replace relationship_coded = "Grandparent of spouse" if relationship == "20203" 
        replace relationship_coded = "Grandparent of spouse" if relationship == "20299" 
        replace relationship_coded = "Grandparent or Grandaunt/uncle" if relationship == "20301" 
        replace relationship_coded = "Grandaunt/uncle" if relationship == "20401" 
        replace relationship_coded = "Grandaunt/uncle" if relationship == "20402" 
        replace relationship_coded = "Grandaunt/uncle" if relationship == "20499" 
        replace relationship_coded = "Grandparent or Great-grandparent" if relationship == "20501" 
        replace relationship_coded = "Grandparent or Great-grandparent" if relationship == "20502" 
        replace relationship_coded = "Grandparent or Great-grandparent" if relationship == "20503" 
        replace relationship_coded = "Grandparent or Great-grandparent" if relationship == "20504" 
        replace relationship_coded = "Grandparent or Great-grandparent" if relationship == "20505" 
        replace relationship_coded = "Great-grandparent" if relationship == "20601" 
        replace relationship_coded = "Great-grandparent" if relationship == "20602" 
        replace relationship_coded = "Great-grandparent" if relationship == "20603" 
        replace relationship_coded = "Great-grandparent" if relationship == "20604" 
        replace relationship_coded = "Great-grandparent" if relationship == "20699" 
        replace relationship_coded = "Great-great-grandparent" if relationship == "20799" 
        replace relationship_coded = "Great-grandaunt/uncle" if relationship == "20899" 
        replace relationship_coded = "Gaunt/guncle or parent of a/u by m" if relationship == "20901" 
        replace relationship_coded = "Gaunt/guncle or parent of a/u by m" if relationship == "20902" 
        replace relationship_coded = "Gaunt/guncle or parent of a/u by m" if relationship == "20903" 
        replace relationship_coded = "Gaunt/guncle or parent of a/u by m" if relationship == "20904" 
        replace relationship_coded = "Gaunt/guncle or parent of a/u by m" if relationship == "20999" 
        replace relationship_coded = "Grandparent of spouse of sibling" if relationship == "21099" 
        replace relationship_coded = "Great-grandparent of spouse" if relationship == "21199" 
        replace relationship_coded = "Grandaunt/uncle of spouse" if relationship == "21299" 
        replace relationship_coded = "Grandchild" if relationship == "25098" 
        replace relationship_coded = "Grandchild" if relationship == "25101" 
        replace relationship_coded = "Grandchild" if relationship == "25102" 
        replace relationship_coded = "Grandchild" if relationship == "25103" 
        replace relationship_coded = "Grandchild" if relationship == "25104" 
        replace relationship_coded = "Grandchild" if relationship == "25105" 
        replace relationship_coded = "Grandchild" if relationship == "25106" 
        replace relationship_coded = "Grandchild" if relationship == "25107" 
        replace relationship_coded = "Grandchild" if relationship == "25108" 
        replace relationship_coded = "Grandchild" if relationship == "25109" 
        replace relationship_coded = "Grandchild" if relationship == "25110" 
        replace relationship_coded = "Grandchild" if relationship == "25111" 
        replace relationship_coded = "Grandchild" if relationship == "25112" 
        replace relationship_coded = "Grandchild" if relationship == "25113" 
        replace relationship_coded = "Grandchild" if relationship == "25114" 
        replace relationship_coded = "Grandchild" if relationship == "25199" 
        replace relationship_coded = "Spouse of grandchild" if relationship == "25201" 
        replace relationship_coded = "Spouse of grandchild" if relationship == "25202" 
        replace relationship_coded = "Spouse of grandchild" if relationship == "25203" 
        replace relationship_coded = "Spouse of grandchild" if relationship == "25299" 
        replace relationship_coded = "Grandchild or Grandniece/nephew" if relationship == "25301" 
        replace relationship_coded = "Grandniece/nephew" if relationship == "25401" 
        replace relationship_coded = "Grandniece/nephew" if relationship == "25402" 
        replace relationship_coded = "Grandniece/nephew" if relationship == "25499" 
        replace relationship_coded = "Grandchild or Great-grandchild" if relationship == "25501" 
        replace relationship_coded = "Grandchild or Great-grandchild" if relationship == "25502" 
        replace relationship_coded = "Grandchild or Great-grandchild" if relationship == "25503" 
        replace relationship_coded = "Grandchild or Great-grandchild" if relationship == "25504" 
        replace relationship_coded = "Grandchild or Great-grandchild" if relationship == "25505" 
        replace relationship_coded = "Great-grandchild" if relationship == "25601" 
        replace relationship_coded = "Great-grandchild" if relationship == "25602" 
        replace relationship_coded = "Great-grandchild" if relationship == "25603" 
        replace relationship_coded = "Great-grandchild" if relationship == "25604" 
        replace relationship_coded = "Great-grandchild" if relationship == "25699" 
        replace relationship_coded = "Great-great-grandchild" if relationship == "25799" 
        replace relationship_coded = "Great-grandniece/nephew" if relationship == "25899" 
        replace relationship_coded = "Gniece/neph or niece/neph by m of child" if relationship == "25901" 
        replace relationship_coded = "Gniece/neph or niece/neph by m of child" if relationship == "25902" 
        replace relationship_coded = "Gniece/neph or niece/neph by m of child" if relationship == "25903" 
        replace relationship_coded = "Gniece/neph or niece/neph by m of child" if relationship == "25904" 
        replace relationship_coded = "Gniece/neph or niece/neph by m of child" if relationship == "25999" 
        replace relationship_coded = "Sibling of spouse of grandchild" if relationship == "26099" 
        replace relationship_coded = "Spouse of great-grandchild" if relationship == "26199" 
        replace relationship_coded = "Spouse of grandniece/nephew" if relationship == "26299" 
        replace relationship_coded = "Other relative" if relationship == "99731" 
        replace relationship_coded = "Other non-relative" if relationship == "99831" 
        label var relationship_coded "Relationship btwn person X and Y"

        * check 00237 
            
    /* 07. Operate from person X's perspective --> drop years when non response */
        drop if psid_status_x_ == "5"
        drop if psid_status_x_ == "2"
        drop if psid_status_x_ == "3"
        drop if psid_status_x_ == "4"
        drop person_number person_number_y psid_status_x_ relationship
        
    /* 08. Reshape again ... */
        order ID yr
        sort ID yr
        preserve
        reshape wide  relationship_coded coresidence_status, i(ID yr) j(ID_y)
        sort ID yr ID_y
        bysort ID yr: g index = _n
        isid ID yr index
        reshape wide ID_y relationship_coded coresidence_status psid_status_y_ rel_5_changed birth_year_y sex_y, i(ID yr) j(index)

    /* 09. SAVE */
        save "$output/relationships_roster_.dta", replace

    /* 10. Keep just relationships for sample people 
        clear 
        use "_psid_long.dta"
        drop if analytic_sample_indiv == 0
        drop if in_ == 0
        keep ID fam fam_id_ year
        rename year yr
        merge 1:1 ID yr using "relationships_roster_.dta"
        drop if _merge == 2
        sort ID yr
        drop _merge
        tempfile rel1
        save `rel1'

    /* 10. Merge on long heads to create relationship of ID to head in year panel */
        use "${output}/_psid_long_heads.dta", clear
        rename ID ID_y1
        rename year yr
        merge 1:m ID_y1 yr using "`rel1'"
        order fam ID yr fam_id_
        sort fam ID yr
        drop if ID == . */

}

/* ------------------------------------- */
* PART IV: Merge three datasets: 
* 1. Long data: _psid_long.dta
* 2. Long data with hhr changes: _hhr.csv
* 3. Long data of heads: _heads_panel.dta
/* ------------------------------------- */

if `part4' == 1{
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
        merge 1:m ID year fam_id_ using "$output/_psid_long.dta"
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
        drop hhr_no_self ages_no_self rel_no_self 
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
    
    /* 05. Save */
        save "$output/_unclean_panel.dta", replace
        
}

/* ------------------------------------- */
* PART V: Clean save panel 
/* ------------------------------------- */

if `part5' == 1{
    /* 01. Clean */
        clear
        use "$output/_unclean_panel.dta", clear
        sort fam year fam_id_ ID
        drop analytic_sample_indiv analytic_sample_family 
        label var fam "1968 Family ID"
        label var ID "Individual ID"
        label var year "Year"
        label var age_ "Age of Individual"
        label var fam_id_ "Family ID in Year"
        label var hhr "Household Roster (Excluding Self)"
        label var ages_hhr "Ages of Household Roster (Excluding Self)"
        label var rel_hhr "Relationship to Head of Household of Household Roster (Excluding Self)"
        label var siblings "Siblings in family unit from FIMS"
        label var parents "Parents in family unit from FIMS"
        label var grandparents "Grandparents in family unit from FIMS"
        drop hhr_prev ages_prev rel_prev
        label var ids_left "IDs of people who left the household since last wave"
        label var ids_came "IDs of people who came into the household since last wave"
        label var ages_left "Ages of people who left the household since last wave"
        label var ages_came "Ages of people who came into the household since last wave since last wave"
        label var rel_left "Relationship to head of people who left the household since last wave"
        label var rel_came "Relationship to head of people who came into the household since last wave"
        label var sib_ages_came "Ages of siblings who came into the household since last wave"
        label var sib_ages_left "Ages of siblings who left the household since last wave"
        label var par_came "Parent came into household"
        label var par_left "Parent left household"
        label var gpar_came "Grandparent came into household"
        label var gpar_left "Grandparent left household"
        label var hhr_change "Household composition changed since last wave"
        label var hhr_in "Household member(s) came into household since last wave"
        label var hhr_out "Household member(s) left household since last wave"
        label var adult_came "Adult came into household since last wave"
        label var adult_left "Adult left household since last wave"
        label var child_came "Child came into household since last wave"
        label var child_left "Child left household since last wave"
        label var sib_came "Sibling came into household since last wave"
        label var sib_left "Sibling left household since last wave"
        label var year_left_survey "Year left survey"
        label var why_left_survey "Reason for leaving survey"
        drop in_
        drop sib_list par_list gpar_list
        drop _merge

    /* 02. Reference Person Education - Fine Grained */
        g rp_education_A = "Less than HS" if head_education == 0 | head_education == 1 | head_education == 2 | head_education == 3 & year <= 1990
        replace rp_education_A = "High School Graduate" if head_education == 4 & year <= 1990
        replace rp_education_A = "Some College" if head_education == 5 | head_education == 6 & year <= 1990
        replace rp_education_A = "College +" if head_education == 7 | head_education == 8 & year <= 1990
        replace rp_education_A = "Unknown" if head_education == 9 & year <= 1990
        replace rp_education_A = "Less than HS" if head_yrs_school >= 0 & head_yrs_school <= 11 & year > 1990 & year <= 2023 & head_yrs_school != . 
        replace rp_education_A = "High School Graduate" if head_yrs_school == 12 & year > 1990 & year <= 2023 & head_yrs_school != . 
        replace rp_education_A = "Some College" if head_yrs_school >= 13 & head_yrs_school <= 15 & year > 1990 & year <= 2023 & head_yrs_school != . 
        replace rp_education_A = "College +" if head_yrs_school ==16 | head_yrs_school == 17 & year > 1990 & year <= 2023 & head_yrs_school != . 
        replace rp_education_A = "Unknown" if head_yrs_school == 99 & year > 1990 & year <= 2023 & head_yrs_school != . 
        label var rp_education_A "Education of Reference Person - Time Varying, highly strat"

    /* 03. Reference Person Education - Coarse */
        g rp_education_B = "No College Degree" if rp_education_A == "Less than HS" | rp_education_A == "High School Graduate" | rp_education_A == "Some College"
        replace rp_education_B = "College Degree or More" if rp_education_A == "College +"
        replace rp_education_B = "Unknown" if rp_education_A == "Unknown"
        label var rp_education_B "Education of Reference Person - Time Varying, Coarse"

        drop head_yrs_school head_education

    /* 04. Reference Person Race */
        g rp_race = "White" if head_race == 1
        replace rp_race = "Black" if head_race == 2
        replace rp_race = "Hispanic" if head_race == 5
        replace rp_race = "Other" if head_race == 3 | head_race == 4 | head_race == 6 | head_race == 7
        replace rp_race = "Unknown" if head_race == 9 | head_race == 0
        label var rp_race "Race of RP"

    /* 05. Relationship to RP - Fine Grained */ 
        g who_is_rp_A = ""
        replace who_is_rp_A = "Self" if head_rel_ == 1
        replace who_is_rp_A = "Self" if head_rel_ == 10
        replace who_is_rp_A = "Husband" if head_rel_ == 2
        replace who_is_rp_A = "Husband" if head_rel_ == 20
        replace who_is_rp_A = "Husband" if head_rel_ == 22
        replace who_is_rp_A = "Parent" if head_rel_ == 3
        replace who_is_rp_A = "Parent" if head_rel_ == 30
        replace who_is_rp_A = "Stepparent" if head_rel_ == 33 
        replace who_is_rp_A = "Stepparent" if head_rel_ == 35
        replace who_is_rp_A = "Parent-in-law" if head_rel_ == 37
        replace who_is_rp_A = "Foster Parent" if head_rel_ == 38
        replace who_is_rp_A = "Sibling" if head_rel_ == 4
        replace who_is_rp_A = "Sibling" if head_rel_ == 40
        replace who_is_rp_A = "Sibling-in-law" if head_rel_ == 47
        replace who_is_rp_A = "Grandparent" if head_rel_ == 6
        replace who_is_rp_A = "Grandparent" if head_rel_ == 60
        replace who_is_rp_A = "Great-grandparent" if head_rel_ == 65
        replace who_is_rp_A = "Other relative" if head_rel_ == 7
        replace who_is_rp_A = "Nonrelative" if head_rel_ == 8
        replace who_is_rp_A = "Aunt/Uncle" if head_rel_ == 70
        replace who_is_rp_A = "Aunt/Uncle" if head_rel_ == 71
        replace who_is_rp_A = "Niece/Nephew" if head_rel_ == 72
        replace who_is_rp_A = "Cousin" if head_rel_ == 74
        replace who_is_rp_A = "Cousin" if head_rel_ == 75
        replace who_is_rp_A = "Other relative" if head_rel_ == 97 | head_rel_ ==96 | head_rel_ == 95
        replace who_is_rp_A = "Nonrelative" if head_rel_ == 98
        replace who_is_rp_A = "Other" if head_rel_ == 48 | head_rel_ == 83 | head_rel_ == 88
        label var who_is_rp_A "Who is R to Reference Person - Fine Grained"

    /* 06. Who is RP - Coarser */
        g who_is_rp_B = ""
        replace who_is_rp_B = "Self or Partner" if head_rel_ == 1 | head_rel_ == 10 | head_rel_ == 2 | head_rel_ == 20 | head_rel_ == 22
        replace who_is_rp_B = "Parent" if head_rel_ == 3 | head_rel_ == 30
        replace who_is_rp_B = "Stepparent / Parent-in-law / Foster Parent" if head_rel_ == 33 | head_rel_ == 35 | head_rel_ == 37 | head_rel_ == 38
        replace who_is_rp_B = "Sibling" if head_rel_ == 4 | head_rel_ == 40
        replace who_is_rp_B = "Sibling-in-law" if head_rel_ == 47
        replace who_is_rp_B = "Grandparent or Great-grandparent" if head_rel_ == 6 | head_rel_ == 60 | head_rel_ == 65
        replace who_is_rp_B = "Aunt/Uncle/Niece/Nephew/Cousin" if head_rel_ == 70 | head_rel_ == 71 | head_rel_ == 72 | head_rel_ == 74 | head_rel_ == 75
        replace who_is_rp_B = "Other relative" if head_rel_ == 7 | head_rel_ == 97 | head_rel_ ==96 | head_rel_ == 95
        replace who_is_rp_B = "Nonrelative" if head_rel_ == 8 | head_rel_ == 98
        replace who_is_rp_B = "Other" if head_rel_ == 48 | head_rel_ == 83 | head_rel_ == 88
        label var who_is_rp_B "Who is R to Reference Person - Coarser"


    /* 07. Who is RP - Coarser */
        g who_is_rp_C = ""
        replace who_is_rp_C = "Self or Partner" if head_rel_ == 1 | head_rel_ == 10 | head_rel_ == 2 | head_rel_ == 20 | head_rel_ == 22
        replace who_is_rp_C = "Relative" if head_rel_ == 3 | head_rel_ == 30 | head_rel_ == 4 | head_rel_ == 40  | head_rel_ == 6 | head_rel_ == 60 | head_rel_ == 65 | head_rel_ == 7 | head_rel_ == 97 | head_rel_ ==96 | head_rel_ == 95
        replace who_is_rp_C = "Nonrelative" if head_rel_ == 33 | head_rel_ == 35 | head_rel_ == 37 | head_rel_ == 38 | head_rel_ == 70 | head_rel_ == 71 | head_rel_ == 72 | head_rel_ == 74 | head_rel_ == 75 | head_rel_ == 47 | head_rel_ == 8 | head_rel_ == 98
        replace who_is_rp_C = "Other" if head_rel_ == 48 | head_rel_ == 83 | head_rel_ == 88
        label var who_is_rp_C "Who is R to Reference Person - Coarsest"

    /* 08. Clean up */
        drop rel_to_head why_nonresponse_ fu_new_head

    /* 09. Save */
        save "$output/_psid_analytic_sample.dta", replace

}

/* ------------------------------------- */
* PART VI: Tables
/* ------------------------------------- */

if `part6' == 1{
    /* 01. Make Tables - June 3, 2026 for meeting June 7, 2026 */
        decode sex, g(sex1)
        drop sex
        rename sex1 sex
        replace og_1968_family = 0 if og_1968_family == . 
        replace imm_latino_family = 0 if imm_latino_family == .
        g birth_year = year - age_

    /* 02. TO DO: Parent race vs. other RP race */

    /* 03. Collapse */
        local maxvars par_came par_left gpar_came gpar_left hhr_change hhr_in hhr_out adult_came adult_left child_came child_left sib_came sib_left og_1968_family imm_latino_family birth_year
        local minvars age_first_observed
        local firstnm rp_race head_sex who_is_rp
        local lastnm sex rp_education_A rp_education_B
        local mean waves_17_under waves_17_skipadjusted sample_indiv_N sample_indiv_A sample_indiv_B 

        collapse (max) `maxvars' (min) `minvars' (first) `firstnm' (last) `lastnm' (mean) `mean', by(ID)

    /* 04. Birth Cohort */
    g birth_cohort = "pre 1955" if birth_year < 1955
    replace birth_cohort = "1955-1965" if birth_year >= 1955 & birth_year < 1965
    replace birth_cohort = "1965-1975" if birth_year >= 1965 & birth_year < 1975
    replace birth_cohort = "1975-1985" if birth_year >= 1975 & birth_year < 1985
    replace birth_cohort = "1985-1995" if birth_year >= 1985 & birth_year < 1995
    replace birth_cohort = "1995-2005" if birth_year >= 1995 & birth_year < 2005
    replace birth_cohort = "2005-2015" if birth_year >= 2005 & birth_year < 2015
    replace birth_cohort = "after 2015" if birth_year >= 2015
    label var birth_cohort "Birth Cohort of Individual"

}


