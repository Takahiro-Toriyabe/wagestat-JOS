use "${path_data}/pj/pj3_5/chingin_matched.dta", clear

keep if inrange(year, 2012, 2017) & inlist(merge_result, 2, 3)
assert !missing(id_est)

tab year merge_result

merge m:1 year using "${path_data}//cpi.dta", ///
	assert(2 3) nogen keep(3)

// Clean industry code
clean_industry_wc2009_2017 SangyoDai

// Make some variables for analysis
gen wage = Genkin / 100 / cpi
gen lnwage = ln(wage)
gen flag_unmatched = merge_result == 2
bysort year id_est: gen worker_num = _n

// Descriptive statistics
local fmt "%03.2f"
tempname hh
file open `hh' using "${path_table}/pj3_5/unmatched_wc.tex", ///
	write replace

// All establishments
sum flag_unmatched if worker_num == 1, meanonly
local frac = strofreal(r(mean), "`fmt'")

foreach i in 1 0 {
	sum wage [aw=${weight_wc_k}] if flag_unmatched == `i'
	local b`i' = strofreal(r(mean), "`fmt'")
	local s`i' = "[" + strofreal(r(sd), "`fmt'") + "]"
}
reg wage flag_unmatched [aw=${weight_wc_k}], cluster(id_est)
local b2 = strofreal(_b[flag_unmatched], "`fmt'")
local s2 = "(" + strofreal(_se[flag_unmatched], "`fmt'") + ")"

if float(`frac') == float(0) {
	local b1 ""
	local s1 ""
	local b2 ""
	local s2 ""
}

file write `hh' "All & `frac' & `b1' & `b0' & `b2' \\" _newline
file write `hh' "& & `s1' & `s0' & `s2' \\" _newline

// By year
file write `hh' "Survey year & & & & \\" _newline

qui levelsof year, local(ylist)
foreach y in `ylist' {
	sum flag_unmatched if worker_num == 1 & year == `y', meanonly
	local frac = strofreal(r(mean), "`fmt'")
	foreach i in 1 0 {
		sum wage [aw=${weight_wc_k}] if flag_unmatched == `i' & year == `y'
		local b`i' = strofreal(r(mean), "`fmt'")
		local s`i' = "[" + strofreal(r(sd), "`fmt'") + "]"
	}

	reg wage flag_unmatched [aw=${weight_wc_k}] if year == `y', cluster(id_est)
	local b2 = strofreal(_b[flag_unmatched], "`fmt'")
	local s2 = "(" + strofreal(_se[flag_unmatched], "`fmt'") + ")"

	if float(`frac') == float(0) {
		local b1 ""
		local s1 ""
		local b2 ""
		local s2 ""
	}
	
	file write `hh' "`y' & `frac' & `b1' & `b0' & `b2' \\" _newline
	file write `hh' "& & `s1' & `s0' & `s2' \\" _newline
}

file close `hh'

// By establishment size
tempname hh
file open `hh' using "${path_table}/pj3_5/unmatched_estsize_wc.tex", ///
	write replace

qui levelsof JigyoKibo, local(elist)
foreach e in `elist' {
	sum flag_unmatched if worker_num == 1 & JigyoKibo == `e', meanonly
	local frac = strofreal(r(mean), "`fmt'")
	foreach i in 1 0 {
		sum wage [aw=${weight_wc_k}] if flag_unmatched == `i' & JigyoKibo == `e'
		local b`i' = strofreal(r(mean), "`fmt'")
		local s`i' = "[" + strofreal(r(sd), "`fmt'") + "]"
	}
	reg wage flag_unmatched [aw=${weight_wc_k}] if JigyoKibo == `e', cluster(id_est)
	local b2 = strofreal(_b[flag_unmatched], "`fmt'")
	local s2 = "(" + strofreal(_se[flag_unmatched], "`fmt'") + ")"
	
	if float(`frac') == float(0) {
		local b1 ""
		local s1 ""
		local b2 ""
		local s2 ""
	}

	local lbl = subinstr("`: label JigyoKibo `e''", "~", "--", .)
	file write `hh' "`lbl' & `frac' & `b1' & `b0' & `b2' \\" _newline
	file write `hh' "& & `s1' & `s0' & `s2' \\" _newline
}

file close `hh'

// By industry
tempname hh
file open `hh' using "${path_table}/pj3_5/unmatched_industry_wc.tex", ///
	write replace

qui levelsof SangyoDai, local(indlist)
foreach ind in `indlist' {
	sum flag_unmatched if worker_num == 1 & SangyoDai == `ind', meanonly
	local frac = strofreal(r(mean), "`fmt'")
	foreach i in 1 0 {
		sum wage [aw=${weight_wc_k}] if flag_unmatched == `i' & SangyoDai == `ind'
		local b`i' = strofreal(r(mean), "`fmt'")
		local s`i' = "[" + strofreal(r(sd), "`fmt'") + "]"
	}
	reg wage flag_unmatched [aw=${weight_wc_k}] if SangyoDai == `ind', cluster(id_est)
	local b2 = strofreal(_b[flag_unmatched], "`fmt'")
	local s2 = "(" + strofreal(_se[flag_unmatched], "`fmt'") + ")"

	if float(`frac') == float(0) {
		local b1 ""
		local s1 ""
		local b2 ""
		local s2 ""
	}

	local lbl = subinstr("`: label SangyoDai `ind''", "~", "--", .)
	file write `hh' "`lbl' & `frac' & `b1' & `b0' & `b2' \\" _newline
	file write `hh' "& & `s1' & `s0' & `s2' \\" _newline
}

file close `hh'

// Regression
local fmt "%04.3f"
tempname hh
file open `hh' using "${path_table}/pj3_5/unmatched_reg_wc.tex", ///
	write replace

local absorblist ""
local cnt = 0
foreach var in year JigyoKibo SangyoDai Ken {
	local absorblist "`absorblist' `var'"
	reghdfe lnwage flag_unmatched [aw=${weight_wc_k}], ///
		vce(cluster id_est) absorb(`absorblist')
	local b`cnt' = strofreal(_b[flag_unmatched], "`fmt'")
	local s`cnt' = "(" + strofreal(_se[flag_unmatched], "`fmt'") + ")"
	local n`cnt' = e(N)
	local `cnt++'
}

file write `hh' "Supplementary & `b0' & `b1' & `b2' & `b3' \\" _newline
file write `hh' "& `s0' & `s1' & `s2' & `s3' \\" _newline
file write `hh' "\midrule" _newline
file write `hh' "Year & X & X & X & X \\" _newline
file write `hh' "Industry & & X & X & X \\" _newline
file write `hh' "Establishment size & & & X & X \\" _newline
file write `hh' "Prefecture & & & & X \\" _newline
file write `hh' "Observations & `n0' & `n1' & `n2' & `n3' \\" _newline
file close `hh'
