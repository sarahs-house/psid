****************************
* Sarah Sullivan 
* Created: December 13, 2025
* 03_final_paper_v1.do
****************************
/* 
SOURCE: Fomby, Paula. 2024. The Panel Study of Income Dynamics Family Composition File User Guide:
Early Release. Data release <release number>, Ann Arbor, MI: Survey Research Center, Institute
for Social Research, University of Michigan. <Open ICPSR DOI>. 
*/
************************************


/* 00. Program Set Up */
    clear all
    set more off
    cap log close

    set maxvar 32767

    cd "$root"

    local date = subinstr("`c(current_date)'", "/", "-", .)
    local time = subinstr("`c(current_time)'", ":", "-", .z)
    local datetime = "`date'_`time'"
    log using "$root/_log/03_final_paper_v1_`datetime'.log", replace

    * Switches
    local part1 1
    local part2 0
    local part3 0
    local part4 0
    local part5 0

/* ******************** */
* PART I: 
* Load in data & make variables
/* ******************** */

if `part1' == 1 {
    /* 01. Load in data */
    cd "$root"
    use "01_family_structure_v12.dta", clear

    sort ID yr
    /* 01. Population trimming: Some kids slip through */
        egen never_kid = min(age), by(ID)
        drop if never_kid > 16
        drop  never_kid

    /* 02. Family structure change variables */ 
        local strings who_left who_came ages_left ages_came hhr_prev ages_prev sib_ages_came sib_ages_left

        local nums adult_came adult_left n_adults_came n_adults_left child_came sib_came  sib_left child_left fu_change adult_change gpar_came par_came other_came gpar_left par_left other_left no_in no_out

        foreach var of local strings {
            replace `var' = "" if yr == yr_first_observed
        }

        foreach var of local nums {
            replace `var' = . if yr == yr_first_observed
        }


    /* 03. CPI 
        DECEMBER 13 QUESTION: WHERE DID YOU GET THIS?? */
        g cpi = . 
        replace cpi = 34.8  if yr == 1968
        replace cpi = 36.7  if yr == 1969
        replace cpi = 38.8  if yr == 1970
        replace cpi = 40.5  if yr == 1971
        replace cpi = 41.8  if yr == 1972
        replace cpi = 44.4  if yr == 1973
        replace cpi = 49.3  if yr == 1974
        replace cpi = 53.8  if yr == 1975
        replace cpi = 56.9  if yr == 1976
        replace cpi = 60.6  if yr == 1977
        replace cpi = 65.2  if yr == 1978
        replace cpi = 72.6  if yr == 1979
        replace cpi = 82.4  if yr == 1980
        replace cpi = 90.9  if yr == 1981
        replace cpi = 96.5  if yr == 1982
        replace cpi = 99.6  if yr == 1983
        replace cpi = 103.9 if yr == 1984
        replace cpi = 107.6 if yr == 1985
        replace cpi = 109.6 if yr == 1986
        replace cpi = 113.6 if yr == 1987
        replace cpi = 118.3 if yr == 1988
        replace cpi = 124.0 if yr == 1989
        replace cpi = 130.7 if yr == 1990
        replace cpi = 136.2 if yr == 1991
        replace cpi = 140.3 if yr == 1992
        replace cpi = 144.5 if yr == 1993
        replace cpi = 148.2 if yr == 1994
        replace cpi = 152.4 if yr == 1995
        replace cpi = 156.9 if yr == 1996
        replace cpi = 160.5 if yr == 1997
        replace cpi = 163.0 if yr == 1998
        replace cpi = 166.6 if yr == 1999
        replace cpi = 172.2 if yr == 2000
        replace cpi = 177.1 if yr == 2001
        replace cpi = 179.9 if yr == 2002
        replace cpi = 184.0 if yr == 2003
        replace cpi = 188.9 if yr == 2004
        replace cpi = 195.3 if yr == 2005
        replace cpi = 201.6 if yr == 2006
        replace cpi = 207.3 if yr == 2007
        replace cpi = 215.3 if yr == 2008
        replace cpi = 214.5 if yr == 2009
        replace cpi = 218.1 if yr == 2010
        replace cpi = 224.9 if yr == 2011
        replace cpi = 229.6 if yr == 2012
        replace cpi = 233.0 if yr == 2013
        replace cpi = 236.7 if yr == 2014
        replace cpi = 237.0 if yr == 2015
        replace cpi = 240.0 if yr == 2016
        replace cpi = 245.1 if yr == 2017
        replace cpi = 251.1 if yr == 2018
        replace cpi = 255.7 if yr == 2019
        replace cpi = 258.8 if yr == 2020
        replace cpi = 271.0 if yr == 2021
        replace cpi = 292.7 if yr == 2022
        replace cpi = 304.7 if yr == 2023
        replace cpi = 313.7 if yr == 2024
        replace cpi = 322.3 if yr == 2025
    
    

    /* 04. HH income inflation and winsor and log family income (winsor and cpi adjusted = lfu*/
        winsor2 FU_income, cuts(5 95)
        g FU_income_w_real = FU_income_w[_n+1] / cpi * 100 if ID == ID[_n+1]
        g lfu = log(FU_income_w_real)

    /* 05. GET RID OF ADULT OBSERVATIONS & KIDS NOT OBSERVED AT 1*/
        drop if age > 16
        egen min_age = min(age), by(ID)

        drop if min_age != 1


    /* 06. adult gain/loss/both/never variables 
        ever adult gain/loss/both */
        g both = 1 if adult_came == 1 & adult_left == 1
        replace both = 0 if both == . & ID == ID[_n-1]

        g both1 = both
        replace both1 = 0 if both == . 
        egen ever_both = max(both1), by(ID)
        drop both1

        g adult_left1 = adult_left
        replace adult_left1 = 0 if adult_left == . 
        egen ever_left = max(adult_left1), by(ID)
        drop adult_left1

        g adult_came1 = adult_came  
        replace adult_came1 = 0 if adult_came == . 
        egen ever_came = max(adult_came1), by(ID)
        drop adult_came1

        replace adult_came = 0 if both == 1
        replace adult_left = 0 if both == 1

        g never_left = 1 if ever_left == 0
        replace never_left = 0 if ever_left == 1
        g never_came = 1 if ever_came == 0
        replace never_came = 0 if ever_came == 1
        g never_both = 1 if ever_both == 0
        replace never_both = 0 if ever_both == 1
        g never_any = 1 if ever_left == 0 & ever_came == 0 & ever_both == 0
        replace never_any = 0 if ever_left == 1 | ever_came == 1 | ever_both == 1

        g ever_change = 1 if ever_came == 1 | ever_left == 1 | ever_both == 1
        replace ever_change = 0 if ever_change == .
        g never_change = 1 if ever_change == 0
        replace never_change = 0 if ever_change == 1

    /* relationship */
        g bio_mom_in_who_came = 0
        g bio_dad_in_who_came = 0
        g bio_mom_in_who_left = 0
        g bio_dad_in_who_left = 0
        
        replace bio_mom_in_who_came = 1 if strpos(who_came, string(bio_mom_id)) > 0 & bio_mom_id != . & who_came != ""
        replace bio_dad_in_who_came = 1 if strpos(who_came, string(bio_dad_id)) > 0 & bio_dad_id != . & who_came != ""
        replace bio_mom_in_who_left = 1 if strpos(who_left, string(bio_mom_id)) > 0 & bio_mom_id != . & who_left != ""
        replace bio_dad_in_who_left = 1 if strpos(who_left, string(bio_dad_id)) > 0 & bio_dad_id != . & who_left != ""
        
        g bio_parent_came = 1 if bio_mom_in_who_came == 1 | bio_dad_in_who_came == 1
        replace bio_parent_came = 0 if bio_parent_came == .
        
        g bio_parent_left = 1 if bio_mom_in_who_left == 1 | bio_dad_in_who_left == 1
        replace bio_parent_left = 0 if bio_parent_left == .
        
        g sibling_in_who_came = 0
        g sibling_in_who_left = 0
        
        forvalues i = 1/9 {
            replace sibling_in_who_came = 1 if strpos(who_came, string(id_s0`i')) > 0 & id_s0`i' != . & who_came != "" & `i' < 10
            replace sibling_in_who_left = 1 if strpos(who_left, string(id_s0`i')) > 0 & id_s0`i' != . & who_left != "" & `i' < 10
        }

        forvalues i = 10/16{
            replace sibling_in_who_came = 1 if strpos(who_came, string(id_s`i')) > 0 & id_s`i' != . & who_came != "" & `i' >= 10
            replace sibling_in_who_left = 1 if strpos(who_left, string(id_s`i')) > 0 & id_s`i' != . & who_left != "" & `i' >= 10
        }
        g relative_came = 1 if bio_parent_came == 1 | sibling_in_who_came == 1
        replace relative_came = 0 if relative_came == .

        g relative_left = 1 if bio_parent_left == 1 | sibling_in_who_left == 1
        replace relative_left = 0 if relative_left == .


    /* 06. decade */
        g decade = 1 if yr >= 1968 & yr <= 1977
        replace decade = 2 if yr >= 1978 & yr <= 1987
        replace decade = 3 if yr >= 1988 & yr <= 1997
        replace decade = 4 if yr >= 1998 & yr <= 2007
        replace decade = 5 if yr >= 2008 & yr <= 2017
        replace decade = 6 if yr >= 2018 & yr <= 2021

    /* 07. time */ 
        sort ID yr
        g time = yr - yr_first_observed
        label var time "years since first observed"

    /* 08. race / nonwhite */
        g race1 = race if yr == yr_first_observed 
        replace race1 = 0 if race1 == .

        egen race2 = max(race1), by(ID)
        count if race2 == 9 & ID != ID[_n+1]
        count if race2 == 0 & ID != ID[_n+1]
        count if ID != ID[_n+1]

        replace race2 = . if race2 == 9
        replace race2 = . if race2 == 0
        g nonwhite = 1 if race2 != 1
        replace nonwhite = 0 if race2 == 1
        replace nonwhite = . if race2 == .

        drop race race1 race2

    /* 09. max education */
        replace ed = 0 if ed == 98                  
        replace ed = 0 if ed == 99        
        replace ed = 0 if  yr == 1969
        egen max_education = max(ed), by(ID)
    
    /* 10. max education in buckets */
        /* these are all high school when you drop the adult obs */
        g max_ed_bucket = "Unknown" if max_education == 0
        replace max_ed_bucket ="< High School" if max_education < 12 & max_education != 0
        replace max_ed_bucket = "High School" if max_education == 12
        replace max_ed_bucket = "College" if max_education > 12 
    /* 11. SAVE */
        save 03_final_paper_v3.dta, replace

}


/* ******************** */
* PART II: 
* EDA
/* ******************** */

if `part2' == 1{
    g head_ed_collapse = head_ed if yr == yr_first_observed
    replace head_ed_collapse = -1 if head_ed_collapse == 0 | head_ed_collapse == 99
    egen born_head_ed = max(head_ed_collapse), by(ID)

    replace sex = -1 if sex == .
    egen max_sex = max(sex), by(ID)

    g fu_collapse = FU_income_w_real if yr == yr_first_observed
    egen born_fu = max(fu_collapse), by(ID)

    g hhr_count = 0
    replace hhr_count = 1 if hhr_ != "" & hhr_ != "[]"
    replace hhr_count = length(hhr_) - length(subinstr(hhr_, ",", "", .)) + 1 if hhr_ != "" & hhr_ != "[]"
    replace hhr_count = 0 if hhr_ == "[]" | hhr_ == ""

    g born_hhr = hhr_count if yr == yr_first_observed

    preserve
    collapse (mean) lfu ever_change never_change ever_left never_left ever_came never_came ever_both never_both nonwhite born_fu max_sex born_hhr born_head_ed, by(ID)
    
}


/* ******************** */
* PART III: 
* REGRESSION
/* ******************** */

if `part3' == 1 {
    * regression
       *OLS
       g age_sq = age*age
       restore
        reg lfu age i.yr ever_left nonwhite born_head_ed hhr_count age age_sq, cluster(fam)
        reg lfu age i.yr ever_came  nonwhite born_head_ed hhr_count age age_sq, cluster(fam)
        reg lfu age i.yr ever_both nonwhite born_head_ed hhr_count age age_sq, cluster(fam)

        * Fixed effects

        * Generate lead/lag dummy variables for adult_came
            sort ID yr
            gen adult_came_2before = 0
            gen adult_came_1before = 0
            gen adult_came_1after = 0
            gen adult_came_2after = 0

            replace adult_came_2before = 1 if adult_came[_n+2] == 1 & ID == ID[_n+2]
            replace adult_came_1before = 1 if adult_came[_n+1] == 1 & ID == ID[_n+1]
            replace adult_came_1after = 1 if adult_came[_n-1] == 1 & ID == ID[_n-1]
            replace adult_came_2after = 1 if adult_came[_n-2] == 1 & ID == ID[_n-2]

            * Generate lead/lag dummy variables for adult_left
            gen adult_left_2before = 0
            gen adult_left_1before = 0
            gen adult_left_1after = 0
            gen adult_left_2after = 0

            replace adult_left_2before = 1 if adult_left[_n+2] == 1 & ID == ID[_n+2]
            replace adult_left_1before = 1 if adult_left[_n+1] == 1 & ID == ID[_n+1]
            replace adult_left_1after = 1 if adult_left[_n-1] == 1 & ID == ID[_n-1]
            replace adult_left_2after = 1 if adult_left[_n-2] == 1 & ID == ID[_n-2]

            * Generate lead/lag dummy variables for both
            gen both_2before = 0
            gen both_1before = 0
            gen both_1after = 0
            gen both_2after = 0

            replace both_2before = 1 if both[_n+2] == 1 & ID == ID[_n+2]
            replace both_1before = 1 if both[_n+1] == 1 & ID == ID[_n+1]
            replace both_1after = 1 if both[_n-1] == 1 & ID == ID[_n-1]
            replace both_2after = 1 if both[_n-2] == 1 & ID == ID[_n-2]

        xtset ID age
        xtreg lfu i.yr adult_left_2before adult_left_1before adult_left adult_left_1after adult_left_2after age age_sq , fe cluster(fam)
        xtreg lfu i.yr adult_came_2before adult_came_1before adult_came adult_came_1after adult_came_2after age age_sq , fe cluster(fam)
        xtreg lfu i.yr both_2before both_1before both both_1after both_2after age age_sq , fe cluster(fam)

        g reltype = 1 if bio_parent_came == 1 | bio_parent_left == 1
        replace reltype = 2 if reltype != 1


        * Adjust reltype for lead/lag variables based on actual change periods
        sort ID yr
        replace reltype = reltype[_n+2] if adult_left_2before == 1 & ID == ID[_n+2]
        replace reltype = reltype[_n+1] if adult_left_1before == 1 & ID == ID[_n+1]
        replace reltype = reltype[_n-1] if adult_left_1after == 1 & ID == ID[_n-1]
        replace reltype = reltype[_n-2] if adult_left_2after == 1 & ID == ID[_n-2]

        replace reltype = reltype[_n+2] if adult_came_2before == 1 & ID == ID[_n+2]
        replace reltype = reltype[_n+1] if adult_came_1before == 1 & ID == ID[_n+1]
        replace reltype = reltype[_n-1] if adult_came_1after == 1 & ID == ID[_n-1]
        replace reltype = reltype[_n-2] if adult_came_2after == 1 & ID == ID[_n-2]

        replace reltype = reltype[_n+2] if both_2before == 1 & ID == ID[_n+2]
        replace reltype = reltype[_n+1] if both_1before == 1 & ID == ID[_n+1]
        replace reltype = reltype[_n-1] if both_1after == 1 & ID == ID[_n-1]
        replace reltype = reltype[_n-2] if both_2after == 1 & ID == ID[_n-2]

        g left_parent = 1 if reltype == 1 & adult_left == 1
        replace left_parent = 0 if left_parent != 1
        g came_parent = 1 if reltype == 1 & adult_came == 1
        replace came_parent = 0 if came_parent != 1

        xtreg lfu i.yr adult_left_*##i.left_parent age age_sq, fe cluster(fam)

        xtreg lfu i.yr i.reltype##(adult_left_2before adult_left_1before adult_left adult_left_1after adult_left_2after) age age_sq, fe cluster(fam)
        xtreg lfu i.yr i.reltype##(adult_came_2before adult_came_1before adult_came adult_came_1after adult_came_2after) age age_sq, fe cluster(fam)
        xtreg lfu i.yr i.reltype##(both_2before both_1before both both_1after both_2after) age age_sq, fe cluster(fam)



}


















/*

    collapse (mean) lfu, by(yr adult_came adult_left both)

    twoway (line log_fam_income_real_w yr if adult_came == 1, sort lpattern(solid) lcolor(blue) legend(label(1 "Gain"))) (line fam_income_real_w yr if adult_left == 1, sort lpattern(solid) lcolor(red) legend(label(2 "Loss"))) (line fam_income_real_w yr if both == 1, sort lpattern(solid) lcolor(green) legend(label(3 "Both"))), ytitle("Family Income (2021 USD)") xtitle("Year") title("Family Income Trajectories by Type of Change Experienced") legend(order(1 2 3))

    restore

    g change_in_income = fam_income_real_w - fam_income_real_w[_n-1] if ID == ID[_n-1]
    g pct_change_income = (change_in_income / fam_income_real_w[_n-1]) * 100 if ID == ID[_n-1] & fam_income_real_w[_n-1] != 0

    preserve
    collapse (mean) pct_change_income, by(yr adult_came adult_left both)

    keep if yr < 1990
    twoway (line pct_change_income yr if adult_came == 1, sort lpattern(solid) lcolor(blue) legend(label(1 "Gain"))) (line pct_change_income yr if adult_left == 1, sort lpattern(solid) lcolor(red) legend(label(2 "Loss"))) (line pct_change_income yr if both == 1, sort lpattern(solid) lcolor(green) legend(label(3 "Both"))), ytitle("% Change in Family Income") xtitle("Year") title("Family Income Trajectories by Type of Change Experienced") legend(order(1 2 3))




    bysort ID: egen fam_mean_income = mean(lfu)
    g inc_within = lfu - fam_mean_income

    preserve
    keep if ever_came == 1
    collapse (mean) inc_within ever_came ever_left ever_both nonwhite, by(yr)
    twoway(line inc_within yr if ever_left==1, lcolor(red) lwidth(medthick) lpattern(solid) legend(label(1 "Experienced Loss"))) (line inc_within yr if ever_adult_came==1, lcolor(blue) lwidth(medthick) lpattern(dash) legend(label(2 "Experienced Gain"))) (line inc_within yr if ever_both==1, lcolor(green) lwidth(medthick) lpattern(dot) legend(label(3 "Experienced Both"))), ytitle("Change in Log Income") xtitle("Year") title("Average Within-Household Income Change Over Time") legend(order(1 2 3))
    restore 

    collapse (mean) lfu, by(yr adult_came adult_left both)
    twoway (line log_fam_income_real_w yr if adult_came == 1, sort lpattern(solid) lcolor(blue) legend(label(1 "Gain"))) (line fam_income_real_w yr if adult_left == 1, sort lpattern(solid) lcolor(red) legend(label(2 "Loss"))) (line fam_income_real_w yr if both == 1, sort lpattern(solid) lcolor(green) legend(label(3 "Both"))), ytitle("Family Income (2021 USD)") xtitle("Year") title("Family Income Trajectories by Type of Change Experienced") legend(order(1 2 3))








