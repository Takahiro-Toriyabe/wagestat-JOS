// Using data
use "${path_chosa_chingin}/chingin.dta", clear
keep if inrange(year, 2009, 2017)

tempfile usingdata
save `usingdata', replace

// H21-H24
forvalues y = 21(1)24 {
	use "${path_meibo_chingin}/chingin_meibo_h`y'.dta", clear
	if `y' != 24 {
		keep v0 v1 v2 v3 v8 v16-v23 v32 v35
		qui destring v0 v1 v2 v3 v8 v22 v23 v32 v35, replace
	}
	else {
		keep v0 v1 v2 v3 v8 v16-v23 v32 v35 v68
		qui destring v0 v1 v2 v3 v8 v22 v23 v32 v35 v68, replace
	}
	

	rename v0 Ken
	rename v1 Shiku
	rename v2 Kihon
	rename v3 Jigyosyo
	rename v8 industry
	rename v32 estsize
	rename v35 sample_rate
	
	rename v16 name
	rename v17 tel1
	rename v18 tel2
	rename v19 tel3
	rename v20 zip1
	rename v21 zip2
	rename v22 pref_code
	rename v23 city_code
		
	if `y' == 24 {
		rename v68 id_common
	}

	duplicates report Ken Shiku Kihon Jigyosyo
	duplicates drop Ken Shiku Kihon Jigyosyo, force

	gen year = 1988 + `y'
	merge 1:m year Ken Shiku Kihon Jigyosyo using ///
		`usingdata', gen(merge_result)
	keep if year == 1988 + `y'

	tempfile tmp`y'
	save `tmp`y''
}

// H25-26
forvalues y = 25(1)26 {
	use "${path_meibo_chingin}/chingin_meibo_h`y'.dta", clear
	local cnt = 0
	foreach var of varlist * {
		local lbl = usubinstr(usubinstr("`var'", "LP", "(", .), "RP", ")", .)
		label variable `var' "`lbl'"
		rename `var' v`++cnt'
	}

	keep v1 v2 v3 v4 v9 v17-v24 v33 v36 v69
	qui destring v1 v2 v3 v4 v9 v23 v24 v33 v36 v69, replace

	rename v1 Ken
	rename v2 Shiku
	rename v3 Kihon
	rename v4 Jigyosyo
	rename v9 industry
	rename v33 estsize
	rename v36 sample_rate
	rename v69 id_common
	
	rename v17 name
	rename v18 tel1
	rename v19 tel2
	rename v20 tel3
	rename v21 zip1
	rename v22 zip2
	rename v23 pref_code
	rename v24 city_code

	duplicates report id_common
	duplicates drop id_common, force

	gen year = 1988 + `y'
	merge 1:m year id_common using `usingdata', gen(merge_result)
	keep if year == 1988 + `y'

	tempfile tmp`y'
	save `tmp`y'', replace
}

// H27
use "${path_meibo_chingin}/chingin_meibo_h27.dta", clear
local cnt = 0
foreach var of varlist * {
	local lbl = usubinstr(usubinstr("`var'", "LP", "(", .), "RP", ")", .)
	label variable `var' "`lbl'"
	rename `var' v`++cnt'
}

keep v28 v2 v9 v38 v41 v22-v29
qui destring v28 v2 v9 v38 v41 v29, replace

rename v28 Ken
rename v2 id_common
rename v9 industry
rename v38 estsize
rename v41 sample_rate

rename v22 tel1
rename v23 tel2
rename v24 tel3
rename v25 zip1
rename v26 zip2
rename v27 name
gen pref_code = Ken
rename v29 city_code

duplicates report id_common
duplicates drop id_common, force

gen year = 2015
merge 1:m year id_common using `usingdata', gen(merge_result)
keep if year == 2015

tempfile tmp27
save `tmp27', replace

// H28
use "${path_meibo_chingin}/chingin_meibo_h28.dta", clear
local cnt = 0
foreach var of varlist * {
	local lbl = usubinstr(usubinstr("`var'", "LP", "(", .), "RP", ")", .)
	label variable `var' "`lbl'"
	rename `var' v`++cnt'
}

keep v31 v1 v9 v41 v44 v2 v26 v27 v29 v32
qui destring v31 v1 v9 v41 v44 v2 v32, replace

rename v31 Ken
rename v1 id_common
rename v9 industry
rename v41 estsize
rename v44 sample_rate

rename v26 tel
rename v27 zip
rename v29 name
gen pref_code = Ken
rename v32 city_code

duplicates report id_common
duplicates drop id_common, force

gen year = 2016
merge 1:m year id_common using `usingdata', gen(merge_result)
keep if year == 2016

tempfile tmp28
save `tmp28', replace

// H29
use "${path_meibo_chingin}/chingin_meibo_h29.dta", clear
local cnt = 0
foreach var of varlist * {
	local lbl = usubinstr(usubinstr("`var'", "LP", "(", .), "RP", ")", .)
	label variable `var' "`lbl'"
	rename `var' v`++cnt'
}

keep v1 v2 v6 v7 v9 v13 v15 v20 v10
qui destring v1 v2 v6 v7 v9 v10, replace

rename v2 Ken
rename v1 id_common
gen industry = substr(v6, 1, 1)
drop v6
rename v7 estsize
rename v9 sample_rate

rename v13 name
rename v15 tel
rename v20 zip
gen pref_code = Ken
rename v10 city_code 

duplicates report id_common
duplicates drop id_common, force

gen year = 2017
merge 1:m year id_common using `usingdata', gen(merge_result)
keep if year == 2017

tempfile tmp29
save `tmp29', replace

// Append data
clear
forvalues y = 21(1)29 {
	append using `tmp`y''
}

save "${path_data}/pj/pj3_5/chingin_matched.dta", replace
