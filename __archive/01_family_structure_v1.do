****************************
* Sarah Sullivan 
* September 18, 2025
* Last Updated: September 22, 2025
* 02_family_structure_v1
****************************
/* Fomby, Paula. 2024. The Panel Study of Income Dynamics Family Composition File User Guide:
Early Release. Data release <release number>, Ann Arbor, MI: Survey Research Center, Institute
for Social Research, University of Michigan. <Open ICPSR DOI>. */
************************************

set maxvar 32767
    clear all

/* 01. Load in data */
    cd "/Users/sarsul/Desktop/psid/198084-V2"
    use "famcomp6821.dta"


/* 02. Generate Variables and observe */
    destring(FC2), replace
    destring(FC3), replace

    g ID = (FC2*1000)+FC3
    order ID

    count if ID != ID[_n+1]
        * n = 33,578
    di(_N)
        * _N = 309,602

    label var ID "Person Identification Number"
    sort ID FC4

    * drop 
    drop FC1 

    * Time
    destring(FC4), replace
    label var FC4 "Year of Interview"


    * Children's birth years
    tab FC14 
        *1885-2021
    g birth_year = FC14 if ID != ID[_n+1]

    destring birth_year, replace
    label var birth_year "Individual Birth Year"
    g birth_year_cont = FC14
    destring(birth_year_cont), replace
    egen birth_year_cont1 = max(birth_year_cont), by(ID)
    drop birth_year_cont
    rename birth_year_cont1 birth_year_cont

    * drop any kids who we only observe once
    bysort ID: g wave_count =  _n
        * 276,024 obs, 2-24 waves    
    
/* 03. Population born between 1978 and 1996*/
    count if birth_year <= 1996 & birth_year >= 1978
    drop if birth_year_cont > 1996 | birth_year_cont < 1978
        * 100,643 obs
    count if ID != ID[_n+1]
        * 9,510 ppl 
    label var FC8 "Age"
    order ID FC4 FC8
    
    label var FC16 "Mom's Marital at ID's birth" 
        * constant within individual 
    tempfile temp
    save `temp'
    clear

    use "/Users/sarsul/Desktop/psid/ind2023er/ind2023er.dta"

    drop ER30000
    g ID = (1000*ER30001) + ER30002
    label var ID "UNIQUE ID = FAM # + PERSON #"
    order ID

    merge 1:m ID using "`temp'"

    order ER30001 ID FC4 FC8 FC16 _merge ER30002 ER30003
    sort ER30001 ID 
    egen max_temp = max(_merge), by(ER30001)
    * keep only families with children born 1978-1997
    drop if max_temp == 1
    count if ER30001 != ER30001[_n+1]
        * n = 150,711 individuals; 2,297 families; 3,415 variables
    drop max_temp _merge
        * Population: 
    /* Need to merge on parents panel. 
    Save list of "qualified families" in dta */
    tempfile temp1
    save `temp1'
    collapse ER30002, by(ER30001)
    drop ER30002 
    save qualified_families_v1.dta, replace

    local qualified "/Users/sarsul/Desktop/psid/ind2023er/qualified_families_v1.dta"


/* 04 Pull data from survey waves 1978-1991 */
    /* 1978 survey */
        clear
        cd "/Users/sarsul/Desktop/psid/fam1978"
        use "/Users/sarsul/Desktop/psid/fam1978/fam1978.dta"
        rename V5702 ER30001
        g yr = 1978

        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
        save "/Users/sarsul/Desktop/psid/fam1978/fam1978_qualifiedsample.dta", replace

    /* 1979 survey */
        clear 
        cd "/Users/sarsul/Desktop/psid/fam1979"
        use "/Users/sarsul/Desktop/psid/fam1979/fam1979.dta"
        rename V6302 ER30001
        g yr = 1979


        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-1997
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1979/fam1979_qualifiedsample.dta", replace


    /* 1980 survey */
        clear 
        cd .. 
        cd fam1980
        use "fam1980.dta"
        rename V6902 ER30001
        g yr = 1980
        
        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1980/fam1980_qualifiedsample.dta", replace


    /* 1981 survey */
        clear 
        cd .. 
        cd fam1981
        use "fam1981.dta"
        rename V7502 ER30001
        g yr = 1981
            
        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1981/fam1981_qualifiedsample.dta", replace


    /* 1982 survey */
        clear 
        cd .. 
        cd fam1982
        use "fam1982.dta"
        rename V8202 ER30001
        
      g yr = 1982
        
        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1982/fam1982_qualifiedsample.dta", replace

    /* 1983 survey */
        clear 
        cd .. 
        cd fam1983
        use "fam1983.dta"
        rename V8802 ER30001
      g yr = 1983
        
        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1983/fam1983_qualifiedsample.dta", replace
    /* 1984 survey */
        clear 
        cd .. 
        cd fam1984
        use "fam1984.dta"
        rename V10002 ER30001
        g yr = 1984
        
        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1984/fam1984_qualifiedsample.dta", replace

    /* 1985 survey */
        clear 
        cd .. 
        cd fam1985
        use "fam1985.dta"
        rename V11102 ER30001
        g yr = 1985
        
        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1985/fam1985_qualifiedsample.dta", replace

    /* 1986 survey */
        clear 
        cd .. 
        cd fam1986
        use "fam1986.dta"
        rename V12502 ER30001
        g yr = 1986
        
        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1986/fam1986_qualifiedsample.dta", replace


    /* 1987 survey */
        clear 
        cd .. 
        cd fam1987
        use "fam1987.dta"
        rename V13702 ER30001

        g yr = 1987
        
        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1987/fam1987_qualifiedsample.dta", replace

    /* 1988 survey */
        clear 
        cd .. 
        cd fam1988
        use "fam1988.dta"
        rename V14802 ER30001
        g yr = 1988
        
        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1988/fam1988_qualifiedsample.dta", replace

    /* 1989 survey */
        clear 
        cd .. 
        cd fam1989
        use "fam1989.dta"
        rename V16302 ER30001
        g yr = 1989
        
        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1989/fam1989_qualifiedsample.dta", replace

    /* 1990 survey */
        clear 
        cd .. 
        cd fam1990
        use "fam1990.dta"
        rename V17702 ER30001
        g yr = 1990
        
        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1990/fam1990_qualifiedsample.dta", replace
        
    /* 1991 survey */
        clear 
        cd .. 
        cd fam1991
        use "fam1991.dta"
        rename V19002 ER30001
        g yr = 1991
        
        * keep wanted variables only 
        do "/Users/sarsul/Desktop/psid/00_RENAMING_V1.do"

        merge m:1 ER30001 using `qualified'
        order ER30001 _merge

        * keep qualified families only
        g qualified_family = 1 if _merge == 3
        keep if qualified_family == 1
            * 1,944 families observed in 1978 with a child born 
                * between 1978-19907
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 

        drop _merge
 
        save "/Users/sarsul/Desktop/psid/fam1991/fam1991_qualifiedsample.dta", replace
    
/* 0. Merge all waves together  */
    append using "/Users/sarsul/Desktop/psid/fam1990/fam1990_qualifiedsample.dta"
    append using "/Users/sarsul/Desktop/psid/fam1989/fam1989_qualifiedsample.dta"
    append using "/Users/sarsul/Desktop/psid/fam1988/fam1988_qualifiedsample.dta"
    append using "/Users/sarsul/Desktop/psid/fam1987/fam1987_qualifiedsample.dta"
    append using "/Users/sarsul/Desktop/psid/fam1986/fam1986_qualifiedsample.dta"
    append using "/Users/sarsul/Desktop/psid/fam1985/fam1985_qualifiedsample.dta"
    append using "/Users/sarsul/Desktop/psid/fam1984/fam1984_qualifiedsample.dta"
    append using "/Users/sarsul/Desktop/psid/fam1983/fam1983_qualifiedsample.dta"
    append using "/Users/sarsul/Desktop/psid/fam1982/fam1982_qualifiedsample.dta"
    append using "/Users/sarsul/Desktop/psid/fam1981/fam1981_qualifiedsample.dta" 
    append using "/Users/sarsul/Desktop/psid/fam1980/fam1980_qualifiedsample.dta"
    append using "/Users/sarsul/Desktop/psid/fam1979/fam1979_qualifiedsample.dta"
    append using "/Users/sarsul/Desktop/psid/fam1978/fam1978_qualifiedsample.dta"

    order ER30001 yr
    sort ER30001 yr
    * X= 31,195; 1978 - 1991

/* Save */
    save "02_family_structure_v1.dta", replace





















/*
309602
33578=1 (10.85% of obs, 33,578 people bc each obs only once)

    * Waves in study  
    sort ID year
    bysort ID: g wave_number = _n
    label var wave_number "Wave Number"

    * Waves in Study
    egen waves_in_study = max(wave_number), by(ID)
    label var waves_in_study "Waves in Study"

    forvalues i = 1968/1996{
        g instudy_`i' = 1 if year == `i'
    }

    forvalues i = 1997(2)2021{
        g instudy_`i' = 1 if year == `i'
    }

    forvalues i = 1968/1996{
        egen instudy_`i'_2 = max(instudy_`i'), by(ID)
    }

    forvalues i = 1997(2)2021{
        egen instudy_`i'_2 = max(instudy_`i'), by(ID)
    }

    forvalues i = 1968/1996{
        drop instudy_`i'
    }

    forvalues i = 1997(2)2021{
        drop instudy_`i'
    }

    forvalues i = 1968/1996{
        rename instudy_`i'_2 instudy_`i'
    }

    forvalues i = 1997(2)2021{
        rename instudy_`i'_2 instudy_`i'
    }



/* 03. RENAME AND LABEL */
    rename FC2 ID68
    label var ID68 "1968 ID"
    rename FC3 PN

    label var PN "Person Number"
    rename FC8 AgeT
    label var AgeT "Age at Time t"

    g family_interview_date = FC9 + "/" + FC10 + "/" + FC11
    g family_interview_date1 = date(family_interview_date, "MDY")
    format family_interview_date1 %tdDDmonCCYY
    drop family_interview_date
    rename family_interview_date1 family_interview_date
    label var family_interview_date "Family Interview Date DMY"
    drop FC9 FC10 FC11

    * MOM
    rename FC15 mom_union_birth
    label var mom_union_birth "Mom's Union Status at R's birth CONSTANT"
    rename FC16 mom_marriage_birth 
    label var mom_marriage_birth "Mom's Marital Status at R's birth CONSTANT"
    rename FC17 momID1968
    label var momID1968  "Mom's 1968 ID"
    rename FC18 momPN 
    label var momPN "Mom's PN"

    rename FC22 mom_res_status 
    label var mom_res_status "Mom's residential status at time t"
    rename FC24 mom_enter_HH
    label var mom_enter_HH "Start of Coreside w/ child Year"    
    rename FC26 mom_exit_HH
    label var mom_exit_HH "End of Coreside w/ child Year"    

    rename FC36 mom_marriage_start_date
    label var mom_marriage_start_date "Marriage start date with mom's current or most recent spouse (year)"
    rename FC38 mom_cohab_start_date
    label var mom_cohab_start_date "COHAB start date with MOM's current or most recent spouse/partner (year)"  
    rename FC40 mom_partner_leave_date 
    label var mom_partner_leave_date "Mom's spouse/partner's most recent exit date (year)"

/* PRESERVE BEFORE TRIMMING POPULATIONS */
    preserve













/* 05. Population born */
    restore
    preserve
    count if birth_year == 1978
    drop if birth_year_cont != 1978

/* 06. EDA */
    g momID = momID1968 + momPN
    order ID year AgeT momID 
    drop ID68 PN momID1968 momPN
    order ID year AgeT momID mom_union_birth mom_res_status









