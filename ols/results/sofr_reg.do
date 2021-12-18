#delimit ;

cd "/Users/mac/Desktop/Research/sofr";



/* DAILY DATA */
use "data/data_reg.dta";

lab var log_Public "log_debt";
lab var change_Public "difflog_debt";
lab var SOFR_spread "SOFR";
lab var LIBOR_spread "LIBOR";
lab var SOFR_spread_change "diff_SOFR";
lab var LIBOR_spread_change "diff_LIBOR";
lab var difflog_Volume "difflog_volume";


/* REGRESSION 2*/
reg SOFR_spread_change change_Public, robust;
est store reg1;
outreg2 using results/result_reg.tex, replace label;

reg SOFR_spread_change change_Public difflog_Volume, robust;
est store reg2;
outreg2 using results/result_reg.tex, append label;

reg LIBOR_spread_change change_Public, robust;
est store reg3;
outreg2 using results/result_reg.tex, append label;

reg LIBOR_spread_change change_Public difflog_Volume, robust;
est store reg4;
outreg2 using results/result_reg.tex, append label;



/* WEEKLY DATA*/
use "data/data_week.dta";
lab var change_repo "difflog_repo";
lab var change_public "difflog_debt";


/* REGRESSION 1*/















