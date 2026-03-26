****************************
* Sarah Sullivan 
* Last Updated: December 13, 2025
* 00_fims_sib.do
****************************

************************************

    use  "${root}/fims_sib_v1.dta", clear

    g ID = ER30001*1000 + ER30002
    rename ER30001 fam

    * drop type of sibling for now
    drop TYPE*

    * id for each sibling
    forvalues i = 1/16 {
        local suffix = string(`i', "%02.0f")
        g ID_S`suffix' = ID68_S`suffix' * 1000 + PN_S`suffix'
    }

    * drop PN and ID68 for siblings
    drop PN* ID68* ER*

    * save
    save "${root}/00_fims_sib_v1.dta", replace