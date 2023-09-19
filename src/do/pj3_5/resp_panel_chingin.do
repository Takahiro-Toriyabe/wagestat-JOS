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

sort id_common year
duplicates drop id_common year, force

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

tab2tex nsampled nrespond, ///
	using("${path_table}/pj3_5/resp_panel_chingin.tex") ///
	row nofreq row_title("\#Sampled years") col_title("\#Response") ///
    valuelabels format(%04.3f)
