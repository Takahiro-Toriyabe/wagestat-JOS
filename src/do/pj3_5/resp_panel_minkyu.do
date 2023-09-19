use "${path_meibo_minkyu}/minkyu_meibo.dta", clear
merge 1:1 year KYOKUSYO SEIRI ///
	using "${path_chosa_minkyu_gensen}/minkyu_gensen.dta", ///
	assert(1 3) gen(merge_result)

// Make balanced panel as non-sampled year otherwise do not appear in the data
egen id = group(KYOKUSYO SEIRI)
xtset id year
tsfill, full

// Count # of sampled years and responses
gen flag_sampled = !missing(merge_result)
gen flag_respond = merge_result == 3

by id: egen nsampled = total(flag_sampled)
by id: egen nrespond = total(flag_respond)

// Change unit of obs from (establishment, year) -> establishment
keep if !missing(estsize)
duplicates drop id, force

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
	using("${path_table}/pj3_5/resp_panel_minkyu.tex") ///
	row nofreq row_title("\#Sampled years") col_title("\#Response") ///
    valuelabels format(%04.3f)
