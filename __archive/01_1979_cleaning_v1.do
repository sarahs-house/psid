




    local identity_vars ER30001 yr qualified_family V6165
        label var ER30001 "Individual ID"
        label var yr "Year"
        label var qualified_family "=1 if family has a child born btwn 1978-1997" 
            * Sarah check if this is true
        label var V6165 "WHO TO HEAD: H/W/OTHER"

    local past_IDs v5835-v5844

    local demographic_vars V5850 V5851 V5852 
        label var V5850 "Age of Head"
        label var V5851 "Sex of Head"
        label var V5852 "Age of Wife"
        label var V6194 "Education of Head - Baskets"
        label var V6195 "Education of Wife - Baskets"
        label var V5703 "State"
        label var V6180 "Region"
        label var V6135 "Head: No. Regions ever lived in"
        label var V6184 "Head: Moved from home region"

    local family_structure_vars V5853 V5854 V5710 V5711 V5712 V5713 V5714
        label var V5842 "No. People in FU"
        label var V6191 "No. Adults in FU"
        label var V5853 "No. Kids in FU"
        label var V6109 "Non-Head Adult in FU"
        label var V6115 "Head: New wife, old wife, no wife 1977?"
        label var V6127 "FU: new head?"
        label var V5854 "Age of youngest kid in FU"
        label var V5710 "Change in Fam Composition"
        label var V5711 "No. people moved into FU"
        label var V5712 "Who moved INTO FU rel to Head"
        label var V5713 "No. people moved into FU"
        label var V5714 "Who moved OUT OF FU rel to Head"
        label var V5755 "Family Size 1978"
        label var V5779 "No Major Adults in FU, =1 single, =2 head+wife"
        label var V6034 "Head Marital Status: married, sing, wid, div, sep"
        label var V6035 "Head Ever Married"
        label var V6036 "Head: Outcome of last marriage"

        label var V6197 "HEAD MARITAL STATUS COMPARABLE TO 1968-1976 (MARRIED AND COHAB TOGETHER)"

        label var V6135 "Head: Age of oldest child"
        label var V6136 "Head: Age of 2nd oldest child"
        label var V6137 "Head: Age of 3rd oldest child"
        label var V6138 "Head: No. of children"
        label var V6139 "Head: No. children before 25 y/o"


    local SES_vars V5782 V5788 V5815 V5796 V5799L V5800 V5801 V5801 V5802 V5817 V5819 V5820 V5821 V5831 V5833 V6176 V5864 V5717 V5721 V5723 V5727 V6188 V6189 V6190 V6078 V5757 V5758 V5765 V5766 V5778 V5872 V5873 V5873_A V5874 V5874_A V5941 V5731 V5905 V5907 V5908 V5911 V5906 V5909 V5910 V5902 V5903 V5739 V5915 V5916  V6038 V6039 V6039_A V6040 V5743 V5751 V5816 V6157 V6158 V6159 V6163 V6164 V6116 V6117 V6118 V6119 V6120

        * INCOME
        label var V6173 "Total FU Income 1977: taxes and transfers, H, W, OFUM"
                label var V5782 "Head 1977 annual wage income"
                label var V5788 "Wife 1977 annual wage income"
                label var V5815 "Head + Wife 1977 transfer income amount"
                label var V5796 "Head + Wife taxable income 1977"
                label var V5799L "Head + Wife No dependents 1977"
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


    local others V60003 V6133 V6134 V6147 V6148
        label var V60003 "Head Year Retired"
        label var V6133 "Q head's first job"
        label var V6134 "Q change industries/ type of job?""
        label var V6147 "Q MOVED FOR JOB" 
        label var V6148 "Q NOT MOVED FOR JOB"

    order `identity_vars' `demographic_vars' `family_structure_vars' `SES_vars' `growing_up' `past_IDs' `social_capital_job' `others'


