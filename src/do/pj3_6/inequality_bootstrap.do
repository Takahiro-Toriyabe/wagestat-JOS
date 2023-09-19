local fn "inequality_bootstrap"
take_log `fn', path("${path_log}/pj3_6")

// SSPS: Main
clear
set seed 1120002

use "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", clear
gen earnings = KYUYOGAKU_KEI
egen id_common = group(KYOKUSYO SEIRI)

keep id_common year earnings ${weight_minkyu_k}
save "${path_root}/data/_ssps_bootstrap_tmp.dta", replace

collapse (p10) p10=earnings (p50) p50=earnings (p90) p90=earnings [aw=${weight_minkyu_k}], by(year)
tsset year
gen p50p10 = p10 / p50
gen p90p50 = p90 / p50
gen d_p50p10 = 100 * d.p50p10 / l.p50p10
gen d_p90p50 = 100 * d.p90p50 / l.p90p50

mkmat p50p10 p90p50 d_p50p10 d_p90p50, matrix(B_SSPS)

// SSPS: Bootstrap
local R = 1000
capture matrix drop bs_p50p10 bs_p90p50 bs_d_p50p10 bs_d_p90p50
forvalues r = 1(1)`R' {
	display "Iteration `r'..." _continue
	qui {
		use "${path_root}/data/_ssps_bootstrap_tmp.dta", clear
		bsample, cluster(id_common)
		collapse (p10) p10=earnings (p50) p50=earnings (p90) p90=earnings [aw=${weight_minkyu_k}], by(year)
		gen p50p10 = p10 / p50
		gen p90p50 = p90 / p50

		tsset year
		gen d_p50p10 = 100 * d.p50p10 / l.p50p10
		gen d_p90p50 = 100 * d.p90p50 / l.p90p50
		
		foreach var in p50p10 p90p50 d_p50p10 d_p90p50 {
			mkmat `var'
			matrix bs_`var' = nullmat(bs_`var') \ `var''
		}
	}
	display "Done"
}

clear
foreach var in p50p10 p90p50 d_p50p10 d_p90p50 {
	svmat bs_`var', name(`var'_)
}

gen seq_r = _n
reshape long p50p10_ p90p50_ d_p50p10_ d_p90p50_, i(seq_r) j(year)
rename *_ *
replace year = year + 2011

collapse (sd) p50p10 p90p50 d_p50p10 d_p90p50, by(year)
mkmat p50p10 p90p50 d_p50p10 d_p90p50, matrix(SE_SSPS)

// BSWS: Main
use "${path_data}/pj/pj3_5/chingin_matched.dta", clear
keep if inrange(year, 2012, 2017) & inlist(merge_result, 2, 3)

gen earnings = Genkin + Tokubetsu / 12

keep id_common year earnings ${weight_wc_k}
save "${path_root}/data/_bsws_bootstrap_tmp.dta", replace

collapse (p10) p10=earnings (p50) p50=earnings (p90) p90=earnings [aw=${weight_wc_k}], by(year)
tsset year
gen p50p10 = p10 / p50
gen p90p50 = p90 / p50
gen d_p50p10 = 100 * d.p50p10 / l.p50p10
gen d_p90p50 = 100 * d.p90p50 / l.p90p50


mkmat p50p10 p90p50 d_p50p10 d_p90p50, matrix(B_BSWS)

// BSWS: Bootstrap
capture matrix drop bs_p50p10 bs_p90p50 bs_d_p50p10 bs_d_p90p50
forvalues r = 1(1)`R' {
	display "Iteration `r'..." _continue
	qui {
		use "${path_root}/data/_bsws_bootstrap_tmp.dta", clear
		bsample, cluster(id_common)

		collapse (p10) p10=earnings (p50) p50=earnings (p90) p90=earnings [aw=${weight_wc_k}], by(year)
		gen p50p10 = p10 / p50
		gen p90p50 = p90 / p50

		tsset year
		gen d_p50p10 = 100 * d.p50p10 / l.p50p10
		gen d_p90p50 = 100 * d.p90p50 / l.p90p50

		foreach var in p50p10 p90p50 d_p50p10 d_p90p50 {
			mkmat `var'
			matrix bs_`var' = nullmat(bs_`var') \ `var''
		}
	}
	display "Done"
}

clear
foreach var in p50p10 p90p50 d_p50p10 d_p90p50 {
	svmat bs_`var', name(`var'_)
}

gen seq_r = _n
reshape long p50p10_ p90p50_ d_p50p10_ d_p90p50_, i(seq_r) j(year)
rename *_ *
replace year = year + 2011

collapse (sd) p50p10 p90p50 d_p50p10 d_p90p50, by(year)
mkmat p50p10 p90p50 d_p50p10 d_p90p50, matrix(SE_BSWS)

matlist SE_BSWS
matlist SE_SSPS

// Export result
local j = 1
foreach stat in p50p10 p90p50 {
	tempname hh
	file open `hh' using "${path_table}/pj3_6/inequality_`stat'_stat_test.tex", write replace
	
	forvalues i = 1(1)6 {
		local y = 2011 + `i'
		local b1_bsws`i' = strofreal(B_BSWS[`i', `j'], "%04.3f")
		local se1_bsws`i' = "(" + strofreal(SE_BSWS[`i', `j'], "%04.3f") + ")"

		local b1_ssps`i' = strofreal(B_SSPS[`i', `j'], "%04.3f")
		local se1_ssps`i' = "(" + strofreal(SE_SSPS[`i', `j'], "%04.3f") + ")"

		if `i' > 1 {
			local b2_bsws`i' = strofreal(B_BSWS[`i', `j' + 2], "%04.3f")
			local se2_bsws`i' = "(" + strofreal(SE_BSWS[`i', `j' + 2], "%04.3f") + ")"

			local b2_ssps`i' = strofreal(B_SSPS[`i', `j' + 2], "%04.3f")
			local se2_ssps`i' = "(" + strofreal(SE_SSPS[`i', `j' + 2], "%04.3f") + ")"
	
			local b3`i' = strofreal(B_BSWS[`i', `j' + 2] - B_SSPS[`i', `j' + 2], "%04.3f")
			local se3`i' = "(" + strofreal(sqrt(SE_BSWS[`i', `j' + 2]^2 + SE_SSPS[`i', `j' + 2]^2), "%04.3f") + ")"
		}
		file write `hh' "`y' & `b1_bsws`i'' & `b2_bsws`i'' & `b1_ssps`i'' & `b2_ssps`i'' & `b3`i'' \\" _newline
		file write `hh' "& `se1_bsws`i'' & `se2_bsws`i'' & `se1_ssps`i'' & `se2_ssps`i'' & `se3`i'' \\" _newline		
	}
	file close `hh'
	
	local j = `j' + 1
}

log close `fn'
