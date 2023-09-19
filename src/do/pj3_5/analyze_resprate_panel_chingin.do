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

// Descriptive stat
local i = 1
foreach var in flag_resp l_ln_wage l_ln_earnings l_age l_female l_ln_workhours {
	sum `var' if !missing(l_ln_wage)
	local m`i' = strofreal(r(mean), "%04.3f")
	local s`i' = "[" + strofreal(r(sd), "%04.3f") + "]"
	local n`i' = r(N)
	
	if "`var'" != "flag_resp" {
		foreach j in 1 0 {
			sum `var' if !missing(l_ln_wage) & flag_resp == `j'
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

qui duplicates report id_common if !missing(l_ln_wage)
local e = r(unique_value)

foreach i in 1 0 {
	qui duplicates report id_common if !missing(l_ln_wage) & flag_resp == `i'
	local e`i' = r(unique_value)
}
	
local lbl1 "Unit response"
local lbl2 "L.\$ln(wage)\$"
local lbl3 "L.\$ln(earnings)\$"
local lbl4 "L.Age"
local lbl5 "L.Female"
local lbl6 "L.\$ln(WorkHours)\$"

tempname hh
file open `hh' using "${path_table}/pj3_5/resprate_panel_sumstat_chingin.tex", write replace
forvalues i = 1(1)6 {
	file write `hh' "`lbl`i'' & `m`i'' & `m`i'1' & `m`i'0' & `m`i'_d' \\" _newline
	file write `hh' "& `s`i'' & `s`i'1' & `s`i'0' & `s`i'_d' \\" _newline
}

file write `hh' "Establishments & `e' & `e1' & `e0' & \\" _newline
file write `hh' "Observations & `n2' & `n21' & `n20' & \\" _newline

file close `hh'

// Regression analysis (wage)
recode estsize (0 1 2 3 = 1) (4 5 = 2) (6 7 = 3) (8 9 = 4), gen(estcat)
local cond1 "1 == 1"
local cond2 "estcat == 1"
local cond3 "estcat == 2"
local cond4 "estcat == 3"
local cond5 "estcat == 4"

forvalues i = 1(1)5 {
	reghdfe flag_resp l_ln_wage l_age l_female l_ln_workhours if `cond`i'', ///
		absorb(year estsize industry Ken popcat) cluster(id_common)
	foreach v in l_ln_wage l_age l_female l_ln_workhours {
		local b_`v'`i' = strofreal(_b[`v'], "%04.3f")
		local se_`v'`i' = "(" + strofreal(_se[`v'], "%04.3f") + ")"
	}
	sum flag_resp if e(sample), meanonly
	local mean`i' = strofreal(r(mean), "%04.3f")
	local n`i' = e(N)
}

tempname hh
file open `hh' using "${path_table}/pj3_5/resprate_panel_chingin_w.tex", write replace

file write `hh' "L.\$ln(wage)\$ & `b_l_ln_wage1'  & `b_l_ln_wage2'  & `b_l_ln_wage3'  & `b_l_ln_wage4'  & `b_l_ln_wage5' \\" _newline
file write `hh' "& `se_l_ln_wage1' & `se_l_ln_wage2'  & `se_l_ln_wage3'  & `se_l_ln_wage4' &  `se_l_ln_wage5' \\" _newline

file write `hh' "L.Age & `b_l_age1' & `b_l_age2'  & `b_l_age3'  & `b_l_age4'  & `b_l_age5' \\" _newline
file write `hh' "& `se_l_age1'  & `se_l_age2'  & `se_l_age3'  & `se_l_age4' & `se_l_age5' \\" _newline

file write `hh' "L.Female & `b_l_female1' & `b_l_female2'  & `b_l_female3'  & `b_l_female4' & `b_l_female5' \\" _newline
file write `hh' "& `se_l_female1'  & `se_l_female2'  & `se_l_female3'  & `se_l_female4'  & `se_l_female5' \\" _newline

file write `hh' "L.\$ln(WorkHours)\$ & `b_l_ln_workhours1'  & `b_l_ln_workhours2'  & `b_l_ln_workhours3'  & `b_l_ln_workhours4' & `b_l_ln_workhours5' \\" _newline
file write `hh' "& `se_l_ln_workhours1' & `se_l_ln_workhours2'  & `se_l_ln_workhours3'  & `se_l_ln_workhours4' & `se_l_ln_workhours5' \\" _newline

file write `hh' "Mean of Dep.Var. & `mean1' & `mean2' & `mean3' & `mean4' & `mean5' \\" _newline
file write `hh' "Observations & `n1' & `n2' & `n3' & `n4' & `n5' \\" _newline

file close `hh'

// Regression analysis (earnings)
forvalues i = 1(1)5 {
	reghdfe flag_resp l_ln_earnings l_age l_female l_ln_workhours if `cond`i'', ///
		absorb(year estsize industry Ken popcat) cluster(id_common)
	foreach v in l_ln_earnings l_age l_female l_ln_workhours {
		local b_`v'`i' = strofreal(_b[`v'], "%04.3f")
		local se_`v'`i' = "(" + strofreal(_se[`v'], "%04.3f") + ")"
	}
	local n`i' = e(N)
}

tempname hh
file open `hh' using "${path_table}/pj3_5/resprate_panel_chingin_e.tex", write replace

file write `hh' "L.\$ln(earnings)\$ & `b_l_ln_earnings1'  & `b_l_ln_earnings2'  & `b_l_ln_earnings3'  & `b_l_ln_earnings4'  & `b_l_ln_earnings5' \\" _newline
file write `hh' "& `se_l_ln_earnings1' & `se_l_ln_earnings2'  & `se_l_ln_earnings3'  & `se_l_ln_earnings4'  & `se_l_ln_earnings5' \\" _newline

file write `hh' "L.Age & `b_l_age1' & `b_l_age2'  & `b_l_age3'  & `b_l_age4'  & `b_l_age5' \\" _newline
file write `hh' "& `se_l_age1'  & `se_l_age2'  & `se_l_age3'  & `se_l_age4' & `se_l_age5' \\" _newline

file write `hh' "L.Female & `b_l_female1' & `b_l_female2'  & `b_l_female3'  & `b_l_female4' & `b_l_female5' \\" _newline
file write `hh' "& `se_l_female1'  & `se_l_female2'  & `se_l_female3'  & `se_l_female4'  & `se_l_female5' \\" _newline

file write `hh' "L.\$ln(WorkHours)\$ & `b_l_ln_workhours1'  & `b_l_ln_workhours2'  & `b_l_ln_workhours3'  & `b_l_ln_workhours4' & `b_l_ln_workhours5' \\" _newline
file write `hh' "& `se_l_ln_workhours1' & `se_l_ln_workhours2'  & `se_l_ln_workhours3'  & `se_l_ln_workhours4' & `se_l_ln_workhours5' \\" _newline

file write `hh' "Observations & `n1' & `n2' & `n3' & `n4' & `n5' \\" _newline

file close `hh'

// Construct weight
keep if !missing(l_ln_wage)
logit flag_resp i.year i.estsize i.industry i.Ken i.popcat, asis
predict p1, pr

logit flag_resp i.year i.estsize i.industry i.Ken i.popcat l_ln_wage, asis
predict p2, pr

logit flag_resp i.year i.estsize i.industry i.Ken i.popcat l_ln_wage l_age l_female l_ln_workhours, asis
predict p3, pr

tempfile tmp
keep id_common year p?
save `tmp', replace

use "${path_data}/pj/pj3_5/chingin_matched.dta", clear
keep if inrange(year, 2012, 2017) & !missing(id_common) & inlist(merge_result, 1, 3)

merge m:1 year using "${path_root}/data/cpi.dta", ///
	nogen assert(2 3) keep(3)

gen age = Nenrei
gen tenure = Kinzoku
gen female = Sei == 2 if !missing(Sei)
gen workhours = SyoteiJikan + ChokaJikan
gen earnings = (Genkin + Tokubetsu / 12) / 100 / cpi
gen wage = earnings / workhours

merge m:1 id_common year using `tmp', assert(1 3) nogen
forvalues i = 1(1)3 {
	gen wt`i'_k = Fukugen / p`i'
}

local wt1 = "${weight_wc_k}"
local wt2 = "${weight_wc_k}*!missing(wt1)"
local wt3 = "wt1_k"
local wt4 = "wt2_k"
local wt5 = "wt3_k"

forvalues j = 1(1)5 {
	foreach var in earnings wage {
		sum `var' [aw=`wt`j''] if !missing(wage) & !missing(earnings)
		local m_`var'`j' = strofreal(r(mean), "%04.3f")
		local sd_`var'`j' = "[" + strofreal(r(sd), "%04.3f") + "]"
		local n_`var'`j' = r(N)
	}
}

tempname hh
file open `hh' using "${path_table}/pj3_5/reweighting_chingin.tex", write replace

file write `hh' "Total salary & `m_earnings1' & `m_earnings2' & `m_earnings3' & `m_earnings4' & `m_earnings5' \\" _newline
file write `hh' "& `sd_earnings1' & `sd_earnings2' & `sd_earnings3' & `sd_earnings4' & `sd_earnings5' \\" _newline
file write `hh' "Hourly wage & `m_wage1' & `m_wage2' & `m_wage3' & `m_wage4' & `m_wage5' \\" _newline
file write `hh' "& `sd_wage1' & `sd_wage2' & `sd_wage3' & `sd_wage4' & `sd_wage5' \\" _newline

file write `hh' "\midrule" _newline
file write `hh' "Weight & Built-in & Built-in & Logit & Logit & Logit \\" _newline
file write `hh' "Year & & & X & X & X \\" _newline
file write `hh' "Industry & & & X & X & X \\" _newline
file write `hh' "Establishment size & & & X & X & X \\" _newline
file write `hh' "Prefecture & & & X & X & X \\" _newline
file write `hh' "City size & & & X & X & X \\" _newline
file write `hh' "Lagged wage & & & & X & X \\" _newline
file write `hh' "Other lagged characteristics & & & & & X \\" _newline
file write `hh' "Observations & `n_wage1' & `n_wage2' & `n_wage3' & `n_wage4' & `n_wage5' \\" _newline

file close `hh'
