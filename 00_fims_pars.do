****************************
* Sarah Sullivan 
* Last Updated: December 13, 2025
* 00_fims_pars.do
****************************

************************************

    use  "${root}/fims_pars_v1.dta", clear

    g ID = ER30001*1000 + ER30002
    rename ER30001 fam

    * id for each parent
    g ID_aM = ER30001_P_AM*1000 + ER30002_P_AM
    g ID_aD = ER30001_P_AF*1000 + ER30002_P_AF
    g ID_bM = ER30001_P_M*1000 + ER30002_P_M
    g ID_bD = ER30001_P_F*1000 + ER30002_P_F

    * drop PN and ID68 for siblings
    drop ER*

    * save
    save "${root}/00_fims_pars_v1.dta", replace