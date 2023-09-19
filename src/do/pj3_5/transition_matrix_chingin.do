use "${path_data}/pj/pj3_5/chingin_matched.dta", clear

keep if inrange(year, 2012, 2017) & inlist(merge_result, 1, 3)
drop if missing(id_common)

// Make city class variable
replace pref_code = Ken if missing(pref_code)
replace city_code = Shiku if missing(city_code)
assert !missing(pref_code) & !missing(city_code)

merge m:1 pref_code city_code year ///
	using "${path_data}/city_converter_chingin.dta", ///
	assert(2 3) keep(3) nogen

merge m:1 code_h using "${path_data}/pop.dta", ///
	assert(2 3) keep(3) nogen

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
sort id_common year
by id_common: gen t = _n
xtset id_common t

// Count # of sampled years and responses
gen flag_sampled = 1
gen flag_respond = merge_result == 3

by id_common: egen nsampled = total(flag_sampled)
by id_common: egen nrespond = total(flag_respond)
by id_common: egen flag_large = max(estsize <= 3)
assert inlist(flag_large, 1, 0)

// Check establishment-size distribution
label values estsize M_JigyoKibo

preserve
	keep estsize nsampled
	foreach i in 1 2 3 {
		keep if nsampled >= `i'
		
		tempfile tmp`i'
		save `tmp`i'', replace
	}

	clear
	append using `tmp1' `tmp2' `tmp3', gen(datacat) 
	label define datacat 1 "1回以上" 2 "2回以上" 3 "3回以上"
	label values datacat datacat
	tab2tex estsize datacat, using("${path_table}/pj3_5/markov_check_sample_chingin.tex") ///
		col nofreq row_title("事業所規模") col_title("抽出回数") valuelabels format("%05.4f")
restore

gen l_flag_respond = l.flag_respond
gen l2_flag_respond = l2.flag_respond

gen resptype1 = 2 - l_flag_respond
label define resptype1 1 "R" 2 "NR"
label values resptype1 resptype1

gen resptype2 = 1 if l_flag_respond == 1 & l2_flag_respond == 1
replace resptype2 = 2 if l_flag_respond == 1 & l2_flag_respond == 0
replace resptype2 = 3 if l_flag_respond == 0 & l2_flag_respond == 1
replace resptype2 = 4 if l_flag_respond == 0 & l2_flag_respond == 0
assert missing(resptype2) if t <= 2
assert !missing(resptype2) if t >= 3

label define resptype2 1 "R\textrightarrow R" 2 "NR\textrightarrow R" ///
	3 "R\textrightarrow NR" 4 "NR\textrightarrow NR"
label values resptype2 resptype2

// Calculate transition matrix
foreach var in resptype1 resptype2 {
	tempname hh
	file open `hh' using "${path_table}/pj3_5/markov_`var'_chingin.tex", write replace
	
	qui levelsof `var', local(typelist)
	foreach i in `typelist' {
		sum flag_respond if `var' == `i', meanonly
		local p`i' = strofreal(r(mean), "%04.3f")
		local q`i' = strofreal(1 - r(mean), "%04.3f")
		local nrec = strofreal(r(N))
		qui duplicates report id_common if `var' == `i'
		local nest = strofreal(r(unique_value))
		file write `hh' "`: label `: value label `var'' `i'' & `p`i'' & `q`i'' & `nrec' & `nest' \\" _newline
	}
	file close `hh'
}
