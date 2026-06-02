****************************
* Sarah Sullivan 
* Created: September 2025
* Last Updated: May 18, 2026
* _fims_gpars.do
****************************

************************************

    use  "${output}/fims_gpars.dta", clear
    * 87,079 observations, information on almost everyone in PSID, who are their parents!


    g ID = ER30001*1000 + ER30002
    rename ER30001 fam


    * id for parents
    g ID_aM = ER30001_P_AM*1000 + ER30002_P_AM
    label var ID_aM "Adoptive mother's ID"
    g ID_aD = ER30001_P_AF*1000 + ER30002_P_AF
    label var ID_aD "Adoptive father's ID"
    g ID_bM = ER30001_P_M*1000 + ER30002_P_M
    label var ID_bM "Biological mother's ID"
    g ID_bD = ER30001_P_F*1000 + ER30002_P_F
    label var ID_bD "Biological father's ID"

    * id for each grandparent
    g ID_aM_aM = ER30001_GP_AMAM * 1000 + ER30002_GP_AMAM
    label var ID_aM_aM "Adoptive mother's adoptive mother's ID"
    g ID_aM_aD = ER30001_GP_AMAF * 1000 + ER30002_GP_AMAF
    label var ID_aM_aD "Adoptive mother's adoptive father's ID"
    g ID_aM_bM = ER30001_GP_AMM * 1000 + ER30002_GP_AMM
    label var ID_aM_bM "Adoptive mother's biological mother's ID"
    g ID_aM_bD = ER30001_GP_AMF * 1000 + ER30002_GP_AMF
    label var ID_aM_bD "Adoptive mother's biological father's ID"

    g ID_aD_aM = ER30001_GP_AFAM * 1000 + ER30002_GP_AFAM
    label var ID_aD_aM "Adoptive father's adoptive mother's ID"
    g ID_aD_aD = ER30001_GP_AFAF * 1000 + ER30002_GP_AFAF
    label var ID_aD_aD "Adoptive father's adoptive father's ID"
    g ID_aD_bM = ER30001_GP_AFM * 1000 + ER30002_GP_AFM
    label var ID_aD_bM "Adoptive father's biological mother's ID"
    g ID_aD_bD = ER30001_GP_AFF * 1000 + ER30002_GP_AFF
    label var ID_aD_bD "Adoptive father's biological father's ID"

    g ID_bM_aM = ER30001_GP_MAM * 1000 + ER30002_GP_MAM
    label var ID_bM_aM "Biological mother's adoptive mother's ID"
    g ID_bM_aD = ER30001_GP_MAF * 1000 + ER30002_GP_MAF
    label var ID_bM_aD "Biological mother's adoptive father's ID"
    g ID_bM_bM = ER30001_GP_MM * 1000 + ER30002_GP_MM
    label var ID_bM_bM "Biological mother's biological mother's ID"
    g ID_bM_bD = ER30001_GP_MF * 1000 + ER30002_GP_MF
    label var ID_bM_bD "Biological mother's biological father's ID"

    g ID_bD_aM = ER30001_GP_FAM * 1000 + ER30002_GP_FAM
    label var ID_bD_aM "Biological father's adoptive mother's ID"
    g ID_bD_aD = ER30001_GP_FAF * 1000 + ER30002_GP_FAF
    label var ID_bD_aD "Biological father's adoptive father's ID"
    g ID_bD_bM = ER30001_GP_FM * 1000 + ER30002_GP_FM
    label var ID_bD_bM "Biological father's biological mother's ID"
    g ID_bD_bD = ER30001_GP_FF * 1000 + ER30002_GP_FF
    label var ID_bD_bD "Biological father's biological father's ID"

    drop ER*

    * save
    * outputs a file for all PSID people (NOT JUST SAMPLE PEOPLE), for whom we have family information
    * 87,079 people. People in the sample PLUS people with sample moms, dads, or grandparents who they themselves 
    * may not be in the sample. 
    save "${root}/_fims_gpars_clean.dta", replace
