****************************
* Sarah Sullivan 
* Created: September 24, 2025
* Last Updated: September 25, 2025
* 02_analysis_v1.do
****************************
/* Fomby, Paula. 2024. The Panel Study of Income Dynamics Family Composition File User Guide:
Early Release. Data release <release number>, Ann Arbor, MI: Survey Research Center, Institute
for Social Research, University of Michigan. <Open ICPSR DOI>. */
************************************
    clear all

    set maxvar 32767

    use "/Users/sarsul/Desktop/psid/01_family_panel_v1.dta"
    * N= 1,660,525

    preserve 

/* 01. Program Setup */
    drop ID
    rename ER30001 fam 
    label var fam "Family ID"
    rename ER30002 fam_number
    label var fam_number "Within Family Count"
    label var yr "Year"
    rename ER30003 role
    label var role "Relation to Head"

    * Kid Number
    egen kid_num_temp = min(fam_number), by(fam yr)
    bysort fam yr: g kid_number = 1 if fam_number == kid_num_temp

    forvalues j = 2/25{
        bysort fam yr: replace kid_number = `j' if fam_number == kid_num_temp+(`j'-1)
    }

    replace kid_number = . if role != 3
    drop fam_number kid_num_temp
    label var kid_number "Child ID within family"

    * famkid
    g famkid = fam*10000 + kid_number
    label var famkid "fam*10000 + kid_number"

/* 02. Age */
        g K_I1 = .
        label var K_I1 "K Age of Individual"
        replace K_I1 = ER30004 if role == 3 & yr == 1968
        replace K_I1 = ER30023 if role == 3 & yr == 1969
        replace K_I1 = ER30046 if role == 3 & yr == 1970
        replace K_I1 = ER30070 if role == 3 & yr == 1971
        replace K_I1 = ER30094 if role == 3 & yr == 1972
        replace K_I1 = ER30120 if role == 3 & yr == 1973
        replace K_I1 = ER30141 if role == 3 & yr == 1974
        replace K_I1 = ER30163 if role == 3 & yr == 1975
        replace K_I1 = ER30191 if role == 3 & yr == 1976
        replace K_I1 = ER30220 if role == 3 & yr == 1977
        replace K_I1 = ER30249 if role == 3 & yr == 1978
        replace K_I1 = ER30286 if role == 3 & yr == 1979
        replace K_I1 = ER30316 if role == 3 & yr == 1980
        replace K_I1 = ER30346 if role == 3 & yr == 1981
        replace K_I1 = ER30376 if role == 3 & yr == 1982
        replace K_I1 = ER30402 if role == 3 & yr == 1983
        replace K_I1 = ER30432 if role == 3 & yr == 1984
        replace K_I1 = ER30466 if role == 3 & yr == 1985
        replace K_I1 = ER30501 if role == 3 & yr == 1986
        replace K_I1 = ER30538 if role == 3 & yr == 1987
        replace K_I1 = ER30573 if role == 3 & yr == 1988
        replace K_I1 = ER30609 if role == 3 & yr == 1989
        replace K_I1 = ER30645 if role == 3 & yr == 1990
        replace K_I1 = ER30692 if role == 3 & yr == 1991
        replace K_I1 = ER30736 if role == 3 & yr == 1992
        replace K_I1 = ER30809 if role == 3 & yr == 1993
        replace K_I1 = ER33104 if role == 3 & yr == 1994
        replace K_I1 = ER33204 if role == 3 & yr == 1995
        replace K_I1 = ER33304 if role == 3 & yr == 1996
        replace K_I1 = ER33404 if role == 3 & yr == 1997
        replace K_I1 = ER33504 if role == 3 & yr == 1999
        replace K_I1 = ER33604 if role == 3 & yr == 2001
        replace K_I1 = ER33704 if role == 3 & yr == 2003
        replace K_I1 = ER33804 if role == 3 & yr == 2005
        replace K_I1 = ER33904 if role == 3 & yr == 2007
        replace K_I1 = ER34004 if role == 3 & yr == 2009
        replace K_I1 = ER34104 if role == 3 & yr == 2011
        replace K_I1 = ER34204 if role == 3 & yr == 2013
        replace K_I1 = ER34305 if role == 3 & yr == 2015
        replace K_I1 = ER34504 if role == 3 & yr == 2017
        replace K_I1 = ER34704 if role == 3 & yr == 2019
        replace K_I1 = ER34904 if role == 3 & yr == 2021
        replace K_I1 = ER35104 if role == 3 & yr == 2023

        replace K_I1 = . if role != 3


/* 03. VARIABLES
        ** Z: FAMILY-YEAR CHARACTERISTICS **

        - EXPERIENCED CHANGE IN FAMILY STRUCTURE
        - EXPERIENCED LOSS 
        - EXPERIENCED GAIN
        - WHO LOST (RE: HEAD)
        - WHO GAINED (RE: HEAD)
        - WHO LOST (RE: SELF)
        - WHO GAINED (RE: SELF)

        ** Z: HOUSEHOLD-YEAR CHARACTERISTICS **

        - STATE
        - HOUSEHOLD INCOME
        - NO. PEOPLE IN HOUSEHOLD 

        ** I: INDIVIDUAL-YEAR CHARACTERISTICS **

        - AGE

        */

    /* 03a. K_Z1: K Experienced Change in FU */
        sort fam yr
        egen K_Z1 = min(V5710), by(fam yr)
        order famkid fam yr K_Z1  V5710
        replace K_Z1 = 0 if K_Z1 == .
        replace K_Z1 = 1 if K_Z1 > 0 
        replace K_Z1 = . if role != 3
        label var K_Z1 "K Experienced Change in FU"


    /* 03b. K_Z2 Exp Loss/Gain in FS, Net change in people*/
        sort fam yr
        egen K_Z2 = min(V5711), by(fam yr)
        egen K_Z3 = min(V5713), by(fam yr)
        g K_Z4 = K_Z2 - K_Z3

        replace K_Z2 = 0 if K_Z2 == .
        replace K_Z2 = 1 if K_Z2 > 0 
        replace K_Z2 = . if role != 3
        label var K_Z2 "K Experienced Gain in FU"

        replace K_Z3 = 0 if K_Z3 == .
        replace K_Z3 = 1 if K_Z3 > 0 
        replace K_Z3 = . if role != 3
        label var K_Z3 "K Experienced Loss in FU"


        replace K_Z4 = . if role != 3
        label var K_Z4 "K Net Change in No Adults"

    /* 03d. K_Z5: K Total Family Unit Income */
        sort fam yr
        egen K_Z5 = min(V6173), by(fam yr)
        replace K_Z5 = . if role != 3
        label var K_Z5 "K Total Family Unit Income"

   
/* 04. Trim Population */ 
    drop if role != 3
    * n= 185,050
    sort famkid yr
    * Keep only observations for which we have individual's age
    by famkid: drop if K_I1 == 0 & famkid == famkid[_n-1]

    * Drop if 17 or older at time of first observation
    egen min_age_temp = min(K_I1), by(famkid)
    drop if min_age_temp >= 17
    drop min_age_temp

    order famkid fam yr kid_number K_I1 K_Z1 K_Z2 K_Z3 K_Z4 K_Z5

/* 05. COUNT */
    * How many instances of HH gain in 1978?
        count if K_Z2 == 1 & K_I1 <= 18 & yr == 1978
            * 440

    * How many instances of HH loss in 1978?
        count if K_Z3 == 1 & K_I1 <= 18 & yr == 1978
            * 236


    
    sum K_Z5 if K_Z2 == 1 & K_I1 <= 18, d 











    /*  02e. K_I2 Birth Date 

            g K_I2 = .
            label var K_I2 "K Birth Date"
            replace K_I2 = yr - K_I1 
            replace K_I2 = . if role != 3 */


    /*  02f. K_I3 Born in 1965 or Later 
            g K_I3 = 0
            label var K_I3 "K Born in 1965 or Later"
            replace K_I3 = 1 if K_I2 >= 1965 & K_I2 != .
            replace K_I3 = . if role != 3 */


        /*  02g. K_Z1 Exp Change in Fam Struc
                V5703 = CHANGE IN FAMILY STRUCTURE 
                egen inyear_K_Z1 = max(K_Z1), by(fam yr)
                replace K_Z1 = inyear_K_Z1 if inyear_K_Z1 == 1 & role == 3
                replace K_Z1 = 0 if role != 3
                drop inyear_K_Z1

                replace ever_K_Z1 = 0 if role != 3
                replace ever_K_Z1 = 1 if ever_K_Z1 >0
                label var ever_K_Z1 "K Ever Exp Change in Fam Struc"
                label var K_Z1 "K Exp Change in Fam Struc" */











/*
  



    /* 02e. K_Z3: K State */
        g K_Z3 = V5703
        label var max_K_Z3 "K State"
        sort fam yr
        egen max_K_Z3 = max(K_Z3), by(fam yr)
        replace K_Z3 = max_K_Z3 if role == 3
        replace K_Z3 = . if role != 3
        drop max_K_Z3

/*

    /* 02d. K_Z4 */
        g K_Z4 = ???
        label var K_Z4 "Who Lost (RE: HEAD)"
        by(fam yr): replace K_Z4 = 0 if role != 3
        egen max_K_Z4 = max(K_Z4), by(fam yr)
        by(fam yr): replace K_Z4 = max_K_Z4 if role == 3
        drop max_K_Z4


    /* 02e. K_Z5 */
        g K_Z5 = ???
        label var K_Z5 "Who GAINED (RE: HEAD)"
        by(fam yr): replace K_Z5 = 0 if role != 3
        egen max_K_Z5 = max(K_Z5), by(fam yr)
        by(fam yr): replace K_Z5 = max_K_Z5 if role == 3
        drop max_K_Z5



/* 03. VARIABLES CREATED */

    /* 03b. K_Z6 */
        g K_Z6 = ???
        label var K_Z6 "Ever Experienced Ch Fam Struc"

    /* 03a. K_Z7 */
        g K_Z7 = ???
        label var K_Z7 "Who LOST (RE: SELF)"

    /* 03b. K_Z7 */
        g K_Z7 = ???
        label var K_Z7 "Who GAINED (RE: SELF)"


        - WHO LOST (RE: SELF)
        - WHO GAINED (RE: SELF)


/* 04. VARIABLES CONSTANT WITHIN CHILD FAMILY, VARY BY YEARS */
    /* 04a. AGE */
        g K_I7 = ??
        label var ddr "K AGE"

    /* 04b. RACE - DERIVED FROM HEAD RACE*/
        g K_I8 = V6209
        **COPY
        label var K_I8 "K RACE = HEAD RACE"

    /* */






order KZ_1

/*
    g first_kid = fam_number if role == 3
    egen min_first_kid = min(first_kid), by(fam)
    replace first_kid = 0 if first_kid > min_first_kid
    replace first_kid = 1 if first_kid != 0
    drop min_first_kid

    g second_kid = fam_number if role == 3 & first_kid != 1
    egen min_second_kid = min(second_kid), by(fam)
    replace second_kid =0 if second_kid > min_second_kid
    replace second_kid = 1 if second_kid != 0
    drop min_second_kid

    g third_kid = fam_number if role == 3 & first_kid != 1
    replace third_kid = . if second_kid == 1
    egen min_third_kid = min(third_kid), by(fam)
    replace min_third_kid =0 if third_kid > min_third_kid
    replace third_kid = 1 if third_kid != 0
    drop min_third_kid

    g kid_id = 1 if first_kid == 1 & second_kid == 0 & third_kid == 0
    replace kid_id = 2 if second_kid == 1 & first_kid == 0 & third_kid ==0 
    replace kid_id = 3 if third_kid == 1 & first_kid == 0 & second_kid == 0 

    order fam yr role kid_id
*/