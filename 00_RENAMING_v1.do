****************************
* Sarah Sullivan 
* Last Updated: September 23, 2025
* September 22, 2025
* 00_RENAMING_V1
****************************

/* 00. Identity */
        local identity_vars fam yr
        label var fam "Family ID"
        label var yr "Year"
        
/* 01. Who to head */
    local vars V180	V800	V1489	V2201	V2827	V3248	V3670	V4149	V4700	V5618	V6165	V6764	V7397	V8049	V8673	V9359	V11006	V12354	V13607	V14654	V16128	V17525	V18856	V20156	V21462	V23318	ER2013	ER5012	ER7012	ER10015	ER13016	ER17019	ER24073	ER27879	ER40869	ER46697	ER52097	ER57901	ER65081	ER71164	ER77186	ER81522	ER85379        

        foreach var of local vars {
            capture confirm variable `var'
            if !_rc {
                rename `var' V6165
                label var V6165 "R - Who to Head"
                continue
            }
        } 

/* 02. Household ID, past_IDs

    *label var V6814 "Household ID 1979"

    local past_IDs V5835-V5844 */


/* 03. G HEAD ID */
    g ID = fam*1000 + 1

/* 03. Age of head */
    local vars V117 V1008 V1239 V1942 V2542 V3095 V3508 V3921 V4436 V5350 V5850 V6462 V7067 V7658 V8352 V8961 V10419 V11606 V13011 V14114 V15130 V16631 V18049 V19349 V20651 V22406 ER2007 ER5006 ER7006 ER10009 ER13010 ER17013 ER21017 ER25017 ER36017 ER42017 ER47317 ER53017 ER60017 ER66017 ER72017 ER78017 ER82018
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5850
                    label var V5850 "Age of Head"
                    continue
                }
            }

/* 04. Sex of Head */
    local vars V119	V1010	V1240	V1943	V2543	V3096	V3509	V3922	V4437	V5351	V5851	V6463	V7068	V7659	V8353	V8962	V10420	V11607	V13012	V14115	V15131	V16632	V18050	V19350	V20652	V22407	ER2008	ER5007	ER7007	ER10010	ER13011	ER17014	ER21018	ER25018	ER36018	ER42018	ER47318	ER53018	ER60018	ER66018	ER72018	ER78018	ER82019
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5851
                    label var V5851 "Sex of Head"
                    continue
                }
            }

/* 05. Age of Spouse */
    local vars V118 V1011 V1241 V1944 V2544 V3097 V3510 V3923 V4438 V5352 V5852 V6464 V7069 V7660 V8354 V8963 V10421 V11608 V13013 V14116 V15132 V16633 V18051 V19351 V20653 V22408 ER2009 ER5008 ER7008 ER10011 ER13012 ER17015 ER21019 ER25019 ER36019 ER42019 ER47319 ER53019 ER60019 ER66019 ER72019 ER78019 ER82020
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5852
                    label var V5852 "Age of Spouse"
                    continue
                }
            }

/* 06. Race of Head */
        local vars V181	V801	V1490	V2202	V2828	V3300	V3720	V4204	V5096	V5662	V6209	V6802	V7447	V8099	V8723	V9408	V11055	V11938	V13565	V14612	V16086	V17483	V18814	V20114	V21420	V23276	ER3944	ER6814	ER9060	ER11848	ER15928	ER19989	ER23426	ER27393	ER40565	ER46543	ER51904	ER57659	ER64810	ER70882	ER76897	ER81144	ER85121
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6209
                    label var V6209 "Head: Race"
                    continue
                }
            }

/* 07. Education of Head - Baskets */
        local vars V313	V794	V1485	V2197	V2823	V3241	V3663	V4198	V5074	V5647	V6194	V6787	V7433	V8085	V8709	V9395	V11042	V12400	V13640	V14687	V16161	V17545	V18898																				
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6194
                    label var V6194 "Education of Head - Baskets"
                    continue
                }
            }

/* 08. Education of Wife - Baskets */
        local vars V246				V2687	V3216	V3638	V4199	V5075	V5648	V6195	V6788	V7434	V8086	V8710	V9396	V11043	V12401	V13641	V14688	V16162	V17546	V18899															
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6195
                    label var V6195 "Education of Wife - Baskets"
                    continue
                }
            }

/* 09. State */
        local vars V93	V537	V1103	V1803	V2403	V3003	V3403	V3803	V4303	V5203 V5703 V6303	V6903	V7503	V8203	V8803	V10003	V11103	V12503	V13703	V14803	V16303	V17703	V19003	V20303	V21603	ER4156	ER6996	ER9247	ER12221	ER13004	ER17004	ER21003	ER25003	ER36003	ER42003	ER47303	ER53003	ER60003	ER66003	ER72003	ER78003	ER82003
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5703
                    label var V5703 "State"
                    continue
                }
            }

/* 10. Region */
        local vars V361	V876	V1572	V2284	V2911	V3279	V3699	V4178	V5054	V5633	V6180	V6773	V7419	V8071	V8695	V9381	V11028	V12379	V13631	V14678	V16152	V17538	V18889	V20189	V21495	V23327	ER4157E	ER6997E	ER9248E	ER12221E	ER16430	ER20376	ER24143	ER28042	ER41032	ER46974	ER52398	ER58215	ER65451	ER71530	ER77591	ER81918	ER85772
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6180
                    label var V6180 "Region"
                    continue
                }
            }

        
/* 11. Head Moved from Home Region */
        local vars V363	V878	V1576	V2288	V2915	V3283	V3703	V4182	V5058	V5637	V6184	V6777	V7423	V8075	V8699	V9385	V11032	V12386	V13636	V14683	V16157	V17543	V18894	V20194	V21500	V23332	ER4157D	ER6997D	ER9248D	ER12221D	ER16431B	ER20377B	ER24147	ER28046	ER41036	ER46978	ER52402	ER58220	ER65456	ER71535	ER77596	ER81923	ER85777
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6184
                    label var V6184 "Head: Moved from home region"
                    continue
                }
            }
            

/* 12. Head Change in Mar Status from Last Yr */
        local vars V5680	V6219	V6812	V7455	V8107	V8731	V9420	V11066	V12427	V13666	V14713	V16188	V17566	V18917	V20217	V21523	V23337	ER4159B	ER6999B	ER9250B	ER12223B	ER16424	ER20370	ER24151	ER28050	ER41040	ER46984	ER52408	ER58226	ER65462	ER71541	ER77602	ER81929	ER85783
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6219
                    label var V6219 "Head Change in Mar Status from Last Yr"
                    continue
                }
            }

/* 13. Family Weight */
        local vars V439	V1014	V1609	V2321	V2968	V3301	V3721	V4224	V5099	V5665	V6212	V6805	V7451	V8103	V8727	V9433	V11079	V12446	V13687	V14737	V16208	V17612	V18943	V20243	V21547																		
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6212
                    label var V6212 "Family Weight"
                    continue
                }
            }   

/* 14. No. People in FU */
        local vars V115	V549	V1238	V1941	V2541	V3094	V3507	V3920	V4435	V5349	V5849	V6461	V7066	V7657	V8351	V8960	V10418	V11605	V13010	V14113	V15129	V16630	V18048	V19348	V20650	V22405	ER2006	ER5005	ER7005	ER10008	ER13009	ER17012	ER21016	ER25016	ER36016	ER42016	ER47316	ER53016	ER60016	ER66016	ER72016	ER78016	ER82017
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5849
                    label var V5849 "No. People in FU"
                    continue
                }
            }        

/* 15. No. Adults in FU */
        local vars V116	V894	V1591	V2303	V2930	V3295	V3715	V4194	V5070	V5644	V6191	V6784	V7430	V8082	V8706	V9392	V11039	V12397																						
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6191
                    label var V6191 "No. Adults in FU"
                    continue
                }
            }        

/* 16. No. Kids in FU */
        local vars V398	V550	V1242	V1945	V2545	V3098	V3511	V3924	V4439	V5353	V5853	V6465	V7070	V7661	V8355	V8964	V10422	V11609	V13014	V14117	V15133	V16634	V18052	V19352	V20654	V22409	ER2010	ER5009	ER7009	ER10012	ER13013	ER17016	ER21020	ER25020	ER36020	ER42020	ER47320	ER53020	ER60021	ER66021	ER72021	ER78021	ER82022
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5853
                    label var V5853 "No. Kids in FU"
                    continue
                }
            }       

/* 17. Non-Head Adult in FU: 1978 ONLY */

        local vars V6109
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6109
                    label var V6109 "Non Head Adult in FU"
                    continue
                }
            }        


/* 18. Head: New wife, old wife, no wife 1977?*/
        local vars V3215	V3637	V4107	V4694	V5566	V6115	V6712	V7345	V7997	V8621	V9307	V10954		V13484	V14531	V16005	V17402	V18733	V20033	V21339	V23196	ER3863	ER6733	ER8979	ER11731	ER15805	ER19866	ER23303	ER27263	ER40438	ER46410	ER51771	ER57508	ER64630	ER70703	ER76711	ER80976	ER84953
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6115
                    label var V6115 "Head: New wife, old wife, no wife 1977?"
                    continue
                }
            }       

/* 19. FU: new head?*/
        local vars V791	V1461	V2165	V2791	V3217	V3639	V4114	V4658	V5578	V6127	V6724	V7357	V8009	V8633	V9319	V10966	V11906	V13533	V14580	V16054	V17451	V18782	V20082	V21388	V23245	ER3917	ER6787	ER9033	ER11812	ER15890	ER19951	ER23388	ER27352	ER40527	ER46504	ER51865	ER57618	ER64769	ER70841	ER76856	ER81103	ER85080
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6127
                    label var V6127 "FU: new head?"
                    continue
                }
            }       

/* 20. Age of youngest kid in FU */
        local vars V120	V1013	V1243	V1946	V2546	V3099	V3512	V3925	V4440	V5354	V5854	V6466	V7071	V7662	V8356	V8965	V10423	V11610	V13015	V14118	V15134	V16635	V18053	V19353	V20655	V22410	ER2011	ER5010	ER7010	ER10013	ER13014	ER17017	ER21021	ER25021	ER36021	ER42021	ER47321	ER53021	ER60022	ER66022	ER72022	ER78022	ER82023

            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5854
                    label var V5854 "Age of youngest kid in FU"
                    continue
                }
            }       

/* 21. Change in Fam Composition */
        local vars V542	V1109	V1809	V2410	V3010	V3410	V3810	V4310	V5210	V5710	V6310	V6910	V7510	V8210	V8810	V10010	V11112	V12510	V13710	V14810	V16310	V17710	V19010	V20310	V21608	ER2005A	ER5004A	ER7004A	ER10004A	ER13008A	ER17007	ER21007	ER25007	ER36007	ER42007	ER47307	ER53007	ER60007	ER66007	ER72007	ER78007	ER82007
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5710
                    label var V5710 "Change in Fam Composition"
                    continue
                }
            }       

/* 22. No. people moved into FU */
        local vars V128	V543	V1110	V1810	V2411	V3011	V3411	V3811	V4311	V5211	V5711	V6311	V6911	V7511	V8211	V8811	V10011	V11113	V12511	V13711	V14811	V16311	V17711	V19011	V20311																		
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5711
                    label var V5711 "No. people moved into FU"
                    continue
                }
            }       

/* 23. Who moved INTO FU rel to Head */
        local vars V129	V544	V1111	V1811	V2412	V3012	V3412	V3812	V4312	V5212	V5712	V6312	V6912	V7512	V8212	V8812	V10012	V11114	V12512	V13712	V14812	V16312	V17712	V19012	V20312																		
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5712
                    label var V5712 "Who moved INTO FU rel to Head"
                    continue
                }
            }       

/* 24. No. people moved OUT OF FU */
        local vars V130	V545	V1112	V1812	V2413	V3013	V3413	V3813	V4313	V5213	V5713	V6313	V6913	V7513	V8213	V8813	V10013	V11115	V12513	V13713	V14813	V16313	V17713	V19013	V20313																		
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5713
                    label var V5713 "No. people moved OUT OF FU"
                    continue
                }
            }    

/* 25. Who moved OUT OF FU rel to Head*/
        local vars V131	V546	V1113	V1813	V2414	V3014	V3414	V3814	V4314	V5214	V5714	V6314	V6914	V7514	V8214	V8814	V10014	V11116	V12514	V13714	V14814	V16314	V17714	V19014	V20314								
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5714
                    label var V5714 "Who moved OUT of FU rel to Head"
                    continue
                }
            }    
/* 26. Family Size  */
        local vars V493	V1167	V1868	V2468	V3017	V3437	V3837	V4346	V5254	V5755	V6361	V6959	V7551	V8249	V8851	V10222	V11364	V12763	V13867	V14889	V16389	V17798	V19098	V20398																		
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5755
                    label var V5755 "Family Size "
                    continue
                }
            }    

/* 27. No. Major Adults in FU, =1 single, =2 head+wife */
        local vars V71	V492	V1166	V1867	V2467	V3043	V3455	V3855	V4370	V5280	V5779	V6360	V6958	V7550	V8248	V8850	V10221	V11363	V12762	V13866	V14888	V16388	V17797	V19097	V20397																		
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5779
                    label var V5779 "No. Major Adults in FU, =1 single, =2 head+wife"
                    continue
                }
            }    

/* 28. Head Marital Status: married, sing, wid, div, sep*/
        local vars V5502	V6034	V6659	V7261	V7952	V8603	V9276	V10426	V11612	V13017	V14120	V15136	V16637	V18055	V19355	V20657	V22412	ER2014	ER5013	ER7013	ER10016	ER13021	ER17024	ER21023	ER25023	ER36023	ER42023	ER47323	ER53023	ER60024	ER66024	ER72024	ER78025	ER82026
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6034
                    label var V6034 "Head Marital Status: married, sing, wid, div, sep"
                    continue
                }
            }    

/* 29. Head Ever Married*/
        local vars V5503	V6035	V6660	V7262	V7953	V8604	V9277	V10427
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6035
                    label var V6035 "Head Ever Married"
                    continue
                }
            }    

/* 30. Head: Outcome of last marriage*/
        local vars V5504	V6036	V6661	V7263	V7954	V8605	V9278	V10428
                foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6036
                    label var V6036 "Head: Outcome of last marriage"
                    continue
                }
            }    

/* 31. HEAD MARITAL STATUS COMPARABLE TO 1968-1976 (MARRIED AND COHAB TOGETHER
        rename V6790 V6197
        label var V6197 "HEAD MARITAL STATUS COMPARABLE TO 1968-1976 (MARRIED AND COHAB TOGETHER)" */


/* 32. Total FU Income 1977: taxes and transfers, H, W, OFUM*/
        local vars V81	V529	V1514	V2226	V2852	V3256	V3676	V4154	V5029	V5626	V6173	V6766	V7412	V8065	V8689	V9375	V11022	V12371	V13623	V14670	V16144	V17533	V18875	V20175	V21481	V23322	ER4153	ER6993	ER9244	ER12079	ER16462	ER20456	ER24099	ER28037	ER41027	ER46935	ER52343	ER58152	ER65349	ER71426	ER77448	ER81775	ER85629
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6173
                    label var V6173 "Total FU Income 1977: taxes and transfers, H, W, OFUM"
                    continue
                }
            }    

/* 33. OWN VS. RENT*/
        local vars V103	V593	V1264	V1967	V2566	V3108	V3522	V3939	V4450	V5364	V5864	V6479	V7084	V7675	V8364	V8974	V10437	V11618	V13023	V14126	V15140	V16641	V18072	V19372	V20672	V22427	ER2032	ER5031	ER7031	ER10035	ER13040	ER17043	ER21042	ER25028	ER36028	ER42029	ER47329	ER53029	ER60030	ER66030	ER72030	ER78031	ER82032
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5864
                    label var V5864 "OWN VS. RENT"
                    continue
                }
            }    

/* 34. Home Value */
        local vars V5	V449	V1122	V1823	V2423	V3021	V3417	V3817	V4318	V5217	V5717	V6319	V6917	V7517	V8217	V8817	V10018	V11125	V12524	V13724	V14824	V16324	V17724	V19024	V20324	V21610	ER2033	ER5032	ER7032	ER10036	ER13041	ER17044	ER21043	ER25029	ER36029	ER42030	ER47330	ER53030	ER60031	ER66031	ER72031	ER78032	ER82033
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5717
                    label var V5717 "Home Value"
                    continue
                }
            }    

/* 35. Annual Mortgage */
        local vars V8	V453	V1126	V1827	V2427	V4322	V5221	V5721	V6323	V6921	V7521		V8821	V10022	V11129	V12528	V13728			V17728	V19028	V20328	V21615																	
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5721
                    label var V5721 "Annual Mortgage"
                    continue
                }
            }    

/* 36. Annual Rent */
        local vars V10	V455	V1128	V1829	V2429	V3023	V3419	V3819	V4326	V5225	V5723	V6326	V6925	V7525	V8221	V8825	V10026	V11133	V12532	V13732			V17733	V19033	V20333	V21622								
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5723
                    label var V5723 "Annual Rent"
                    continue
                }
            } 



/* 37. Pub Housing Rent Value -- Paid by govt */
        local vars V12	V457	V1130	V1831	V2431	V3025	V3421	V3821	V4330	V5229	V5727	V6330	V6929	V7527	V8223	V8827	V10028	V11135	V12534	V13734			V17735	V19035	V20335	V21626
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5727
                    label var V5727 "Pub Housing"
                    continue
                }
            }

/* 38. FU Received Welfare Y/N 
        local vars V6078	V6682
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6078
                    label var V6078 "FU Received Welfare Y/N"
                    continue
                }
            }    */


/* 39. Head employment status */
        local vars V196	V639	V1278	V1983	V2581	V3114	V3528	V3967	V4458	V5373	V5872	V6492	V7095	V7706	V8374	V9005	V10453	V11637	V13046	V14146	V15154	V16655	V18093	V19393	V20693	V22448	ER2068	ER5067	ER7163
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5872
                    label var V5872 "Head Employment Status"
                    continue
                }
            }    

/* 40. Head occupation + 
        local vars V5873_A	V6497_A	V7100_A
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V5873_A
                    label var V5873_A "Head occupation +"
                    continue
                }
            } */

/* 41. Wife occupation + 1977 
        local vars V6039_A	V6596_A	V7198_A
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6039_A
                    label var V6039_A "Wife occupation + 1977"
                    continue
                }
            }  */

/* 42. Head: Years of school*/
        local vars V4093	V4684	V5608	V6157	V6754	V7387	V8039	V8663	V9349	V10996 V20198	V21504	V23333	ER4158	ER6998	ER9249	ER12222	ER16516	ER20457	ER24148	ER28047	ER41037	ER46981	ER52405	ER58223	ER65459	ER71538	ER77599	ER81926	ER85780
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6157
                    label var V6157 "Head: Years of school
                    continue
                }
            }

/* 43. Wife: Years of school */
        local vars V4102	V4695	V5567	V6116	V6713	V7346	V7998	V8622	V9308	V10955 V20199	V21505	V23334	ER4159	ER6999	ER9250	ER12223	ER16517	ER20458	ER24149	ER28048	ER41038	ER46982	ER52406	ER58224	ER65460	ER71539	ER77600	ER81927	ER85781
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6116
                    label var V6116 "Wife: Years of school
                    continue
                }
            }


/* 44. Head: parents poor, avg, well off? */
        local vars V317	V792	V1483	V2195	V2821	V3239	V3661	V4137	V4680	V5600	V6149	V6746	V7379	V8031	V8655	V9341	V10988	V11921	V13548	V14595	V16069	V17466	V18797	V20097	V21403	V23259	ER3923	ER6793	ER9039	ER11846	ER15926	ER19987	ER23424	ER27390	ER37728	ER46540	ER51901	ER57656	ER64807	ER70879	ER76894	ER81141	ER85118
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6149
                    label var V6149 "Head: parents poor, avg, well off?"
                    continue
                }
            }


/* 45. Head: Mom's education */
        local vars V3634	V4139	V4682	V5602	V6151	V6748	V7381	V8033	V8657	V9343	V10990	V11923	V13550	V14597	V16071	V17468	V18799	V20099	V21405	V23261	ER3926	ER6796	ER9042	ER11824	ER15903	ER19964	ER23401	ER27366	ER40541	ER46518	ER51879	ER57632	ER64783	ER70855	ER76870	ER81117	ER85094
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6151
                    label var V6151 "Head: Mom's education"
                    continue
                }
            }  

/* 46. Head: Dad's education */
        local vars V318	V793	V1484	V2196	V2822	V3240	V3662	V4138	V4681	V5601	V6150	V6747	V7380	V8032	V8656	V9342	V10989	V11922	V13549	V14596	V16070	V17467	V18798	V20098	V21404	V23260	ER3924	ER6794	ER9040	ER11816	ER15894	ER19955	ER23392	ER27356	ER40531	ER46508	ER51869	ER57622	ER64773	ER70845	ER76860	ER81107	ER85084
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6150
                    label var V6150 "Head: Dad's education"
                    continue
                }
            }  

/* 47. Wife: Mom's education */
        local vars V3609	V4109	V4754	V5573	V6122	V6719	V7352	V8004	V8628	V9314	V10961	V12278	V13486	V14533	V16007	V17404	V18735	V20035	V21341	V23198	ER3866	ER6736	ER8982	ER11743	ER15818	ER19879	ER23316	ER27277	ER40452	ER46424	ER51785	ER57522	ER64644	ER70717	ER76725	ER80990	ER84967
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6122
                    label var V6122 "Wife: Mom's education"
                    continue
                }
            }  

/* 48. Wife: Dad's education */
        local vars V3608	V4108	V4753	V5572	V6121	V6718	V7351	V8003	V8627	V9313	V10960	V12277	V13485	V14532	V16006	V17403	V18734	V20034	V21340	V23197	ER3864	ER6734	ER8980	ER11735	ER15809	ER19870	ER23307	ER27267	ER40442	ER46414	ER51775	ER57512	ER64634	ER70707	ER76715	ER80980	ER84957
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6121
                    label var V6121 "Wife: Dad's education"
                    continue
                }
            }  

/* 49. Head: State father grew up */
        local vars V1454	V2166	V2792	V3218	V3640	V4115	V4659	V5579	V6128	V6725	V7358	V8010	V8634	V9320	V10967	V11907	V13534	V14581	V16055	V17452	V18783	V20083	V21389	V23246	ER3917A	ER6787A	ER9033A
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6128
                    label var V6128 "Head: State father grew up in"
                    continue
                }
            }  

/* 50. Head: State mother grew up */
        local vars V1456	V2168	V2794	V3220	V3642	V4117	V4661	V5581	V6130	V6727	V7360	V8012	V8636	V9322	V10969	V11909	V13536	V14583	V16057	V17454	V18785	V20085	V21391	V23248	ER3917B	ER6787B	ER9033B	
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6130
                    label var V6130 "Head: State mother grew up in"
                    continue
                }
            }


/* 51. Head: dad's main job while R grow up*/
        local vars V1458	V2170	V2796	V3222	V3644	V4119	V4663	V5583	V6132	V6729	V7362	V8014	V8638	V9324	V10971	V11911	V13538	V14585	V16059	V17456	V18787	V20087	V21393	V23250	ER4087	ER6927	ER9178
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6132
                    label var V6132 "Head: dad's main job while R grow up"
                    continue
                }
            }  

/* 52. Head: No. brothers/sisters */
        local vars V316	V567	V1467	V2178	V2804	V3230	V3652	V4127	V4671	V5591	V6140	V6737	V7370	V8022	V8646	V9332	V10979
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6140
                    label var V6140 "Head: No. brothers/sisters"
                    continue
                }
            }  

/* 53. Head: urban/rural growing up */
        local vars V312	V786	V1476	V2188	V2814	V3232	V3654	V4130	V4673	V5593	V6142	V6739	V7372	V8024	V8648	V9334	V10981	V11914	V13541	V14588	V16062	V17459	V18790	V20090	V21396	V23253	ER3919	ER6789	ER9035	ER11841	ER15921	ER19982	ER23419	ER27385	ER40560	ER46537	ER51898	ER57653	ER64804	ER70876	ER76891	ER81138	ER85115
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6142
                    label var V6142 "Head: urban/rural growing up"
                    continue
                }
            }  

/* 54. Head: state where grew up */
        local vars V311	V787	V1477	V2189	V2815	V3233	V3655	V4131	V4674	V5594	V6143	V6740	V7373	V8025	V8649	V9335	V10982	V11915	V13542	V14589	V16063	V17460	V18791	V20091	V21397	V23254	ER3919A	ER6789A	ER9035A					
            foreach var of local vars {
                capture confirm variable `var'
                if !_rc {
                    rename `var' V6143
                    label var V6143 "Head: state where grew up"
                    continue
                }
            }  

/* 55. DROP */
    local vars fam yr ID V6165 V5850 V5851 V5852 V6209 V6194 V6195 V5703 V6180 V6184 V6219 V6212 V5849 V6191 V5853 V6115 V6127 V5854 V5710 V5711 V5712 V5713 V5714 V5755 V5779 V6034 V6035 V6036 V6173 V5864 V5717 V5723 V5727 V5872 V6157 V6116 V6149 V6151 V6150 V6122 V6121 V6128 V6130 V6132 V6140 V6142 V6143
    local keepvars

    foreach var of local vars {
        capture confirm variable `var'
        if _rc == 0 {
            local keepvars `keepvars' `var'
        }
    }

    if "`keepvars'" != "" {
        keep `keepvars'
    }





/*

        label var V6142 "H"
        label var V6143 "p"
        label var V6181 "Head: region where grew up"


        label var V6141 "Head: Older siblings Y/N"

        label var V6182 "Head: Region father grew up"
        label var V6183 "Head: Region mother grew up"

        label var V6040 "Wife industry"
        label var V5874 "Head industry"
        label var V5874_A "Head industry +"
        label var V5743 "Wife hours worked annual 1977"
        label var V5751 "Wife hours unemployed 1977"
        label var V5902 "Head became unemployed 1977"

        rename V6732 V6135
        label var V6135 "Head: Age of oldest child"
        rename V6733 V6136
        label var V6136 "Head: Age of 2nd oldest child"
        rename V6734 V6137
        label var V6137 "Head: Age of 3rd oldest child"
        rename V6735 V6138
        label var V6138 "Head: No. of children"
        rename V6736 V6139
        label var V6139 "Head: No. children before 25 y/o"

        label var V6200 "Head: No. kids aged 1-2"
        label var V6201 "Head: No. kids aged 3-5"
        label var V6202 "Head: No. kids aged 6-13"
        label var V6203 "Head: No. girls aged 14-17"
        label var V6204 "Head: No. boys aged 14-17"
        label var V6025 "Head: No. girls aged 18-20"
        label var V6026 "Head: No. boys aged 18-20"
        label var V6027 "Head: No. girls aged 21-29"
        label var V6028 "Head: No. boys aged 21-29"
*/

/*
    local SES_vars V6198 V5782 V5788 V5815 V5796 V5799 V5800 V5801 V5801 V5802 V5817 V5819 V5820 V5821 V5831 V5833 V6176 V5864 V5717  V5727 V6188 V6189 V6190 V6078 V5757 V5758 V5765 V5766 V5778 V5872 V5873 V5873_A V5874 V5874_A V5941 V5731 V5905 V5907 V5908 V5911 V5906 V5909 V5910 V5902 V5903 V5739 V5915 V5916  V6038 V6039 V6039_A V6040 V5743 V5751 V5816 V6157 V6158 V6159 V6163 V6164 V6116 V6117 V6118 V6119 V6120

        * INCOME
                label var V6198 "Income Decile 1977"
                label var V6173 "Total FU Income 1977: taxes and transfers, H, W, OFUM"
                label var V5782 "Head 1977 annual wage income"
                label var V5788 "Wife 1977 annual wage income"
                label var V5815 "Head + Wife 1977 transfer income amount"
                label var V5796 "Head + Wife taxable income 1977"
                label var V5799 "Head + Wife No dependents 1977"
                label var V5800 "Head + Wife income taxes"
                label var V5801 "Head + Wife marginal tax rates"
                label var V5802 "Head + Wife ADC/AFDC Amount 1977" 
                    *** CHECK ^
                label var V5817 "Others Taxable income 1977"
                label var V5819 "Others ASSET income 1977"
                label var V5820 "Others income tax 1977"
                label var V5821 "Others ADC/AFDC 1977"
                label var V5831 "Others Transfer Income 1977"
                label var V5833 "No. Other Income Receivers in FU (not H/W) 1977"
                label var V6176 "Income to Needs Ratio 1977, adj for farmers"
        * HOUSING
            label var V5864 "OWN VS. RENT"
            label var V5717 "Home Value"
            label var V5721 "Annual Mortgage"
            label var V5723 "Annual Rent"
            label var V5727 "Pub Housing Rent Value -- Paid by govt"
            /* HOUSEHOLD CHARACTERISTIC VARIABLES: V5862+
            MOVES: V5866-V5867-V5868 */
            label var V6188 "VALUE PER ROOM OF DU 1978"
            label var V6189 "Extra rooms: actual - required"
            label var V6190 "Density: # ppl per room"
        * WELFARE
            label var V6078 "FU Received Welfare Y/N"
            label var V5757 "Weekly food need unadjusted for infl"
            label var V5758 "Poverty Threshold 1978"
            label var V5765 "No ppl received food stamps"
            label var V5766 "Amount of food stamps last month"
            label var V5778 "No of months with food stamps 1977"
        * WORK
            label var V5872 "Head employment status"
            label var V5873 "Head occupation"
            label var V5873_A "Head occupation +"
                * ^ CHECK
            label var V5874 "Head industry"
            label var V5874_A "Head industry +"
                * ^ CHECK
            label var V5941 "Head Hours at first job"
            label var V5731 "Head hours worked annual 1977"
            label var V5905 "Head hours worked per week 1977"
            label var V5907 "Head salaried/hourly/other"
            label var V5908 "Head pay per hour if salaried"
            label var V5911 "Head pay per hour not salaried"
            label var V5906 "Head worked overtime in 1977 Y/N"
                * if V5906 == TRUE
                label var V5909 "Head whether paid OT"
                label var V5910 "Head hourly OT pay actual"
            label var V5902 "Head became unemployed 1977"
            label var V5903 "Head weeks unemployed 1977"
            label var V5739 "Head hours unemployed 1977" 
            label var V5915 "Head second job Y/N 1977"
            label var V5916 "Head second occupation"
            label var V6038 "Wife worked Y/N 1977"
            label var V6039 "Wife occupation 1977"
            label var V6039_A "Wife occupation + 1977"
            label var V6040 "Wife industry"
            label var V5743 "Wife hours worked annual 1977"
            label var V5751 "Wife hours unemployed 1977"
            label var V5816 "Others hours worked annual 1977"

        * EDUCATION
            label var V6157 "Head: Years of school"
            label var V6158 "Head: add'l school Y/N"
            label var V6159 "Head: kind of add'l school"
            label var V6163 "Head: bachelor degree Y/N"
            label var V6164 "Head: adv degree Y/N"
            label var V6116 "Wife: Years of school"
            label var V6117 "Wife: add'l school Y/N"
            label var V6118 "Wife: kind of add'l school"
            label var V6119 "Wife: bachelor degree Y/N"
            label var V6120 "Wife: adv degree Y/N"


    local growing_up V6149 V6151 V6150 V6122 V6121 V6128 V6182 V6130 V6183 V6132 V6140 V6141 V6142 V6143 V6181
        * SES  GROWING UP
            label var V6149 "Head: parents poor, avg, well off?"
        * PARENTAL EDUCATION 
            label var V6151 "Head: Mom's education"
            label var V6150 "Head: Dad's education"
            label var V6122 "Wife: Mom's education"
            label var V6121 "Wife: Dad's education"
        * PARENTS' CHILDHOOD HOME
            label var V6128 "Head: State father grew up"
            label var V6182 "Head: Region father grew up"
            label var V6130 "Head: State mother grew up"
            label var V6183 "Head: Region mother grew up"
        * PARENTAL OCCUPATION GROWING UP
            label var V6132 "Head: dad's main job while R grow up"
        * R'S FAMILY STRUCTURE GROWING UP
            label var V6140 "Head: No. brothers/sisters"
            label var V6141 "Head: Older siblings Y/N"
        * R'S CHILDHOOD COMMUNITY/REGION
            label var V6142 "Head: urban/rural growing up"
            label var V6143 "Head: state where grew up"
            label var V6181 "Head: region where grew up"


    local social_capital_job V5929 V5930 V5932 V5933 V5934 V5935 V5936 V5937 V5938
        label var V5929 "Head 1st Job: age"
            * Same if unemployed? V5973 
        label var V5930 "Head 1st Job: occupation"
        label var V5932 "Head 1st Job: how found"
        label var V5933 "Head 1st Job: any help?"
        label var V5934 "Head 1st Job: who helped?"
        label var V5935 "Head 1st Job: how helped?"
        label var V5936 "Head 1st Job: helper at company"
        label var V5937 "Head 1st Job: helper had say in hiring"
        label var V5938 "Head 1st Job: how much helper say"
            * Go back in and fill in social capital information for current job, 
            * starting around V5941, if interested

    local others V6003 V6133 V6134 V6147 V6148
        label var V6003 "Head Year Retired"
        label var V6133 "Q head's first job"
        label var V6134 "Q change industries/ type of job?"
        label var V6147 "Q MOVED FOR JOB" 
        label var V6148 "Q NOT MOVED FOR JOB"



    order `identity_vars' `demographic_vars' `family_structure_vars' `SES_vars' `growing_up' `past_IDs' `social_capital_job' `others'
    keep `identity_vars' `demographic_vars' `family_structure_vars' `SES_vars' `growing_up' `past_IDs' `social_capital_job' `others'
*/