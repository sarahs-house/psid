****************************
* Sarah Sullivan 
* Created: September 2025
* Last Updated: May 18, 2026
* _fims_sib.do
****************************

************************************

    use  "${output}/fims_sib.dta", clear
    * 38,324 sample members for whom we have sibling data


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