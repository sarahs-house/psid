* Sarah Sullivan
* April 8, 2026
* analysis2.do 


/* 00. Load in data */
    import delimited "full_sample_changes.csv", clear

/* 02. Collapse by ID */
    collapse (mean) fam yr age_ age_first_observed birth_year (sum) hh_came hh_left adult_came adult_left child_came child_left n_adults_came n_adults_left sib_came sib_left par_came par_left gpar_came gpar_left  (firstnm) cohort_5 cohort_10, by(id)

/* 03. Count number of people in each cohort */
    gen n_people = 1

/* 03. Collapse by cohorts - 5 year */
    collapse (mean) yr age_ age_first_observed birth_year hh_came hh_left adult_came adult_left child_came child_left n_adults_left n_adults_came sib_came sib_left par_came par_left gpar_came gpar_left (sum) n_people, by(cohort_5)

/* 04. Export collapsed data 5-yr */
    export excel using "full_sample_changes_5yr.xlsx", replace firstrow(variables)


/* 00. Load in data */
    import delimited "full_sample_changes.csv", clear

/* 02. Collapse by ID */
    collapse (mean) fam yr age_ age_first_observed birth_year (sum) hh_came hh_left adult_came adult_left child_came child_left n_adults_came n_adults_left sib_came sib_left par_came par_left gpar_came gpar_left  (firstnm) cohort_5 cohort_10, by(id)

/* 03. Count number of people in each cohort */
    gen n_people = 1


/* 03. Collapse by cohorts - 10 year */
    collapse (mean) yr age_ age_first_observed birth_year hh_came hh_left adult_came adult_left child_came child_left n_adults_left n_adults_came sib_came sib_left par_came par_left gpar_came gpar_left (sum) n_people, by(cohort_10)

/* 04. Export collapsed data 10-yr */
    export excel using "full_sample_changes_10yr.xlsx", replace firstrow(variables)






/* ------- */
    
/* 00. Load in data */
    import delimited "only_changed_sample.csv", clear


/* 01. Collapse by ID */
    collapse (mean) fam yr age_ age_first_observed birth_year (sum) hh_came hh_left adult_came adult_left child_came child_left n_adults_came n_adults_left sib_came sib_left par_came par_left gpar_came gpar_left any_change (firstnm) cohort_5 cohort_10, by(id)

/* 03. Count number of people in each cohort */
    gen n_people = 1


/* 01. Collapse by cohorts - 5 year */
    collapse (mean) yr age_ age_first_observed birth_year hh_came hh_left adult_came adult_left child_came child_left n_adults_left n_adults_came sib_came sib_left par_came par_left gpar_came gpar_left (sum) n_people, by(cohort_5)

/* 04. Export collapsed data */
    export excel using "only_changed_sample_5yr.xlsx", replace firstrow(variables)

    
/* 00. Load in data */
    import delimited "only_changed_sample.csv", clear



/* 01. Collapse by ID */
    collapse (mean) fam yr age_ age_first_observed birth_year (sum) hh_came hh_left adult_came adult_left child_came child_left n_adults_came n_adults_left sib_came sib_left par_came par_left gpar_came gpar_left any_change (firstnm) cohort_5 cohort_10, by(id)

/* 03. Count number of people in each cohort */
    gen n_people = 1

/* 01. Collapse by cohorts - 10 year */
    collapse (mean) yr age_ age_first_observed birth_year hh_came hh_left adult_came adult_left child_came child_left n_adults_left n_adults_came sib_came sib_left par_came par_left gpar_came gpar_left (sum) n_people, by(cohort_10)

    

/* 04. Export collapsed data */
    export excel using "only_changed_sample_10yr.xlsx", replace firstrow(variables)

    
