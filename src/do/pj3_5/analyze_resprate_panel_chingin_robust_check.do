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
	using "${path_root}/data/est_info_chingin.dta", keep(1 3)
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
keep `varlist' l_* id_common flag_panel
foreach var in `varlist' {
	assert !missing(`var')
}
gen d_year = year - l_year
gen tmp = d_year * l_ln_wage
assert d_year >= 1

// Regression analysis (wage)
recode estsize (0 1 2 3 = 1) (4 5 = 2) (6 7 = 3) (8 9 = 4), gen(estcat)
local xlist1 "l_ln_wage"
local xlist2 "l_ln_wage d_year"
local xlist3 "l_ln_wage d_year tmp"
local xlist4 "l_ln_wage d_year tmp l_age l_female l_ln_workhours"

forvalues i = 1(1)4 {
	reghdfe flag_resp `xlist`i'', ///
		absorb(year estsize industry Ken popcat) cluster(id_common)
	foreach v in l_ln_wage d_year tmp l_age l_female l_ln_workhours {
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
file open `hh' using "${path_table}/pj3_5/resprate_panel_chingin_w_robust_check.tex", write replace

file write `hh' "L.\$ln(wage)\$ & `b_l_ln_wage1'  & `b_l_ln_wage2'  & `b_l_ln_wage3'  & `b_l_ln_wage4' \\" _newline
file write `hh' "& `se_l_ln_wage1' & `se_l_ln_wage2'  & `se_l_ln_wage3'  & `se_l_ln_wage4' \\" _newline

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

