****************************
* Sarah Sullivan 
* September 18, 2025
* Last Updated: September 23, 2025
* 01_family_structure_v2
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
    
/* 03. Population born between 1968 and 2007*/
    drop if birth_year_cont < 1968 | birth_year_cont > 2007
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
    save qualified_families_v2.dta, replace

    local qualified "/Users/sarsul/Desktop/psid/ind2023er/qualified_families_v1.dta"
        * N= 3129

/* 04 Pull data from survey waves 1968-2021 */
    /* 1968 survey */
        clear
        cd "/Users/sarsul/Desktop/psid/fam1968"
        use "/Users/sarsul/Desktop/psid/fam1968/fam1968.dta"
        rename V3 ER30001
        g yr = 1968

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
        save "/Users/sarsul/Desktop/psid/fam1968/fam1968_qualifiedsample.dta", replace

    /* 1969 survey */
        clear
        cd "/Users/sarsul/Desktop/psid/fam1969"
        use "/Users/sarsul/Desktop/psid/fam1969/fam1969.dta"
        rename V442 ER30001
        g yr = 1969

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
        save "/Users/sarsul/Desktop/psid/fam1969/fam1969_qualifiedsample.dta", replace

    /* 1970 survey */
        clear
        cd "/Users/sarsul/Desktop/psid/fam1970"
        use "/Users/sarsul/Desktop/psid/fam1970/fam1970.dta"
        rename V1102 ER30001
        g yr = 1970

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
        save "/Users/sarsul/Desktop/psid/fam1970/fam1970_qualifiedsample.dta", replace
    /* 1971 survey */
        clear
        cd "/Users/sarsul/Desktop/psid/fam1971"
        use "/Users/sarsul/Desktop/psid/fam1971/fam1971.dta"
        rename V1802 ER30001
        g yr = 1971

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
        save "/Users/sarsul/Desktop/psid/fam1971/fam1971_qualifiedsample.dta", replace


    /* 1972 survey */
        clear
        cd "/Users/sarsul/Desktop/psid/fam1972"
        use "/Users/sarsul/Desktop/psid/fam1972/fam1972.dta"
        rename V2402 ER30001
        g yr = 1972

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
        save "/Users/sarsul/Desktop/psid/fam1972/fam1972_qualifiedsample.dta", replace

    /* 1973 survey */
        clear
        cd "/Users/sarsul/Desktop/psid/fam1973"
        use "/Users/sarsul/Desktop/psid/fam1973/fam1973.dta"
        rename V3002 ER30001
        g yr = 1973

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
        save "/Users/sarsul/Desktop/psid/fam1973/fam1973_qualifiedsample.dta", replace

    /* 1974 survey */
        clear
        cd "/Users/sarsul/Desktop/psid/fam1974"
        use "/Users/sarsul/Desktop/psid/fam1974/fam1974.dta"
        rename V3402 ER30001
        g yr = 1974

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
        save "/Users/sarsul/Desktop/psid/fam1974/fam1974qualifiedsample.dta", replace

    /* 1975 survey */
        clear
        cd "/Users/sarsul/Desktop/psid/fam1975"
        use "/Users/sarsul/Desktop/psid/fam1975/fam1975.dta"
        rename V3802 ER30001
        g yr = 1975

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
        save "/Users/sarsul/Desktop/psid/fam1975/fam1975_qualifiedsample.dta", replace

    /* 1976 survey */
        clear
        cd "/Users/sarsul/Desktop/psid/fam1976"
        use "/Users/sarsul/Desktop/psid/fam1976/fam1976.dta"
        rename V4302 ER30001
        g yr = 1976

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
        save "/Users/sarsul/Desktop/psid/fam1976/fam1976_qualifiedsample.dta", replace

    /* 1977 survey */
        clear
        cd "/Users/sarsul/Desktop/psid/fam1977"
        use "/Users/sarsul/Desktop/psid/fam1977/fam1977.dta"
        rename V5202 ER30001
        g yr = 1977

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
        save "/Users/sarsul/Desktop/psid/fam1977/fam1977_qualifiedsample.dta", replace

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
    save "01_family_structure_v2.dta", replace








