use "${path_meibo_minkyu}/minkyu_meibo.dta", clear
merge 1:1 year KYOKUSYO SEIRI ///
	using "${path_chosa_minkyu_gensen}/minkyu_gensen.dta", ///
	assert(1 3) gen(merge_result)

// Panel set
egen id = group(KYOKUSYO SEIRI)
sort id year
by id: gen t = _n
xtset id t

// Count # of sampled years and responses
gen flag_sampled = !missing(merge_result)
gen flag_respond = merge_result == 3

by id: egen nsampled = total(flag_sampled)
by id: egen nrespond = total(flag_respond)

// Check establishment-size distribution
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
	tab2tex estsize datacat, using("${path_table}/pj3_5/markov_check_sample_minkyu.tex") ///
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
	file open `hh' using "${path_table}/pj3_5/markov_`var'_minkyu.tex", write replace
	
	qui levelsof `var', local(typelist)
	foreach i in `typelist' {
		sum flag_respond if `var' == `i', meanonly
		local p`i' = strofreal(r(mean), "%04.3f")
		local q`i' = strofreal(1 - r(mean), "%04.3f")
		local nrec = strofreal(r(N))
		qui duplicates report id if `var' == `i'
		local nest = strofreal(r(unique_value))
		file write `hh' "`: label `: value label `var'' `i'' & `p`i'' & `q`i'' & `nrec' & `nest' \\" _newline
	}
	file close `hh'
}
