****************************
* Sarah Sullivan 
* Created: December 27, 2025
* Last Updated: March 6, 2026
****************************
/* 
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
    local part2 1
    local part3 1
    local part4 0
    local part5 0
    local part6 0

    local qualified "$root/A1_qualified_families_v1.dta"


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

/* ******************** */
* PART II: Individual File
* inputs individual level data for all 
* individuals ever in the PSID between 
* 1968-2023
/* ******************** */ 

if `part2' == 1{
    /* 13. Individual file */
        clear
        use "$d_2023"
        drop ER30000 
        rename ER30002 fam_number
        g ID = (1000*fam) + fam_number
        order fam ID

        merge 1:m ID using "A1_02_qualified_kids_v1.dta"
            * N = n = 85,536

        replace kid_sample = 0 if kid_sample == .
        count if fam != fam[_n+1]
            * n_families = 8,102
        egen max_merge = max(kid_sample), by(fam)

        * drop families who don't have a qualified child --> max_merge == 0
        drop if max_merge == 0 
            * N = n = 64,428
            * n_families = 2,836
        drop max_merge
        
        drop ER30007 ER30026 ER30049 ER30073 ER30097 ER30123 ER30144 ER30166 ER30194 ER30223 ER30252 ER30289 ER30319 ER30349 ER30367 ER30379 ER30393 ER30403 ER30407 ER30422 ER30433 ER30437 ER30456 ER30467 ER30471 ER30491 ER30502 ER30506 ER30528 ER30539 ER30543 ER30563 ER30574 ER30578 ER30599 ER30610 ER30614 ER30635 ER30646 ER30650 ER30677 ER30693 ER30697 ER30720 ER30737 ER30741 ER30795 ER30810 ER30814 ER30856 ER32023 ER32025 ER32027 ER32029 ER32031 ER32035 ER32038 ER32040 ER32042 ER32045 ER32047 ER33105 ER33109 ER33122 ER33205 ER33209 ER33212 ER33224 ER33263 ER33270 ER33278 ER33305 ER33309 ER33312 ER33319 ER33405 ER33409 ER33412 ER33431 ER33505 ER33509 ER33513 ER33539 ER33605 ER33609 ER33613 ER33630 ER33705 ER33709 ER33713 ER33733 ER33805 ER33809 ER33814 ER33839 ER33905 ER33909 ER33914 ER33939 ER34005 ER34009 ER34017 ER34033 ER34105 ER34109 ER34117 ER34145 ER34205 ER34209 ER34217 ER34222 ER34225 ER34233 ER34234 ER34252 ER34306 ER34310 ER34321 ER34324 ER34326 ER34329 ER34332 ER34339 ER34343 ER34353 ER34356 ER34358 ER34361 ER34364 ER34371 ER34375 ER34383 ER34384 ER34402 ER34505 ER34509 ER34520 ER34523 ER34525 ER34528 ER34531 ER34538 ER34542 ER34552 ER34555 ER34557 ER34560 ER34563 ER34570 ER34574 ER34592 ER34593 ER34641 ER34705 ER34709 ER34720 ER34723 ER34725 ER34728 ER34731 ER34740 ER34746 ER34756 ER34759 ER34761 ER34764 ER34767 ER34776 ER34782 ER34800 ER34801 ER34850 ER34905 ER34909 ER34920 ER34923 ER34925 ER34928 ER34931 ER34940 ER34946 ER34956 ER34959 ER34961 ER34964 ER34967 ER34976 ER34982 ER35002 ER35003 ER35051 ER35105 ER35109 ER35120 ER35123 ER35125 ER35128 ER35131 ER35140 ER35146 ER35156 ER35159 ER35161 ER35164 ER35167 ER35176 ER35182 ER35202 ER35203 ER35251

    /* 14. Which waves are you in?*/
        forvalues i = 1968/1997{
            g in_`i' = . 
            label var in_`i' "In FU `i'"
        }

        forvalues i=1999(2)2021{
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
        *replace in_2023 = 1 if ER35263 == 0

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
        * replace in_2023 = 0 if ER35263 == 97
        * DECEMBER 13, 2025 --> NOT ADDING 2023 DATA
            *drop in_2023

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

    /* 16. PRESERVE */

        tempfile temp1
        save `temp1'

        preserve

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


    /* 23. MERGE ON FIMS */
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


/* ------------------------------------- */
* PART IV: merge together data from each survey 
* wave
/* ------------------------------------- */

if `part4' == 1{

    /* 20. Pull and merge together data from survey waves 1968-2021 */
        /* 1968 survey */
            clear
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
    
            save "$root/fam1991/fam1991_qualifiedsample.dta", replace 


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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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
            set maxvar 32767
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

        * Panel data set of the heads of every household in the qualified sample from 1968-2021
        save "$root/A1_heads_panel_v1.dta", replace

    /* 22. Merge on Household Roster Data */
        * add in observations for children, including data on who comes who goes etc. 
        append using "$root/A1_hhr_v1.dta"

    /* 23. FU Income */
        sort fam yr ID
        * skip . as maximum
        by fam yr: egen FU_income = min(V6173)
        label var FU_income "Family Unit Income in year-1"

    /* 24. Order */
        order ID fam yr
    
    /* 25. Save */
        save "$root/A1_heads_kids_panel_v1.dta", replace

}


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



