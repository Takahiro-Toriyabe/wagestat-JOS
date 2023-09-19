// Data construction
use "${path_data}/pj/pj3_5/chingin_matched.dta", clear

keep if inrange(year, 2012, 2017) & inlist(merge_result, 1, 3)
drop if missing(id_common)

// Change unit of obs from worker -> (establishment, year)
assert !missing(id_est) if merge_result == 3
bysort id_est year: gen worker_num = _n if merge_result == 3
replace worker_num = 1 if merge_result == 1
assert !missing(worker_num)
keep if worker_num == 1

// In 2012, Economic Census ID was used to erase duplication when making chingin_matched.dta
// So, ignore 2012 in this assertion
duplicates report id_common year if worker_num == 1 & year != 2012
assert r(unique_value) == r(N)

gsort id_common year -merge_result
by id_common year: gen seq_tmp = _n if year == 2012
drop if year == 2012 & seq_tmp != 1
drop seq_tmp
isid id_common year

duplicates report id_common
duplicates report id_common if inrange(M_JigyoKibo, 0, 3)

// Make balanced panel as non-sampled year otherwise do not appear in the data
xtset id_common year
tsfill, full

// Count # of sampled years and responses
gen flag_sampled = !missing(merge_result)
gen flag_respond = merge_result == 3

by id_common: egen nsampled = total(flag_sampled)
by id_common: egen nrespond = total(flag_respond)
by id_common: egen flag_large = max(estsize <= 3)
assert inlist(flag_large, 1, 0)

// Change unit of obs from (establishment, year) -> establishment
keep if !missing(estsize)
duplicates drop id_common, force

// Check the result
foreach var in nrespond nsampled {
	qui levelsof `var', local(`var'_list)
	foreach i in ``var'_list' {
		capture label define `var' `i' "`i'"
		capture label define `var' `i' "`i'", add
	}
	label values `var' `var'
}

tempfile tmp
keep id_common nrespond nsampled
save `tmp'

// Merge response history
use "${path_data}/pj/pj3_5/chingin_matched.dta", clear

merge m:1 year using "${path_root}/data/cpi.dta", ///
	nogen assert(2 3) keep(3)

keep if inrange(year, 2012, 2017) & inlist(merge_result, 1, 3) & !missing(id_common)
keep if merge_result == 3

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

merge m:1 id_common using `tmp', assert(2 3) keep(3) nogen

gen age = Nenrei
gen tenure = Kinzoku
gen female = Sei == 2 if !missing(Sei)
gen workhours = SyoteiJikan + ChokaJikan
gen earnings = (Genkin + Tokubetsu / 12) / 100 / cpi
gen wage = earnings / workhours

gen ln_wage = ln(wage)
gen prob_resp = nrespond / nsampled

keep if nsampled > 1

forvalues j = 2(1)6 {
	reghdfe ln_wage ib`j'.nrespond [aw=${weight_wc_k}] ///
		if nsampled == `j', absorb(year estsize industry Ken popcat) cluster(id_common)
	local n`j' = e(N)
	forvalues i = 1(1)`j' {
		local b`i'`j' = strofreal(_b[`i'.nrespond], "%04.3f")
		if `i' < `j' {
			local se`i'`j' = "(" + strofreal(_se[`i'.nrespond], "%04.3f") + ")"
		}
		qui count if e(sample) & nrespond == `i'
		local n`i'`j' = r(N)
		local share`i'`j' = strofreal(100 * `n`i'`j'' / `n`j'', "%03.1f") + "\%"
	}
}

tempname hh
file open `hh' using "${path_table}/pj3_5/difficult_to_reach_chingin_w.tex", write replace

file write `hh' "\#Response=1 & `b12' & `share12' & `b13' & `share13' & `b14' & `share14' & `b15' & `share15' & `b16' & `share16' \\" _newline
file write `hh' "& `se12' & & `se13' & & `se14' & & `se15' & &`se16' & \\" _newline
file write `hh' "\#Response=2 & `b22' & `share22' & `b23' & `share23' & `b24' & `share24' & `b25' & `share25' & `b26' & `share26' \\" _newline
file write `hh' "& `se22' & & `se23' & & `se24' & & `se25' & &`se26' & \\" _newline
file write `hh' "\#Response=3 & `b32' & `share32' & `b33' & `share33' & `b34' & `share34' & `b35' & `share35' & `b36' & `share36' \\" _newline
file write `hh' "& `se32' & & `se33' & & `se34' & & `se35' & &`se36' & \\" _newline
file write `hh' "\#Response=4 & `b42' & `share42' & `b43' & `share43' & `b44' & `share44' & `b45' & `share45' & `b46' & `share46' \\" _newline
file write `hh' "& `se42' & & `se43' & & `se44' & & `se45' & &`se46' & \\" _newline
file write `hh' "\#Response=5 & `b52' & `share52' & `b53' & `share53' & `b54' & `share54' & `b55' & `share55' & `b56' & `share56' \\" _newline
file write `hh' "& `se52' & & `se53' & & `se54' & & `se55' & &`se56' & \\" _newline
file write `hh' "\#Response=6 & `b62' & `share62' & `b63' & `share63' & `b64' & `share64' & `b65' & `share65' & `b66' & `share66' \\" _newline
file write `hh' "& `se62' & & `se63' & & `se64' & & `se65' & &`se66' & \\" _newline
file write `hh' "Observations &`n2' & & `n3' & & `n4' & & `n5' & & `n6' & \\" _newline
file close `hh'
