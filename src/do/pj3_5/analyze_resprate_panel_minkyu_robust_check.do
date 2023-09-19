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
	
// Regression analysis
gen d_year = year - l_year
gen tmp = d_year * l_ln_earnings
assert d_year >= 1

egen cluster_var = group(KYOKUSYO SEIRI)

local xlist1 "l_ln_earnings"
local xlist2 "l_ln_earnings d_year"
local xlist3 "l_ln_earnings d_year tmp"
local xlist4 "l_ln_earnings d_year tmp l_age l_female"

forvalues i = 1(1)4 {
	reghdfe flag_resp `xlist`i'', ///
		absorb(year estsize industry) cluster(cluster_var)
	foreach v in l_ln_earnings d_year tmp l_age l_female l_ln_workhours {
		capture local b_`v'`i' = strofreal(_b[`v'], "%04.3f")
		capture local se_`v'`i' = "(" + strofreal(_se[`v'], "%04.3f") + ")"
	}
	count if e(sample)
	local n`i' = e(N)
}

sum flag_resp if e(sample), meanonly
local mean`i' = strofreal(r(mean), "%04.3f")
local n`i' = e(N)

tempname hh
file open `hh' using "${path_table}/pj3_5/resprate_panel_minkyu_robust_check.tex", write replace

file write `hh' "L.\$ln(earnings)\$ & `b_l_ln_earnings1'  & `b_l_ln_earnings2'  & `b_l_ln_earnings3'  & `b_l_ln_earnings4' \\" _newline
file write `hh' "& `se_l_ln_earnings1' & `se_l_ln_earnings2'  & `se_l_ln_earnings3'  & `se_l_ln_earnings4' \\" _newline

file write `hh' "\$\Delta \text{Year} \$ & `b_d_year1'  & `b_d_year2'  & `b_d_year3'  & `b_d_year4' \\" _newline
file write `hh' "& `se_d_year1' & `se_d_year2'  & `se_d_year3'  & `se_d_year4' \\" _newline

file write `hh' "\$\Delta \text{Year} \times \text{L.}ln(wage)\$ & `b_tmp1'  & `b_tmp2'  & `b_tmp3'  & `b_tmp4' \\" _newline
file write `hh' "& `se_tmp1' & `se_tmp2'  & `se_tmp3'  & `se_tmp4' \\" _newline

file write `hh' "L.Age & `b_l_age1' & `b_l_age2'  & `b_l_age3'  & `b_l_age4' \\" _newline
file write `hh' "& `se_l_age1'  & `se_l_age2'  & `se_l_age3'  & `se_l_age4' \\" _newline

file write `hh' "L.Female & `b_l_female1' & `b_l_female2'  & `b_l_female3'  & `b_l_female4'  \\" _newline
file write `hh' "& `se_l_female1'  & `se_l_female2'  & `se_l_female3'  & `se_l_female4'  \\" _newline

file write `hh' "L.\$ln(WorkHours)\$ & `b_l_ln_workhours1'  & `b_l_ln_workhours2'  & `b_l_ln_workhours3'  & `b_l_ln_workhours4' \\" _newline
file write `hh' "& `se_l_ln_workhours1' & `se_l_ln_workhours2'  & `se_l_ln_workhours3'  & `se_l_ln_workhours4'  \\" _newline

file write `hh' "Observations & `n1' & `n2' & `n3' & `n4' \\" _newline

file close `hh'

