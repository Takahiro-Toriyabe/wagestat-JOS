use "${path_meibo_minkyu}/minkyu_meibo.dta", clear
merge 1:1 KYOKUSYO SEIRI year ///
	using "${path_chosa_minkyu_gensen}/minkyu_gensen.dta", ///
	assert(1 3)

gen flag_resp = _merge == 3
drop _merge

// Merge lagged establishment information
merge m:1 KYOKUSYO SEIRI year ///
	using "${path_root}/data/lagged_wage_minkyu.dta", ///
	assert(1 3) nogen
egen cluster_var = group(KYOKUSYO SEIRI)

// Regression analysis (without weight)
eststo clear
forvalues t = 1(1)7 {
	eststo est`t': reg flag_resp l`t'_ln_earnings ib2019.year ib1.estsize ib1.industry
	local n`t' = e(N)
}
qui suest est1 est2 est3 est4 est5 est6 est7, cluster(cluster_var)
forvalues t = 1(1)7 {
	local b_lag`t' = strofreal([est`t'_mean]_b[l`t'_ln_earnings], "%04.3f")
	local se_lag`t' = "(" + strofreal([est`t'_mean]_se[l`t'_ln_earnings], "%04.3f") + ")"
}

nlcom ([est1_mean]_b[l1_ln_earnings]^2 / [est2_mean]_b[l2_ln_earnings]) ///
	([est2_mean]_b[l2_ln_earnings]^3 / [est3_mean]_b[l3_ln_earnings]^2) ///
	([est3_mean]_b[l3_ln_earnings]^4 / [est4_mean]_b[l4_ln_earnings]^3) ///
	([est4_mean]_b[l4_ln_earnings]^5 / [est5_mean]_b[l5_ln_earnings]^4) ///
	([est5_mean]_b[l5_ln_earnings]^6 / [est6_mean]_b[l6_ln_earnings]^5) ///
	([est6_mean]_b[l6_ln_earnings]^7 / [est7_mean]_b[l7_ln_earnings]^6) ///
	([est1_mean]_b[l1_ln_earnings] / (([est2_mean]_b[l2_ln_earnings] / [est1_mean]_b[l1_ln_earnings] - 1) * ([est2_mean]_b[l2_ln_earnings] / [est1_mean]_b[l1_ln_earnings])^0)) ///
	([est2_mean]_b[l2_ln_earnings] / (([est3_mean]_b[l3_ln_earnings] / [est2_mean]_b[l2_ln_earnings] - 1) * ([est3_mean]_b[l3_ln_earnings] / [est2_mean]_b[l2_ln_earnings])^1)) ///
	([est3_mean]_b[l3_ln_earnings] / (([est4_mean]_b[l4_ln_earnings] / [est3_mean]_b[l3_ln_earnings] - 1) * ([est4_mean]_b[l4_ln_earnings] / [est3_mean]_b[l3_ln_earnings])^2)) ///
	([est4_mean]_b[l4_ln_earnings] / (([est5_mean]_b[l5_ln_earnings] / [est4_mean]_b[l4_ln_earnings] - 1) * ([est5_mean]_b[l5_ln_earnings] / [est4_mean]_b[l4_ln_earnings])^3)) ///
	([est5_mean]_b[l5_ln_earnings] / (([est6_mean]_b[l6_ln_earnings] / [est5_mean]_b[l5_ln_earnings] - 1) * ([est6_mean]_b[l6_ln_earnings] / [est5_mean]_b[l5_ln_earnings])^4)) ///
	([est6_mean]_b[l6_ln_earnings] / (([est7_mean]_b[l7_ln_earnings] / [est6_mean]_b[l6_ln_earnings] - 1) * ([est7_mean]_b[l7_ln_earnings] / [est6_mean]_b[l6_ln_earnings])^5)), post

forvalues t = 1(1)6 {
	local b_level`t' = strofreal(_b[_nl_`t'], "%04.3f")
	local se_level`t' = "(" + strofreal(_se[_nl_`t'], "%04.3f") + ")"
	
	local s = `t' + 4
	local b_growth`t' = strofreal(_b[_nl_`s'], "%04.3f")
	local se_growth`t' = "(" + strofreal(_se[_nl_`s'], "%04.3f") + ")"
}

qui suest est1 est2 est3 est4 est5 est6 est7, cluster(cluster_var)
nlcom ([est2_mean]_b[l2_ln_earnings] / [est1_mean]_b[l1_ln_earnings]) ///
	([est3_mean]_b[l3_ln_earnings] / [est2_mean]_b[l2_ln_earnings]) ///
	([est4_mean]_b[l4_ln_earnings] / [est3_mean]_b[l3_ln_earnings]) ///
	([est5_mean]_b[l5_ln_earnings] / [est4_mean]_b[l4_ln_earnings]) ///
	([est6_mean]_b[l6_ln_earnings] / [est5_mean]_b[l5_ln_earnings]) ///
	([est7_mean]_b[l7_ln_earnings] / [est6_mean]_b[l6_ln_earnings]), post

forvalues t = 1(1)6 {
	local b_rho`t' = strofreal(_b[_nl_`t'], "%04.3f")
	local se_rho`t' = "(" + strofreal(_se[_nl_`t'], "%04.3f") + ")"
}

test (_nl_1 ==  _nl_2) (_nl_2 == _nl_3) (_nl_3 == _nl_4) (_nl_4 == _nl_5) (_nl_5 == _nl_6)
local pval = strofreal(r(p), "%04.3f")

// Export the estimation result
local lbl_lag "\$\ln earnings_{i t-s}\$"
local lbl_rho "\$\hat{\rho}^{(s)} = \hat{\beta}^{(s+1)} / \hat{\beta}^{(s+1)}\$"
local lbl_level "\$\hat{\beta}_{1}^{level}\$"
local lbl_growth "\$\hat{\beta}_{1}^{growth}\$"

tempname hh
file open `hh' using "${path_table}/pj3_5/measurement_error_minkyu.tex", write replace
foreach tag in _lag _rho _level _growth {
	file write `hh' "`lbl`tag'' & `b`tag'1' & `b`tag'2' & `b`tag'3' & `b`tag'4' & `b`tag'5' & `b`tag'6' & `b`tag'7' \\" _newline
	file write `hh' "& `se`tag'1' & `se`tag'2' & `se`tag'3' & `se`tag'4' & `se`tag'5' & `se`tag'6' & `se`tag'7' \\" _newline
}
file write `hh' "P-value (\$H_{0}: \rho^(s) = \rho^{(s')}\$) & \multicolumn{7}{c}{`pval'} \\" _newline
file write `hh' "Observations & `n1' & `n2' & `n3' & `n4' & `n5' & `n6' & `n7' \\" _newline
file close `hh'
