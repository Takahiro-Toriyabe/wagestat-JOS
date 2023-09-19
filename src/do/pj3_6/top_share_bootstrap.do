local fn "top_share_bootstrap"
take_log `fn', path("${path_log}/pj3_6")

clear
set seed 1120002

// BSWS
use "${path_data}/pj/pj3_5/chingin_matched.dta", clear
keep if inrange(year, 2012, 2017) & inlist(merge_result, 2, 3)

gen earnings = Genkin + Tokubetsu / 12
drop if missing(earnings)

sort year
capture matrix drop BSWS0

forvalues y = 2012(1)2017 {
	sum earnings [aw=${weight_wc_k}] if year == `y', meanonly
	local total = r(sum)
	_pctile earnings [aw=${weight_wc_k}] if year == `y', percentiles(99 99.5 99.9)
	matrix SHARE = r(r1) \ r(r2) \ r(r3)
	forvalues i = 1(1)3 {
		sum earnings [aw=${weight_wc_k}] if year == `y' & earnings >= SHARE[`i', 1], meanonly
		local s`i' = 100 * r(sum) / `total'
	}
	matrix BSWS0 = nullmat(BSWS0) \ `y', `s1', `s2', `s3', 0
}

keep id_common year earnings ${weight_wc_k}
save "${path_root}/data/_bsws_top_share_bootstrap_tmp.dta", replace

local R = 1000
capture matrix drop BSWS_bs
forvalues r = 1(1)`R' {
	display "Iteration `r'..." _continue
	qui {
		use "${path_root}/data/_bsws_top_share_bootstrap_tmp.dta", clear
		bsample, cluster(id_common)
		
		forvalues y = 2012(1)2017 {
			sum earnings [aw=${weight_wc_k}] if year == `y', meanonly
			local total = r(sum)
			_pctile earnings [aw=${weight_wc_k}] if year == `y', percentiles(99 99.5 99.9)
			matrix SHARE = r(r1) \ r(r2) \ r(r3)
			forvalues i = 1(1)3 {
				sum earnings [aw=${weight_wc_k}] if year == `y' & earnings >= SHARE[`i', 1], meanonly
				local s = 100 * r(sum) / `total'
				matrix BSWS_bs = nullmat(BSWS_bs) \ `r', `y', `i', `s'
			}
		}
	}
	display "Done"
}


// SSPS
use "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", clear
keep if inrange(year, 2012, 2017)
gen earnings = KYUYOGAKU_KEI
egen id_common = group(KYOKUSYO SEIRI)

sort year
capture matrix drop SSPS0
forvalues y = 2012(1)2017 {
	sum earnings [aw=${weight_minkyu_k}] if year == `y', meanonly
	local total = r(sum)
	_pctile earnings [aw=${weight_minkyu_k}] if year == `y', percentiles(99 99.5 99.9)
	matrix SHARE = r(r1) \ r(r2) \ r(r3)
	forvalues i = 1(1)3 {
		sum earnings [aw=${weight_minkyu_k}] if year == `y' & earnings >= SHARE[`i', 1], meanonly
		local s`i' = 100 * r(sum) / `total'
	}
	matrix SSPS0 = nullmat(SSPS0) \ `y', `s1', `s2', `s3', 3
}

keep id_common year earnings ${weight_minkyu_k}
save "${path_root}/data/_ssps_top_share_bootstrap_tmp.dta", replace

capture matrix drop SSPS_bs
forvalues r = 1(1)`R' {
	display "Iteration `r'..." _continue
	qui {
		use "${path_root}/data/_ssps_top_share_bootstrap_tmp.dta", clear
		bsample, cluster(id_common)
		
		forvalues y = 2012(1)2017 {
			sum earnings [aw=${weight_minkyu_k}] if year == `y', meanonly
			local total = r(sum)
			_pctile earnings [aw=${weight_minkyu_k}] if year == `y', percentiles(99 99.5 99.9)
			matrix SHARE = r(r1) \ r(r2) \ r(r3)
			forvalues i = 1(1)3 {
				sum earnings [aw=${weight_minkyu_k}] if year == `y' & earnings >= SHARE[`i', 1], meanonly
				local s = 100 * r(sum) / `total'
				matrix SSPS_bs = nullmat(SSPS_bs) \ `r', `y', `i', `s'
			}
		}
	}
	display "Done"
}

// Export result
foreach data in BSWS SSPS {
	clear
	svmat `data'_bs
	rename `data'_bs1 r
	rename `data'_bs2 year
	rename `data'_bs3 cat
	rename `data'_bs4 share

	egen id = group(r cat)
	xtset id year
	gen d_share = 100 * d.share / l.share

	collapse (sd) se_share=share se_d_share=d_share, by(year cat)

	reshape wide se_share se_d_share, i(year) j(cat)
	mkmat year se_share1 se_share2 se_share3 se_d_share1 se_d_share2 se_d_share3, matrix(`data'_se)
	matlist `data'_se
}

forvalues j = 1(1)3 {
	tempname hh
	file open `hh' using "${path_table}/pj3_6/top_share`j'_stat_test.tex", write replace

	forvalues i = 1(1)6 {
		local y = 2011 + `i'
		local b1 = strofreal(BSWS0[`i', `j' + 1], "%04.3f")
		local s1 = "(" + strofreal(BSWS_se[`i', `j' + 1], "%04.3f") + ")"
		local b3 = strofreal(SSPS0[`i', `j' + 1], "%04.3f")
		local s3 = "(" + strofreal(SSPS_se[`i', `j' + 1], "%04.3f") + ")"
		
		if `i' == 1 {
			foreach k in 2 4 5 {
				local b`k' ""
				local s`k' ""
			}
		}
		else {
			local d_bsws = 100 * (BSWS0[`i', `j' + 1] / BSWS0[`i' - 1, `j' + 1] - 1)
			local d_ssps = 100 * (SSPS0[`i', `j' + 1] / SSPS0[`i' - 1, `j' + 1] - 1)
			local dd = `d_bsws' - `d_ssps'
			local dd_se = sqrt(BSWS_se[`i', `j' + 4]^2  + SSPS_se[`i', `j' + 4]^2)
			
			local b2 = strofreal(`d_bsws', "%04.3f")
			local s2 = "(" + strofreal(BSWS_se[`i', `j' + 4], "%04.3f") + ")"
			local b4 = strofreal(`d_ssps', "%04.3f")
			local s4 = "(" + strofreal(SSPS_se[`i', `j' + 4], "%04.3f") + ")"
			local b5 = strofreal(`dd', "%04.3f")
			local s5 = "(" + strofreal(`dd_se', "%04.3f") + ")"
		}
		file write `hh' "`y' & `b1' & `b2' & `b3' & `b4' & `b5' \\" _newline
		file write `hh' "& `s1' & `s2' & `s3' & `s4' & `s5' \\" _newline
	}
	file close `hh'
	cat "${path_table}/pj3_6/top_share`j'_stat_test.tex"
}

log close `fn'
