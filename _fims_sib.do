****************************
* Sarah Sullivan 
* Last Updated: December 13, 2025
* 00_fims_sib.do
****************************

************************************

    use  "${root}/fims_sib.dta", clear
    * 38,324 have siblings


    g ID = ER30001*1000 + ER30002
    rename ER30001 fam
    label var ID "Individual ID"

    * id for each sibling
    forvalues i = 1/16 {
        local suffix = string(`i', "%02.0f")
        g ID_S`suffix' = ID68_S`suffix' * 1000 + PN_S`suffix'
        label var ID_S`suffix' "Sibling `i' ID"
    }

    * sex is constructed as sex_S#
    * type is constructed as type_S#

    * drop PN and ID68 for siblings
    drop PN* ID68* ER*


    * save
    save "${root}/_fims_sib_clean.dta", replace