****************************
* Sarah Sullivan 
* Last Updated: June 1, 2026
* Created: September 22, 2025
* _renaming.do
****************************

/* 01. 1968 ID */ 
    label var yr "Year"
    local vars V3 V534 V1230 V1932 V2533 V3085 V3497 V3909 V4423 V5336 V5835 V6446 V7050 V7642 V8335 V8943 V10400 V11581 V12988 V14090 V15105 V16605 V18021 V19321 V20621 V22400 ER2005G ER5005G ER7005G ER10005G ER13019 ER17022 ER21009 ER25009 ER36009 ER42009 ER47309 ER53009 ER60009 ER66009 ER72009 ER78009 ER82009
        foreach var of local vars {
            capture confirm variable `var'
            if !_rc {
                rename `var' fam
                label var fam "1968 fam ID: V534"
                continue
            }
        }

g v3_2 = fam

/* 02. Family-year ID */ 
    local vars v3_2 V442 V1102 V1802 V2402 V3002 V3402 V3802 V4302 V5202 V5702 V6302 V6902 V7502 V8202 V8802 V10002 V11102 V12502 V13702 V14802 V16302 V17702 V19002 V20302 V21602 ER2002 ER5002 ER7002 ER10002 ER13002 ER17002 ER21002 ER25002 ER36002 ER42002 ER47302 ER53002 ER60002 ER66002 ER72002 ER78002 ER82002
        foreach var of local vars {
            capture confirm variable `var'
            if !_rc {
                rename `var' fam_id_
                label var fam_id_ "YEAR fam ID: V442"
                continue
            }
        }

/* 03. Who to head */
    local vars V180 V800 V1489 V2201 V2827 V3248 V3670 V4149 V4700 V5618 V6165 V6764 V7397 V8049 V8673 V9359 V11006 V12354 V13607 V14654 V16128 V17525 V18856 V20156 V21462 V23318 ER2013 ER5012 ER7012 ER10015 ER13016 ER17019 ER24073 ER27879 ER40869 ER46697 ER52097 ER57901 ER65081 ER71164 ER77186 ER81522 ER85379
        foreach var of local vars {
            capture confirm variable `var'
            if !_rc {
                rename `var' rel_to_head
                label var rel_to_head "R - Who to Head, V6165"
                continue
            }
        } 

/* 04. Age of head */
    local vars V117 V1008 V1239 V1942 V2542 V3095 V3508 V3921 V4436 V5350 V5850 V6462 V7067 V7658 V8352 V8961 V10419 V11606 V13011 V14114 V15130 V16631 V18049 V19349 V20651 V22406 ER2007 ER5006 ER7006 ER10009 ER13010 ER17013 ER21017 ER25017 ER36017 ER42017 ER47317 ER53017 ER60017 ER66017 ER72017 ER78017 ER82018
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' head_age
                    label var head_age "Age of Head"
                    continue
                }
            }


/* 05. Sex of Head */
    local vars V119 V1010 V1240 V1943 V2543 V3096 V3509 V3922 V4437 V5351 V5851 V6463 V7068 V7659 V8353 V8962 V10420 V11607 V13012 V14115 V15131 V16632 V18050 V19350 V20652 V22407 ER2008 ER5007 ER7007 ER10010 ER13011 ER17014 ER21018 ER25018 ER36018 ER42018 ER47318 ER53018 ER60018 ER66018 ER72018 ER78018 ER82019
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' head_sex
                    label var head_sex "Sex of Head"
                    continue
                }
            }

/* 06. Race of Head */
        local vars V181 V801 V1490 V2202 V2828 V3300 V3720 V4204 V5096 V5662 V6209 V6802 V7447 V8099 V8723 V9408 V11055 V11938 V13565 V14612 V16086 V17483 V18814 V20114 V21420 V23276 ER3944 ER6814 ER9060 ER11848 ER15928 ER19989 ER23426 ER27393 ER40565 ER46543 ER51904 ER57659 ER64810 ER70882 ER76897 ER81144 ER85121
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' head_race
                    label var head_race "Head: Race"
                    continue
                }
            }

/* 07. Education of Head - Baskets */
        local vars V313 V794 V1485 V2197 V2823 V3241 V3663 V4198 V5074 V5647 V6194 V6787 V7433 V8085 V8709 V9395 V11042 V12400 V13640 V14687 V16161 V17545 V18898
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' head_education
                    label var head_education "Education of Head - Baskets"
                    continue
                }
            }

/* 08. FU: new head? */
        local vars V791 V1461 V2165 V2791 V3217 V3639 V4114 V4658 V5578 V6127 V6724 V7357 V8009 V8633 V9319 V10966 V11906 V13533 V14580 V16054 V17451 V18782 V20082 V21388 V23245 ER3917 ER6787 ER9033 ER11812 ER15890 ER19951 ER23388 ER27352 ER40527 ER46504 ER51865 ER57618 ER64769 ER70841 ER76856 ER81103 ER85080
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' fu_new_head
                    label var fu_new_head "FU: new head?"
                    continue
                }
            }       

/* 09. Head Marital Status: married, sing, wid, div, sep*/
        local vars V5502 V6034 V6659 V7261 V7952 V8603 V9276 V10426 V11612 V13017 V14120 V15136 V16637 V18055 V19355 V20657 V22412 ER2014 ER5013 ER7013 ER10016 ER13021 ER17024 ER21023 ER25023 ER36023 ER42023 ER47323 ER53023 ER60024 ER66024 ER72024 ER78025 ER82026
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' head_marital
                    label var head_marital "Head Marital Status: married, sing, wid, div, sep"
                    continue
                }
            }    

/* 10. Head: Years of school*/
        local vars V4093 V4684 V5608 V6157 V6754 V7387 V8039 V8663 V9349 V10996 V20198 V21504 V23333 ER4158 ER6998 ER9249 ER12222 ER16516 ER20457 ER24148 ER28047 ER41037 ER46981 ER52405 ER58223 ER65459 ER71538 ER77599 ER81926 ER85780
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' head_yrs_school
                    label var head_yrs_school "Head: Years of school V6157"
                    continue
                }
            }

/* 11. Wife: Years of school */

        local vars V4102	V4695	V5567	V6116	V6713	V7346	V7998	V8622	V9308	V10955 V20199	V21505	V23334	ER4159	ER6999	ER9250	ER12223	ER16517	ER20458	ER24149	ER28048	ER41038	ER46982	ER52406	ER58224	ER65460	ER71539	ER77600	ER81927	ER85781
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' wife_yrs_school
                    label var wife_yrs_school "Wife: Years of school V6116"
                    continue
                }
            }

/* 12. Date of interview */
    local vars V99 V553 V1236 V1939 V2539 V3092 V3505 V3918 V4433 V5347 V5847 V6459 V7064 V7655 V8349 V8958 V10416 V11600 V13008 V14111 V15127 V16628 V18046 V19346 V20648 V22403 ER2005 ER5004 ER7004 ER10006	ER13007	ER17010	ER21013	ER25013	ER36013	ER42013	ER47313	ER53013	ER60013	ER66013	ER72013	ER78013	ER82013
    

        foreach var of local vars {
            capture confirm variable `var'
            if !_rc {
                rename `var' date_interview
                label var date_interview "RECODE V99 Date of interview"
                continue
            }
        }

