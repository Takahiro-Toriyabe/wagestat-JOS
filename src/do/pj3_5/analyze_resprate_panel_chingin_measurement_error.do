use "${path_data}/pj/pj3_5/chingin_matched.dta", clear

keep if inrange(year, 2012, 2017) & inlist(merge_result, 1, 3) & !missing(id_common)
assert !missing(id_common) if merge_result == 3

// Drop observations to conduct establishment-level analysis
bysort year id_common: gen worker_num = _n if merge_result == 3
keep if merge_result == 1 | (merge_result == 3 & worker_num == 1)

gen flag_resp = merge_result == 3

// Make city class variable
replace pref_code = Ken if missing(pref_code)
replace city_code = Shiku if missing(city_code)
assert !missing(pref_code) & !missing(city_code)

merge m:1 pref_code city_code year ///
	using "${path_root}/data/city_converter_chingin.dta", ///
	assert(2 3) keep(3) nogen

merge m:1 code_h using "${path_root}/data/pop.dta", ///
	assert(2 3) keep(3) nogen

// Merge lagged establishment information
merge m:1 id_common year ///
	using "${path_root}/data/lagged_wage_chingin.dta", keep(1 3)
gen flag_panel = _merge == 3
drop _merge

// Put value labels
label values estsize JigyoKibo
put_value_label_pref Ken
clean_industry_wc2009_2017 industry

qui levelsof year, local(ylist)
foreach y in `ylist' {
	capture label define year `y' "`y'年"
	capture label define year `y' "`y'年", add
}
label values year year

local varlist flag_resp year Ken popcat industry estsize sample_rate
keep `varlist' l*_ln_wage id_common flag_panel
foreach var in `varlist' {
	assert !missing(`var')
}

// Regression analysis (without weight)
eststo clear
forvalues t = 1(1)5 {
	eststo est`t': reg flag_resp l`t'_ln_wage ib2017.year ib0.estsize ib0.industry ib1.Ken ib1.popcat
	local n`t' = e(N)
}
qui suest est1 est2 est3 est4 est5, cluster(id_common)
forvalues t = 1(1)5 {
	local b_lag`t' = strofreal([est`t'_mean]_b[l`t'_ln_wage], "%04.3f")
	local se_lag`t' = "(" + strofreal([est`t'_mean]_se[l`t'_ln_wage], "%04.3f") + ")"
}

esttab, keep(l*_ln_wage) se b(%04.3f)

nlcom ([est1_mean]_b[l1_ln_wage]^2 / [est2_mean]_b[l2_ln_wage]) ///
	([est2_mean]_b[l2_ln_wage]^3 / [est3_mean]_b[l3_ln_wage]^2) ///
	([est3_mean]_b[l3_ln_wage]^4 / [est4_mean]_b[l4_ln_wage]^3) ///
	([est4_mean]_b[l4_ln_wage]^5 / [est5_mean]_b[l5_ln_wage]^4) ///
	([est1_mean]_b[l1_ln_wage] / (([est2_mean]_b[l2_ln_wage] / [est1_mean]_b[l1_ln_wage] - 1) * ([est2_mean]_b[l2_ln_wage] / [est1_mean]_b[l1_ln_wage])^0)) ///
	([est2_mean]_b[l2_ln_wage] / (([est3_mean]_b[l3_ln_wage] / [est2_mean]_b[l2_ln_wage] - 1) * ([est3_mean]_b[l3_ln_wage] / [est2_mean]_b[l2_ln_wage])^1)) ///
	([est3_mean]_b[l3_ln_wage] / (([est4_mean]_b[l4_ln_wage] / [est3_mean]_b[l3_ln_wage] - 1) * ([est4_mean]_b[l4_ln_wage] / [est3_mean]_b[l3_ln_wage])^2)) ///
	([est4_mean]_b[l4_ln_wage] / (([est5_mean]_b[l5_ln_wage] / [est4_mean]_b[l4_ln_wage] - 1) * ([est5_mean]_b[l5_ln_wage] / [est4_mean]_b[l4_ln_wage])^3)), post

forvalues t = 1(1)4 {
	local b_level`t' = strofreal(_b[_nl_`t'], "%04.3f")
	local se_level`t' = "(" + strofreal(_se[_nl_`t'], "%04.3f") + ")"
	
	local s = `t' + 4
	local b_growth`t' = strofreal(_b[_nl_`s'], "%04.3f")
	local se_growth`t' = "(" + strofreal(_se[_nl_`s'], "%04.3f") + ")"
}

qui suest est1 est2 est3 est4 est5, cluster(id_common)
nlcom ([est2_mean]_b[l2_ln_wage] / [est1_mean]_b[l1_ln_wage]) ///
	([est3_mean]_b[l3_ln_wage] / [est2_mean]_b[l2_ln_wage]) ///
	([est4_mean]_b[l4_ln_wage] / [est3_mean]_b[l3_ln_wage]) ///
	([est5_mean]_b[l5_ln_wage] / [est4_mean]_b[l4_ln_wage]), post

forvalues t = 1(1)4 {
	local b_rho`t' = strofreal(_b[_nl_`t'], "%04.3f")
	local se_rho`t' = "(" + strofreal(_se[_nl_`t'], "%04.3f") + ")"
}

test (_nl_1 ==  _nl_2) (_nl_2 == _nl_3) (_nl_3 == _nl_4)
local pval = strofreal(r(p), "%04.3f")

// Export the estimation result
local lbl_lag "\$\ln wage_{i t-s}\$"
local lbl_rho "\$\hat{\rho}^{(s)} = \hat{\beta}^{(s+1)} / \hat{\beta}^{(s+1)}\$"
local lbl_level "\$\hat{\beta}_{1}^{level}\$"
local lbl_growth "\$\hat{\beta}_{1}^{growth}\$"

tempname hh
file open `hh' using "${path_table}/pj3_5/measurement_error_chingin.tex", write replace
foreach tag in _lag _rho _level _growth {
	file write `hh' "`lbl`tag'' & `b`tag'1' & `b`tag'2' & `b`tag'3' & `b`tag'4' & `b`tag'5' \\" _newline
	file write `hh' "& `se`tag'1' & `se`tag'2' & `se`tag'3' & `se`tag'4' & `se`tag'5' \\" _newline
}
file write `hh' "P-value (\$H_{0}: \rho^(s) = \rho^{(s')}\$) & \multicolumn{5}{c}{`pval'} \\" _newline
file write `hh' "Observations & `n1' & `n2' & `n3' & `n4' & `n5' \\" _newline
file close `hh'
