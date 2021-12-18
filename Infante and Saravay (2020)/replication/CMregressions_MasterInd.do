//The input for this file do file an excel file with the following time series:
//
//- day: day of the observation
//- month: month of the observation
//- year: year of the observation
//- D`l'_USText: dealer `l' US Treasury collateral multplier of all contracts, for `l' from 1 to 9 dealers in our sample
//- D`l'_USTextRP: dealer `l' US Treasury collateral multplier of repo contracts, for `l' from 1 to 9 dealers in our sample
//- CDS_D`l': dealer `l' CDS quote, for `l' from 1 to 9 dealers in our sample
//- notesOutstanding: total outsanding amount of nominal Treasury Notes and Bonds
//- allBillOutstanding: total outsanding amount of nominal Treasury Bills
//- shortBillOutstanding: total outsanding amount of nominal Treasury Bills with one month less to mature
//- ustSomaHoldings: total Tresury holdings of the SOMA portfolio
//- tbillFourWeek: four-week T-bill rate
//- OIS1M: one-month overnigth index swap rate
//- tprRateBONY: Treasury tri-praty repo rate published by Bank of New York Mellon
//- gcfRate: GCF Treasury repo rate
//- sofr: Secured overnight financing rate
//- InterdealerOtrSpecialness: Index of interdelaer on-the-run Treasury repo rates
//- auctionSettleDate: an indictor equal to 1 on the Treaesury auction settlement
//- vix: VIX index for the S&P Index
//- vixTenYear: VIX index for the 10-year Treasury yield
//- yield10yr: 10-year Treasury yield of fitted yield curve
//- yield2yr: 2-year Treasury yield of fitted yield curve
//- quarterEndDummyOrg: an indicator equal to 1 on quarter-end dates
//- quarterEndDummyRollingWindow: an indicator equal to 1 on quarter-end dates, plus minus 2 business days around quarter-end
//
//See XXXX file to download individual dealer collateral multipliers using the FR 2052a


version 14
////clear data used from this .dat file -- could induce error?
clear 

capture log close

cd /fst/home/m1sxi00/Research/5GRPrime/TreasuryReuse/STATA
import excel CM_Ind_run_July2021.xlsx, firstrow

//start log
log using DailyCMSymEq, text replace

////Import date and change to date format
gen OrgDate = mdy(month, day, year)
format OrgDate %td 
//generate time dummies 
gen dWOY = week(OrgDate)
//set time series
gen time_teset = _n
tsset time_teset

gen TBillLogGr = log(allBillOutstanding) - log(L.allBillOutstanding)
gen ShTBillLogGr = log(shortBillOutstanding) - log(L.shortBillOutstanding)
gen USTLogGr = log(notesOutstanding) - log(L.notesOutstanding)
gen SOMALogGr = log(ustSomaHoldings) - log(L.ustSomaHoldings)

gen CY1M = - tbillFourWeek + OIS1M
gen Sp = InterdealerOtrSpecialness
gen GCF_sp = gcfRate - tprRateBONY
gen USTslope = yield10yr - yield2yr

///time dummy for mid-march change in policy
gen indMidMarch2020 = 0
replace indMidMarch2020 = 1 if OrgDate >= td(15mar2020)

//gen quarterEndDummy = quarterEndDummyOrg
//gen quarterEndDummy = quarterEndDummyRobust
gen quarterEndDummy = quarterEndDummyRollingWindow

foreach l in 1 2 3 4 5 6 7 8 9{
	replace D`l'_USText =. if quarterEndDummy == 1 | OrgDate == td(17sep2019) | OrgDate == td(16sep2019) 
	replace D`l'_USTextRP =. if quarterEndDummy == 1 | OrgDate == td(17sep2019) | OrgDate == td(16sep2019)
	//CM of average across all firms
	gen CM_LogGr_`l' = log(D`l'_USText) - log(L.D`l'_USText)
	gen CMrepo_LogGr_`l' = log(D`l'_USTextRP) - log(L.D`l'_USTextRP)

	winsor2 CM_LogGr_`l' CMrepo_LogGr_`l', replace cuts(1 , 99)
	
	drop D`l'_USText  D`l'_USTextRP
}

drop allBillOutstanding shortBillOutstanding notesOutstanding ustSomaHoldings tbillFourWeek OIS1M InterdealerOtrSpecialness gcfRate tprRateBONY yield10yr yield2yr sofr day month year


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////	
//simultaneous equation estimation of original model imposing the same coefficients across all dealers
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////	
foreach var in CM CMrepo{

	#delimit;
	gmm (`var'_LogGr_1  - {beta}*L.CY1M  - {cte1} - {gamL1_1}*L.`var'_LogGr_1 - {gamL2_1}*L2.`var'_LogGr_1 - {gamL3_1}*L3.`var'_LogGr_1 - {gamL4_1}*L4.`var'_LogGr_1 - {gamCDS_1}*L.CDS_D1 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020) 
	    (`var'_LogGr_2  - {beta}*L.CY1M  - {cte2} - {gamL1_2}*L.`var'_LogGr_2 - {gamL2_2}*L2.`var'_LogGr_1 - {gamL3_2}*L3.`var'_LogGr_2 - {gamL4_2}*L4.`var'_LogGr_2 - {gamCDS_2}*L.CDS_D2 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_3  - {beta}*L.CY1M  - {cte3} - {gamL1_3}*L.`var'_LogGr_3 - {gamL2_3}*L2.`var'_LogGr_3 - {gamL3_3}*L3.`var'_LogGr_3 - {gamL4_3}*L4.`var'_LogGr_3 - {gamCDS_3}*L.CDS_D3 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)
	    (`var'_LogGr_4  - {beta}*L.CY1M  - {cte4} - {gamL1_4}*L.`var'_LogGr_4 - {gamL2_4}*L2.`var'_LogGr_4 - {gamL3_4}*L3.`var'_LogGr_4 - {gamL4_4}*L4.`var'_LogGr_4 - {gamCDS_4}*L.CDS_D4 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_5  - {beta}*L.CY1M  - {cte5} - {gamL1_5}*L.`var'_LogGr_5 - {gamL2_5}*L2.`var'_LogGr_5 - {gamL3_5}*L3.`var'_LogGr_5 - {gamL4_5}*L4.`var'_LogGr_5 - {gamCDS_5}*L.CDS_D5 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020) 
	    (`var'_LogGr_6  - {beta}*L.CY1M  - {cte6} - {gamL1_6}*L.`var'_LogGr_6 - {gamL2_6}*L2.`var'_LogGr_6 - {gamL3_6}*L3.`var'_LogGr_6 - {gamL4_6}*L4.`var'_LogGr_6 - {gamCDS_6}*L.CDS_D6 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_7  - {beta}*L.CY1M  - {cte7} - {gamL1_7}*L.`var'_LogGr_7 - {gamL2_7}*L2.`var'_LogGr_7 - {gamL3_7}*L3.`var'_LogGr_7 - {gamL4_7}*L4.`var'_LogGr_7 - {gamCDS_7}*L.CDS_D7 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020) 
	    (`var'_LogGr_8  - {beta}*L.CY1M  - {cte8} - {gamL1_8}*L.`var'_LogGr_8 - {gamL2_8}*L2.`var'_LogGr_8 - {gamL3_8}*L3.`var'_LogGr_8 - {gamL4_8}*L4.`var'_LogGr_8 - {gamCDS_8}*L.CDS_D8 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_9  - {beta}*L.CY1M  - {cte9} - {gamL1_9}*L.`var'_LogGr_9 - {gamL2_9}*L2.`var'_LogGr_9 - {gamL3_9}*L3.`var'_LogGr_9 - {gamL4_9}*L4.`var'_LogGr_9 - {gamCDS_9}*L.CDS_D9 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020), 
		instruments(1: TBillLogGr L.CY1M L.`var'_LogGr_1 L2.`var'_LogGr_1 L3.`var'_LogGr_1 L4.`var'_LogGr_1 L.CDS_D1 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(2: TBillLogGr L.CY1M L.`var'_LogGr_2 L2.`var'_LogGr_2 L3.`var'_LogGr_2 L4.`var'_LogGr_2 L.CDS_D2 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(3: TBillLogGr L.CY1M L.`var'_LogGr_3 L2.`var'_LogGr_3 L3.`var'_LogGr_3 L4.`var'_LogGr_3 L.CDS_D3 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(4: TBillLogGr L.CY1M L.`var'_LogGr_4 L2.`var'_LogGr_4 L3.`var'_LogGr_4 L4.`var'_LogGr_4 L.CDS_D4 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(5: TBillLogGr L.CY1M L.`var'_LogGr_5 L2.`var'_LogGr_5 L3.`var'_LogGr_5 L4.`var'_LogGr_5 L.CDS_D5 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(6: TBillLogGr L.CY1M L.`var'_LogGr_6 L2.`var'_LogGr_6 L3.`var'_LogGr_6 L4.`var'_LogGr_6 L.CDS_D6 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(7: TBillLogGr L.CY1M L.`var'_LogGr_7 L2.`var'_LogGr_7 L3.`var'_LogGr_7 L4.`var'_LogGr_7 L.CDS_D7 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(8: TBillLogGr L.CY1M L.`var'_LogGr_8 L2.`var'_LogGr_8 L3.`var'_LogGr_8 L4.`var'_LogGr_8 L.CDS_D8 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(9: TBillLogGr L.CY1M L.`var'_LogGr_9 L2.`var'_LogGr_9 L3.`var'_LogGr_9 L4.`var'_LogGr_9 L.CDS_D9 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		vce(hac nw 21) winitial(unadjusted,independent) wmatrix(hac nw 21) 
		variables(`var'_LogGr_1 `var'_LogGr_2 `var'_LogGr_3 `var'_LogGr_4 `var'_LogGr_5 `var'_LogGr_6 `var'_LogGr_7 `var'_LogGr_8 `var'_LogGr_9);  
	estat overid;
	estadd scalar Jstat = r(J);
	estadd scalar pJstat = r(J_p);
	estadd scalar dfJstat = r(J_df);
	estimates store `var'_SymEqReg;	
	#delimit cr	
		
}	
estout CM_SymEqReg CMrepo_SymEqReg  using TMasterIndBase_July2021.txt, replace  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(se))) ///	
	order(/gamTBillLogGr /gamUSTLogGr /gamSOMALogGr /gamGCF /gamSP /beta /gamindMar) keep(/gamTBillLogGr /gamUSTLogGr /gamSOMALogGr /gamGCF /gamSP /beta /gamindMar) /// 
	stats(Jstat pJstat dfJstat N, labels("J-Stat" "p-value" "df" "N obs") fmt(3 3 0 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01)
	
	
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////	
//simultaneous equation estimation of original model imposing different coefficients of driveres for US and non-US dealers
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
foreach var in CM CMrepo{
	#delimit;	
	gmm (`var'_LogGr_1  - {betaUS}*L.CY1M  - {cte1} - {gamL1_1}*L.`var'_LogGr_1 - {gamL2_1}*L2.`var'_LogGr_1 - {gamL3_1}*L3.`var'_LogGr_1 - {gamL4_1}*L4.`var'_LogGr_1 - {gamCDS_1}*L.CDS_D1 -  {gamSPUS}*L.Sp -  {gamGCFUS}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020) 
	    (`var'_LogGr_2  - {betaRoW}*L.CY1M  - {cte2} - {gamL1_2}*L.`var'_LogGr_2 - {gamL2_2}*L2.`var'_LogGr_1 - {gamL3_2}*L3.`var'_LogGr_2 - {gamL4_2}*L4.`var'_LogGr_2 - {gamCDS_2}*L.CDS_D2 -  {gamSPRoW}*L.Sp -  {gamGCFRoW}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_3  - {betaUS}*L.CY1M  - {cte3} - {gamL1_3}*L.`var'_LogGr_3 - {gamL2_3}*L2.`var'_LogGr_3 - {gamL3_3}*L3.`var'_LogGr_3 - {gamL4_3}*L4.`var'_LogGr_3 - {gamCDS_3}*L.CDS_D3 -  {gamSPUS}*L.Sp -  {gamGCFUS}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)
	    (`var'_LogGr_4  - {betaUS}*L.CY1M  - {cte4} - {gamL1_4}*L.`var'_LogGr_4 - {gamL2_4}*L2.`var'_LogGr_4 - {gamL3_4}*L3.`var'_LogGr_4 - {gamL4_4}*L4.`var'_LogGr_4 - {gamCDS_4}*L.CDS_D4 -  {gamSPUS}*L.Sp -  {gamGCFUS}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_5  - {betaUS}*L.CY1M  - {cte5} - {gamL1_5}*L.`var'_LogGr_5 - {gamL2_5}*L2.`var'_LogGr_5 - {gamL3_5}*L3.`var'_LogGr_5 - {gamL4_5}*L4.`var'_LogGr_5 - {gamCDS_5}*L.CDS_D5 -  {gamSPUS}*L.Sp -  {gamGCFUS}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020) 
	    (`var'_LogGr_6  - {betaUS}*L.CY1M  - {cte6} - {gamL1_6}*L.`var'_LogGr_6 - {gamL2_6}*L2.`var'_LogGr_6 - {gamL3_6}*L3.`var'_LogGr_6 - {gamL4_6}*L4.`var'_LogGr_6 - {gamCDS_6}*L.CDS_D6 -  {gamSPUS}*L.Sp -  {gamGCFUS}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_7  - {betaRoW}*L.CY1M  - {cte7} - {gamL1_7}*L.`var'_LogGr_7 - {gamL2_7}*L2.`var'_LogGr_7 - {gamL3_7}*L3.`var'_LogGr_7 - {gamL4_7}*L4.`var'_LogGr_7 - {gamCDS_7}*L.CDS_D7 -  {gamSPRoW}*L.Sp -  {gamGCFRoW}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020) 
	    (`var'_LogGr_8  - {betaUS}*L.CY1M  - {cte8} - {gamL1_8}*L.`var'_LogGr_8 - {gamL2_8}*L2.`var'_LogGr_8 - {gamL3_8}*L3.`var'_LogGr_8 - {gamL4_8}*L4.`var'_LogGr_8 - {gamCDS_8}*L.CDS_D8 -  {gamSPUS}*L.Sp -  {gamGCFUS}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_9  - {betaRoW}*L.CY1M  - {cte9} - {gamL1_9}*L.`var'_LogGr_9 - {gamL2_9}*L2.`var'_LogGr_9 - {gamL3_9}*L3.`var'_LogGr_9 - {gamL4_9}*L4.`var'_LogGr_9 - {gamCDS_9}*L.CDS_D9 -  {gamSPRoW}*L.Sp -  {gamGCFRoW}*L.GCF_sp  - {gamUSTLogGr}*USTLogGr - {gamSOMALogGr}*SOMALogGr - {gamTBillLogGr}*TBillLogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020), 
		instruments(1: TBillLogGr L.CY1M L.`var'_LogGr_1 L2.`var'_LogGr_1 L3.`var'_LogGr_1 L4.`var'_LogGr_1 L.CDS_D1 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(2: TBillLogGr L.CY1M L.`var'_LogGr_2 L2.`var'_LogGr_2 L3.`var'_LogGr_2 L4.`var'_LogGr_2 L.CDS_D2 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(3: TBillLogGr L.CY1M L.`var'_LogGr_3 L2.`var'_LogGr_3 L3.`var'_LogGr_3 L4.`var'_LogGr_3 L.CDS_D3 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(4: TBillLogGr L.CY1M L.`var'_LogGr_4 L2.`var'_LogGr_4 L3.`var'_LogGr_4 L4.`var'_LogGr_4 L.CDS_D4 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(5: TBillLogGr L.CY1M L.`var'_LogGr_5 L2.`var'_LogGr_5 L3.`var'_LogGr_5 L4.`var'_LogGr_5 L.CDS_D5 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(6: TBillLogGr L.CY1M L.`var'_LogGr_6 L2.`var'_LogGr_6 L3.`var'_LogGr_6 L4.`var'_LogGr_6 L.CDS_D6 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(7: TBillLogGr L.CY1M L.`var'_LogGr_7 L2.`var'_LogGr_7 L3.`var'_LogGr_7 L4.`var'_LogGr_7 L.CDS_D7 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(8: TBillLogGr L.CY1M L.`var'_LogGr_8 L2.`var'_LogGr_8 L3.`var'_LogGr_8 L4.`var'_LogGr_8 L.CDS_D8 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(9: TBillLogGr L.CY1M L.`var'_LogGr_9 L2.`var'_LogGr_9 L3.`var'_LogGr_9 L4.`var'_LogGr_9 L.CDS_D9 L.Sp L.GCF_sp USTLogGr SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		vce(hac nw 21) winitial(unadjusted,independent) wmatrix(hac nw 21) 
		variables(`var'_LogGr_1 `var'_LogGr_2 `var'_LogGr_3 `var'_LogGr_4 `var'_LogGr_5 `var'_LogGr_6 `var'_LogGr_7 `var'_LogGr_8 `var'_LogGr_9);  
	estat overid;
	estadd scalar Jstat = r(J);
	estadd scalar pJstat = r(J_p);
	estadd scalar dfJstat = r(J_df);
	estimates store `var'USRoW_SymEqReg;
	#delimit cr
}	


estout CMUSRoW_SymEqReg CMrepoUSRoW_SymEqReg using TMasterIndUSRoW_July2021.txt, replace  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(se))) ///	
	order(/gamTBillLogGr /gamUSTLogGr /gamSOMALogGr /gamGCFUS /gamGCFRoW /gamSPUS /gamSPRoW /betaUS /betaRoW  /gamindMar) keep(/gamTBillLogGr /gamUSTLogGr /gamSOMALogGr /gamGCFUS /gamGCFRoW /gamSPUS /gamSPRoW /betaUS /betaRoW  /gamindMar) /// 
	stats(Jstat pJstat dfJstat N, labels("J-Stat" "p-value" "df" "N obs") fmt(3 3 0 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01)	
	
	
estout CM_SymEqReg CMUSRoW_SymEqReg CMrepo_SymEqReg CMrepoUSRoW_SymEqReg using TMasterInd_July2021.txt, replace  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(se))) ///	
	order(/gamTBillLogGr /gamUSTLogGr /gamSOMALogGr /gamGCF /gamGCFUS /gamGCFRoW  /gamSP /gamSPUS /gamSPRoW  /beta /betaUS /betaRoW /gamindMar) keep(/gamTBillLogGr /gamUSTLogGr /gamSOMALogGr /gamGCF /gamGCFUS /gamGCFRoW  /gamSP /gamSPUS /gamSPRoW  /beta /betaUS /betaRoW /gamindMar) /// 
	stats(Jstat pJstat dfJstat N, labels("J-Stat" "p-value" "df" "N obs") fmt(3 3 0 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01)	
	

	
	
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////	
//simultaneous equation estimation of IV model imposing the same coefficients across all dealers
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
foreach var in CM CMrepo{
	#delimit;
	gmm (`var'_LogGr_1  - {beta}*L.CY1M  - {cte1} - {gamL1_1}*L.`var'_LogGr_1 - {gamL2_1}*L2.`var'_LogGr_1 - {gamL3_1}*L3.`var'_LogGr_1 - {gamL4_1}*L4.`var'_LogGr_1 - {gamCDS_1}*L.CDS_D1 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020) 
	    (`var'_LogGr_2  - {beta}*L.CY1M  - {cte2} - {gamL1_2}*L.`var'_LogGr_2 - {gamL2_2}*L2.`var'_LogGr_1 - {gamL3_2}*L3.`var'_LogGr_2 - {gamL4_2}*L4.`var'_LogGr_2 - {gamCDS_2}*L.CDS_D2 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_3  - {beta}*L.CY1M  - {cte3} - {gamL1_3}*L.`var'_LogGr_3 - {gamL2_3}*L2.`var'_LogGr_3 - {gamL3_3}*L3.`var'_LogGr_3 - {gamL4_3}*L4.`var'_LogGr_3 - {gamCDS_3}*L.CDS_D3 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)
	    (`var'_LogGr_4  - {beta}*L.CY1M  - {cte4} - {gamL1_4}*L.`var'_LogGr_4 - {gamL2_4}*L2.`var'_LogGr_4 - {gamL3_4}*L3.`var'_LogGr_4 - {gamL4_4}*L4.`var'_LogGr_4 - {gamCDS_4}*L.CDS_D4 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_5  - {beta}*L.CY1M  - {cte5} - {gamL1_5}*L.`var'_LogGr_5 - {gamL2_5}*L2.`var'_LogGr_5 - {gamL3_5}*L3.`var'_LogGr_5 - {gamL4_5}*L4.`var'_LogGr_5 - {gamCDS_5}*L.CDS_D5 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020) 
	    (`var'_LogGr_6  - {beta}*L.CY1M  - {cte6} - {gamL1_6}*L.`var'_LogGr_6 - {gamL2_6}*L2.`var'_LogGr_6 - {gamL3_6}*L3.`var'_LogGr_6 - {gamL4_6}*L4.`var'_LogGr_6 - {gamCDS_6}*L.CDS_D6 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_7  - {beta}*L.CY1M  - {cte7} - {gamL1_7}*L.`var'_LogGr_7 - {gamL2_7}*L2.`var'_LogGr_7 - {gamL3_7}*L3.`var'_LogGr_7 - {gamL4_7}*L4.`var'_LogGr_7 - {gamCDS_7}*L.CDS_D7 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020) 
	    (`var'_LogGr_8  - {beta}*L.CY1M  - {cte8} - {gamL1_8}*L.`var'_LogGr_8 - {gamL2_8}*L2.`var'_LogGr_8 - {gamL3_8}*L3.`var'_LogGr_8 - {gamL4_8}*L4.`var'_LogGr_8 - {gamCDS_8}*L.CDS_D8 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_9  - {beta}*L.CY1M  - {cte9} - {gamL1_9}*L.`var'_LogGr_9 - {gamL2_9}*L2.`var'_LogGr_9 - {gamL3_9}*L3.`var'_LogGr_9 - {gamL4_9}*L4.`var'_LogGr_9 - {gamCDS_9}*L.CDS_D9 -  {gamSP}*L.Sp -  {gamGCF}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020), 
		instruments(1: L.ShTBillLogGr L.`var'_LogGr_1 L2.`var'_LogGr_1 L3.`var'_LogGr_1 L4.`var'_LogGr_1 L.CDS_D1 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(2: L.ShTBillLogGr L.`var'_LogGr_2 L2.`var'_LogGr_2 L3.`var'_LogGr_2 L4.`var'_LogGr_2 L.CDS_D2 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(3: L.ShTBillLogGr L.`var'_LogGr_3 L2.`var'_LogGr_3 L3.`var'_LogGr_3 L4.`var'_LogGr_3 L.CDS_D3 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(4: L.ShTBillLogGr L.`var'_LogGr_4 L2.`var'_LogGr_4 L3.`var'_LogGr_4 L4.`var'_LogGr_4 L.CDS_D4 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(5: L.ShTBillLogGr L.`var'_LogGr_5 L2.`var'_LogGr_5 L3.`var'_LogGr_5 L4.`var'_LogGr_5 L.CDS_D5 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(6: L.ShTBillLogGr L.`var'_LogGr_6 L2.`var'_LogGr_6 L3.`var'_LogGr_6 L4.`var'_LogGr_6 L.CDS_D6 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(7: L.ShTBillLogGr L.`var'_LogGr_7 L2.`var'_LogGr_7 L3.`var'_LogGr_7 L4.`var'_LogGr_7 L.CDS_D7 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(8: L.ShTBillLogGr L.`var'_LogGr_8 L2.`var'_LogGr_8 L3.`var'_LogGr_8 L4.`var'_LogGr_8 L.CDS_D8 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(9: L.ShTBillLogGr L.`var'_LogGr_9 L2.`var'_LogGr_9 L3.`var'_LogGr_9 L4.`var'_LogGr_9 L.CDS_D9 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		vce(hac nw 21) winitial(unadjusted,independent) wmatrix(hac nw 21) 
		variables(`var'_LogGr_1 `var'_LogGr_2 `var'_LogGr_3 `var'_LogGr_4 `var'_LogGr_5 `var'_LogGr_6 `var'_LogGr_7 `var'_LogGr_8 `var'_LogGr_9);  
	estat overid;
	estadd scalar Jstat = r(J);
	estadd scalar pJstat = r(J_p);
	estadd scalar dfJstat = r(J_df);
	estimates store `var'_IVSymEqReg;
	#delimit cr
}

estout CM_IVSymEqReg CMrepo_IVSymEqReg using TMasterIndIVBase_July2021.txt, replace  ///
	varlabels(/beta " $\widehat{(Tbill-OIS)}_{t-1}$ " /gamSP " $(SOFR-RPSpecial)_{t-1}$ "  /gamGCF " $(GCF-SORF)_{t-1}$ " /gamUSTLogGr_lag "$\Delta log(USTNotesOut_{t-1}) $" /gamSOMALogGr_lag "$\Delta log(SOMA_{t-1}) $")  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(se))) ///
	order(/beta /gamSP /gamGCF /gamUSTLogGr_lag /gamSOMALogGr_lag /gamindMar) keep(/beta /gamSP /gamGCF /gamUSTLogGr_lag /gamSOMALogGr_lag /gamindMar) /// 
	stats(Jstat pJstat dfJstat N, labels("J-Stat" "p-value" "df" "N obs") fmt(3 3 0 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01)		


	
	
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////	
//simultaneous equation estimation of IV model imposing different coefficients of driveres for US and non-US dealers
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////	
foreach var in CM CMrepo{
	#delimit;
	gmm (`var'_LogGr_1  - {betaUS}*L.CY1M  - {cte1} - {gamL1_1}*L.`var'_LogGr_1 - {gamL2_1}*L2.`var'_LogGr_1 - {gamL3_1}*L3.`var'_LogGr_1 - {gamL4_1}*L4.`var'_LogGr_1 - {gamCDS_1}*L.CDS_D1 -  {gamSPUS}*L.Sp -  {gamGCFUS}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020) 
	    (`var'_LogGr_2  - {betaRoW}*L.CY1M  - {cte2} - {gamL1_2}*L.`var'_LogGr_2 - {gamL2_2}*L2.`var'_LogGr_1 - {gamL3_2}*L3.`var'_LogGr_2 - {gamL4_2}*L4.`var'_LogGr_2 - {gamCDS_2}*L.CDS_D2 -  {gamSPRoW}*L.Sp -  {gamGCFRoW}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_3  - {betaUS}*L.CY1M  - {cte3} - {gamL1_3}*L.`var'_LogGr_3 - {gamL2_3}*L2.`var'_LogGr_3 - {gamL3_3}*L3.`var'_LogGr_3 - {gamL4_3}*L4.`var'_LogGr_3 - {gamCDS_3}*L.CDS_D3 -  {gamSPUS}*L.Sp -  {gamGCFUS}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)
	    (`var'_LogGr_4  - {betaUS}*L.CY1M  - {cte4} - {gamL1_4}*L.`var'_LogGr_4 - {gamL2_4}*L2.`var'_LogGr_4 - {gamL3_4}*L3.`var'_LogGr_4 - {gamL4_4}*L4.`var'_LogGr_4 - {gamCDS_4}*L.CDS_D4 -  {gamSPUS}*L.Sp -  {gamGCFUS}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_5  - {betaUS}*L.CY1M  - {cte5} - {gamL1_5}*L.`var'_LogGr_5 - {gamL2_5}*L2.`var'_LogGr_5 - {gamL3_5}*L3.`var'_LogGr_5 - {gamL4_5}*L4.`var'_LogGr_5 - {gamCDS_5}*L.CDS_D5 -  {gamSPUS}*L.Sp -  {gamGCFUS}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020) 
	    (`var'_LogGr_6  - {betaUS}*L.CY1M  - {cte6} - {gamL1_6}*L.`var'_LogGr_6 - {gamL2_6}*L2.`var'_LogGr_6 - {gamL3_6}*L3.`var'_LogGr_6 - {gamL4_6}*L4.`var'_LogGr_6 - {gamCDS_6}*L.CDS_D6 -  {gamSPUS}*L.Sp -  {gamGCFUS}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_7  - {betaRoW}*L.CY1M  - {cte7} - {gamL1_7}*L.`var'_LogGr_7 - {gamL2_7}*L2.`var'_LogGr_7 - {gamL3_7}*L3.`var'_LogGr_7 - {gamL4_7}*L4.`var'_LogGr_7 - {gamCDS_7}*L.CDS_D7 -  {gamSPRoW}*L.Sp -  {gamGCFRoW}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020) 
	    (`var'_LogGr_8  - {betaUS}*L.CY1M  - {cte8} - {gamL1_8}*L.`var'_LogGr_8 - {gamL2_8}*L2.`var'_LogGr_8 - {gamL3_8}*L3.`var'_LogGr_8 - {gamL4_8}*L4.`var'_LogGr_8 - {gamCDS_8}*L.CDS_D8 -  {gamSPUS}*L.Sp -  {gamGCFUS}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020)      
		(`var'_LogGr_9  - {betaRoW}*L.CY1M  - {cte9} - {gamL1_9}*L.`var'_LogGr_9 - {gamL2_9}*L2.`var'_LogGr_9 - {gamL3_9}*L3.`var'_LogGr_9 - {gamL4_9}*L4.`var'_LogGr_9 - {gamCDS_9}*L.CDS_D9 -  {gamSPRoW}*L.Sp -  {gamGCFRoW}*L.GCF_sp  - {gamUSTLogGr_lag}*L.USTLogGr - {gamSOMALogGr_lag}*L.SOMALogGr - {gamslope}*L.USTslope - {gamVIXTen}*L.vixTenYear - {gamVIX}*L.vix - {gamindMar}*indMidMarch2020), 
		instruments(1: L.ShTBillLogGr L.`var'_LogGr_1 L2.`var'_LogGr_1 L3.`var'_LogGr_1 L4.`var'_LogGr_1 L.CDS_D1 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(2: L.ShTBillLogGr L.`var'_LogGr_2 L2.`var'_LogGr_2 L3.`var'_LogGr_2 L4.`var'_LogGr_2 L.CDS_D2 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(3: L.ShTBillLogGr L.`var'_LogGr_3 L2.`var'_LogGr_3 L3.`var'_LogGr_3 L4.`var'_LogGr_3 L.CDS_D3 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(4: L.ShTBillLogGr L.`var'_LogGr_4 L2.`var'_LogGr_4 L3.`var'_LogGr_4 L4.`var'_LogGr_4 L.CDS_D4 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(5: L.ShTBillLogGr L.`var'_LogGr_5 L2.`var'_LogGr_5 L3.`var'_LogGr_5 L4.`var'_LogGr_5 L.CDS_D5 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(6: L.ShTBillLogGr L.`var'_LogGr_6 L2.`var'_LogGr_6 L3.`var'_LogGr_6 L4.`var'_LogGr_6 L.CDS_D6 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(7: L.ShTBillLogGr L.`var'_LogGr_7 L2.`var'_LogGr_7 L3.`var'_LogGr_7 L4.`var'_LogGr_7 L.CDS_D7 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(8: L.ShTBillLogGr L.`var'_LogGr_8 L2.`var'_LogGr_8 L3.`var'_LogGr_8 L4.`var'_LogGr_8 L.CDS_D8 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		instruments(9: L.ShTBillLogGr L.`var'_LogGr_9 L2.`var'_LogGr_9 L3.`var'_LogGr_9 L4.`var'_LogGr_9 L.CDS_D9 L.Sp L.GCF_sp L.USTLogGr L.SOMALogGr L.USTslope L.vixTenYear L.vix indMidMarch2020) 
		vce(hac nw 21) winitial(unadjusted,independent) wmatrix(hac nw 21) 
		variables(`var'_LogGr_1 `var'_LogGr_2 `var'_LogGr_3 `var'_LogGr_4 `var'_LogGr_5 `var'_LogGr_6 `var'_LogGr_7 `var'_LogGr_8 `var'_LogGr_9);  
		
	estat overid;
	estadd scalar Jstat = r(J);
	estadd scalar pJstat = r(J_p);
	estadd scalar dfJstat = r(J_df);
	estimates store `var'USRoW_IVSymEqReg;
	#delimit cr
}
	
estout CMUSRoW_IVSymEqReg CMrepoUSRoW_IVSymEqReg using TMasterIndUSRoWIV_July2021.txt, replace  ///
	varlabels(/betaUS " $\widehat{(Tbill-OIS)}_{t-1}^{US}$ " /betaRoW " $\widehat{(Tbill-OIS)}_{t-1}^{RoW}$ " /gamSPUS " $(SOFR-RPSpecial)_{t-1}^{US}$ " /gamSPRoW " $(SOFR-RPSpecial)_{t-1}^{RoW}$ " /gamGCFUS " $(GCF-SORF)_{t-1}^{US}$ " /gamGCFRoW " $(GCF-SORF)_{t-1}^{RoW}$ " /gamUSTLogGr_lag "$\Delta log(USTNotesOut_{t-1}) $" /gamSOMALogGr_lag "$\Delta log(SOMA_{t-1}) $")  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(se))) ///
	order(/betaUS /betaRoW /gamSPUS /gamSPRoW /gamGCFUS /gamGCFRoW /gamUSTLogGr_lag /gamSOMALogGr_lag /gamindMar) keep(/betaUS /betaRoW /gamSPUS /gamSPRoW /gamGCFUS /gamGCFRoW /gamUSTLogGr_lag /gamSOMALogGr_lag /gamindMar) /// 
	stats(Jstat pJstat dfJstat N, labels("J-Stat" "p-value" "df" "N obs") fmt(3 3 0 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01)		
	
estout CM_IVSymEqReg CMUSRoW_IVSymEqReg CMrepo_IVSymEqReg  CMrepoUSRoW_IVSymEqReg  using TMasterIndIV_July2021.txt, replace  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(se))) ///
	order(/beta /betaUS /betaRoW /gamSP /gamSPUS /gamSPRoW /gamGCF /gamGCFUS /gamGCFRoW /gamUSTLogGr_lag /gamSOMALogGr_lag /gamindMar) keep(/beta /betaUS /betaRoW /gamSP /gamSPUS /gamSPRoW /gamGCF /gamGCFUS /gamGCFRoW /gamUSTLogGr_lag /gamSOMALogGr_lag /gamindMar) /// 
	stats(Jstat pJstat dfJstat N, labels("J-Stat" "p-value" "df" "N obs") fmt(3 3 0 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01)	

	
export delimited /fst/home/m1sxi00/Research/5GRPrime/TreasuryReuse/STATA/CMRegressions_MasterOutput_IndFirm.csv, replace 	
