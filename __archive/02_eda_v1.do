****************************
* Sarah Sullivan 
* Created: November 17, 2025
* Last Updated: November 17, 2025
* 02_eda_v1.do
****************************
/* 
SOURCE: Fomby, Paula. 2024. The Panel Study of Income Dynamics Family Composition File User Guide:
Early Release. Data release <release number>, Ann Arbor, MI: Survey Research Center, Institute
for Social Research, University of Michigan. <Open ICPSR DOI>. 
*/
************************************
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
    log using "$root/_log/02_eda_v1_`datetime'.log", replace

    * Switches
    local part1 1
    local part2 0
    local part3 0
    local part4 0
    local part5 0


/* ******************** */
* PART I: 
* Load in data
* Empirical growth plot
/* ******************** */ 

if `part1' == 1 {
    /* 01. Load in data */
    cd "$root"
    use "01_family_structure_v11.dta", clear

    sort fam ID yr
    
    egen never_kid = min(age), by(ID)
    drop if never_kid > 18
    drop  never_kid

    /* hh_income winsor */
    winsor2 FU_income, cuts(5 95)
    sum FU_income_w, d

    /* Family structure change variables */ 
    local strings who_left who_came ages_left ages_came hhr_prev ages_prev
    local nums adult_came adult_left n_adults_came n_adults_left child_came child_left fu_change adult_change

    foreach var of local strings {
        replace `var' = "" if yr == yr_first_observed
    }

    foreach var of local nums {
        replace `var' = . if yr == yr_first_observed
    }


    /* CPI */
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


    sort ID yr

    /* 01. Interactions & treatment variables*/

    drop if age > 16
    egen wave_count = count(yr), by(ID)
    drop if wave_count < 2
    drop wave_count

    /* log family income */
    * income adjusted for inflation 
    g fam_income_real_w = FU_income_w[_n+1] / cpi * 100 if ID == ID[_n+1]

    g fu_p_1 = fam_income_real_w[_n+1] if ID == ID[_n+1]
    g lfu = log(fu_p_1)

    /* adult gain/loss variables */
    g both = 1 if adult_came == 1 & adult_left == 1
    replace both = 0 if both == . & ID == ID[_n-1]

    g decade = 1 if yr >= 1968 & yr <= 1977
    replace decade = 2 if yr >= 1978 & yr <= 1987
    replace decade = 3 if yr >= 1988 & yr <= 1997
    replace decade = 4 if yr >= 1998 & yr <= 2007
    replace decade = 5 if yr >= 2008 & yr <= 2017
    replace decade = 6 if yr >= 2018 & yr <= 2021

    sort ID yr
    g time = yr - yr_first_observed
    g race1 = race if yr_first_observed == yr
    replace race1 = 0 if race1 == .
    egen race2 = max(race1), by(ID)
    replace race2 = . if race2 == 9
    replace race2 = . if race2 == 0
    g nonwhite = 1 if race2 != 1
    replace nonwhite = 0 if race2 == 1
    replace nonwhite = . if race2 == .

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
}


if `part2' == 1{
    * regression
    xtset ID time
    xtreg lfu time i.yr adult_came adult_left both, fe cluster(fam)
    estimates store fe1
    xtreg lfu time i.yr adult_came adult_left both adult_came##c.nonwhite adult_left##c.nonwhite both##c.nonwhite, fe cluster(fam)
    estimates store fe2
    esttab fe1 fe2 using "fe_models_table2.tex", replace label se star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) booktabs alignment(S S) compress fragment substitute(\_ _) mtitles("Baseline FE" "FE + Race Interactions") drop(*yr*) addnotes("Cluster-robust standard errors at the family level in parentheses.", "Year fixed effects included but omitted from table.")

}



if `part3' == 1 {
    bysort ID: egen fam_mean_income = mean(lfu)
    g inc_within = lfu - fam_mean_income

    preserve
    keep if ever_came == 1
    collapse (mean) inc_within ever_came ever_left ever_both nonwhite, by(yr)
    twoway(line inc_within yr if ever_left==1, lcolor(red) lwidth(medthick) lpattern(solid) legend(label(1 "Experienced Loss"))) (line inc_within yr if ever_adult_came==1, lcolor(blue) lwidth(medthick) lpattern(dash) legend(label(2 "Experienced Gain"))) (line inc_within yr if ever_both==1, lcolor(green) lwidth(medthick) lpattern(dot) legend(label(3 "Experienced Both"))), ytitle("Change in Log Income") xtitle("Year") title("Average Within-Household Income Change Over Time") legend(order(1 2 3))
    restore 

    








    collapse (mean) lfu, by(yr adult_came adult_left both)
    twoway (line log_fam_income_real_w yr if adult_came == 1, sort lpattern(solid) lcolor(blue) legend(label(1 "Gain"))) (line fam_income_real_w yr if adult_left == 1, sort lpattern(solid) lcolor(red) legend(label(2 "Loss"))) (line fam_income_real_w yr if both == 1, sort lpattern(solid) lcolor(green) legend(label(3 "Both"))), ytitle("Family Income (2021 USD)") xtitle("Year") title("Family Income Trajectories by Type of Change Experienced") legend(order(1 2 3))

}




















    collapse (mean) lfu, by(yr adult_came adult_left both)

    twoway (line log_fam_income_real_w yr if adult_came == 1, sort lpattern(solid) lcolor(blue) legend(label(1 "Gain"))) (line fam_income_real_w yr if adult_left == 1, sort lpattern(solid) lcolor(red) legend(label(2 "Loss"))) (line fam_income_real_w yr if both == 1, sort lpattern(solid) lcolor(green) legend(label(3 "Both"))), ytitle("Family Income (2021 USD)") xtitle("Year") title("Family Income Trajectories by Type of Change Experienced") legend(order(1 2 3))

    restore

    g change_in_income = fam_income_real_w - fam_income_real_w[_n-1] if ID == ID[_n-1]
    g pct_change_income = (change_in_income / fam_income_real_w[_n-1]) * 100 if ID == ID[_n-1] & fam_income_real_w[_n-1] != 0

    preserve
    collapse (mean) pct_change_income, by(yr adult_came adult_left both)

    keep if yr < 1990
    twoway (line pct_change_income yr if adult_came == 1, sort lpattern(solid) lcolor(blue) legend(label(1 "Gain"))) (line pct_change_income yr if adult_left == 1, sort lpattern(solid) lcolor(red) legend(label(2 "Loss"))) (line pct_change_income yr if both == 1, sort lpattern(solid) lcolor(green) legend(label(3 "Both"))), ytitle("% Change in Family Income") xtitle("Year") title("Family Income Trajectories by Type of Change Experienced") legend(order(1 2 3))











