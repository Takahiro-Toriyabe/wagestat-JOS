use "${path_meibo_minkyu}/minkyu_meibo.dta", clear
merge 1:1 year KYOKUSYO SEIRI ///
	using "${path_chosa_minkyu_gensen}/minkyu_gensen.dta", ///
	assert(1 3)

gen flag_resp = _merge == 3
drop _merge

qui levelsof year, local(ylist)
foreach y in `ylist' {
	capture label define year `y' "`y'"
	capture label define year `y' "`y'", add
}
label values year year

label define _industry 1 "Manufacturing (C)" 2 "Wholesales (C)" 3 "Retail trade (C)" ///
    4 "Construction (C)" 5 "Transportation (C)" 6 "Service (C)" 7 "Inn/restaurant (C)" ///
    8 "Other (C)" 9 "Retail trade (I)" 10 "Wholesales (I)" 11 "Manufacturing/retailing (I)" ///
    12 "Manufacturing/wholesales (I)" 13 "Contract manufacturing (I)" 14 "Repairing (I)" ///
    15 "Service (I)" 16 "Construction (I)" 17 "Other sales (I)" 18 "Agriculture (I)" 19 "Other business (I)" ///
    20 "Other (I)"
label values industry _industry

label define _estsize 1 "Head quarter" 2 "5000+" 3 "1000-4999" 4 "500-999" 5 "100-499" 6 "30-99" 7 "10-29" 8 "1-9"
label values estsize _estsize

// Visualize
graph hbar flag_resp if year == 2017, ///
	ytitle("Response rate") ylabel(0(0.1)1, format(%02.1f)) ///
	over(estsize) ///
	scheme(tt_mono)
export_graph resprate_estsize_minkyu, path("${path_figure}/pj3_5")

graph hbar flag_resp if year == 2017, ///
	ytitle("Response rate") ylabel(0(0.1)1, format(%02.1f)) ///
	over(industry) ///
	scheme(tt_mono)
export_graph resprate_industry_minkyu, path("${path_figure}/pj3_5")

// Export as tables
foreach var in estsize industry {
	export_twoway_table `var' year, main_var(flag_resp) format("%03.2f") ///
		valuelabel total1 export("${path_table}/pj3_5/resprate_`var'_minkyu.tex")
}

// Parameters
local b_year = 2012
local xmin_year = -0.12
local xmax_year = 0.022
local xd_year = 0.02
local fmt_year "%03.2f"

local b_industry = 1
local xmin_industry = -0.25
local xmax_industry = 0.11
local xd_industry = 0.05
local fmt_industry "%03.2f"

local b_estsize = 5
local xmin_estsize = -0.35
local xmax_estsize = 0.12
local xd_estsize = 0.05
local fmt_estsize "%03.2f"

egen cluster_var = group(KYOKUSYO SEIRI)

// Estmation and visualize the result
eststo clear
eststo est0: reg flag_resp ib`b_year'.year ib`b_industry'.industry ///
	ib`b_estsize'.estsize, cluster(cluster_var)

foreach var in year industry estsize {
	local lbl_base_`var': label `:value label `var'' `b_`var''

	coefplot (est0, keep(*.`var') baselevels levels(95)), ///
		xlabel(`xmin_`var''(`xd_`var'')`xmax_`var'', ///
			format(`fmt_`var'')) xline(0, lp(l) lc(gs6)) ///
		coeflabels(`b_`var''.`var' = "`lbl_base_`var''")
	export_graph reg_resprate_`var'_minkyu, path("${path_figure}/pj3_5")
}
