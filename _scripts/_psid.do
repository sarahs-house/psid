****************************
* Sarah Sullivan 
* OG Created: December 27, 2025
* Version Created: March 6, 2026
* Last Updated: June 16, 2026

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
Part II: Family matrix
Part III: Harmonization and cleaning of year level PSID data for waves 1968-2023. 
Part IV: Merging of data sets
Part V: Cleaning and output for various deliverables 
Part VI: Tables

To do next:
- pull relevant tables
- weights
- see what's going on with dob and birth_cohort for sample B 
- write a little about cases where RP becomes wife/husband or self. (e.g., move out at 16)

Questions/overall to do: 
- how granular of relationships do we care about? 

- Rule for sample A is currently # of waves observed before 18 = 18. But some ppl are observed at one age for more than one 
wave, but NOT OBSERVED AT AGE 1 or 17. Should we condition on being observed at age 1? Same for the other edge. Condition on 17?
    - e.g: 
    years observed (age): 1968 (2), 1969 (3), 1970 (4), 1971 (5), 1972 (6), 1973 (7), 1974 (8), 1975 (9), 1976 (10), 1977 (11), 1978 (12), 1979 (13), 1980 (14), 1981 (15), 1982 (16), 1983 (17), 1984 (17)
    years observed (age): 2001 (1), 2003 (3), 2005 (5), 2007 (7), 2009 (9), 2011 (11), 2013 (13), 2015 (15), 2017 (16)

- check age-first-observed for same reason
- ever race of relative reported
- why do some people have no age data ever observed? same with marital status? 
- write up logic for hhr, ages_hhr, rel_hhr
- write up workflow & update readmes 



*/

************************************

/* ******************** */
* PART 0: PROGRAM SET UP
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

    /* 05. Weights */

        rename ER31996 strata_ind2023
        rename ER31997 cluster_ind2023

        forvalues i = 1968/1997{
            g indiv_weight_`i' = 0
            label var indiv_weight_`i' "Individual Weight `i'"
        }

        forvalues i=1999(2)2023{
            g indiv_weight_`i' = 0
            label var indiv_weight_`i' "Individual Weight `i'"
        }

        /* Longitudinal weights until 1989: no cross-sectional weights available pre 1989 */
        replace indiv_weight_1968 = ER30019
        replace indiv_weight_1969 = ER30042 
        replace indiv_weight_1970 = ER30066 
        replace indiv_weight_1971 = ER30090 
        replace indiv_weight_1972 = ER30116 
        replace indiv_weight_1973 = ER30137 
        replace indiv_weight_1974 = ER30159 
        replace indiv_weight_1975 = ER30187 
        replace indiv_weight_1976 = ER30216 
        replace indiv_weight_1977 = ER30245 
        replace indiv_weight_1978 = ER30282 
        replace indiv_weight_1979 = ER30312 
        replace indiv_weight_1980 = ER30342 
        replace indiv_weight_1981 = ER30372 
        replace indiv_weight_1982 = ER30398 
        replace indiv_weight_1983 = ER30428 
        replace indiv_weight_1984 = ER30462 
        replace indiv_weight_1985 = ER30497 
        replace indiv_weight_1986 = ER30534 
        replace indiv_weight_1987 = ER30569 
        replace indiv_weight_1988 = ER30605 
        replace indiv_weight_1989 = ER30641

        /* Combined longitudinal core and latino for 1990-1992*/
        replace indiv_weight_1990 = ER30688 
        replace indiv_weight_1991 = ER30732 
        replace indiv_weight_1992 = ER30805


        /* Combined core and latino for 1993-1995, with 1993 revision */
        replace indiv_weight_1993 = ER30866 
        replace indiv_weight_1994 = ER33121 
        replace indiv_weight_1995 = ER33277
    
        /* Core Longitudinal weight for 1996 */
        replace indiv_weight_1996 = ER33318

        /* Combined longitudinal core and latino for 1997-2023 */
        replace indiv_weight_1997 = ER33430 
        replace indiv_weight_1999 = ER33546 
        replace indiv_weight_2001 = ER33637 
        replace indiv_weight_2003 = ER33740 
        replace indiv_weight_2005 = ER33848
        replace indiv_weight_2007 = ER33950
        replace indiv_weight_2009 = ER34045 
        replace indiv_weight_2011 = ER34154 
        replace indiv_weight_2013 = ER34268 
        replace indiv_weight_2015 = ER34413 
        replace indiv_weight_2017 = ER34650 
        replace indiv_weight_2019 = ER34863 
        replace indiv_weight_2021 = ER35064 
        replace indiv_weight_2023 = ER35264




    /* 06. AGE --> 
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

    /* 07. Save ages intermediate file */
        save "${output}/_ind_ages.dta", replace

    /* 08. Age first observed */
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
    
    /* 09. FIMS: merge on family identification mapping system files that allow us to identify parents, gpars, and sibs */
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

    /* 10. CREATE ANALYTIC SAMPLE INDICATOR --> ANYONE OBSERVED DURING CHILDHOOD FOR ANY NUMBER OF WAVES.
        * Sample N: all PSID children. Anyone observed for any number of waves BEFORE age 18.
        
        LATER:
            * Sample A: full childhood. Anyone observed continuously from birth to age 18. 
            * Sample B: two-wave+ children. Anyone observed for at least two waves BEFORE age 18.
        */

        g analytic_sample_indiv = 1 if waves_17_under >= 1
        replace analytic_sample_indiv = 0 if waves_17_under == 0
        label var analytic_sample_indiv "Binary: In Sample N, A, or B. Observed before age 18."
        * n = 45,057 (out of 85,536 total individuals)

    /* 11. Some erroneous sample people 
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
        g erroneousperson = 1 if ID == 1830184 | ID == 5535171 | ID == 5129170 | ID == 5349174 | ID == 5876003 | ID == 8190002 | ID == 9045004 | ID == 1841003 | ID == 5128182 | ID == 5442171 | ID == 5449170 | ID == 9296170
        replace erroneousperson = 0 if erroneousperson == .
        label var erroneousperson "Binary: Person with age reporting error, dropped from sample"
        * n = 12

    /* 12. HARDCODE ERRORS */
        * because he is the only member of his household, we're gonna replace his family iD with the other one
        replace fam = 5741 if ID == 5742001
        g fam_changed = 1 if ID == 5742001
        
        replace fam = 1843 if ID == 1844001
        replace fam_changed = 1 if ID == 1844001

        replace fam = 937 if ID == 938002
        replace fam_changed = 1 if ID == 938002
        
        replace fam_changed = 0 if fam_changed == .
        label var fam_changed "Binary: Family ID changed for person with two households in one home"


    /* 13. Flag Analytic Sample Families & Drop unqualified families 
        * 5,565 families
        * 80,125 sample people in qualified families
        * 45,045 qualified children (children in sample N, A, or B)
        */
        * analytic_sample_family = 1 if at least one person in the original 1968 family unit is in the analytic sample (analytic_sample_indiv == 1)
        egen analytic_sample_family = max(analytic_sample_indiv), by(fam)
        label var analytic_sample_indiv "Binary: In Sample N, A, or B"
        label var analytic_sample_family "Binary: Family with at least one child in Sample N, A, or B"

        * Drop families that do not have at least one child in the analytic sample (analytic_sample_family == 0)
        drop if analytic_sample_family == 0


    /* 14. Waves observed, adjusted for skipped years of data collection 
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

    /* 15. Define each sample: N, A, B -->
        For samples N and B, we use waves_17_under. For sample A, we use waves_17_skipadjusted.

        Sample A is counting who is observed continously throughout childhood, using the rule of being observed for at least 17 waves before age 18, adjusted for skipping years. 

        Sample B counts who is observed at least twice before 17. This is a more inclusive sample than sample A but less inclusive than sample N. It is more inclusive than sample A because it allows for some skipping of waves in childhood.
        If a kid is observed only once before 17 but after 1997, their waves_17_skipadjusted will be 2, so they will fall in sample A erroneously. For that reason, we use waves_17_under.

        Sample N counts children simply observed in childhood. This is the most inclusive sample and necessarily includes all people in samples A and B. 
        Comparing samples A and B to sample N allows us to understand what is lost when we require more waves of observation in childhood.

        Sample A: 8,823 children; 55,924 family members; 2,047 families
        Sample B: 38,425 children; 77,283 family members;  4,987 families
        Sample N: 45,045 children; 80,125 family members; 5,565 families
        */

        g sample_indiv_N = 1 if waves_17_under >= 1 & analytic_sample_indiv == 1
        replace sample_indiv_N = 0 if waves_17_under == 0 | analytic_sample_indiv == 0
        label var sample_indiv_N "Binary: In Sample N (at least one wave before age 18)"
        egen sample_family_N = max(sample_indiv_N), by(fam)
        label var sample_family_N "Binary: Family with at least one child in Sample N"

        g sample_indiv_A = 1 if waves_17_skipadjusted >= 17 & analytic_sample_indiv == 1
        replace sample_indiv_A = 0 if waves_17_skipadjusted < 17 | analytic_sample_indiv == 0
        label var sample_indiv_A "Binary: In Sample A (observed in all waves from birth to age 18)"
        egen sample_family_A = max(sample_indiv_A), by(fam)
        label var sample_family_A "Binary: Family with at least one child in Sample A"

        g sample_indiv_B = 1 if waves_17_under >= 2 & analytic_sample_indiv == 1
        replace sample_indiv_B = 0 if waves_17_under < 2 | analytic_sample_indiv == 0
        label var sample_indiv_B "Binary: In Sample B (at least two waves before age 18)"
        egen sample_family_B = max(sample_indiv_B), by(fam)
        label var sample_family_B "Binary: Family with at least one child in Sample B"

    /* 16. Sex */
        rename ER32000 sex 
        label var sex "Sex of Individual"

    /* 17. Split offs 
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
            replace fam_id_1968 = 5742 if ID == 5742001
            replace fam_id_1968 = 1844 if ID == 1844001
            replace fam_id_1968 = 938 if ID == 938002
            replace fam_id_1968 = 5742 if ID == 5742001
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


    /* 18. Head relationship 
        * Variable recording the relationship between the individual and the Head/Reference Person in each wave. 
        = 0 if the person is not observed in that year. 
        */ 
        local head_rel 1968 ER30003 1969 ER30022 1970 ER30045 1971 ER30069 1972 ER30093 1973 ER30119 1974 ER30140 1975 ER30162 1976 ER30190 1977 ER30219 1978 ER30248 1979 ER30285 1980 ER30315 1981 ER30345 1982 ER30375 1983 ER30401 1984 ER30431 1985 ER30465 1986 ER30500 1987 ER30537 1988 ER30572 1989 ER30608 1990 ER30644 1991 ER30691 1992 ER30735 1993 ER30808 1994 ER33103 1995 ER33203 1996 ER33303 1997 ER33403 1999 ER33503 2001 ER33603 2003 ER33703 2005 ER33803 2007 ER33903 2009 ER34003 2011 ER34103 2013 ER34203 2015 ER34303 2017 ER34503 2019 ER34703 2021 ER34903 2023 ER35103

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

    /* 19. Why nonresponse 
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
        

    /* 20. Clean and save tempfile before reshape */
        local ids fam ID 
        local demos sex age_first_observed
        local sample analytic_sample_indiv analytic_sample_family sample_indiv_N sample_family_N sample_indiv_A sample_family_A sample_indiv_B sample_family_B og_1968_family imm_latino_family fam_sample 
        local ins in_1968 in_1969 in_1970 in_1971 in_1972 in_1973 in_1974 in_1975 in_1976 in_1977 in_1978 in_1979 in_1980 in_1981 in_1982 in_1983 in_1984 in_1985 in_1986 in_1987 in_1988 in_1989 in_1990 in_1991 in_1992 in_1993 in_1994 in_1995 in_1996 in_1997 in_1999 in_2001 in_2003 in_2005 in_2007 in_2009 in_2011 in_2013 in_2015 in_2017 in_2019 in_2021 in_2023 
        local weights indiv_weight_1968 indiv_weight_1969 indiv_weight_1970 indiv_weight_1971 indiv_weight_1972 indiv_weight_1973 indiv_weight_1974 indiv_weight_1975 indiv_weight_1976 indiv_weight_1977 indiv_weight_1978 indiv_weight_1979 indiv_weight_1980 indiv_weight_1981 indiv_weight_1982 indiv_weight_1983 indiv_weight_1984 indiv_weight_1985 indiv_weight_1986 indiv_weight_1987 indiv_weight_1988 indiv_weight_1989 indiv_weight_1990 indiv_weight_1991 indiv_weight_1992 indiv_weight_1993 indiv_weight_1994 indiv_weight_1995 indiv_weight_1996 indiv_weight_1997 indiv_weight_1999 indiv_weight_2001 indiv_weight_2003 indiv_weight_2005 indiv_weight_2007 indiv_weight_2009 indiv_weight_2011 indiv_weight_2013 indiv_weight_2015 indiv_weight_2017 indiv_weight_2019 indiv_weight_2021 indiv_weight_2023 cluster_ind2023 strata_ind2023
        local ages age_1968 age_1969 age_1970 age_1971 age_1972 age_1973 age_1974 age_1975 age_1976 age_1977 age_1978 age_1979 age_1980 age_1981 age_1982 age_1983 age_1984 age_1985 age_1986 age_1987 age_1988 age_1989 age_1990 age_1991 age_1992 age_1993 age_1994 age_1995 age_1996 age_1997 age_1999 age_2001 age_2003 age_2005 age_2007 age_2009 age_2011 age_2013 age_2015 age_2017 age_2019 age_2021 age_2023 
        local waves waves waves_skipadjusted waves_17_under waves_17_skipadjusted 
        local parents_gpars ID_bM ID_bD ID_aM ID_aD ID_aM_aM ID_aM_aD ID_aM_bM ID_aM_bD ID_aD_aM ID_aD_aD ID_aD_bM ID_aD_bD ID_bM_aM ID_bM_aD ID_bM_bM ID_bM_bD ID_bD_aM ID_bD_aD ID_bD_bM ID_bD_bD 
        local siblings ID_S01 ID_S02 ID_S03 ID_S04 ID_S05 ID_S06 ID_S07 ID_S08 ID_S09 ID_S10 ID_S11 ID_S12 ID_S13 ID_S14 ID_S15 ID_S16 
        local fam_id fam_id_1968 fam_id_1969 fam_id_1970 fam_id_1971 fam_id_1972 fam_id_1973 fam_id_1974 fam_id_1975 fam_id_1976 fam_id_1977 fam_id_1978 fam_id_1979 fam_id_1980 fam_id_1981 fam_id_1982 fam_id_1983 fam_id_1984 fam_id_1985 fam_id_1986 fam_id_1987 fam_id_1988 fam_id_1989 fam_id_1990 fam_id_1991 fam_id_1992 fam_id_1993 fam_id_1994 fam_id_1995 fam_id_1996 fam_id_1997 fam_id_1999 fam_id_2001 fam_id_2003 fam_id_2005 fam_id_2007 fam_id_2009 fam_id_2011 fam_id_2013 fam_id_2015 fam_id_2017 fam_id_2019 fam_id_2021 fam_id_2023 
        local head_rel head_rel_1968 head_rel_1969 head_rel_1970 head_rel_1971 head_rel_1972 head_rel_1973 head_rel_1974 head_rel_1975 head_rel_1976 head_rel_1977 head_rel_1978 head_rel_1979 head_rel_1980 head_rel_1981 head_rel_1982 head_rel_1983 head_rel_1984 head_rel_1985 head_rel_1986 head_rel_1987 head_rel_1988 head_rel_1989 head_rel_1990 head_rel_1991 head_rel_1992 head_rel_1993 head_rel_1994 head_rel_1995 head_rel_1996 head_rel_1997 head_rel_1999 head_rel_2001 head_rel_2003 head_rel_2005 head_rel_2007 head_rel_2009 head_rel_2011 head_rel_2013 head_rel_2015 head_rel_2017 head_rel_2019 head_rel_2021 head_rel_2023
        local why_nonresponse why_nonresponse_1968 why_nonresponse_1969 why_nonresponse_1970 why_nonresponse_1971 why_nonresponse_1972 why_nonresponse_1973 why_nonresponse_1974 why_nonresponse_1975 why_nonresponse_1976 why_nonresponse_1977 why_nonresponse_1978 why_nonresponse_1979 why_nonresponse_1980 why_nonresponse_1981 why_nonresponse_1982 why_nonresponse_1983 why_nonresponse_1984 why_nonresponse_1985 why_nonresponse_1986 why_nonresponse_1987 why_nonresponse_1988 why_nonresponse_1989 why_nonresponse_1990 why_nonresponse_1991 why_nonresponse_1992 why_nonresponse_1993 why_nonresponse_1994 why_nonresponse_1995 why_nonresponse_1996 why_nonresponse_1997 why_nonresponse_1999 why_nonresponse_2001 why_nonresponse_2003 why_nonresponse_2005 why_nonresponse_2007 why_nonresponse_2009 why_nonresponse_2011 why_nonresponse_2013 why_nonresponse_2015 why_nonresponse_2017 why_nonresponse_2019 why_nonresponse_2021 why_nonresponse_2023
        keep `ids' `demos' `sample' `weights' `ins' `ages' `waves' `parents_gpars' `siblings' `fam_id' `head_rel' `why_nonresponse'

    /* 21. RESHAPE LONG and save tempfile `long-file1'
        This creates a long file with one row per person-year, including blank rows for years when the person is not observed. (AKA a perfect panel)
        * 3,445,375 person-year observations --> INCLUDING BLANKS. 2,071,258 person-year observations with non-missing fam_id_ (i.e., observed in that year)
        * 80,125 people (+2)
        * 45,056 of them sample members (the rest are family members of sample members)

        */ 

        reshape long age_ in_ indiv_weight_ fam_id_ head_rel_ why_nonresponse_,  i(ID) j(year)
        order ID fam fam_id_ age_first_observed sex
        
        label var year "Year"
        label var fam_id_ "Family ID in year"
        label var age_ "Age in year"
        label var in_ "Present in year"
        label var head_rel_ "Relationship to head/RP in year"
        label var why_nonresponse_ "Why nonresponse in year"
        label var indiv_weight_ "Individual weight in year"

    /* 22. Drop rows when person not interviewed PROVIDED IT IS NOT THE OBSERVATION
        AFTER THE LAST OBSERVATION FOR THAT PERSON 
        keep one after each person's last observation to understand why they attrited */
        
        * flag the last row for each person (people who don't earn last obs are from fims but literally no other info on them - n = 373)
        sort ID year 
        by ID (year): g lastobs = 1 if in_ == 0 & in_[_n-1] == 1
        replace lastobs = 1 if in_ == 1 & year == 2023
        replace lastobs = 0 if lastobs == . & in_ == 1
        drop if lastobs == . 

    /* 23. Use attrit rows to develop why left survey variable and year left survey variable */
        g why_left_survey = why_nonresponse_ if lastobs == 1
        replace why_left_survey = 2023 if lastobs == 1 & year == 2023
        replace why_left_survey = 0 if why_left_survey == .
        egen why_left_survey_max = max(why_left_survey), by(ID)
        drop why_left_survey
        rename why_left_survey_max why_left_survey
        label var why_left_survey "Why left survey, based on attrit row"
        egen year_left_survey = max(year), by(ID)
        label var year_left_survey "Year left survey, based on attrit row"

    /* 24. DROP ATTRIT ROWS */
        drop if in_ == 0 
        * N = 866,035 person-year observations with in_ == 1 (person observed in that year)
    
    /* 25. Household Roster */
        g hhr = ""
        sort fam year fam_id_ ID
        label var hhr "Household roster: IDs of family members in the same family-year"

        * for each year in each family (fam_id_), replace hhr with a list of the IDs of the family members with the same value of fam_id_ in that year. 
        * if hhr = "", that means it is the row capturing the year AFTER the individual left the study (the year after their last observation)
        * count if hhr == "" & ID == ID[_n+1] --> 0

        g str_id = string(ID)
        bysort year fam_id_ (ID): replace hhr = str_id[1]
        bysort year fam_id_ (ID): replace hhr = hhr[_n-1] + " " + str_id if _n > 1
        bysort year fam_id_ (ID): replace hhr = hhr[_N]
        drop str_id

        * without self 
        g hhr_padded = " " + hhr + " "
        g hhr_no_self = strtrim(itrim(subinstr(hhr_padded, " " + string(ID) + " ", " ", .)))
        drop hhr_padded
        label var hhr_no_self "HHR without self: IDs of family members in the same family-year excluding self"

    /* 26. Ages Roster */
        g ages_hhr = ""
        sort fam year fam_id_ ID
        g str_age = string(age_)
        replace str_age = "" if str_age == "."
        bysort year fam_id_ (ID): replace ages_hhr = str_age[1]
        bysort year fam_id_ (ID): replace ages_hhr = ages_hhr[_n-1] + " " + str_age if _n > 1
        bysort year fam_id_ (ID): replace ages_hhr = ages_hhr[_N]
        drop str_age
        replace ages_hhr = "" if in_ == 2
        label var ages_hhr "Ages of family members in the same family-year"

        g ages_padded = " " + ages_hhr + " "
        g ages_no_self = strtrim(itrim(subinstr(ages_padded, " " + string(age_) + " ", " ", .)))
        drop ages_padded
        label var ages_no_self "Ages without self: Ages of family members in the same family-year excluding self"

    /* 27. Relationships Roster */
        g rel_hhr = ""
        sort fam year fam_id_ ID
        g str_rel = string(head_rel_)
        bysort year fam_id_ (ID): replace rel_hhr = str_rel[1]
        bysort year fam_id_ (ID): replace rel_hhr = rel_hhr[_n-1] + " " + str_rel if _n > 1
        bysort year fam_id_ (ID): replace rel_hhr = rel_hhr[_N]
        drop str_rel
        replace rel_hhr = "" if in_ == 2

        label var rel_hhr "Relationships of family members TO HEAD/RP in the same family-year"

        g rel_padded = " " + rel_hhr + " "
        g rel_no_self = strtrim(itrim(subinstr(rel_padded, " " + string(head_rel_) + " ", " ", .)))
        drop rel_padded
        label var rel_no_self "Rel no self: Relationships of family members TO HEAD/RP in the same family-year excluding self"

    /* 28. List of siblings - time invariant*/
        egen sib_list = concat(ID_S01 ID_S02 ID_S03 ID_S04 ID_S05 ID_S06 ID_S07 ID_S08 ID_S09 ID_S10 ID_S11 ID_S12 ID_S13 ID_S14 ID_S15 ID_S16), punct(" ")
        replace sib_list = subinstr(sib_list, ".", "", .)
        replace sib_list = strtrim(sib_list)
        replace sib_list = stritrim(sib_list)
        label var sib_list "List of siblings (time invariant)"

    /* 29. List of parents - time invariant */
        egen par_list = concat(ID_aM ID_bM ID_aD ID_bD), punct(" ")
        replace par_list = subinstr(par_list, ".", "", .)
        replace par_list = strtrim(par_list)
        replace par_list = stritrim(par_list)
        label var par_list "List of parents (time invariant)"

    /* 30. List of grandparents - time invariant */
        egen gpar_list = concat(ID_aM_aM ID_aM_bM ID_aM_aD ID_aM_bD ID_bM_aM ID_bM_bM ID_bM_aD ID_bM_bD ID_aD_aM ID_aD_bM ID_aD_aD ID_aD_bD ID_bD_aM ID_bD_bM ID_bD_aD ID_bD_bD), punct(" ")
        replace gpar_list = subinstr(gpar_list, ".", "", .)
        replace gpar_list = strtrim(gpar_list)
        replace gpar_list = stritrim(gpar_list)
        label var gpar_list "List of grandparents (time invariant)"

    /* 31. Save and export full */
        save "$output/_psid_long.dta", replace
    
    /* 32. TRIM TO HEADS AND THEN SAMPLE HEADS */
        /* INTERMEDIATE FILE OF HEADS IN YEARS -- USED TO MERGE LATER */
            g flag = 1 if head_rel_ == 1 | head_rel_ == 10
            drop if flag != 1
            g head = 1
            label var head "Binary: Is head in year"
            keep ID fam year fam_id_ head
            save "${output}/_psid_long_heads.dta", replace


    /* 33. Drop non-sample members and observations after 17 */
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

    /* 34. Clean up and save */ 
            local ids ID fam_id_ year fam age_ 
            local rosters hhr_no_self ages_no_self rel_no_self
            local lists sib_list par_list gpar_list
            local sample sample_indiv_N sample_indiv_A sample_indiv_B
            local attrit year_left_survey why_left_survey
            local weights indiv_weight_ cluster_ind2023 strata_ind2023

            keep `ids' `rosters' `lists' `sample' `attrit' `weights'

            order fam ID year indiv_weight_ hhr_no_self ages_no_self rel_no_self sib_list par_list gpar_list age_ sample_indiv_N sample_indiv_A sample_indiv_B  

            sort fam ID year
    
            save "${output}/_psid_long_lean.dta", replace
}

/* ------------------------------------- */
* PART II: Family Matrix
/* ------------------------------------- */

if `part2' == 1{
    /* 01. Input and clean family matrix */
            use "${raw}/MX23REL/MX23REL.dta", clear
        * drop release number, sequence numbers for x and y
            drop MX1 MX4 MX9
        * generate IDs for x and y, drop original person numbers
            g ID = (1000*MX5) + MX6
            g ID_y = (1000*MX10) + MX11
            label var ID "Individual ID (1000*MX5 + MX6)"
            label var ID_y "Individual ID Y (1000*MX10 + MX11)"
            drop MX6 MX11 
        * drop 1968 family number for y (this is usually the same) 
            drop MX10
        * year, fam, fam_id_ and fam_id_y_
            rename MX2 year
            rename MX3 fam_id_
            rename MX5 fam
        * drop person y relationship to RP
            drop MX12
        * core relationship variable
            rename MX8 relationship_x_y
        * relationship of x to head. 
            rename MX7 head_rel_
        * order
            order fam year ID ID_y fam_id_ relationship_x_y
    
    /* 02. Merge on ages */
        rename ID ID_x
        rename ID_y ID
        merge m:1 ID using "$output/_ind_ages.dta"

        rename ID ID_y
        rename ID_x ID
        keep fam year ID ID_y fam_id_ relationship_x_y head_rel_ person_number age_1968 age_1969 age_1970 age_1971 age_1972 age_1973 age_1974 age_1975 age_1976 age_1977 age_1978 age_1979 age_1980 age_1981 age_1982 age_1983 age_1984 age_1985 age_1986 age_1987 age_1988 age_1989 age_1990 age_1991 age_1992 age_1993 age_1994 age_1995 age_1996 age_1997 age_1999 age_2001 age_2003 age_2005 age_2007 age_2009 age_2011 age_2013 age_2015 age_2017 age_2019 age_2021 age_2023

        g age_y = . 
        forvalues i = 1968/1997 {
             replace age_y = age_`i' if year == `i'
        }
        forvalues i = 1999(2)2023 {
            replace age_y = age_`i' if year == `i'
        }

        forvalues i = 1968/1997 {
            drop age_`i'
        }
        forvalues i = 1999(2)2023 {
            drop age_`i'
        }

    /* 02. Merge on sample members, only need their relationships */
        merge m:1 ID year fam_id_ using "$output/_psid_long_lean.dta"
        * drop non-sample people's relationships
        drop if _merge == 1
        * fill in age
        replace age_y = 999 if age_y == . 

    /* 03. Index */ 
        sort ID year fam_id_ ID_y
        drop person_number
        bysort ID year fam_id_: g index = _n
        order fam year ID ID_y index
        drop _merge

    /* 04. Reshape wide */
        reshape wide ID_y relationship_x_y age_y, i(ID year fam_id_) j(index)

    /* 05. Remake HHR  */
        g hhr_matrix = ""
        forvalues i = 1/19{
            g str_ID_y`i' = string(ID_y`i')
        }

        forvalues i = 1/19{
            replace str_ID_y`i' = "" if relationship_x_y`i' == 10
        }
        forvalues i = 1/19{
            replace str_ID_y`i' = "" if str_ID_y`i' == "."
        }

        replace hhr_matrix = str_ID_y1 + " " + str_ID_y2 + " " + str_ID_y3 + " " + str_ID_y4 + " " + str_ID_y5 + " " + str_ID_y6 + " " + str_ID_y7 + " " + str_ID_y8 + " " + str_ID_y9 + " " + str_ID_y10 + " " + str_ID_y11 + " " + str_ID_y12 + " " + str_ID_y13 + " " + str_ID_y14 + " " + str_ID_y15 + " " + str_ID_y16 + " " + str_ID_y17 + " " + str_ID_y18 + " " + str_ID_y19
        replace hhr_matrix = stritrim(hhr_matrix)
        replace hhr_matrix = strtrim(hhr_matrix)
        label var hhr_matrix "Household roster based on family matrix: IDs of family members in the same family-year based on family matrix"

        drop str_ID_y*

    /* 06. Make relationship roster */
        g rel_matrix = ""
        forvalues i = 1/19{
            g str_rel`i' = string(relationship_x_y`i')
        }
        forvalues i = 1/19{
            replace str_rel`i' = "" if relationship_x_y`i' == 10
        }
        forvalues i = 1/19{
            replace str_rel`i' = "" if str_rel`i' == "."
        }

        replace rel_matrix = str_rel1 + " " + str_rel2 + " " + str_rel3 + " " + str_rel4 + " " + str_rel5 + " " + str_rel6 + " " + str_rel7 + " " + str_rel8 + " " + str_rel9 + " " + str_rel10 + " " + str_rel11 + " " + str_rel12 + " " + str_rel13 + " " + str_rel14 + " " + str_rel15 + " " + str_rel16 + " " + str_rel17 + " " + str_rel18 + " " + str_rel19
        replace rel_matrix = stritrim(rel_matrix)
        replace rel_matrix = strtrim(rel_matrix)
        label var rel_matrix "Relationship roster based on family matrix: Relationships of family members to head/RP in the same family-year based on family matrix"

        drop str_rel*
    
    /* 07. Remake ages roster */

      g age_matrix = ""
        forvalues i = 1/19{
            g str_age`i' = string(age_y`i')
        }
        forvalues i = 1/19{
            replace str_age`i' = "" if relationship_x_y`i' == 10
        }
        forvalues i = 1/19{
            replace str_age`i' = "" if str_age`i' == "."
        }

        replace age_matrix = str_age1 + " " + str_age2 + " " + str_age3 + " " + str_age4 + " " + str_age5 + " " + str_age6 + " " + str_age7 + " " + str_age8 + " " + str_age9 + " " + str_age10 + " " + str_age11 + " " + str_age12 + " " + str_age13 + " " + str_age14 + " " + str_age15 + " " + str_age16 + " " + str_age17 + " " + str_age18 + " " + str_age19
        replace age_matrix = stritrim(age_matrix)
        replace age_matrix = strtrim(age_matrix)
        label var age_matrix "Age roster based on family matrix: Ages of family members in the same family-year based on family matrix"

        drop str_age*

    /* 07 Clean up, clean up */
        keep fam ID year fam_id_ age_ hhr_matrix rel_matrix age_matrix hhr_no_self ages_no_self rel_no_self sib_list par_list gpar_list sample_indiv_N sample_indiv_A sample_indiv_B why_left_survey year_left_survey 
        order fam ID year fam_id_ age_ hhr_matrix rel_matrix age_matrix hhr_no_self ages_no_self rel_no_self sib_list par_list gpar_list sample_indiv_N sample_indiv_A sample_indiv_B why_left_survey year_left_survey 

    /* 08. Five strange observations */
        replace hhr_matrix = hhr_no_self if ID == 1290003 & year == 1969
        replace hhr_matrix = hhr_no_self if ID == 1290004 & year == 1969
            * 1290003 and 1290004 are siblings. ("relationship"=40)
            replace rel_matrix = "30 30 40" if ID == 1290003 & year == 1969
            replace rel_matrix = "30 30 40" if ID == 1290004 & year == 1969
            replace age_matrix = "49 41 16" if ID == 1290003 & year == 1969
            replace age_matrix = "49 41 18" if ID == 1290004 & year == 1969

        replace hhr_matrix = hhr_no_self if ID == 2411033 & year == 2009
        replace hhr_matrix = hhr_no_self if ID == 2411034 & year == 2009
        replace hhr_matrix = hhr_no_self if ID == 2411174 & year == 2009

            * based on relationship in past years
            replace rel_matrix = "30 72 40 40 30" if ID == 2411033 & year == 2009
            replace age_matrix = "40 1 20 16 44" if ID == 2411033 & year == 2009

            * based on relationship in past years
            replace rel_matrix = "30 40 72 40 35" if ID == 2411174 & year == 2009
            replace age_matrix = "40 8 1 20 44" if ID == 2411174 & year == 2009
            
            * based on recontruction
            replace rel_matrix = "60 70 30 70 61" if ID == 2411034 & year == 2009
            replace age_matrix = "40 8 20 16 44" if ID == 2411034 & year == 2009    

    /* 09. Save */
        keep fam ID year fam_id_ age_ hhr_matrix rel_matrix age_matrix hhr_no_self ages_no_self rel_no_self sib_list par_list gpar_list sample_indiv_N sample_indiv_A sample_indiv_B why_left_survey year_left_survey
        save "$output/_psid_long_matrix.dta", replace
    

}


/* ------------------------------------- */
* PART IIB: RUN _PSID_LONG_MATRIX.DTA 
* THROUGH 
* _HHR.IPYNB TO IDENTIFY HHR CHANGES
/* ------------------------------------- */


/* ------------------------------------- */
* PART III: merge together data from each survey 
* wave
/* ------------------------------------- */

if `part3' == 1{

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
* PART IV: Merge three datasets: 
* 1. Long data: _psid_long.dta
* 2. Long data with hhr changes: _hhr.csv
* 3. Long data of heads: _heads_panel.dta
/* ------------------------------------- */

if `part4' == 1{
    /* 01. Load _hhr.csv */
        import delimited "$output/_hhr.csv", clear
        
        drop is_first is_last
        local truefalse adult_came child_came adult_left child_left parent_came parent_left nonbio_parent_came nonbio_parent_left bio_parent_came bio_parent_left step_parent_came step_parent_left social_parent_came social_parent_left in_law_parent_came in_law_parent_left foster_parent_came foster_parent_left social_in_law_parent_came social_in_law_parent_left any_gpar_ggpar_came any_gpar_ggpar_left any_gpar_came any_gpar_left any_ggpar_came any_ggpar_left bio_grandparent_came bio_grandparent_left step_grandparent_came step_grandparent_left in_law_grandparent_came in_law_grandparent_left social_grandparent_came social_grandparent_left bio_greatgrandparent_came bio_greatgrandparent_left step_greatgrandparent_came step_greatgrandparent_left inlaw_greatgrandparent_came inlaw_greatgrandparent_left social_greatgrandparent_came social_greatgrandparent_left any_auntuncle_came any_auntuncle_left bio_auntuncle_came bio_auntuncle_left marriage_auntuncle_came marriage_auntuncle_left social_auntuncle_came social_auntuncle_left any_sibling_came any_sibling_left bio_sibling_came bio_sibling_left step_sibling_came step_sibling_left social_sibling_came social_sibling_left in_law_sibling_came in_law_sibling_left social_in_law_sibling_came social_in_law_sibling_left any_cousin_came any_cousin_left cousin_came cousin_left marriage_cousin_came marriage_cousin_left social_cousin_came social_cousin_left any_nephniece_came any_nephniece_left bio_nephniece_came bio_nephniece_left marriage_nephniece_came marriage_nephniece_left social_nephniece_came social_nephniece_left any_ownchild_came any_ownchild_left bio_child_came bio_child_left step_child_came step_child_left social_child_came social_child_left foster_child_came foster_child_left in_law_child_came in_law_child_left social_in_law_child_came social_in_law_child_left any_grandchild_came any_grandchild_left any_greatgrandchild_came any_greatgrandchild_left any_ggchild_came any_ggchild_left bio_grandchild_came bio_grandchild_left step_grandchild_came step_grandchild_left inlaw_grandchild_came inlaw_grandchild_left social_grandchild_came social_grandchild_left bio_greatgrandchild_came bio_greatgrandchild_left step_greatgrandchild_came step_greatgrandchild_left inlaw_greatgrandchild_came inlaw_greatgrandchild_left social_greatgrandchild_came social_greatgrandchild_left any_relativeother_came any_relativeother_left bio_relativeother_came bio_relativeother_left marriage_relativeother_came marriage_relativeother_left social_relativeother_came social_relativeother_left nonrelative_came nonrelative_left spouse_partner_came spouse_partner_left spouse_came spouse_left partner_came partner_left adult_came2 adult_left2 nonsib_adult_came nonsib_adult_left genabove_adult_came genabove_adult_left genabove2_adult_came genabove2_adult_left parent_adult_came parent_adult_left grandparent_adult_came grandparent_adult_left grandgrandparent_adult_came grandgrandparent_adult_left auntuncle_adult_came auntuncle_adult_left sibling_adult_came sibling_adult_left cousin_adult_came cousin_adult_left niece_neph_adult_came niece_neph_adult_left any_ownchild_adult_came any_ownchild_adult_left any_ggchild_adult_came any_ggchild_adult_left unknown_rel_came unknown_rel_left unknown_adult_came unknown_adult_left foster_other_came foster_other_left nonrelative_adult_came nonrelative_adult_left  any_relativeother_adult_came any_relativeother_adult_left spousepartner_adult_came spousepartner_adult_left 
        foreach var of local truefalse {
            cap g `var'1 = 1 if `var' == "True"
            cap replace `var'1 = 0 if `var' == "False"
            cap drop `var'
            cap rename `var'1 `var'
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
        order fam year fam_id_ ID indiv_weight_
        drop analytic_sample_indiv analytic_sample_family 
        label var indiv_weight_ "Individual weight"
        label var fam "1968 Family ID"
        label var ID "Individual ID"
        label var year "Year"
        label var age_ "Age of Individual"
        label var fam_id_ "Family ID in Year"
        label var hhr_matrix "Household roster"
        label var rel_matrix "Relationship roster"
        label var age_matrix "Age roster"
        label var hhr "Household roster, quotes"
        label var rel "Relationship roster, quotes"
        label var ages "Age roster, quotes"
        label var why_left_survey "Why attrited"
        label var year_left_survey "Year attrited"
        label var hhr_prev "Previous household roster"
        label var rel_prev "Previous relationship roster"
        label var ages_prev "Previous age roster"
        label var ids_left "IDs of household members who left"
        label var ids_came "IDs of household members who came"
        label var ages_left "Ages of hoysehold members who left"
        label var ages_came "Ages of household members who came"
        label var rel_left "Relationships of household members who left"
        label var rel_came "Relationships of household members who came"
        label var rel_left_desc "Relationships of household members who left, descriptions"
        label var rel_came_desc "Relationships of household members who came, descriptions"
        label var adult_came "Adult entered household"
        label var child_came "Child entered household"
        label var adult_left "Adult left household"
        label var child_left "Child left household"
        cap label var unknown_age_came "Unknown age entered household"
        cap label var unknown_age_left "Unknown age left household"
        label var parent_came "Parent entered household"
        label var parent_left "Parent left household"
        label var nonbio_parent_came "Non-biological parent entered household"
        label var nonbio_parent_left "Non-biological parent left household"
        label var bio_parent_came "Biological parent entered household"
        label var bio_parent_left "Biological parent left household"
        label var step_parent_came "Step-parent entered household"
        label var step_parent_left "Step-parent left household"
        label var social_parent_came "Social parent entered household"
        label var social_parent_left "Social parent left household"
        label var in_law_parent_came "Parent-in-law entered household"
        label var in_law_parent_left "Parent-in-law left household"
        label var foster_parent_came "Foster parent entered household"
        label var foster_parent_left "Foster parent left household"
        label var social_in_law_parent_came "Social parent-in-law entered household"
        label var social_in_law_parent_left "Social parent-in-law left household"
        label var any_gpar_ggpar_came "Any grandparent or great-grandparent entered household"
        label var any_gpar_ggpar_left "Any grandparent or great-grandparent left household"
        label var any_gpar_came "Any grandparent entered household"
        label var any_gpar_left "Any grandparent left household"
        label var any_ggpar_came "Any great-grandparent entered household"
        label var any_ggpar_left "Any great-grandparent left household"
        label var bio_grandparent_came "Biological grandparent entered household"
        label var bio_grandparent_left "Biological grandparent left household"
        label var step_grandparent_came "Step-grandparent entered household"
        label var step_grandparent_left "Step-grandparent left household"
        label var in_law_grandparent_came "Grandparent-in-law entered household"
        label var in_law_grandparent_left "Grandparent-in-law left household"
        label var social_grandparent_came "Social grandparent entered household"
        label var social_grandparent_left "Social grandparent left household"
        label var bio_greatgrandparent_came "Biological great-grandparent entered household"
        label var bio_greatgrandparent_left "Biological great-grandparent left household"
        label var step_greatgrandparent_came "Step-great-grandparent entered household"
        label var step_greatgrandparent_left "Step-great-grandparent left household"
        label var inlaw_greatgrandparent_came "Great-grandparent-in-law entered household"
        label var inlaw_greatgrandparent_left "Great-grandparent-in-law left household"
        label var social_greatgrandparent_came "Social great-grandparent entered household"
        label var social_greatgrandparent_left "Social great-grandparent left household"
        label var any_auntuncle_came "Any Aunt/uncle entered household"
        label var any_auntuncle_left "Any Aunt/uncle left household"
        label var bio_auntuncle_came "Biological aunt/uncle entered household"
        label var bio_auntuncle_left "Biological aunt/uncle left household"
        label var marriage_auntuncle_came "Marriage aunt/uncle entered household"
        label var marriage_auntuncle_left "Marriage aunt/uncle left household"
        label var social_auntuncle_came "Social aunt/uncle entered household"
        label var social_auntuncle_left "Social aunt/uncle left household"
        label var any_sibling_came "Any sibling entered household"
        label var any_sibling_left "Any sibling left household"
        label var bio_sibling_came "Biological sibling entered household"
        label var bio_sibling_left "Biological sibling left household"
        label var step_sibling_came "Step-sibling entered household"
        label var step_sibling_left "Step-sibling left household"
        label var social_sibling_came "Social sibling entered household"
        label var social_sibling_left "Social sibling left household"
        label var in_law_sibling_came "Sibling-in-law entered household"
        label var in_law_sibling_left "Sibling-in-law left household"
        label var social_in_law_sibling_came "Social sibling-in-law entered household"
        label var social_in_law_sibling_left "Social sibling-in-law left household"
        label var any_cousin_came "Any cousin entered household"
        label var any_cousin_left "Any cousin left household"
        rename cousin_came bio_cousin_came
        label var bio_cousin_came "Biological cousin entered household"
        rename cousin_left bio_cousin_left
        label var bio_cousin_left "Biological cousin left household"
        label var marriage_cousin_came "Marriage cousin entered household"
        label var marriage_cousin_left "Marriage cousin left household"
        label var social_cousin_came "Social cousin entered household"
        label var social_cousin_left "Social cousin left household"
        label var any_nephniece_came "Any nephew/niece entered household"
        label var any_nephniece_left "Any nephew/niece left household"
        label var bio_nephniece_came "Biological nephew/niece entered household"
        label var bio_nephniece_left "Biological nephew/niece left household"
        label var marriage_nephniece_came "Marriage nephew/niece entered household"
        label var marriage_nephniece_left "Marriage nephew/niece left household"
        label var social_nephniece_came "Social nephew/niece entered household"
        label var social_nephniece_left "Social nephew/niece left household"
        label var any_ownchild_came "Any own child entered household"
        label var any_ownchild_left "Any own child left household"
        label var bio_child_came "Biological child entered household"
        label var bio_child_left "Biological child left household"
        label var step_child_came "Step-child entered household"
        label var step_child_left "Step-child left household"
        label var social_child_came "Social child entered household"
        label var social_child_left "Social child left household"
        label var foster_child_came "Foster child entered household"
        label var foster_child_left "Foster child left household"
        label var in_law_child_came "Child-in-law entered household"
        label var in_law_child_left "Child-in-law left household"
        label var social_in_law_child_came "Social child-in-law entered household"
        label var social_in_law_child_left "Social child-in-law left household"
        label var any_grandchild_came "Any grandchild entered household"
        label var any_grandchild_left "Any grandchild left household"
        label var any_greatgrandchild_came "Any great-grandchild entered household"
        label var any_greatgrandchild_left "Any great-grandchild left household"
        label var any_ggchild_came "Any great-grandchild entered household"
        label var any_ggchild_left "Any great-grandchild left household"
        label var bio_grandchild_came "Biological grandchild entered household"
        label var bio_grandchild_left "Biological grandchild left household"
        label var step_grandchild_came "Step-grandchild entered household"
        label var step_grandchild_left "Step-grandchild left household"
        label var inlaw_grandchild_came "Grandchild-in-law entered household"
        label var inlaw_grandchild_left "Grandchild-in-law left household"
        label var social_grandchild_came "Social grandchild entered household"
        label var social_grandchild_left "Social grandchild left household"
        label var bio_greatgrandchild_came "Bio great-grandchild entered household"
        label var bio_greatgrandchild_left "Bio great-grandchild left household"
        label var step_greatgrandchild_came "Step great-grandchild entered household"
        label var step_greatgrandchild_left "Step great-grandchild left household"
        label var inlaw_greatgrandchild_came "Great-grandchild-in-law entered household"
        label var inlaw_greatgrandchild_left "Great-grandchild-in-law left household"
        label var social_greatgrandchild_came "Social great-grandchild entered household"
        label var social_greatgrandchild_left "Social great-grandchild left household"
        label var foster_other_came "Foster other entered household"
        label var foster_other_left "Foster other left household"
        label var any_relativeother_came "Any other relative entered household"
        label var any_relativeother_left "Any other relative left household"
        label var bio_relativeother_came "Biological other relative entered household"
        label var bio_relativeother_left "Biological other relative left household"
        label var marriage_relativeother_came "Marriage other relative entered household"
        label var marriage_relativeother_left "Marriage other relative left household"
        label var social_relativeother_came "Social other relative entered household"
        label var social_relativeother_left "Social other relative left household"
        label var nonrelative_came "Non-relative entered household"
        label var nonrelative_left "Non-relative left household"
        label var spouse_partner_came "Spouse/partner entered household"
        label var spouse_partner_left "Spouse/partner left household"
        label var spouse_came "Spouse entered household"
        label var spouse_left "Spouse left household"
        label var partner_came "Partner entered household"
        label var partner_left "Partner left household"
        label var age_first_observed "Age first observed"
        label var sex "Sex"
        label var in_ "Observed in year"
        label var head_rel_ "Relationship to head/RP in year"
        label var og_1968_family "Original 1968 family"
        label var imm_latino_family "Immigrant/Latino family in 1968"
        label var fam_sample "Sample"
        label var waves "Waves observed"
        label var waves_17_under "Waves observed under age 17"
        label var waves_skipadjusted "Waves observed, skip adjusted"
        label var waves_17_skipadjusted "Waves observed under age 17, skip adjusted"
        label var sample_indiv_N "Individual in Sample N"
        label var sample_family_N "Family in Sample N"
        label var sample_indiv_A "Individual in Sample A"
        label var sample_family_A "Family in Sample A"
        label var sample_indiv_B "Individual in Sample B"
        label var sample_family_B "Family in Sample B"

        label var head_age "Age of Reference Person"
        label var head_sex "Sex of Reference Person"
        label var head_marital "Marital status of Reference Person"
        label var head_race "Race of Reference Person"
        *label var resp_to_head_rel "Relationship of respondent to head"
        label var head_yrs_school "Years of Schooling of Reference Person"
        label var head_education "Education of Reference Person - Buckets"
        label var nonsib_adult_came "Non-sibling adult entered household"
        label var nonsib_adult_left "Non-sibling adult left household"
        label var genabove_adult_came "Generation above adult entered household"
        label var genabove_adult_left "Generation above adult left household"
        label var genabove2_adult_came "Generation above LEAN adult entered household"
        label var genabove2_adult_left "Generation above LEAN adult left household"
        label var unknown_rel_came "Unknown relationship entered household"
        label var unknown_rel_left "Unknown relationship left household"


        drop _merge resp_to_head_rel ages_hhr rel_hhr
        drop sib_list par_list gpar_list siblings parents grandparents why_nonresponse_ lastobs



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

    /* 08. Parent race vs. other RP race */
        g parent_self_race = rp_race if who_is_rp_A == "Parent" | who_is_rp_A == "Self"
        label var parent_self_race "RP Race is Race of Self or Parent"

        g relative_race = rp_race if who_is_rp_C == "Relative" | who_is_rp_A == "Self"
        label var relative_race "RP Race is Race of Biological Relative or Self"

    /* 09. Clean up */
        decode sex, g(sex1)
        drop sex
        rename sex1 sex
        replace og_1968_family = 0 if og_1968_family == . 
        replace imm_latino_family = 0 if imm_latino_family == .

    /* 10. Birth year 
        Because no one is age "0" in the PSID, birth year can be 
        as early as 1967. */

    /* HERE'S WHERE I WILL FIX. QUICK FIX FOR NOW */
        g birth_year = year - age_
        egen max_birth_year = max(birth_year), by(ID)
        replace birth_year = max_birth_year
        replace birth_year = 2007 if birth_year > 2007 & sample_indiv_A == 1
        drop max_birth_year


        label var birth_year "Birth Year of Individual"

    /* 11. Birth Cohort - A */
        g birth_cohort_A = "pre-1955" if birth_year < 1955
        replace birth_cohort_A = "1955-1964" if birth_year >= 1955 & birth_year < 1965
        replace birth_cohort_A = "1965-1974" if birth_year >= 1965 & birth_year < 1975
        replace birth_cohort_A = "1975-1984" if birth_year >= 1975 & birth_year < 1985
        replace birth_cohort_A = "1985-1994" if birth_year >= 1985 & birth_year < 1995
        replace birth_cohort_A = "1995-2004" if birth_year >= 1995 & birth_year < 2005
        replace birth_cohort_A = "2005-2014" if birth_year >= 2005 & birth_year < 2015
        replace birth_cohort_A = "2015-" if birth_year >= 2015
        label var birth_cohort_A "Birth Cohort of Individual A"

    /* 12. Birth Cohort - B */
        g birth_cohort_B = "pre-1966" if birth_year < 1967
        replace birth_cohort_B = "1967-1976" if birth_year >= 1967 & birth_year < 1977
        replace birth_cohort_B = "1977-1986" if birth_year >= 1977 & birth_year < 1987
        replace birth_cohort_B = "1987-1996" if birth_year >= 1987 & birth_year < 1997
        replace birth_cohort_B = "1997-2006" if birth_year >= 1997 & birth_year < 2007
        replace birth_cohort_B = "2007-2016" if birth_year >= 2007 & birth_year < 2017
        replace birth_cohort_B = "2017-" if birth_year >= 2017
        label var birth_cohort_B "Birth Cohort of Individual B"

    /* 12. Save */
        sort ID year
        save "$output/_psid_analytic_sample.dta", replace

}

/* ------------------------------------- */
* PART VI: Tables
/* ------------------------------------- */

if `part6' == 1{

    /* 01. Weights */
        use "$output/_psid_analytic_sample.dta", clear

        replace indiv_weight_ = . if indiv_weight_ == 0
        g strindiv_weight_ = string(indiv_weight_)
        replace strindiv_weight_ = "" if strindiv_weight_ == "."


    /* 02. Define vars for collapse */
        * Unused variables: 
            * age_first_observed better captured by min(age_), no?
            * head_rel_ given by who_is_rp...; head_race is encoded in rp_race
            local notusedstring hhr_matrix rel_matrix age_matrix hhr ages rel ids_left ids_came ages_left ages_came rel_left rel_came rel_left_desc rel_came_desc parent_self_race relative_race  hhr_prev rel_prev ages_prev
            local notusednum fam_id_ age_first_observed in_  head_rel_ head_race

        * Numeric variables
            * use mean for number variables that should be constant within person over time.
            local maxvars cluster_ind2023 strata_ind2023 birth_year fam adult_came child_came adult_left adult_came2 adult_left2 child_left parent_came parent_left nonbio_parent_came nonbio_parent_left bio_parent_came bio_parent_left step_parent_came step_parent_left social_parent_came social_parent_left in_law_parent_came in_law_parent_left foster_parent_came foster_parent_left social_in_law_parent_came social_in_law_parent_left any_gpar_ggpar_came any_gpar_ggpar_left any_gpar_came any_gpar_left any_ggpar_came any_ggpar_left bio_grandparent_came bio_grandparent_left step_grandparent_came step_grandparent_left in_law_grandparent_came in_law_grandparent_left social_grandparent_came social_grandparent_left bio_greatgrandparent_came bio_greatgrandparent_left step_greatgrandparent_came step_greatgrandparent_left inlaw_greatgrandparent_came inlaw_greatgrandparent_left social_greatgrandparent_came social_greatgrandparent_left any_auntuncle_came any_auntuncle_left bio_auntuncle_came bio_auntuncle_left marriage_auntuncle_came marriage_auntuncle_left social_auntuncle_came social_auntuncle_left any_sibling_came any_sibling_left bio_sibling_came bio_sibling_left step_sibling_came step_sibling_left social_sibling_came social_sibling_left in_law_sibling_came in_law_sibling_left social_in_law_sibling_came social_in_law_sibling_left any_cousin_came any_cousin_left bio_cousin_came bio_cousin_left marriage_cousin_came marriage_cousin_left social_cousin_came social_cousin_left any_nephniece_came any_nephniece_left bio_nephniece_came bio_nephniece_left marriage_nephniece_came marriage_nephniece_left social_nephniece_came social_nephniece_left any_ownchild_came any_ownchild_left bio_child_came bio_child_left step_child_came step_child_left social_child_came social_child_left foster_child_came foster_child_left in_law_child_came in_law_child_left social_in_law_child_came social_in_law_child_left any_grandchild_came any_grandchild_left any_greatgrandchild_came any_greatgrandchild_left any_ggchild_came any_ggchild_left bio_grandchild_came bio_grandchild_left step_grandchild_came step_grandchild_left inlaw_grandchild_came inlaw_grandchild_left social_grandchild_came social_grandchild_left bio_greatgrandchild_came bio_greatgrandchild_left step_greatgrandchild_came step_greatgrandchild_left inlaw_greatgrandchild_came inlaw_greatgrandchild_left social_greatgrandchild_came social_greatgrandchild_left foster_other_came foster_other_left any_relativeother_came any_relativeother_left bio_relativeother_came bio_relativeother_left marriage_relativeother_came marriage_relativeother_left social_relativeother_came social_relativeother_left nonrelative_came nonrelative_left spouse_partner_came spouse_partner_left spouse_came spouse_left partner_came partner_left nonsib_adult_came nonsib_adult_left genabove_adult_came genabove_adult_left genabove2_adult_came genabove2_adult_left unknown_rel_came unknown_rel_left parent_adult_came parent_adult_left grandparent_adult_came grandparent_adult_left grandgrandparent_adult_came grandgrandparent_adult_left auntuncle_adult_came auntuncle_adult_left sibling_adult_came sibling_adult_left cousin_adult_came cousin_adult_left niece_neph_adult_came niece_neph_adult_left unknown_adult_came unknown_adult_left nonrelative_adult_came nonrelative_adult_left spousepartner_adult_came spousepartner_adult_left 
            local minvars year age_
            local mean indiv_weight_ why_left_survey year_left_survey waves og_1968_family imm_latino_family waves_17_under waves_skipadjusted waves_17_skipadjusted sample_indiv_N sample_family_N sample_indiv_A sample_family_A sample_indiv_B sample_family_B 

        * Strings
            * currently reporting reference person ed and race at child's first observation --> therefore, reporting who is reference person at first observation as well 
            local firstnm fam_sample rp_education_A rp_education_B rp_race who_is_rp_A who_is_rp_B who_is_rp_C birth_cohort_A birth_cohort_B
            * since it's longitudinal data, we use most recent survey weight (captures attrition up to age 17)
            local lastnm sex strindiv_weight_

    /* 03. Collapse */
        sort ID year
        collapse (max) `maxvars' (min) `minvars' (first) `firstnm' (last) `lastnm' (mean) `mean', by(ID)

    /* 04. svyset */
        destring(strindiv_weight_), replace
        replace strindiv_weight_ = 0 if strindiv_weight == .
        svyset cluster_ind2023 [pweight=strindiv_weight_], strata(strata_ind2023)

    /* 05. Clean up */
        rename year year_first_observed
        rename age_ age_first_observed

        replace sex = "Unknown" if sex == "NA"

        label define sexlabel 1 "Male" 2 "Female" 3 "Unknown"
        encode sex, g(sex1) label(sexlabel)

        label define racelabel 1 "White" 2 "Black" 3 "Hispanic" 4 "Other" 5 "Unknown"
        encode rp_race, g(rp_race1) label(racelabel)

        label define educationlabel 1 "No College Degree" 2 "College Degree or More" 3 "Unknown"
        encode rp_education_B, g(rp_education_B1) label(educationlabel)

        label define birthcohortAlabel 1 "pre-1955" 2 "1955-1964" 3 "1965-1974" 4 "1975-1984" 5 "1985-1994" 6 "1995-2004" 7 "2005-2014" 8 "2015-", replace
        encode birth_cohort_A, g(birth_cohort_A1) label(birthcohortAlabel)

        label define birthcohortBlabel 1 "pre-1966" 2 "1967-1976" 3 "1977-1986" 4 "1987-1996" 5 "1997-2006" 6 "2007-2016" 7 "2017-", replace
        encode birth_cohort_B, g(birth_cohort_B1) label(birthcohortBlabel)

        label var sex1 "Sex"
        label var rp_race1 "Race of Reference Person"
        label var rp_education_B1 "Education of Reference Person"
        label var birth_cohort_A1 "Birth Cohort A"
        label var birth_cohort_B1 "Birth Cohort B"
        label var birth_year "Birth Year"

        g adult_change = adult_came + adult_left
        g genabove_adult_change = genabove_adult_came + genabove_adult_left
        g genabove2_adult_change = genabove2_adult_came + genabove2_adult_left
        g parent_adult_change = parent_adult_came + parent_adult_left
        g grandparent_adult_change = grandparent_adult_came + grandparent_adult_left
        g grandgrandparent_adult_change = grandgrandparent_adult_came + grandgrandparent_adult_left
        g auntuncle_adult_change = auntuncle_adult_came + auntuncle_adult_left
        g sibling_adult_change = sibling_adult_came + sibling_adult_left
        g cousin_adult_change = cousin_adult_came + cousin_adult_left
        g niece_neph_adult_change = niece_neph_adult_came + niece_neph_adult_left
        g nonrelative_adult_change = nonrelative_adult_came + nonrelative_adult_left
        g spousepartner_adult_change = spousepartner_adult_came + spousepartner_adult_left
        g unknown_adult_change = unknown_adult_came + unknown_adult_left
        g any_relativeother_adult_change = any_relativeother_came + any_relativeother_left

        replace adult_change = 1 if adult_change == 2
        replace genabove_adult_change = 1 if genabove_adult_change == 2
        replace genabove2_adult_change = 1 if genabove2_adult_change == 2
        replace parent_adult_change = 1 if parent_adult_change == 2
        replace grandparent_adult_change = 1 if grandparent_adult_change == 2
        replace grandgrandparent_adult_change = 1 if grandgrandparent_adult_change == 2
        replace auntuncle_adult_change = 1 if auntuncle_adult_change == 2
        replace sibling_adult_change = 1 if sibling_adult_change == 2
        replace cousin_adult_change = 1 if cousin_adult_change == 2
        replace niece_neph_adult_change = 1 if niece_neph_adult_change == 2
        replace nonrelative_adult_change = 1 if nonrelative_adult_change == 2
        replace spousepartner_adult_change = 1 if spousepartner_adult_change == 2
        replace unknown_adult_change = 1 if unknown_adult_change == 2
        replace any_relativeother_adult_change = 1 if any_relativeother_adult_change == 2


    /* TI. Table 1: Sample Stats */

        /* Ia. Sample A Weighted */
        svy, subpop(if sample_indiv_A == 1): tab sex1
        svy, subpop(if sample_indiv_A == 1): tab rp_race1
        svy, subpop(if sample_indiv_A == 1): tab rp_education_B1
        svy, subpop(if sample_indiv_A == 1): mean birth_year
        svy, subpop(if sample_indiv_A == 1): tab birth_cohort_B1

        /* Ib. Sample A Unweighted */
        tab sex1 if sample_indiv_A == 1
        tab rp_race1 if sample_indiv_A == 1
        tab rp_education_B1 if sample_indiv_A == 1
        mean birth_year if sample_indiv_A == 1
        tab birth_cohort_B1 if sample_indiv_A == 1

        /* Ic. Sample B Weighted */
        svy, subpop(if sample_indiv_B == 1): tab sex1
        svy, subpop(if sample_indiv_B == 1): tab rp_race1
        svy, subpop(if sample_indiv_B == 1): tab rp_education_B1
        svy, subpop(if sample_indiv_B == 1): mean birth_year
        svy, subpop(if sample_indiv_B == 1): tab birth_cohort_B1

        /* Id. Sample B Unweighted */
        tab sex1 if sample_indiv_B == 1
        tab rp_race1 if sample_indiv_B == 1
        tab rp_education_B1 if sample_indiv_B == 1
        mean birth_year if sample_indiv_B == 1
        tab birth_cohort_B1 if sample_indiv_B == 1

        /* Ie. Sample N Weighted*/
        svy, subpop(if sample_indiv_N == 1): tab sex1
        svy, subpop(if sample_indiv_N == 1): tab rp_race1
        svy, subpop(if sample_indiv_N == 1): tab rp_education_B1
        svy, subpop(if sample_indiv_N == 1): mean birth_year
        svy, subpop(if sample_indiv_N == 1): tab birth_cohort_B1

        /* If. Sample N Unweighted */
        tab sex1 if sample_indiv_N == 1
        tab rp_race1 if sample_indiv_N == 1
        tab rp_education_B1 if sample_indiv_N == 1
        mean birth_year if sample_indiv_N == 1
        tab birth_cohort_B1 if sample_indiv_N == 1

    /* TII. Table 2: Adult ins, outs, changes */

        /* IIa. Adult in: unweighted, sample A */
            tab adult_came if sample_indiv_A == 1
            tab genabove_adult_came if sample_indiv_A == 1
            tab genabove2_adult_came if sample_indiv_A == 1
            tab parent_adult_came if sample_indiv_A == 1
            tab grandparent_adult_came if sample_indiv_A == 1
            tab grandgrandparent_adult_came if sample_indiv_A == 1
            tab auntuncle_adult_came if sample_indiv_A == 1
            tab sibling_adult_came if sample_indiv_A == 1
            tab cousin_adult_came if sample_indiv_A == 1
            tab niece_neph_adult_came if sample_indiv_A == 1
            tab unknown_adult_came if sample_indiv_A == 1
            tab nonrelative_adult_came if sample_indiv_A == 1
            tab spousepartner_adult_came if sample_indiv_A == 1
            tab any_relativeother_came if sample_indiv_A == 1

        /* IIb. Adult in: unweighted, sample B */
            tab adult_came if sample_indiv_B == 1
            tab genabove_adult_came if sample_indiv_B == 1
            tab genabove2_adult_came if sample_indiv_B == 1
            tab parent_adult_came if sample_indiv_B == 1
            tab grandparent_adult_came if sample_indiv_B == 1
            tab grandgrandparent_adult_came if sample_indiv_B == 1
            tab auntuncle_adult_came if sample_indiv_B == 1
            tab sibling_adult_came if sample_indiv_B == 1
            tab cousin_adult_came if sample_indiv_B == 1
            tab niece_neph_adult_came if sample_indiv_B == 1
            tab unknown_adult_came if sample_indiv_B == 1
            tab nonrelative_adult_came if sample_indiv_B == 1
            tab spousepartner_adult_came if sample_indiv_B == 1
            tab any_relativeother_came if sample_indiv_B == 1

        /* IIc. Adult in: Weighted, sample A */
            svy, subpop(if sample_indiv_A == 1): tab adult_came 
            svy, subpop(if sample_indiv_A == 1): tab genabove_adult_came
            svy, subpop(if sample_indiv_A == 1): tab genabove2_adult_came
            svy, subpop(if sample_indiv_A == 1): tab parent_adult_came 
            svy, subpop(if sample_indiv_A == 1): tab parent_adult_came 
            svy, subpop(if sample_indiv_A == 1): tab grandparent_adult_came 
            svy, subpop(if sample_indiv_A == 1): tab grandgrandparent_adult_came
            svy, subpop(if sample_indiv_A == 1): tab auntuncle_adult_came 
            svy, subpop(if sample_indiv_A == 1): tab sibling_adult_came
            svy, subpop(if sample_indiv_A == 1): tab cousin_adult_came
            svy, subpop(if sample_indiv_A == 1): tab niece_neph_adult_came
            svy, subpop(if sample_indiv_A == 1): tab unknown_adult_came
            svy, subpop(if sample_indiv_A == 1): tab nonrelative_adult_came
            svy, subpop(if sample_indiv_A == 1): tab spousepartner_adult_came
            svy, subpop(if sample_indiv_A == 1): tab any_relativeother_came

        /* IId. Adult in: Weighted, sample B */
            svy, subpop(if sample_indiv_B == 1): tab adult_came 
            svy, subpop(if sample_indiv_B == 1): tab genabove_adult_came
            svy, subpop(if sample_indiv_B == 1): tab genabove2_adult_came
            svy, subpop(if sample_indiv_B == 1): tab parent_adult_came 
            svy, subpop(if sample_indiv_B == 1): tab parent_adult_came 
            svy, subpop(if sample_indiv_B == 1): tab grandparent_adult_came 
            svy, subpop(if sample_indiv_B == 1): tab grandgrandparent_adult_came
            svy, subpop(if sample_indiv_B == 1): tab auntuncle_adult_came 
            svy, subpop(if sample_indiv_B == 1): tab sibling_adult_came
            svy, subpop(if sample_indiv_B == 1): tab cousin_adult_came
            svy, subpop(if sample_indiv_B == 1): tab niece_neph_adult_came
            svy, subpop(if sample_indiv_B == 1): tab nonrelative_adult_came
            svy, subpop(if sample_indiv_B == 1): tab spousepartner_adult_came
            svy, subpop(if sample_indiv_B == 1): tab unknown_adult_came
            svy, subpop(if sample_indiv_B == 1): tab any_relativeother_came

        /* IIe. Adult out: Unweighted, sample A */
            tab adult_left if sample_indiv_A == 1
            tab genabove_adult_left if sample_indiv_A == 1
            tab genabove2_adult_left if sample_indiv_A == 1
            tab parent_adult_left if sample_indiv_A == 1
            tab grandparent_adult_left if sample_indiv_A == 1
            tab grandgrandparent_adult_left if sample_indiv_A == 1
            tab auntuncle_adult_left if sample_indiv_A == 1
            tab sibling_adult_left if sample_indiv_A == 1
            tab cousin_adult_left if sample_indiv_A == 1
            tab niece_neph_adult_left if sample_indiv_A == 1
            tab nonrelative_adult_left if sample_indiv_A == 1
            tab spousepartner_adult_left if sample_indiv_A == 1
            tab unknown_adult_left if sample_indiv_A == 1
            tab any_relativeother_left if sample_indiv_A == 1
    
        /* IIf. Adult out: Unweighted, sample B */
            tab adult_left if sample_indiv_B == 1
            tab genabove_adult_left if sample_indiv_B == 1
            tab genabove2_adult_left  if sample_indiv_B == 1
            tab parent_adult_left if sample_indiv_B == 1
            tab grandparent_adult_left if sample_indiv_B == 1
            tab grandgrandparent_adult_left if sample_indiv_B == 1
            tab auntuncle_adult_left if sample_indiv_B == 1
            tab sibling_adult_left if sample_indiv_B == 1
            tab cousin_adult_left if sample_indiv_B == 1
            tab niece_neph_adult_left if sample_indiv_B == 1
            tab nonrelative_adult_left if sample_indiv_B == 1
            tab spousepartner_adult_left if sample_indiv_B == 1
            tab unknown_adult_left if sample_indiv_B == 1
            tab any_relativeother_left if sample_indiv_B == 1

        
        /* IIg. Adult out: Weighted, sample A */
            svy, subpop(if sample_indiv_A == 1): tab adult_left
            svy, subpop(if sample_indiv_A == 1): tab genabove_adult_left
            svy, subpop(if sample_indiv_A == 1): tab genabove2_adult_left
            svy, subpop(if sample_indiv_A == 1): tab parent_adult_left 
            svy, subpop(if sample_indiv_A == 1): tab grandparent_adult_left 
            svy, subpop(if sample_indiv_A == 1): tab grandgrandparent_adult_left
            svy, subpop(if sample_indiv_A == 1): tab auntuncle_adult_left 
            svy, subpop(if sample_indiv_A == 1): tab sibling_adult_left
            svy, subpop(if sample_indiv_A == 1): tab cousin_adult_left
            svy, subpop(if sample_indiv_A == 1): tab niece_neph_adult_left
            svy, subpop(if sample_indiv_A == 1): tab nonrelative_adult_left
            svy, subpop(if sample_indiv_A == 1): tab spousepartner_adult_left
            svy, subpop(if sample_indiv_A == 1): tab unknown_adult_left
            svy, subpop(if sample_indiv_A == 1): tab any_relativeother_left
        
        /* IIh. Adult out: Weighted, sample B */
            svy, subpop(if sample_indiv_B == 1): tab adult_left 
            svy, subpop(if sample_indiv_B == 1): tab genabove_adult_left
            svy, subpop(if sample_indiv_B == 1): tab genabove2_adult_left
            svy, subpop(if sample_indiv_B == 1): tab parent_adult_left 
            svy, subpop(if sample_indiv_B == 1): tab grandparent_adult_left 
            svy, subpop(if sample_indiv_B == 1): tab grandgrandparent_adult_left
            svy, subpop(if sample_indiv_B == 1): tab auntuncle_adult_left 
            svy, subpop(if sample_indiv_B == 1): tab sibling_adult_left
            svy, subpop(if sample_indiv_B == 1): tab cousin_adult_left
            svy, subpop(if sample_indiv_B == 1): tab niece_neph_adult_left
            svy, subpop(if sample_indiv_B == 1): tab nonrelative_adult_left
            svy, subpop(if sample_indiv_B == 1): tab spousepartner_adult_left
            svy, subpop(if sample_indiv_B == 1): tab unknown_adult_left
            svy, subpop(if sample_indiv_B == 1): tab any_relativeother_left


        

        /* IIi. Adult change: Unweighted, sample A */
            tab adult_change if sample_indiv_A == 1
            tab genabove_adult_change if sample_indiv_A == 1
            tab genabove2_adult_change if sample_indiv_A == 1
            tab parent_adult_change if sample_indiv_A == 1
            tab grandparent_adult_change if sample_indiv_A == 1
            tab grandgrandparent_adult_change if sample_indiv_A == 1
            tab auntuncle_adult_change if sample_indiv_A == 1
            tab sibling_adult_change if sample_indiv_A == 1
            tab cousin_adult_change if sample_indiv_A == 1
            tab niece_neph_adult_change if sample_indiv_A == 1
            tab nonrelative_adult_change if sample_indiv_A == 1
            tab spousepartner_adult_change if sample_indiv_A == 1
            tab unknown_adult_change if sample_indiv_A == 1
            tab any_relativeother_adult_change if sample_indiv_A == 1

        /* IIj. Adult change: Unweighted, sample B */
            tab adult_change if sample_indiv_B == 1
            tab genabove_adult_change if sample_indiv_B == 1
            tab genabove2_adult_change if sample_indiv_B == 1
            tab parent_adult_change if sample_indiv_B == 1
            tab grandparent_adult_change if sample_indiv_B == 1
            tab grandgrandparent_adult_change if sample_indiv_B == 1
            tab auntuncle_adult_change if sample_indiv_B == 1
            tab sibling_adult_change if sample_indiv_B == 1
            tab cousin_adult_change if sample_indiv_B == 1
            tab niece_neph_adult_change if sample_indiv_B == 1
            tab nonrelative_adult_change if sample_indiv_B == 1
            tab spousepartner_adult_change if sample_indiv_B == 1
            tab unknown_adult_change if sample_indiv_B == 1
            tab any_relativeother_adult_change if sample_indiv_B == 1

        /* IIk. Adult change: Weighted, sample A */
            svy, subpop(if sample_indiv_A == 1): tab adult_change 
            svy, subpop(if sample_indiv_A == 1): tab genabove_adult_change 
            svy, subpop(if sample_indiv_A == 1): tab genabove2_adult_change 
            svy, subpop(if sample_indiv_A == 1): tab parent_adult_change 
            svy, subpop(if sample_indiv_A == 1): tab grandparent_adult_change 
            svy, subpop(if sample_indiv_A == 1): tab grandgrandparent_adult_change 
            svy, subpop(if sample_indiv_A == 1): tab auntuncle_adult_change 
            svy, subpop(if sample_indiv_A == 1): tab sibling_adult_change 
            svy, subpop(if sample_indiv_A == 1): tab cousin_adult_change 
            svy, subpop(if sample_indiv_A == 1): tab niece_neph_adult_change 
            svy, subpop(if sample_indiv_A == 1): tab unknown_adult_change 
            svy, subpop(if sample_indiv_A == 1): tab nonrelative_adult_change 
            svy, subpop(if sample_indiv_A == 1): tab spousepartner_adult_change 
            svy, subpop(if sample_indiv_A == 1): tab any_relativeother_adult_change 

        /* IIl. Adult change: Weighted, sample B */
            svy, subpop(if sample_indiv_B == 1): tab adult_change 
            svy, subpop(if sample_indiv_B == 1): tab genabove_adult_change 
            svy, subpop(if sample_indiv_B == 1): tab genabove2_adult_change 
            svy, subpop(if sample_indiv_B == 1): tab parent_adult_change 
            svy, subpop(if sample_indiv_B == 1): tab grandparent_adult_change 
            svy, subpop(if sample_indiv_B == 1): tab grandgrandparent_adult_change 
            svy, subpop(if sample_indiv_B == 1): tab auntuncle_adult_change 
            svy, subpop(if sample_indiv_B == 1): tab sibling_adult_change 
            svy, subpop(if sample_indiv_B == 1): tab cousin_adult_change 
            svy, subpop(if sample_indiv_B == 1): tab niece_neph_adult_change 
            svy, subpop(if sample_indiv_B == 1): tab nonrelative_adult_change 
            svy, subpop(if sample_indiv_B == 1): tab spousepartner_adult_change 
            svy, subpop(if sample_indiv_B == 1): tab unknown_adult_change 
            svy, subpop(if sample_indiv_B == 1): tab any_relativeother_adult_change 


    /* TIII. Table 3: Adult ins, outs, changes by birth cohort */
        /* IIIa. Adult in: Weighted, sample A by Cohort III
            svy, subpop(if sample_indiv_A == 1): tab adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab genabove_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab genabove2_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab parent_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab parent_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab grandparent_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab grandgrandparent_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab auntuncle_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab sibling_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab cousin_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab niece_neph_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab nonrelative_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab spousepartner_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab unknown_adult_came birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab any_relativeother_came birth_cohort_B

        /* IIIb. Adult out: Weighted, sample A by birth cIIIort*/
            svy, subpop(if sample_indiv_A == 1): tab adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab genabove_adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab genabove2_adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab parent_adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab grandparent_adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab grandgrandparent_adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab auntuncle_adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab sibling_adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab cousin_adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab niece_neph_adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab nonrelative_adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab spousepartner_adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab unknown_adult_left birth_cohort_B
            svy, subpop(if sample_indiv_A == 1): tab any_relativeother_left birth_cohort_B


}

