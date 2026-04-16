****************************
* Sarah Sullivan 
* September 18, 2025
* Last Updated: October 24, 2025
* 01_family_structure_v7
****************************
/* 
SOURCE: Fomby, Paula. 2024. The Panel Study of Income Dynamics Family Composition File User Guide:
Early Release. Data release <release number>, Ann Arbor, MI: Survey Research Center, Institute
for Social Research, University of Michigan. <Open ICPSR DOI>. 
This data set contains all individuals observed as children in the PSID between 1968 and 2021.
*/
************************************

/* 00. Program Set Up */
    clear all
    set more off
    cap log close

    set maxvar 32767

    cd "$root"

    local date = subinstr("`c(current_date)'", "/", "-", .)
    local time = subinstr("`c(current_time)'", ":", "-", .)
    local datetime = "`date'_`time'"
    log using "$root/_log/01_family_structure_v7_`datetime'.log", replace

local first 0 
/* A */
if `first' == 1{

    /* 01. Load in family composition data */
        cd "$root"
        use "198084-V2/famcomp6821.dta"

    /* 02. Generate Variables and observe */
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

        /* for fun */
        g Name = "Sarah" if ID == 1030 
        replace Name = "Jaxon" if ID == 4003
        order Name ID yr


        * Drop any kids who we only observe once, 2816 people (2816 observations)
        bysort ID: g wave_count =  _n
        egen max_wave = max(wave_count), by(ID)
        drop if max_wave == 1
        drop max_wave wave_count

        * Children's age at interview & birth year
        destring(FC8), replace
        rename FC8 Age
        label var Age "Age"

        g birth_year = yr-Age
        egen min_birth_year = min(birth_year), by(ID)  
        replace birth_year = min_birth_year
        drop min_birth_year
        label var birth_year "Individual Birth Year"


    /* 03. Population born between 1960 and 2007*/
        drop if birth_year < 1960 | birth_year > 2007
            * 50,261 obs dropped
            * N = 256,525
            * n = 21,344
        order ID yr Age

        * drop other DOB variables
        
        rename FC16 mom_marital_birth
        label var mom_marital_birth "Mom's Marital at ID's birth" 
            * constant within individual 

    /* 04. Drop sibling & other unused vars */
        drop FC12 FC14
        drop FC225 FC226 FC227 FC228 FC229 FC230 FC231 FC232 FC233 FC234 FC235 FC236 FC237 FC238 FC239 FC240 FC241 FC242 FC243 FC244 FC245 FC246 FC247 FC248 FC249 FC250 FC251 FC252 FC253 FC254 FC255 FC256 FC257 FC258 FC259 FC260 FC261 FC262 FC263 FC264 FC265 FC266 FC267 FC268 FC269 FC270 FC271 FC272 FC273 FC274 FC275 FC276 FC277 FC278 FC279 FC280 FC281 FC282 FC283 FC284 FC285 FC286 FC287 FC288 FC289 FC290 FC291 FC292 FC293 FC294 FC295 FC296 FC297 FC298 FC299 FC300 FC301 FC302 FC303 FC304 FC305 FC306 FC307 FC308 FC309 FC310 FC311 FC312 FC313 FC314 FC315 FC316 FC317 FC318 FC319 FC320 FC321 FC322 FC323 FC324 FC325 FC326 FC327 FC328 FC329 FC330 FC331 FC332 FC333 FC334 FC335 FC336 FC337 FC338 FC339 FC340 FC341 FC342 FC343 FC344 FC345 FC346 FC347 FC348 FC349 FC350 FC351 FC352 FC353 FC354 FC355 FC356 FC357 FC358 FC359 FC360 FC361 FC362 FC363 FC364 FC365 FC366 FC367 FC368 FC369 FC370 FC371 FC372 FC373 FC374 FC375 FC376 FC377 FC378 FC379 FC380 FC381 FC382 FC383 FC384 FC385 FC386 FC387 FC388 FC389 FC390 FC391 FC392 FC393 FC394 FC395 FC396 FC397 FC398 FC399 FC400 FC401 FC402 FC403 FC404 FC405 FC406 FC407 FC408 FC409 FC410 FC411 FC412 FC413 FC414 FC415 FC416 FC417 FC418 FC419 FC420 FC421 FC422 FC423 FC424 FC425 FC426 FC427 FC428 FC429 FC430 FC431 FC432 FC433 FC434 FC435 FC436 FC437 FC438 FC439 FC440 FC441 FC442 FC443 FC444 FC445 FC446 FC447 FC448 FC449 FC450 FC451 FC452 FC453 FC454 FC455 FC456 FC457 FC458 FC459 FC460 FC461 FC462 FC463 FC464 FC465 FC466 FC467 FC468 FC469 FC470 FC471 FC472 FC473 FC474 FC475 FC476 FC477 FC478 FC479 FC480 FC481 FC482 FC483 FC484 FC485 FC486 FC487 FC488 FC489 FC490 FC491 FC492 FC493 FC494 FC495 FC496 FC497 FC498 FC499 FC500 FC501 FC502 FC503 FC504 FC505 FC506 FC507 FC508 FC509 FC510 FC511 FC512 FC513 FC514 FC515 FC516 FC517 FC518 FC519 FC520 FC521 FC522 FC523 FC524 FC525 FC526 FC527 FC528 FC529 FC530 FC531 FC532 FC533 FC534 FC535 FC536 FC537 FC538 FC539 FC540 FC541 FC542 FC543 FC544 FC545 FC546 FC547 FC548 FC549 FC550 FC551 FC552 FC553 FC554 FC555 FC556 FC557 FC558 FC559 FC560 FC561 FC562 FC563 FC564 FC565 FC566 FC567 FC568 FC569 FC570 FC571 FC572 FC573 FC574 FC575 FC576 FC577 FC578 FC579 FC580 FC581 FC582 FC583 FC584 FC585 FC586 FC587 FC588 FC589 FC590 FC591 FC592 FC593 FC594 FC595 FC596 FC597 FC598 FC599 FC600 FC601 FC602 FC603 FC604 FC605 FC606 FC607 FC608 FC609 FC610 FC611 FC612 FC613 FC614 FC615 FC616 FC617 FC618 FC619 FC620 FC621 FC622 FC623 FC624 FC625 FC626 FC627 FC628 FC629 FC630 FC631 FC632 FC633 FC634 FC635 FC636 FC637 FC638 FC639 FC640 FC641 FC642
        drop FC22 FC23 FC24 FC25 FC26 FC27 FC28 FC29 FC30 FC41 FC42 FC43 FC44 FC45 FC46 FC47 FC53 FC54 FC55 FC56 FC57 FC58 FC59 FC60 FC61  FC72 FC73 FC74 FC75 FC76 FC77 FC78 FC5 FC6 FC7 FC9 FC10 FC11 FC13 FC15
        drop FC84 FC85 FC86 FC87 FC88 FC89 FC90 FC91 FC92  FC103 FC104 FC105 FC106 FC107 FC108 FC109 FC110 FC111 FC112 FC113 FC114 FC115 FC116 FC117 FC118 FC119 FC120 FC121 FC122 FC123 FC124 FC125 FC126 FC127 FC128 FC129 FC130 FC131 FC132 FC133 FC134 FC135 FC136 FC137 FC138 FC139 FC140
        drop FC165 FC166 FC167 FC168 FC169 FC170 FC171 FC172 FC173 FC174 FC175 FC176 FC177 FC178 FC179 FC180 FC181 FC182 FC183 FC184 FC185 FC186 FC187 FC188 FC189 FC190 FC191 FC192 FC193 FC194 FC195 FC196 FC197 FC198 FC199 FC200 FC201 FC202 FC203 FC204 FC205 FC206 FC207 FC208 FC209 FC210 FC211 FC212 FC213 FC214 FC215 FC216 FC217 FC218 FC219 FC220 FC221 FC222 FC223 FC224


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

    /* 06. Mom S-P/ Dad S-P/ A-Mom S-P/ A-Dad S-P ID */
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


    /* 07. Bio mom and dad together */ 
        g bio_md_together = 1 if bio_mom_id == sp_bio_mom_id & bio_mom_id != . & sp_bio_mom_id != .
        replace bio_md_together = 1 if bio_dad_id == sp_bio_mom_id & bio_dad_id != . & sp_bio_mom_id != .
        label var bio_md_together "Bio mom and dad together"

        by ID: egen bio_md_ever_together = max(bio_md_together)
        replace bio_md_ever_together = 0 if bio_md_ever_together == .
        label var bio_md_ever_together "Bio mom and dad ever together"
        /* this shows up as 0 even if both parent id's are missing */

    /* 08. Bio mom/dad single */ 
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


    /* 09. In Kid Sample */ 
        g kid_sample =1 
        label var kid_sample "Child in Family Composition File"


    /* 10. Clear */ 
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


    /* 12. Save family composition file */
        save "$root/01_family_structure_v7.dta", replace
        collapse (firstnm) mom_marital_birth (mean) fam fam_number birth_year bio_mom_id bio_dad_id a_mom_id a_dad_id bio_md_ever_together kid_sample yr_first_observed yr_last_observed, by(ID)
        save "$root/01_qualified_kids_v7.dta", replace

    /* 13. Individual file */
        clear
        use "$d_2023"
        drop ER30000 
        rename ER30002 fam_number
        g ID = (1000*fam) + fam_number
        order fam ID

        merge 1:m ID using "01_qualified_kids_v7.dta"

        replace kid_sample = 0 if kid_sample == .
        egen max_merge = max(kid_sample), by(fam)

        drop if max_merge == 0 
        drop max_merge
        
        drop ER30007 ER30026 ER30049 ER30073 ER30097 ER30123 ER30144 ER30166 ER30194 ER30223 ER30252 ER30289 ER30319 ER30349 ER30367 ER30379 ER30393 ER30403 ER30407 ER30422 ER30433 ER30437 ER30456 ER30467 ER30471 ER30491 ER30502 ER30506 ER30528 ER30539 ER30543 ER30563 ER30574 ER30578 ER30599 ER30610 ER30614 ER30635 ER30646 ER30650 ER30677 ER30693 ER30697 ER30720 ER30737 ER30741 ER30795 ER30810 ER30814 ER30856 ER32023 ER32025 ER32027 ER32029 ER32031 ER32035 ER32038 ER32040 ER32042 ER32045 ER32047 ER33105 ER33109 ER33122 ER33205 ER33209 ER33212 ER33224 ER33263 ER33270 ER33278 ER33305 ER33309 ER33312 ER33319 ER33405 ER33409 ER33412 ER33431 ER33505 ER33509 ER33513 ER33539 ER33605 ER33609 ER33613 ER33630 ER33705 ER33709 ER33713 ER33733 ER33805 ER33809 ER33814 ER33839 ER33905 ER33909 ER33914 ER33939 ER34005 ER34009 ER34017 ER34033 ER34105 ER34109 ER34117 ER34145 ER34205 ER34209 ER34217 ER34222 ER34225 ER34233 ER34234 ER34252 ER34306 ER34310 ER34321 ER34324 ER34326 ER34329 ER34332 ER34339 ER34343 ER34353 ER34356 ER34358 ER34361 ER34364 ER34371 ER34375 ER34383 ER34384 ER34402 ER34505 ER34509 ER34520 ER34523 ER34525 ER34528 ER34531 ER34538 ER34542 ER34552 ER34555 ER34557 ER34560 ER34563 ER34570 ER34574 ER34592 ER34593 ER34641 ER34705 ER34709 ER34720 ER34723 ER34725 ER34728 ER34731 ER34740 ER34746 ER34756 ER34759 ER34761 ER34764 ER34767 ER34776 ER34782 ER34800 ER34801 ER34850 ER34905 ER34909 ER34920 ER34923 ER34925 ER34928 ER34931 ER34940 ER34946 ER34956 ER34959 ER34961 ER34964 ER34967 ER34976 ER34982 ER35002 ER35003 ER35051 ER35105 ER35109 ER35120 ER35123 ER35125 ER35128 ER35131 ER35140 ER35146 ER35156 ER35159 ER35161 ER35164 ER35167 ER35176 ER35182 ER35202 ER35203 ER35251

    /* 14. Which waves are you in?*/
        forvalues i = 1968/1997{
            g in_`i' = . 
            label var in_`i' "In FU `i'"
        }

        forvalues i=1999(2)2023{
            g in_`i' = . 
            label var in_`i' "In FU `i'"
        }

        replace in_1968 = 1 if ER30018 == 0
        replace in_1969 = 1 if ER30041 == 0
        replace in_1970 = 1 if ER30065 == 0
        replace in_1971 = 1 if ER30089 == 0
        replace in_1972 = 1 if ER30115 == 0
        replace in_1973 = 1 if ER30136 == 0
        replace in_1974 = 1 if ER30158 == 0
        replace in_1975 = 1 if ER30186 == 0
        replace in_1976 = 1 if ER30215 == 0
        replace in_1977 = 1 if ER30244 == 0
        replace in_1978 = 1 if ER30281 == 0
        replace in_1979 = 1 if ER30311 == 0
        replace in_1980 = 1 if ER30341 == 0
        replace in_1981 = 1 if ER30371 == 0
        replace in_1982 = 1 if ER30397 == 0
        replace in_1983 = 1 if ER30427 == 0
        replace in_1984 = 1 if ER30461 == 0
        replace in_1985 = 1 if ER30496 == 0
        replace in_1986 = 1 if ER30533 == 0
        replace in_1987 = 1 if ER30568 == 0
        replace in_1988 = 1 if ER30604 == 0
        replace in_1989 = 1 if ER30640 == 0
        replace in_1990 = 1 if ER30685 == 0
        replace in_1991 = 1 if ER30729 == 0
        replace in_1992 = 1 if ER30802 == 0
        replace in_1993 = 1 if ER30863 == 0
        replace in_1994 = 1 if ER33127 == 0
        replace in_1995 = 1 if ER33283 == 0
        replace in_1996 = 1 if ER33325 == 0
        replace in_1997 = 1 if ER33437 == 0
        replace in_1999 = 1 if ER33545 == 0
        replace in_2001 = 1 if ER33636 == 0
        replace in_2003 = 1 if ER33739 == 0
        replace in_2005 = 1 if ER33847 == 0
        replace in_2007 = 1 if ER33949 == 0
        replace in_2009 = 1 if ER34044 == 0
        replace in_2011 = 1 if ER34153 == 0
        replace in_2013 = 1 if ER34267 == 0
        replace in_2015 = 1 if ER34412 == 0
        replace in_2017 = 1 if ER34649 == 0
        replace in_2019 = 1 if ER34862 == 0
        replace in_2021 = 1 if ER35063 == 0
        replace in_2023 = 1 if ER35263 == 0


        replace in_1968 = 0 if ER30018 == 97
        replace in_1969 = 0 if ER30041 == 97
        replace in_1970 = 0 if ER30065 == 97
        replace in_1971 = 0 if ER30089 == 97
        replace in_1972 = 0 if ER30115 == 97
        replace in_1973 = 0 if ER30136 == 97
        replace in_1974 = 0 if ER30158 == 97
        replace in_1975 = 0 if ER30186 == 97
        replace in_1976 = 0 if ER30215 == 97
        replace in_1977 = 0 if ER30244 == 97
        replace in_1978 = 0 if ER30281 == 97
        replace in_1979 = 0 if ER30311 == 97
        replace in_1980 = 0 if ER30341 == 97
        replace in_1981 = 0 if ER30371 == 97
        replace in_1982 = 0 if ER30397 == 97
        replace in_1983 = 0 if ER30427 == 97
        replace in_1984 = 0 if ER30461 == 97
        replace in_1985 = 0 if ER30496 == 97
        replace in_1986 = 0 if ER30533 == 97
        replace in_1987 = 0 if ER30568 == 97
        replace in_1988 = 0 if ER30604 == 97
        replace in_1989 = 0 if ER30640 == 97
        replace in_1990 = 0 if ER30685 == 97
        replace in_1991 = 0 if ER30729 == 97
        replace in_1992 = 0 if ER30802 == 97
        replace in_1993 = 0 if ER30863 == 97
        replace in_1994 = 0 if ER33127 == 97
        replace in_1995 = 0 if ER33283 == 97
        replace in_1996 = 0 if ER33325 == 97
        replace in_1997 = 0 if ER33437 == 97
        replace in_1999 = 0 if ER33545 == 97
        replace in_2001 = 0 if ER33636 == 97
        replace in_2003 = 0 if ER33739 == 97
        replace in_2005 = 0 if ER33847 == 97
        replace in_2007 = 0 if ER33949 == 97
        replace in_2009 = 0 if ER34044 == 97
        replace in_2011 = 0 if ER34153 == 97
        replace in_2013 = 0 if ER34267 == 97
        replace in_2015 = 0 if ER34412 == 97
        replace in_2017 = 0 if ER34649 == 97
        replace in_2019 = 0 if ER34862 == 97
        replace in_2021 = 0 if ER35063 == 97
        replace in_2023 = 0 if ER35263 == 97
        /*
            replace in_1968 = -1 if in_1968 == .
            replace in_1969 = -1 if in_1969 == .
            replace in_1970 = -1 if in_1970 == .
            replace in_1971 = -1 if in_1971 == .
            replace in_1972 = -1 if in_1972 == .
            replace in_1973 = -1 if in_1973 == .
            replace in_1974 = -1 if in_1974 == .
            replace in_1975 = -1 if in_1975 == .
            replace in_1976 = -1 if in_1976 == .
            replace in_1977 = -1 if in_1977 == .
            replace in_1978 = -1 if in_1978 == .
            replace in_1979 = -1 if in_1979 == .
            replace in_1980 = -1 if in_1980 == .    
            replace in_1981 = -1 if in_1981 == .
            replace in_1982 = -1 if in_1982 == .
            replace in_1983 = -1 if in_1983 == .
            replace in_1984 = -1 if in_1984 == .
            replace in_1985 = -1 if in_1985 == .
            replace in_1986 = -1 if in_1986 == .
            replace in_1987 = -1 if in_1987 == .
            replace in_1988 = -1 if in_1988 == .
            replace in_1989 = -1 if in_1989 == .
            replace in_1990 = -1 if in_1990 == .
            replace in_1991 = -1 if in_1991 == .
            replace in_1992 = -1 if in_1992 == .
            replace in_1993 = -1 if in_1993 == .
            replace in_1994 = -1 if in_1994 == .
            replace in_1995 = -1 if in_1995 == .
            replace in_1996 = -1 if in_1996 == .
            replace in_1997 = -1 if in_1997 == .
            replace in_1999 = -1 if in_1999 == .
            replace in_2001 = -1 if in_2001 == .
            replace in_2003 = -1 if in_2003 == .
            replace in_2005 = -1 if in_2005 == .
            replace in_2007 = -1 if in_2007 == .
            replace in_2009 = -1 if in_2009 == .
            replace in_2011 = -1 if in_2011 == .
            replace in_2013 = -1 if in_2013 == .
            replace in_2015 = -1 if in_2015 == .
            replace in_2017 = -1 if in_2017 == .
            replace in_2019 = -1 if in_2019 == .
            replace in_2021 = -1 if in_2021 == .
            replace in_2023 = -1 if in_2023 == .
        */

    /* 15. Annual HH Roster */
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
        forvalues yr = 1999(2)2023{
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


        keep in_* hh* birth_year fam fam_number ID kid_sample yr_first_observed yr_last_observed bio_mom_id bio_dad_id a_mom_id a_dad_id bio_md_ever_together

    /* 16. Reshape */
        reshape long hhr_, i(ID) j(yr)

        drop if kid_sample != 1

        forvalues yr = 1968/1997{
            drop if yr == `yr' & in_`yr' != 1
    }

    forvalues yr = 1999(2)2023{
        drop if yr == `yr' & in_`yr' != 1
    }


        g Age = yr - birth_year


    /* 17. Identify changes in household roster */
        sort ID yr
        g change_in_hhr = 1 if hhr_ != hhr_[_n-1] & ID == ID[_n-1]
        replace change_in_hhr = 0 if hhr_ == hhr_[_n-1] & ID == ID[_n-1]
        replace change_in_hhr = . if ID != ID[_n-1]
        label var change_in_hhr "Change in hhr"

        g hhr_cur = hhr_
        g hhr_prev = ""
        replace hhr_prev = hhr_[_n-1] if ID==ID[_n-1]

        g hhr_cur_sp  = trim(subinstr(hhr_cur, ",", " ", .))
        g hhr_prev_sp = trim(subinstr(hhr_prev, ",", " ", .))

        g hhr_added_count = 0
        g hhr_removed_count = 0
        g hhr_added = ""
        g hhr_removed = ""

        forvalues k = 1/100 {
            replace hhr_added = trim(hhr_added + " " + word(hhr_cur_sp, `k')) if change_in_hhr==1 & wordcount(hhr_cur_sp) >= `k' & strpos(" " + hhr_prev_sp + " ", " " + word(hhr_cur_sp, `k') + " ")==0
            replace hhr_added_count = hhr_added_count + 1 if change_in_hhr==1 & wordcount(hhr_cur_sp) >= `k' & strpos(" " + hhr_prev_sp + " ", " " + word(hhr_cur_sp, `k') + " ")==0
            replace hhr_removed = trim(hhr_removed + " " + word(hhr_prev_sp, `k')) if change_in_hhr==1 & wordcount(hhr_prev_sp) >= `k' & strpos(" " + hhr_cur_sp + " ", " " + word(hhr_prev_sp, `k') + " ")==0
            replace hhr_removed_count = hhr_removed_count + 1 if change_in_hhr==1 & wordcount(hhr_prev_sp) >= `k' & strpos(" " + hhr_cur_sp + " ", " " + word(hhr_prev_sp, `k') + " ")==0
        }

        replace hhr_added = subinstr(trim(hhr_added), " ", ",", .) if hhr_added != ""
        replace hhr_removed = subinstr(trim(hhr_removed), " ", ",", .) if hhr_removed != ""

        replace hhr_added = "" if change_in_hhr != 1
        replace hhr_removed = "" if change_in_hhr != 1
        replace hhr_added_count = . if change_in_hhr != 1
        replace hhr_removed_count = . if change_in_hhr != 1

        label var hhr_added "IDs added to hhr (when change_in_hhr==1)"
        label var hhr_removed "IDs removed from hhr (when change_in_hhr==1)"
        label var hhr_added_count "Number added (when change_in_hhr==1)"
        label var hhr_removed_count "Number removed (when change_in_hhr==1)"


    /* 18. Change in household roster for children aged 0-18 */

        g change_hhr_0_18 = 1 if change_in_hhr == 1 & Age <= 18
        replace change_hhr_0_18 = 0 if change_in_hhr == 0 & Age <= 18
        replace change_hhr_0_18 = . if Age > 18
        label var change_hhr_0_18 "Change in hhr when Age <= 18"

        g hhr_added_0_18 = ""
        g hhr_removed_0_18 = ""
        g hhr_added_count_0_18 = .
        g hhr_removed_count_0_18 = .

        replace hhr_added_0_18 = hhr_added if Age <= 18
        replace hhr_removed_0_18 = hhr_removed if Age <= 18 

        replace hhr_added_count_0_18 = hhr_added_count if Age <= 18
        replace hhr_removed_count_0_18 = hhr_removed_count if Age <= 18

        drop in_*

    /* 19. Save hh roster time series*/

        save "$root/01_hhr_v7.dta", replace
        collapse ID, by(fam)
        drop ID 
        save "$root/01_qualified_families_v7.dta", replace

}

local qualified "$root/01_qualified_families_v7.dta"
use "`qualified'"

/* 20. Pull and merge on data from survey waves 1968-2021 */
    /* 1968 survey */
        clear
        cd "$root"
        use "$root/fam1968/fam1968.dta"
        rename V3 fam
        g yr = 1968

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        
        label var qualified_family "=1 if family has a child born in fam comp file" 
        drop _merge
        save "$root/fam1968/fam1968_qualifiedsample.dta", replace


    /* 1969 survey */
        clear
        cd "$root/fam1969"
        use "$root/fam1969/fam1969.dta"
        rename V442 fam
        g yr = 1969

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1969/fam1969_qualifiedsample.dta", replace

    /* 1970 survey */
        clear
        cd "$root/fam1970"
        use "$root/fam1970/fam1970.dta"
        rename V1102 fam
        g yr = 1970

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1970/fam1970_qualifiedsample.dta", replace

    /* 1971 survey */
        clear
        cd "$root/fam1971"
        use "$root/fam1971/fam1971.dta"
        rename V1802 fam
        g yr = 1971

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1971/fam1971_qualifiedsample.dta", replace


    /* 1972 survey */
        clear
        cd "$root/fam1972"
        use "$root/fam1972/fam1972.dta"
        rename V2402 fam
        g yr = 1972

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1972/fam1972_qualifiedsample.dta", replace

    /* 1973 survey */
        clear
        cd "$root/fam1973"
        use "$root/fam1973/fam1973.dta"
        rename V3002 fam
        g yr = 1973

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1973/fam1973_qualifiedsample.dta", replace

    /* 1974 survey */
        clear
        cd "$root/fam1974"
        use "$root/fam1974/fam1974.dta"
        rename V3402 fam
        g yr = 1974

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1974/fam1974_qualifiedsample.dta", replace

    /* 1975 survey */
        clear
        cd "$root/fam1975"
        use "$root/fam1975/fam1975.dta"
        rename V3802 fam
        g yr = 1975

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1975/fam1975_qualifiedsample.dta", replace

    /* 1976 survey */
        clear
        cd "$root/fam1976"
        use "$root/fam1976/fam1976.dta"
        rename V4302 fam
        g yr = 1976

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1976/fam1976_qualifiedsample.dta", replace

    /* 1977 survey */
        clear
        cd "$root/fam1977"
        use "$root/fam1977/fam1977.dta"
        rename V5202 fam
        g yr = 1977

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1977/fam1977_qualifiedsample.dta", replace

    /* 1978 survey */
        clear
        cd "$root/fam1978"
        use "$root/fam1978/fam1978.dta"
        rename V5702 fam
        g yr = 1978

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1978/fam1978_qualifiedsample.dta", replace

    /* 1979 survey */
        clear 
        cd "$root/fam1979"
        use "$root/fam1979/fam1979.dta"
        rename V6302 fam
        g yr = 1979


        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1979/fam1979_qualifiedsample.dta", replace


    /* 1980 survey */
        clear 
        cd .. 
        cd fam1980
        use "fam1980.dta"
        rename V6902 fam
        g yr = 1980
        
        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1980/fam1980_qualifiedsample.dta", replace


    /* 1981 survey */
        clear 
        cd .. 
        cd fam1981
        use "fam1981.dta"
        rename V7502 fam
        g yr = 1981
            
        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1981/fam1981_qualifiedsample.dta", replace


    /* 1982 survey */
        clear 
        cd .. 
        cd fam1982
        use "fam1982.dta"
        rename V8202 fam
        
         g yr = 1982
        
        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1982/fam1982_qualifiedsample.dta", replace

    /* 1983 survey */
        clear 
        cd .. 
        cd fam1983
        use "fam1983.dta"
        rename V8802 fam
      g yr = 1983
        
        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1983/fam1983_qualifiedsample.dta", replace
    /* 1984 survey */
        clear 
        cd .. 
        cd fam1984
        use "fam1984.dta"
        rename V10002 fam
        g yr = 1984
        
        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1984/fam1984_qualifiedsample.dta", replace

    /* 1985 survey */
        clear 
        cd .. 
        cd fam1985
        use "fam1985.dta"
        rename V11102 fam
        g yr = 1985
        
        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1985/fam1985_qualifiedsample.dta", replace

    /* 1986 survey */
        clear 
        cd .. 
        cd fam1986
        use "fam1986.dta"
        rename V12502 fam
        g yr = 1986
        
        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1986/fam1986_qualifiedsample.dta", replace


    /* 1987 survey */
        clear 
        cd .. 
        cd fam1987
        use "fam1987.dta"
        rename V13702 fam

        g yr = 1987
        
        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1987/fam1987_qualifiedsample.dta", replace

    /* 1988 survey */
        clear 
        cd .. 
        cd fam1988
        use "fam1988.dta"
        rename V14802 fam
        g yr = 1988
        
        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1988/fam1988_qualifiedsample.dta", replace

    /* 1989 survey */
        clear 
        cd .. 
        cd fam1989
        use "fam1989.dta"
        rename V16302 fam
        g yr = 1989
        
        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1989/fam1989_qualifiedsample.dta", replace

    /* 1990 survey */
        clear 
        cd .. 
        cd fam1990
        use "fam1990.dta"
        rename V17702 fam
        g yr = 1990
        
        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge m:1 fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1990/fam1990_qualifiedsample.dta", replace
        
    /* 1991 survey */
        clear 
        cd .. 
        cd fam1991
        use "fam1991.dta"
        rename V19002 fam
        g yr = 1991
        
        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "$root/fam1991/fam1991_qualifiedsample.dta", replace */


    /* 1992 survey */
        clear 
        cd .. 
        cd fam1992
        use "fam1992.dta"
        rename V20302 fam
        g yr = 1992

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1992/fam1992_qualifiedsample.dta", replace

    /* 1993 survey */
        clear 
        cd .. 
        cd fam1993
        use "fam1993.dta"
        rename V21602 fam
        g yr = 1993

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1993/fam1993_qualifiedsample.dta", replace

    /* 1994 survey */
        clear 
        cd .. 
        cd fam1994er
        use "fam1994.dta"
        rename ER2002 fam
        g yr = 1994

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1994er/fam1994_qualifiedsample.dta", replace

    /* 1995 survey */
        clear 
        cd .. 
        cd fam1995er
        use "fam1995.dta"
        rename ER5002 fam
        g yr = 1995

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1995er/fam1995_qualifiedsample.dta", replace

    /* 1996 survey */
        clear 
        cd .. 
        cd fam1996er
        use "fam1996.dta"
        rename ER7002 fam
        g yr = 1996

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1996er/fam1996_qualifiedsample.dta", replace


    /* 1997 survey */
        clear 
        cd .. 
        cd fam1997er
        use "fam1997.dta"
        rename ER10002 fam
        g yr = 1997

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1997er/fam1997_qualifiedsample.dta", replace


    /* 1999 survey */
        clear 
        cd .. 
        cd fam1999er
        use "fam1999.dta"
        rename ER13002 fam
        g yr = 1999

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam1999er/fam1999_qualifiedsample.dta", replace


    /* 2001 survey */
        clear 
        cd .. 
        cd fam2001er
        use "fam2001.dta"
        rename ER17002 fam
        g yr = 2001

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam2001er/fam2001_qualifiedsample.dta", replace


    /* 2003 survey */
        clear 
        cd .. 
        cd fam2003er
        use "fam2003.dta"
        rename ER21002 fam
        g yr = 2003

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam2003er/fam2003_qualifiedsample.dta", replace


    /* 2005 survey */
        clear 
        cd .. 
        cd fam2005er
        use "fam2005.dta"
        rename ER25002 fam
        g yr = 2005

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam2005er/fam2005_qualifiedsample.dta", replace


    /* 2007 survey */
        clear 
        cd .. 
        cd fam2007er
        use "fam2007.dta"
        rename ER36002 fam
        g yr = 2007

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam2007er/fam2007_qualifiedsample.dta", replace


    /* 2009 survey */
        clear 
        cd .. 
        cd fam2009er
        use "fam2009.dta"
        rename ER42002 fam
        g yr = 2009

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam2009er/fam2009_qualifiedsample.dta", replace


    /* 2011 survey */
        clear 
        cd .. 
        cd fam2011er
        use "fam2011.dta"
        rename ER47302 fam
        g yr = 2011

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam2011er/fam2011_qualifiedsample.dta", replace


    /* 2013 survey */
        clear 
        cd .. 
        cd fam2013er
        use "fam2013.dta"
        rename ER53002 fam
        g yr = 2013

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam2013er/fam2013_qualifiedsample.dta", replace


    /* 2015 survey */
        clear 
        cd .. 
        cd fam2015er
        use "fam2015.dta"
        rename ER60002 fam
        g yr = 2015

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam2015er/fam2015_qualifiedsample.dta", replace


    /* 2017 survey */
        clear 
        cd .. 
        cd fam2017er
        use "fam2017.dta"
        rename ER66002 fam
        g yr = 2017

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam2017er/fam2017_qualifiedsample.dta", replace


    /* 2019 survey */
        clear 
        cd .. 
        cd fam2019er
        use "fam2019.dta"
        rename ER72002 fam
        g yr = 2019

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam2019er/fam2019_qualifiedsample.dta", replace


    /* 2021 survey */
        clear 
        cd .. 
        cd fam2021er
        use "fam2021.dta"
        rename ER78002 fam
        g yr = 2021

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam2021er/fam2021_qualifiedsample.dta", replace


    /* 2023 survey 
        clear 
        cd .. 
        cd fam2023er
        use "fam2023.dta"
        rename V19002 fam
        g yr = 2023

        * keep wanted variables only 
        do "$root/00_RENAMING_V1.do"

        merge 1:m fam using "`qualified'"
        order fam _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "$root/fam2023/fam2023_qualifiedsample.dta", replace */








/* 21. Merge together */

    *append using "$root/fam2021er/fam2021_qualifiedsample.dta"
    append using "$root/fam2019er/fam2019_qualifiedsample.dta"
    append using "$root/fam2017er/fam2017_qualifiedsample.dta"
    append using "$root/fam2015er/fam2015_qualifiedsample.dta"
    append using "$root/fam2013er/fam2013_qualifiedsample.dta"
    append using "$root/fam2011er/fam2011_qualifiedsample.dta"
    append using "$root/fam2009er/fam2009_qualifiedsample.dta"
    append using "$root/fam2007er/fam2007_qualifiedsample.dta"
    append using "$root/fam2005er/fam2005_qualifiedsample.dta"
    append using "$root/fam2003er/fam2003_qualifiedsample.dta"
    append using "$root/fam2001er/fam2001_qualifiedsample.dta"
    append using "$root/fam1999er/fam1999_qualifiedsample.dta"
    append using "$root/fam1997er/fam1997_qualifiedsample.dta"
    append using "$root/fam1996er/fam1996_qualifiedsample.dta"
    append using "$root/fam1995er/fam1995_qualifiedsample.dta"
    append using "$root/fam1994er/fam1994_qualifiedsample.dta"
    append using "$root/fam1993/fam1993_qualifiedsample.dta"
    append using "$root/fam1992/fam1992_qualifiedsample.dta"
    append using "$root/fam1991/fam1991_qualifiedsample.dta"
    append using "$root/fam1990/fam1990_qualifiedsample.dta"
    append using "$root/fam1989/fam1989_qualifiedsample.dta"
    append using "$root/fam1988/fam1988_qualifiedsample.dta"
    append using "$root/fam1987/fam1987_qualifiedsample.dta"
    append using "$root/fam1986/fam1986_qualifiedsample.dta"
    append using "$root/fam1985/fam1985_qualifiedsample.dta"
    append using "$root/fam1984/fam1984_qualifiedsample.dta"
    append using "$root/fam1983/fam1983_qualifiedsample.dta"
    append using "$root/fam1982/fam1982_qualifiedsample.dta"
    append using "$root/fam1981/fam1981_qualifiedsample.dta" 
    append using "$root/fam1980/fam1980_qualifiedsample.dta"
    append using "$root/fam1979/fam1979_qualifiedsample.dta"
    append using "$root/fam1978/fam1978_qualifiedsample.dta"
    append using "$root/fam1977/fam1977_qualifiedsample.dta"
    append using "$root/fam1976/fam1976_qualifiedsample.dta"
    append using "$root/fam1975/fam1975_qualifiedsample.dta"
    append using "$root/fam1974/fam1974_qualifiedsample.dta"
    append using "$root/fam1973/fam1973_qualifiedsample.dta"
    append using "$root/fam1972/fam1972_qualifiedsample.dta"
    append using "$root/fam1971/fam1971_qualifiedsample.dta"
    append using "$root/fam1970/fam1970_qualifiedsample.dta"
    append using "$root/fam1969/fam1969_qualifiedsample.dta"
    append using "$root/fam1968/fam1968_qualifiedsample.dta"

    order fam ID yr

    save "$root/01_heads_panel_v7.dta", replace

/* 22. Merge on Household Roster Data */
    append using "$root/01_hhr_v7.dta"

/* 23. FU Income */
    by fam yr: egen FU_income = min(FU_income)
    label var FU_income "Family Unit Income in year-1"
    g FU_income_change = FU_income if kid_sample == 1 & change_hhr_0_18 == 1
    g FU_income_no_change = FU_income if kid_sample == 1 & change_hhr_0_18 == 0
    label var FU_income_change "FU Income in year-1 when change in hhr for kids lt18"
    label var FU_income_no_change "FU Income in year-1 when NO change in hhr for kids lt18"

    save "$root/01_heads_kids_panel_v7.dta", replace

/*
    preserve
    keep if kid_sample==1 & yr!=. & yr <= 1990
    collapse (mean) mean_FU_income=FU_income, by(yr)
    format mean_FU_income %9.2f
    twoway (line mean_FU_income yr, sort lwidth(medium) lcolor(black)) (scatter mean_FU_income yr, msymbol(circle) msize(small) mcolor(black)), title("Mean FU_income over time (kid_sample==1)") xtitle("Year") ytitle("Mean FU_income") legend(off)
    cap graph export "$root/_figures/FU_income_over_time_kids.png", replace
    restore



/* SARAH. 01_heads_kids_panel_v7.dta does not need to be redone. Don't do it again. */




/* 11. Keep 
    keep fam ID fam_number in_1968 in_1969 in_1970 in_1971 in_1972 in_1973 in_1974 in_1975 in_1976 in_1977 in_1978 in_1979 in_1980 in_1981 in_1982 in_1983 in_1984 in_1985 in_1986 in_1987 in_1988 in_1989 in_1990 in_1991 in_1992 in_1993 in_1994 in_1995 in_1996 in_1997 in_1999 in_2001 in_2003 in_2005 in_2007 in_2009 in_2011 in_2013 in_2015 in_2017 in_2019 in_2021 in_2023 hhr_1968 hhr_1969 hhr_1970 hhr_1971 hhr_1972 hhr_1973 hhr_1974 hhr_1975 hhr_1976 hhr_1977 hhr_1978 hhr_1979 hhr_1980 hhr_1981 hhr_1982 hhr_1983 hhr_1984 hhr_1985 hhr_1986 hhr_1987 hhr_1988 hhr_1989 hhr_1990 hhr_1991 hhr_1992 hhr_1993 hhr_1994 hhr_1995 hhr_1996 hhr_1997 hhr_1999 hhr_2001 hhr_2003 hhr_2005 hhr_2007 hhr_2009 hhr_2011 hhr_2013 hhr_2015 hhr_2017 hhr_2019 hhr_2021 hhr_2023
    tempfile who_when 
    save `who_when', replace

forvalues i = 1968/1997 1997(2)2023 {
    replace hhr_`i' = fam if in_`i' == 1
    replace hhr_`i' = "" if in_`i' != 1
}

    order fam ID fam_number ///
        in_1968 hhr_1968 in_1969 hhr_1969 in_1970 hhr_1970 in_1971 hhr_1971 in_1972 hhr_1972 in_1973 hhr_1973 in_1974 hhr_1974 in_1975 hhr_1975 in_1976 hhr_1976 in_1977 hhr_1977 in_1978 hhr_1978 in_1979 hhr_1979 in_1980 hhr_1980 in_1981 hhr_1981 in_1982 hhr_1982 in_1983 hhr_1983 in_1984 hhr_1984 in_1985 hhr_1985 in_1986 hhr_1986 in_1987 hhr_1987 in_1988 hhr_1988 in_1989 hhr_1989 in_1990 hhr_1990 in_1991 hhr_1991 in_1992 hhr_1992 in_1993 hhr_1993 in_1994 hhr_1994 in_1995 hhr_1995 in_1996 hhr_1996 in_1997 hhr_1997 in_1999 hhr_1999 in_2001 hhr_2001 in_2003 hhr_2003 in_2005 hhr_2005 in_2007 hhr_2007 in_2009 hhr_2009 in_2011 hhr_2011 in_2013 hhr_2013 in_2015 hhr_2015 in_2017 hhr_2017 in_2019 hhr_2019 in_2021 hhr_2021 in_2023 hhr_2023

forvalues i = 1968/1997 1997(2)2023 {
    local hhr_`i' 
}

*/



/*

    d, by(fam)rop ER30000
    g ID = (1000*fam) + ER30002
    label var ID "UNIQUE ID = FAM # + PERSON #"
    order ID

    merge 1:m ID using "`temp'"

    sort fam ID 
    order fam ID

    replace in_kid_sample = 0 if in_kid_sample == .
    egen max_temp = max(in_kid_sample), by(fam)
    * keep only families with children in the family composition file

    drop if max_temp == 0
    count if fam != fam[_n+1]

    drop max_temp _merge 




/* 09. Merge on Panel with data on other HH members*/
    save "$out_2023/cleaned_ind2023er_v1.dta", replace
    collapse ER30002, by(fam)
    drop ER30002 
    save "$out_2023/qualified_families_v4.dta", replace

    local qualified "$out_2023/qualified_families_v4.dta"



  
/* 05. Merge all waves together  */
 
    sort fam yr


/* Save */
    save "01_family_structure_v5.dta", replace




/* */
    clear
    use "$out_2023/cleaned_ind2023er_v1.dta"
    drop if yr == . & ER30003 != 1

    append using "01_family_structure_v5.dta"

    order fam yr ID








/* Merge on Individual Data */

    joinby ID yr using "$out_2023/cleaned_ind2023er_v1.dta", unmatched(both)

    replace fam = (ID-ER30002) / 1000 if fam == .

    sort fam ID yr

    replace yr = 1968 if yr == .
    forvalues i =68/92{
        g year`i' = (1900) + `i'
    }


    reshape long year, i(ID) j(year_)
    drop yr year
    rename year_ yr
    replace yr = yr + 1900




    tempfile temp
    save `temp', replace

    clear
    use "01_family_structure_v4.dta" 
    g ER30002 = 1
    g ID = fam * 1000 + ER30002
    drop ER30002

    joinby ID yr using `temp', unmatched(both)

    replace fam = ID/1000 if fam == .
    replace fam = round(fam, 1.0)

    sort fam yr ER30002 

/* Save */
    cd "$root"
    save "$root/01_family_structure_v4.dta", replace
