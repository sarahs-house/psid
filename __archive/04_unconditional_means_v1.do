****************************
* Sarah Sullivan 
* Created September 26, 2025
* 03_unconditional_means_v1.do
****************************
/* Fomby, Paula. 2024. The Panel Study of Income Dynamics Family Composition File User Guide:
Early Release. Data release <release number>, Ann Arbor, MI: Survey Research Center, Institute
for Social Research, University of Michigan. <Open ICPSR DOI>. */
************************************
    clear all

    set maxvar 32767

/* 00. program setup */
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


    /* 02. VARIABLES
            ** FAMILY-YEAR CHARACTERISTICS **

            - EXPERIENCED CHANGE IN FAMILY STRUCTURE
            - EXPERIENCED LOSS 
            - EXPERIENCED GAIN
            - WHO LOST (RE: HEAD)
            - WHO GAINED (RE: HEAD)
            - WHO LOST (RE: SELF)
            - WHO GAINED (RE: SELF)

            ** HOUSEHOLD-YEAR CHARACTERISTICS **

            - STATE
            - HOUSEHOLD INCOME
            - NO. PEOPLE IN HOUSEHOLD 

            ** INDIVIDUAL-YEAR CHARACTERISTICS **

            - AGE

            */

        /* 02a. K_Z1: K Experienced Change in FU */
            g K_Z1 = V5710
            replace K_Z1 = 0 if K_Z1 == .
            replace K_Z1 = 1 if K_Z1 > 0
            replace K_Z1 = . if role != 3
            label var K_Z1 "K Experienced Change in FU"


        /* 02b. K_Z2: K State */
            g K_Z2 = V5703
            label var K_Z2 "K State"
            sort fam yr
            egen max_K_Z2 = max(K_Z2), by(fam yr)
            replace K_Z2 = max_K_Z2 if role == 3
            replace K_Z2 = . if role != 3
            drop max_K_Z2


        /* 02c. K_Z3: K Total Family Unit Income */
            g K_Z3 = V6173
            label var K_Z3 "K Total Family Unit Income"
            sort fam yr
            egen max_K_Z3 = max(K_Z3), by(fam yr)
            replace K_Z3 = max_K_Z3 if role == 3
            replace K_Z3 = . if role != 3
            drop max_K_Z3
    

        /* 02d. K_I1: K Age of Individual */
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

    /*  02c. K_I2 Birth Date */

            g K_I2 = .
            label var K_I2 "K Birth Date"
            replace K_I2 = yr - K_I1 
            replace K_I2 = . if role != 3


    /*  02d. K_I3 Born in 1965 or Later */
            g K_I3 = 0
            label var K_I3 "K Born in 1965 or Later"
            replace K_I3 = 1 if K_I2 >= 1965 & K_I2 != .
            replace K_I3 = . if role != 3

/* 01. Unconditional Means Model 

    * September 26, 2025

    * L1: Yij = B0i + eij
        * L2: B0i = g00 + u0i

    * i's = children, [1,...,n]
    * j's = years, [1968,...,1992]
    * Yij = FU income (V6173 --> Total Family Unit Income)

    */

    preserve 
    * Keep only heads
    drop if fam_number != 1
   
    * Standardize yr: 
    g yr_st = yr-1968
    label var yr_st "Year Standardized"
    order fam fam_number role yr yr_st V5703
    mixed V6173 || yr_st:yr_st, cov(unstructured) vce(robust)

    restore

/* 02. 