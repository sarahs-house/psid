****************************
* Sarah Sullivan 
* October 26, 2025
* Last Updated: October 26, 2025
* 02_tables_v1.do
****************************
/* 
SOURCE: Fomby, Paula. 2024. The Panel Study of Income Dynamics Family Composition File User Guide:
Early Release. Data release <release number>, Ann Arbor, MI: Survey Research Center, Institute
for Social Research, University of Michigan. <Open ICPSR DOI>. 

This data set contains all individuals observed as children in the PSID between 1968 and 2021.
*/
************************************

/* 00. Program Set Up */
    cap restore
    clear all
    set more off
    cap log close

    set maxvar 32767

    cd "$root"

    local date = subinstr("`c(current_date)'", "/", "-", .)
    local time = subinstr("`c(current_time)'", ":", "-", .z)
    local datetime = "`date'_`time'"
    log using "$root/_log/02_tables_v1_`datetime'.log", replace


/* 01. Load in data */
    use "$root/01_kids_panel_v9.dta", clear
    drop ER* 


    /*  01a. RACE */
    g Race = "White" if race == 1
    replace Race = "Black" if race == 2
    replace Race = "Hispanic/Latino" if race == 3
    replace Race = "Asian" if race == 4
    replace Race = "Missing" if race == 9
    replace Race = "Other" if Race == ""










/* 02. Winsorize income + log income */
    winsor2 FU_income, cuts(1 99)
    g ln_income = ln(FU_income_w + 1)

/* 03. Defining the event 
    adult_event: event type indicator
    = 1 if adult arrival
    = -1 if adult departure
    = 0 if no adult change

    = 2 if both arrival and departure
    = 3 if only arrival 
    = 4 if only departure

    = 5 if net_adult_change > 0 
    = 6 if net_adult_change < 0 */

    g adult_event = .
    g net_adult_change = n_adults_came - n_adults_left

            *replace adult_event = 1 if adult_came ==1 
            *replace adult_event = -1 if adult_left ==1
            *replace adult_event = 0 if adult_change == 0

    * came didn't leave
    replace adult_event = 0 if adult_came ==0 & adult_left ==0
    replace adult_event = 1 if adult_came ==1 & adult_left ==0
    * left didn't come
    replace adult_event = 2 if adult_left ==1 & adult_came ==0
    * came and left, net change positive or negative
    replace adult_event = 3 if adult_left ==1 & adult_came ==1 & net_adult_change > 0
    replace adult_event = 4 if adult_left ==1 & adult_came ==1 & net_adult_change < 0
        * "replacement"
        replace adult_event= 5 if adult_came ==1 & adult_left ==1 & net_adult_change == 0 


/* 03. Defining time */
    xtset ID yr

    bys ID (yr): g yr_change = yr if adult_event != 0 
    bys ID: egen first_change = min(yr_change)
    replace first_change = . if missing(first_change)

    g t_change = yr - first_change if !missing(first_change)
    replace t_change = . if t_change < -10 | t_change > 10


/* 03. Program for event-study regression by kind of change */

program define run_eventstudy, rclass
    syntax , eventtype(integer) label(string)
    
    preserve
        * Keep only relevant event type
        keep if adult_event == `eventtype'
        
        * Create event-time dummies, -1 as baseline
        tabulate t_change, generate(tchange_)

        * Drop baseline (-1)
        capture drop tchange_m1
        capture rename tchange__1 tchange_m1
        
        xtreg ln_income tchange_*, fe vce(cluster ID)

        * Store coefficients in temporary file
        parmest, saving(eventstudy_`label', replace)
    restore
end


/* 04. Pass event types as function args */
    run_eventstudy, eventtype(1) label(arrival)
    run_eventstudy, eventtype(2) label(departure)
    run_eventstudy, eventtype(3) label(net_positive)
    run_eventstudy, eventtype(4) label(net_negative)
    run_eventstudy, eventtype(5) label(replacement)

/* 04*** SAVE SAVE SAVE SAVE */
    save "$root/02_tables_v1.dta", replace

/* 05. Confidence intervals, merge, plot */
    clear
    local types departure net_positive net_negative replacement
    tempfile all

    use eventstudy_arrival, clear
    gen ci_low  = estimate - 1.96 * stderr
    gen ci_high = estimate + 1.96 * stderr
    gen event = "arrival"
    g rel_year_num = _n
    save `all', replace
    
    foreach t of local types {
        use eventstudy_`t', clear
        gen ci_low  = estimate - 1.96 * stderr
        gen ci_high = estimate + 1.96 * stderr
        gen event = "`t'"
        g rel_year_num = _n
        append using `all'
        save `all', replace
    }

    use `all', clear


/* Plot */
    drop if rel_year_num > 10 
    * 5 cats 
        twoway (rcap ci_high ci_low rel_year_num if event=="arrival", lcolor(blue%40)) (line estimate rel_year_num if event=="arrival", lcolor(blue) lwidth(medthick)) (rcap ci_high ci_low rel_year_num if event=="departure", lcolor(red%40)) (line estimate rel_year_num if event=="departure", lcolor(red) lwidth(medthick)) (rcap ci_high ci_low rel_year_num if event=="net_positive", lcolor(green%40)) (line estimate rel_year_num if event=="net_positive", lcolor(green) lwidth(medthick)) (rcap ci_high ci_low rel_year_num if event=="net_negative", lcolor(orange%40)) (line estimate rel_year_num if event=="net_negative", lcolor(orange) lwidth(medthick)) (rcap ci_high ci_low rel_year_num if event=="replacement", lcolor(gs8%40)) (line estimate rel_year_num if event=="replacement", lcolor(gs8) lwidth(medthick)), xline(0, lpattern(dash) lcolor(gs8)) yline(0, lpattern(solid) lcolor(gs10)) legend(order(2 "Arrival" 4 "Departure" 6 "Net + Adult" 8 "Net − Adult" 10 "Replacement") pos(1) ring(0) cols(5)) title("Event Study: Family Income Around Household Composition Changes") ytitle("Change in log(Family Income)") xtitle("Years Relative to Event") ylabel(, angle(horizontal)) graphregion(color(white)) bgcolor(white) xscale(range(0 10))

    graph export "figure1_eventstudy_all_v1.png", replace width(2000)





/* 03. Defining the event: JUST NET GAIN/ LOSS  */

    replace adult_event = .

    * came and left, net change positive or negative
    replace adult_event = 3 if net_adult_change > 0 & net_adult_change != .
    replace adult_event = 4 if net_adult_change < 0 & net_adult_change != . 
        * "replacement"
        replace adult_event= 5 if net_adult_change == 0 & adult_came == 1 & adult_left == 1


/* 04. Pass event types as function args */
    run_eventstudy, eventtype(3) label(net_positive)
    run_eventstudy, eventtype(4) label(net_negative)
    run_eventstudy, eventtype(5) label(replacement)


/* 05. Confidence intervals, merge, plot */
    clear
    local types net_negative replacement
    tempfile all1

    use eventstudy_net_positive, clear
    gen ci_low  = estimate - 1.96 * stderr
    gen ci_high = estimate + 1.96 * stderr
    gen event = "net_positive"
    g rel_year_num = _n
    save `all1', replace
    
    foreach t of local types {
        use eventstudy_`t', clear
        gen ci_low  = estimate - 1.96 * stderr
        gen ci_high = estimate + 1.96 * stderr
        gen event = "`t'"
        g rel_year_num = _n
        append using `all1'
        save `all1', replace
    }

    use `all1', clear


/* Plot */
drop if rel_year_num > 10 
* 3 cats 
    twoway (rcap ci_high ci_low rel_year_num if event=="net_positive", lcolor(green%40)) (line estimate rel_year_num if event=="net_positive", lcolor(green) lwidth(medthick)) (rcap ci_high ci_low rel_year_num if event=="net_negative", lcolor(orange%40)) (line estimate rel_year_num if event=="net_negative", lcolor(orange) lwidth(medthick)) (rcap ci_high ci_low rel_year_num if event=="replacement", lcolor(gs8%40)) (line estimate rel_year_num if event=="replacement", lcolor(gs8) lwidth(medthick)), xline(0, lpattern(dash) lcolor(gs8)) yline(0, lpattern(solid) lcolor(gs10)) legend(order(2 "Net + Adult" 4 "Net − Adult" 6 "Replacement") pos(1) ring(0) cols(5)) title("Figure 1. Family Income After Household Composition Change") ytitle("Change in log(Family Income)") xtitle("Years After Change") ylabel(, angle(horizontal)) graphregion(color(white)) bgcolor(white) xscale(range(0 10))

graph export "figure2_eventstudy_three_v1.png", replace width(2000)




/* Plot 
* Arrival dataset
use eventstudy_arrival.dta, clear
gen ci_low  = estimate - 1.96 * stderr
gen ci_high = estimate + 1.96 * stderr
gen event = "Arrival"
save eventstudy_arrival_labeled.dta, replace

* Departure dataset
use eventstudy_departure.dta, clear
gen ci_low  = estimate - 1.96 * stderr
gen ci_high = estimate + 1.96 * stderr
gen event = "Departure"
save eventstudy_departure_labeled.dta, replace

* Combine both
use eventstudy_arrival_labeled.dta, clear
append using eventstudy_departure_labeled.dta

gen s = parm
replace s = subinstr(s, "tevent__", "-", .)
replace s = subinstr(s, "tevent_",  "", .)
gen rel_year_num = real(s)
drop if missing(rel_year)


/*











************************************************************
*--- Plot event-study results
************************************************************

* Combine both sets for plotting (if desired)
use eventstudy_arrival, clear
gen type = "Arrival"
append using eventstudy_departure
replace type = "Departure" if missing(type)

* Keep only t_change variables
keep if strpos(parm, "t_change_") > 0

* Extract relative-year number from variable names
gen rel_year_num = real(subinstr(subinstr(parm, "t_change_", "", .), "_", "-", .))

* Plot separate figures
foreach ev in Arrival Departure {
    twoway (rcap min95 max95 rel_year_num if type=="`ev'") ///
           (scatter estimate rel_year_num if type=="`ev'", msymbol(O)), ///
           xline(0, lpattern(dash)) ///
           title("Event-Study: `ev' of Adult") ///
           ytitle("Change in log(Family Income)") ///
           xtitle("Years relative to event") ///
           note("95% CIs clustered by individual") ///
           legend(off)
    graph export "figure_eventstudy_`ev'.png", replace
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    keep if inrange(t_change, -20, 10)



    collapse (mean) mean_income = FU_income_w (sd) sd_income = FU_income_w (count) n = FU_income_w, by(t_change first_change)

    gen se = sd_income / sqrt(n)
    gen ci_low = mean_income - 1.96 * se
    gen ci_high = mean_income + 1.96 * se

/* */

* Create dummy variables for each event-time year, using -1 year as reference
tabulate t_change, g(tchange_)
g ln_income = ln(FU_income_w + 1)
xtset ID 

xtreg ln_income tevent_0 tevent_1 tevent_2 tevent_3 tevent_4 tevent_5 ///
               tevent_-5 tevent_-4 tevent_-3 tevent_-2, fe cluster(id)



coefplot, ///
keep(tevent_*) vertical ///
xline(0, lpattern(dash)) ///
title("Event-Study: Income Before and After Adult Transition") ///
ytitle("Change in log(Family Income)") ///
xtitle("Years relative to event") ///
msymbol(O) ciopts(recast(rcap))
graph export "figure_income_eventstudy_reg.png", replace


/* 02. Figure 1*/ 

    winsor2 FU_income, cuts(1 99)
    sum FU_income_w, d

    preserve
    bys ID: keep if _n == 1
    sample 500, count

    keep ID
    tempfile subsample_ids
    save `subsample_ids'

    restore
    merge m:1 ID using `subsample_ids', keep(match)

    twoway (line FU_income_w age, by(ID) lcolor(gs12) lwidth(vthin)) (lowess FU_income_w age, lcolor(black) lwidth(medthick)), title("Income Trajectories (Random 500 Individuals)") ytitle("Family Income") xtitle("Age") legend(off)