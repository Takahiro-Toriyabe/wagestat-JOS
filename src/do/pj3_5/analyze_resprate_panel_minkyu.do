use "${path_meibo_minkyu}/minkyu_meibo.dta", clear
merge 1:1 KYOKUSYO SEIRI year ///
	using "${path_chosa_minkyu_gensen}/minkyu_gensen.dta", ///
	assert(1 3)

gen flag_resp = _merge == 3
drop _merge

// Merge lagged establishment information
merge m:1 KYOKUSYO SEIRI year ///
	using "${path_root}/data/est_info_minkyu.dta", ///
	assert(3) nogen
	
foreach var in year estsize industry {
	drop if missing(`var')
}
	
// Descriptive stat
egen id_common = group(KYOKUSYO SEIRI)

local i = 1
foreach var in flag_resp l_ln_earnings l_age l_female {
	sum `var' if !missing(l_ln_earnings)
	local m`i' = strofreal(r(mean), "%04.3f")
	local s`i' = "[" + strofreal(r(sd), "%04.3f") + "]"
	local n`i' = r(N)
	
	if "`var'" != "flag_resp" {
		foreach j in 1 0 {
			sum `var' if !missing(l_ln_earnings) & flag_resp == `j'
			local m`i'`j' = strofreal(r(mean), "%04.3f")
			local s`i'`j' = "[" + strofreal(r(sd), "%04.3f") + "]"
			local n`i'`j' = r(N)
		}
		qui reg `var' flag_resp, cluster(id_common)
		local m`i'_d = strofreal(_b[flag_resp], "%04.3f")
		local s`i'_d = "(" + strofreal(_se[flag_resp], "%04.3f") + ")"
	}
	local i = `i' + 1
}

qui duplicates report id_common if !missing(l_ln_earnings)
local e = r(unique_value)

foreach i in 1 0 {
	qui duplicates report id_common if !missing(l_ln_earnings) & flag_resp == `i'
	local e`i' = r(unique_value)
}
	
local lbl1 "Unit response"
local lbl2 "L.\$ln(earnings)\$"
local lbl3 "L.Age"
local lbl4 "L.Female"

tempname hh
file open `hh' using "${path_table}/pj3_5/resprate_panel_sumstat_minkyu.tex", write replace
forvalues i = 1(1)4 {
	file write `hh' "`lbl`i'' & `m`i'' & `m`i'1' & `m`i'0' & `m`i'_d' \\" _newline
	file write `hh' "& `s`i'' & `s`i'1' & `s`i'0' & `s`i'_d' \\" _newline
}

file write `hh' "Establishments & `e' & `e1' & `e0' & \\" _newline
file write `hh' "Observations & `n2' & `n21' & `n20' & \\" _newline

file close `hh'

// Regression analysis
egen cluster_var = group(KYOKUSYO SEIRI)
recode estsize (1 2 3 4 = 1) (5 = 2) (6 = 3) (7 8 = 4), gen(estcat)

local cond1 "1 == 1"
local cond2 "estcat == 1"
local cond3 "estcat == 2"
local cond4 "estcat == 3"
local cond5 "estcat == 4"

forvalues i = 1(1)5 {
	reg flag_resp l_ln_earnings l_age l_female i.year i.industry i.estsize ///
		if `cond`i'', cluster(cluster_var)
	foreach v in l_ln_earnings l_age l_female {
		local b_`v'`i' = strofreal(_b[`v'], "%04.3f")
		local se_`v'`i' = "(" + strofreal(_se[`v'], "%04.3f") + ")"
	}
	sum flag_resp if e(sample), meanonly
	local mean`i' = strofreal(r(mean), "%04.3f")
	local n`i' = e(N)
}

tempname hh
file open `hh' using "${path_table}/pj3_5/resprate_panel_minkyu.tex", write replace

file write `hh' "\$ln(earnings)\$ & `b_l_ln_earnings1'  & `b_l_ln_earnings2'  & `b_l_ln_earnings3'  & `b_l_ln_earnings4' & `b_l_ln_earnings5' \\" _newline
file write `hh' "& `se_l_ln_earnings1' & `se_l_ln_earnings2'  & `se_l_ln_earnings3'  & `se_l_ln_earnings4'  & `se_l_ln_earnings5' \\" _newline

file write `hh' "Age & `b_l_age1' & `b_l_age2'  & `b_l_age3'  & `b_l_age4' & `b_l_age5' \\" _newline
file write `hh' "& `se_l_age1'  & `se_l_age2'  & `se_l_age3'  & `se_l_age4' & `se_l_age5' \\" _newline

file write `hh' "Female & `b_l_female1' & `b_l_female2'  & `b_l_female3'  & `b_l_female4' & `b_l_female5' \\" _newline
file write `hh' "& `se_l_female1'  & `se_l_female2'  & `se_l_female3'  & `se_l_female4' & `se_l_female5' \\" _newline

file write `hh' "Mean of Dep.Var. & `mean1' & `mean2' & `mean3' & `mean4' & `mean5' \\" _newline
file write `hh' "Observations & `n1' & `n2' & `n3' & `n4' & `n5' \\" _newline

file close `hh'

// Construct weight
keep if !missing(l_ln_earnings)
logit flag_resp i.year i.estsize i.industry, asis
predict p1, pr

logit flag_resp i.year i.estsize i.industry l_ln_earnings, asis
predict p2, pr

logit flag_resp i.year i.estsize i.industry  l_ln_earnings l_age l_female, asis
predict p3, pr

tempfile wt
keep KYOKUSYO SEIRI year p?
save `wt', replace

use "${path_chosa_minkyu_gensen}/minkyu_gensen.dta", clear
keep year id_minkyu ${weight_minkyu_j}

tempfile tmp
save `tmp', replace

use "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", clear

merge m:1 id_minkyu year using `tmp'
keep if _merge == 3
drop _merge

// Unit of earnings is 10 thousand JPY/month
merge m:1 year using "${path_root}/data/cpi.dta", ///
	assert(2 3) nogen keep(3)

gen earnings = KYUYOGAKU_KEI / 10 / cpi / 12
merge m:1 KYOKUSYO SEIRI year using `wt'
tab _merge
keep if inlist(_merge, 1, 3)
forvalues i = 1(1)3 {
	gen wt`i'_k = (1 / p`i') * ${weight_minkyu_k} / ${weight_minkyu_j}
}

local wt1 = "${weight_minkyu_k}"
local wt2 = "${weight_minkyu_k}*!missing(wt1)"
local wt3 = "wt1_k"
local wt4 = "wt2_k"
local wt5 = "wt3_k"

forvalues j = 1(1)5 {
	foreach var in earnings {
		sum `var' [aw=`wt`j'']
		local m_`var'`j' = strofreal(r(mean), "%04.3f")
		local sd_`var'`j' = "[" + strofreal(r(sd), "%04.3f") + "]"
		local n_`var'`j' = r(N)
	}
}

tempname hh
file open `hh' using "${path_table}/pj3_5/reweighting_minkyu.tex", write replace

file write `hh' "Total salary & `m_earnings1' & `m_earnings2' & `m_earnings3' & `m_earnings4' & `m_earnings5' \\" _newline
file write `hh' "& `sd_earnings1' & `sd_earnings2' & `sd_earnings3' & `sd_earnings4' & `sd_earnings5' \\" _newline

file write `hh' "\midrule" _newline
file write `hh' "Weight & Built-in & Built-in & Logit & Logit & Logit \\" _newline
file write `hh' "Year & & & X & X & X \\" _newline
file write `hh' "Industry & & & X & X & X \\" _newline
file write `hh' "Establishment size & & & X & X & X \\" _newline
file write `hh' "Prefecture & & & & & \\" _newline
file write `hh' "City size & & & & & \\" _newline
file write `hh' "Lagged wage & & & & X & X \\" _newline
file write `hh' "Other lagged characteristics & & & & & X \\" _newline
file write `hh' "Observations & `n_earnings1' & `n_earnings2' & `n_earnings3' & `n_earnings4' & `n_earnings5' \\" _newline

file close `hh'
