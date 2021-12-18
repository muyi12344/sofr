//The input for this file do file an excel file with the following time series:
//
//- day: day of the observation
//- month: month of the observation
//- year: year of the observation
//- Avg_USText: cross-sectional average US Treaury collateral mutilplier of all contracts for the 9 dealers in our sample
//- Avg_USTextRP: cross-sectional average US Treaury collateral mutilplier of repo contracts for the 9 dealers in our sample
//- AvgUS_USText: cross-sectional average US Treaury collateral mutilplier of all contracts for the 6 US dealers in our sample
//- AvgUS_USTextRP: cross-sectional average US Treaury collateral mutilplier of repo contracts for the 6 US dealers in our sample
//- AvgRoW_USText: cross-sectional average US Treaury collateral mutilplier of all contracts for the 3 non-US dealers in our sample
//- AvgRoW_USTextRP: cross-sectional average US Treaury collateral mutilplier of repo contracts for the 3 non-US dealers in our sample
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
//- dealerCdsMedian: median dealer CDS quote of the 9 dealer in our sample
//- auctionSettleDate: an indictor equal to 1 on the Treaesury auction settlement
//- vix: VIX index for the S&P Index
//- vixTenYear: VIX index for the 10-year Treasury yield
//- yield10yr: 10-year Treasury yield of fitted yield curve
//- yield2yr: 2-year Treasury yield of fitted yield curve
//- quarterEndDummyOrg: an indicator equal to 1 on quarter-end dates
//- quarterEndDummyRollingWindow: an indicator equal to 1 on quarter-end dates, plus minus 2 business days around quarter-end
//
//Average CM variables can be found at supplementary material to the FEDS Working paper



version 14
////clear data used from this .dat file -- could induce error?
clear 

capture log close

//Load data
cd /fst/home/m1sxi00/Research/5GRPrime/TreasuryReuse/STATA
import excel CM_Avg_run_July2021.xlsx, firstrow

//start log
log using DailyCMRegressionsTS, text replace

////Import date and change to date format
gen OrgDate = mdy(month, day, year)
format OrgDate %td 

//set time series
gen time_teset = _n
tsset time_teset

///Generate 1-day government issuance controls
gen TBillLogGr = log(allBillOutstanding) - log(L.allBillOutstanding)
gen ShTBillLogGr = log(shortBillOutstanding) - log(L.shortBillOutstanding)
gen USTLogGr = log(notesOutstanding) - log(L.notesOutstanding)
gen SOMALogGr = log(ustSomaHoldings) - log(L.ustSomaHoldings)

///Generate 5-day government issuance controls
gen TBill5dayLogGr = log(allBillOutstanding) - log(L5.allBillOutstanding)
gen ShTBill5dayLogGr = log(shortBillOutstanding) - log(L5.shortBillOutstanding)
gen UST5dayLogGr = log(notesOutstanding) - log(L5.notesOutstanding)
gen SOMA5dayLogGr = log(ustSomaHoldings) - log(L5.ustSomaHoldings)

///Generate spread controls
gen CY1M = - tbillFourWeek + OIS1M
gen Sp = InterdealerOtrSpecialness
gen GCF_sp = gcfRate - tprRateBONY
gen USTslope = yield10yr - yield2yr

///Generate time dummy for mid-march change in policy
gen indMidMarch2020 = 0
replace indMidMarch2020 = 1 if OrgDate >= td(15mar2020)

///Choose the quarter-end dummy
//gen quarterEndDummy = quarterEndDummyOrg
gen quarterEndDummy = quarterEndDummyRollingWindow

//Eliminate quarter-end and repo spike
foreach var in Avg USAvg RoWAvg {
	replace `var'_USText =. if quarterEndDummy == 1 | OrgDate == td(17sep2019) | OrgDate == td(16sep2019)
	replace `var'_USTextRP =. if quarterEndDummy == 1 | OrgDate == td(17sep2019) | OrgDate == td(16sep2019)
}

//Log growth of CM average across all firms
gen CM_LogGr = log(Avg_USText) - log(L.Avg_USText)
gen CMrepo_LogGr = log(Avg_USTextRP) - log(L.Avg_USTextRP)

//Log growth of CM average across US firms
gen CMUS_LogGr = log(USAvg_USText) - log(L.USAvg_USText)
gen CMUSrepo_LogGr = log(USAvg_USTextRP) - log(L.USAvg_USTextRP)

//Log growth of CM average across firms RoW firms
gen CMRoW_LogGr = log(RoWAvg_USText) - log(L.RoWAvg_USText)
gen CMRoWrepo_LogGr = log(RoWAvg_USTextRP) - log(L.RoWAvg_USTextRP)


////FOR 5-DAY OVERLAPPING REGRESSIONS
//5-day Log growth of CM average across all firms
gen CM_5dayLogGr = log(Avg_USText) - log(L5.Avg_USText)
gen CMrepo_5dayLogGr = log(Avg_USTextRP) - log(L5.Avg_USTextRP)

//5-day Log growth of CM average across US firms
gen CMUS_5dayLogGr = log(USAvg_USText) - log(L5.USAvg_USText)
gen CMUSrepo_5dayLogGr = log(USAvg_USTextRP) - log(L5.USAvg_USTextRP)

//5-day Log growth of CM average across firms RoW firms
gen CMRoW_5dayLogGr = log(RoWAvg_USText) - log(L5.RoWAvg_USText)
gen CMRoWrepo_5dayLogGr = log(RoWAvg_USTextRP) - log(L5.RoWAvg_USTextRP)


///winsorize variables 

//winsor2 CM_LogGr CMrepo_LogGr CMUS_LogGr CMUSrepo_LogGr CMRoW_LogGr ///
//	CM_5dayLogGr CMrepo_5dayLogGr CMUS_5dayLogGr CMUSrepo_5dayLogGr CMRoW_5dayLogGr CMRoWrepo_5dayLogGr, replace cuts(1 , 99)
winsor2 CM_LogGr CMrepo_LogGr CMUS_LogGr CMUSrepo_LogGr CMRoW_LogGr CMRoWrepo_LogGr ///
	CM_5dayLogGr CMrepo_5dayLogGr CMUS_5dayLogGr CMUSrepo_5dayLogGr CMRoW_5dayLogGr CMRoWrepo_5dayLogGr, replace cuts(1 , 99)
	
drop Avg_USText Avg_USTextRP USAvg_USText USAvg_USTextRP RoWAvg_USText RoWAvg_USTextRP allBillOutstanding shortBillOutstanding notesOutstanding ustSomaHoldings tbillFourWeek OIS1M InterdealerOtrSpecialness gcfRate tprRateBONY yield10yr yield2yr sofr day month year
	 
 
//////////////////////////////////////////////////////////////////////////////
////////Calculate summary statistics//////////////////////////////////////////	 
//////////////////////////////////////////////////////////////////////////////
estpost summarize CM_LogGr CMUS_LogGr CMRoW_LogGr CMrepo_LogGr CMUSrepo_LogGr CMRoWrepo_LogGr TBillLogGr USTLogGr SOMALogGr GCF_sp Sp CY1M


//////////////////////////////////////////////////////////////////////////////
/////////Calculate variance covariance matrix of CM log changes////////////////
//////////////////////////////////////////////////////////////////////////////
corr CM_LogGr CMUS_LogGr CMRoW_LogGr CMrepo_LogGr CMUSrepo_LogGr CMRoWrepo_LogGr			 
matrix define CMcorr = r(C)	 
estout matrix(CMcorr, fmt(3)) using TMaster_CMcorr.txt, replace ///
	style (tex)   varwidth(20) modelwidth(20)  

	
	
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///////////////Aggregate CM Daily Regressions including government issuance
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
local FinVarLag L.USTslope L.vixTenYear L.vix L.dealerCdsMedian indMidMarch2020
local GovAgg TBillLogGr USTLogGr SOMALogGr

foreach var in CM CMUS CMRoW CMrepo CMUSrepo CMRoWrepo{	
	quietly regress `var'_LogGr L.CY1M L.Sp L.GCF_sp `GovAgg' `FinVarLag'  L(1/4).`var'_LogGr 
	local r2 = e(r2_a)
	quietly newey `var'_LogGr L.CY1M L.Sp L.GCF_sp `GovAgg' `FinVarLag' L(1/4).`var'_LogGr , lag(21) force
	test L.`var'_LogGr = L2.`var'_LogGr = L3.`var'_LogGr = L4.`var'_LogGr = 0
	estadd scalar P_Lag = r(p)
	estadd scalar r2 = `r2'
	estimates store `var'_gov
}

estout CM_gov CMUS_gov CMRoW_gov CMrepo_gov CMUSrepo_gov CMRoWrepo_gov using TMaster_Gov_July2021.txt, replace ///
	varlabels(L.CY1M "$(OIS - Tbill)_{t-1}$" L.Sp "$(SOFR-RpSpecial)_{t-1}$ "  L.GCF_sp "$(GCF-TPR)_{t-1}$ "  TBillLogGr "$\Delta log(TbillsOut_t)$" USTLogGr "$\Delta log(USTNotesOut_t)$" SOMALogGr "$\Delta log(SOMA_t)$" indMidMarch2020 "$1_{\textrm{MidMarch2020}}$" )  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(t-stat))) ///
	order(TBillLogGr USTLogGr SOMALogGr L.GCF_sp L.Sp L.CY1M indMidMarch2020) keep(TBillLogGr USTLogGr SOMALogGr L.GCF_sp L.Sp L.CY1M indMidMarch2020)  /// 
	stats(P_Lag r2 N, labels("P-value" "Adj RSq " "N obs") fmt(3 3 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01)  ///
	title("All and Repo CM regressions with Government Issuance Controls") ///	
	varwidth(40) modelwidth(20)  



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///////INSTRUMENTAL VARIABLES--- 2 stage regressions to instrument for safe asset demand
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
local FinVarLag L.USTslope L.vixTenYear L.vix L.dealerCdsMedian indMidMarch2020
local GovAggLag_Sh L.ShTBillLogGr L.USTLogGr L.SOMALogGr
local GovAggLag_exSh L.USTLogGr L.SOMALogGr

foreach var in CM CMUS CMRoW CMrepo CMUSrepo CMRoWrepo {	
	quietly regress L.CY1M `FinVarLag' L.Sp L.GCF_sp `GovAggLag_Sh' L(1/4).`var'_LogGr 
	local r2 = e(r2_a)
	quietly newey L.CY1M `FinVarLag' L.Sp L.GCF_sp `GovAggLag_Sh' L(1/4).`var'_LogGr , lag(21) force
	estadd scalar r2 = `r2'
	estimates store `var'_CY1MStage1
	quietly ivregress gmm `var'_LogGr `FinVarLag' L.Sp L.GCF_sp `GovAggLag_exSh' L(1/4).`var'_LogGr (L.CY1M = L.ShTBillLogGr), wmatrix(hac nwest 21)
	test L.`var'_LogGr = L2.`var'_LogGr = L3.`var'_LogGr = L4.`var'_LogGr = 0
	estadd scalar P_Lag = r(p)
	estimates store `var'_CY1MStage2
}

estout CM_CY1MStage1 CM_CY1MStage2 CMUS_CY1MStage1 CMUS_CY1MStage2 CMRoW_CY1MStage1 CMRoW_CY1MStage2 using TMaster_IVAll_July2021.txt, replace ///
	varlabels(L.Sp " $(SOFR-RpSpecial)_{t-1}$ "  L.GCF_sp " $(GCF-TPR)_{t-1}$ " L.ShTBillLogGr "$\Delta \log(ShTBillsOut_{t-1})$" L.CY1M " $\hat{(OIS-TBill)}_{t-1}$")  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(t-stat))) ///
	order(L.ShTBillLogGr L.CY1M L.GCF_sp L.Sp) keep(L.ShTBillLogGr L.CY1M L.GCF_sp L.Sp)  /// 
	stats(F P_Lag r2 N, labels("F" "P-value" "Adj RSq " "N obs") fmt(3 3 3 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01)  ///	
	title("Instrumenting Safe Asset Demand---CM 2 stage regressions") ///	
	varwidth(40) modelwidth(20)  

estout CMrepo_CY1MStage1 CMrepo_CY1MStage2 CMUSrepo_CY1MStage1 CMUSrepo_CY1MStage2 CMRoWrepo_CY1MStage1 CMRoWrepo_CY1MStage2 using TMaster_IVRP_July2021.txt, replace ///
	varlabels(L.Sp " $(SOFR-RpSpecial)_{t-1}$ "  L.GCF_sp " $(GCF-TPR)_{t-1}$ " L.ShTBillLogGr "$\Delta \log(ShTBillsOut_{t-1})$" L.CY1M " $\hat{(OIS-TBill)}_{t-1}$")  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(t-stat))) ///
	order(L.ShTBillLogGr L.CY1M L.GCF_sp L.Sp) keep(L.ShTBillLogGr L.CY1M L.GCF_sp L.Sp)  /// 
	stats(F P_Lag r2 N, labels("F" "P-value" "Adj RSq " "N obs") fmt(3 3 3 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01)  ///	
	title("Instrumenting Safe Asset Demand---Repo CM 2 stage regressions") ///	
	varwidth(40) modelwidth(20)  



	
	
	
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///////////////Aggregate CM Daily Regressions including government issuance
///////5-day regressions////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

local FinVarLag5day L5.USTslope L5.vixTenYear L5.vix L5.dealerCdsMedian indMidMarch2020
local GovAgg5day TBill5dayLogGr UST5dayLogGr SOMA5dayLogGr	
	
foreach var in CM CMUS CMRoW CMrepo CMUSrepo CMRoWrepo {	
	quietly regress `var'_5dayLogGr L5.CY1M L5.Sp L5.GCF_sp `GovAgg5day' `FinVarLag5day'  L5.`var'_5dayLogGr L10.`var'_5dayLogGr
	local r2 = e(r2_a)
	quietly newey `var'_5dayLogGr L5.CY1M L5.Sp L5.GCF_sp `GovAgg5day' `FinVarLag5day' L5.`var'_5dayLogGr L10.`var'_5dayLogGr, lag(12) force
	test L5.`var'_5dayLogGr = L10.`var'_5dayLogGr = 0
	estadd scalar P_Lag = r(p)
	estadd scalar r2 = `r2'
	estimates store `var'_5daygov	
}
	
estout CM_5daygov CMUS_5daygov CMRoW_5daygov CMrepo_5daygov CMUSrepo_5daygov CMRoWrepo_5daygov using TMaster_Gov_Overlap_July2021.txt, replace ///
	varlabels(L5.CY1M " $(OIS-Tbill)_{t-5}$ " L5.Sp " $(SOFR-RpSpecial)_{t-5}$ "  L5.GCF_sp " $(GCF-TPR)_{t-5}$ "  TBill5dayLogGr "$\Delta^5 log(TbillsOut_t) $" UST5dayLogGr "$\Delta^5 log(USTNotesOut_t) $" SOMA5dayLogGr "$\Delta^5 log(SOMA_t) $" indMidMarch2020 " 1_{\textrm{MidMarch2020}} ")  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(t-stat))) ///
	order(TBill5dayLogGr UST5dayLogGr SOMA5dayLogGr	L5.GCF_sp L5.Sp L5.CY1M  indMidMarch2020) keep(TBill5dayLogGr UST5dayLogGr SOMA5dayLogGr L5.GCF_sp L5.Sp L5.CY1M  indMidMarch2020)  /// 
	stats(P_Lag r2 N, labels("P-value" "Adj RSq " "N obs") fmt(3 3 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01) ///
	title("All and Repo weekly (i.e., 5-day) CM regressions with Government Issuance Controls") ///	
	varwidth(40) modelwidth(20)  ///

		
		
		

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///////////////Aggregate CM Daily Regressions including fiscal governent controls
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
local FinVarLag L.USTslope L.vixTenYear L.vix L.dealerCdsMedian indMidMarch2020
local FiscAgg TBillLogGr USTLogGr

foreach var in CM CMUS CMRoW CMrepo CMUSrepo CMRoWrepo {
	quietly regress `var'_LogGr L.CY1M L.Sp L.GCF_sp `FiscAgg' `FinVarLag'  L(1/4).`var'_LogGr 
	local r2 = e(r2_a)
	quietly newey `var'_LogGr L.CY1M L.Sp L.GCF_sp `FiscAgg' `FinVarLag' L(1/4).`var'_LogGr , lag(21) force
	test L.`var'_LogGr = L2.`var'_LogGr = L3.`var'_LogGr = L4.`var'_LogGr = 0
	estadd scalar P_Lag = r(p)
	estadd scalar r2 = `r2'
	estimates store `var'_fisc
}

estout CM_fisc CMUS_fisc CMRoW_fisc CMrepo_fisc CMUSrepo_fisc CMRoWrepo_fisc using TMaster_Fisc_July2021.txt, replace ///
	varlabels(L.CY1M "$(OIS - Tbill)_{t-1}$" L.Sp "$(SOFR-RpSpecial)_{t-1}$ "  L.GCF_sp "$(GCF-TPR)_{t-1}$" TBillLogGr "$\Delta log(TbillsOut_t)$" USTLogGr "$\Delta log(USTNotesOut_t)$" indMidMarch2020 "$1_{\textrm{MidMarch2020}}$" )  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(t-stat))) ///
	order(TBillLogGr USTLogGr L.GCF_sp L.Sp L.CY1M indMidMarch2020) keep(TBillLogGr USTLogGr L.GCF_sp L.Sp L.CY1M indMidMarch2020)  /// 
	stats(P_Lag r2 N, labels("P-value" "Adj RSq " "N obs") fmt(3 3 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01)  ///
	title("All and Repo CM regressions with Fiscal Government Controls") ///	
	varwidth(40) modelwidth(20)  ///


export delimited /fst/home/m1sxi00/Research/5GRPrime/TreasuryReuse/STATA/CMRegressions_MasterOutput.csv, replace 


 
/*
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///////////////Aggregate CM Daily Regressions including government issuance
//////////////with auction settlement dummy
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
local FinVarLag_settle L.USTslope L.vixTenYear L.vix L.dealerCdsMedian indMidMarch2020 auctionSettleDate
local GovAgg TBillLogGr USTLogGr SOMALogGr

foreach var in CM CMUS CMRoW CMrepo CMUSrepo CMRoWrepo CMrepoBI CMUSrepoBI CMRoWrepoBI CMrepoTPR CMUSrepoTPR CMRoWrepoTPR {
	quietly regress `var'_LogGr L.CY1M L.Sp L.GCF_sp `GovAgg' `FinVarLag_settle'  L(1/4).`var'_LogGr 
	local r2 = e(r2_a)
	quietly newey `var'_LogGr L.CY1M L.Sp L.GCF_sp `GovAgg' `FinVarLag_settle' L(1/4).`var'_LogGr , lag(21) force
	test L.`var'_LogGr = L2.`var'_LogGr = L3.`var'_LogGr = L4.`var'_LogGr = 0
	estadd scalar P_Lag = r(p)
	estadd scalar r2 = `r2'
	estimates store `var'_gov
}

estout CM_gov CMUS_gov CMRoW_gov CMrepo_gov CMUSrepo_gov CMRoWrepo_gov using TMasterSettle_Gov_July2021.txt, replace ///
	varlabels(L.CY1M "$(OIS - Tbill)_{t-1}$" L.Sp "$(SOFR-RpSpecial)_{t-1}$ "  L.GCF_sp "$(GCF-TPR)_{t-1}$ "  TBillLogGr "$\Delta log(TbillsOut_t)$" USTLogGr "$\Delta log(USTNotesOut_t)$" SOMALogGr "$\Delta log(SOMA_t)$" indMidMarch2020 "$1_{\textrm{MidMarch2020}}$"   auctionSettleDate "$1_{\textrm{AuctionSettle}}$" )  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(t-stat))) ///
	order(TBillLogGr USTLogGr SOMALogGr auctionSettleDate L.GCF_sp L.Sp L.CY1M indMidMarch2020) keep(TBillLogGr USTLogGr SOMALogGr auctionSettleDate L.GCF_sp L.Sp L.CY1M indMidMarch2020)  /// 
	stats(P_Lag r2 N, labels("P-value" "Adj RSq " "N obs") fmt(3 3 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01)  ///
	title("All and Repo CM regressions with Government Issuance Controls") ///	
	varwidth(40) modelwidth(20)  


estout CMrepoBI_gov CMUSrepoBI_gov CMRoWrepoBI_gov CMrepoTPR_gov CMUSrepoTPR_gov CMRoWrepoTPR_gov using TMasterSettle_GovBIvsTPR_July2021.txt, replace ///
	varlabels(L.CY1M "$(OIS - Tbill)_{t-1}$" L.Sp "$(SOFR-RpSpecial)_{t-1}$ "  L.GCF_sp "$(GCF-TPR)_{t-1}$ "  TBillLogGr "$\Delta log(TbillsOut_t)$" USTLogGr "$\Delta log(USTNotesOut_t)$" SOMALogGr "$\Delta log(SOMA_t)$" indMidMarch2020 "$1_{\textrm{MidMarch2020}}$"  auctionSettleDate "$1_{\textrm{AuctionSettle}}$" )  ///
	style (tex) cells(b(star fmt(3) label(Coef)) se(fmt(3) par label(t-stat))) ///
	order(TBillLogGr USTLogGr SOMALogGr auctionSettleDate L.GCF_sp L.Sp L.CY1M indMidMarch2020) keep(TBillLogGr USTLogGr SOMALogGr auctionSettleDate L.GCF_sp L.Sp L.CY1M indMidMarch2020)  /// 
	stats(P_Lag r2 N, labels("P-value" "Adj RSq " "N obs") fmt(3 3 0)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01)  ///
	title("Bilateral and Triparty Repo CM regressions with Government Issuance Controls") ///	
	varwidth(40) modelwidth(20)  

*/


