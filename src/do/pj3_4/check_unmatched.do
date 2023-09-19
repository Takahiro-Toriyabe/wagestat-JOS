// Clean Meibo of Wage Census
forvalues y = 27(1)29 {
	use "${path_meibo_chingin}/chingin_meibo_h`y'.dta", clear
	rename 共通事業所コード id_common
	gen year = 1988 + `y'

	if `y' == 27 {
		rename 都道府県コード pref 
		rename 事業所規模 estsize 
		rename 企業規模 firmsize
		rename 事業所産業分類LP大RP industry
	}
	if `y' == 28 {
		rename 都道府県コード pref 
		rename 事業所規模 estsize 
		rename 企業規模 firmsize
		rename 産業大分類LP事業所RP industry
	}
	if `y' == 29 {
		rename 都道府県 pref 
		rename 事業所規模 estsize 
		rename 企業規模 firmsize
		gen industry = substr(産業分類, 1, 1)
	}

	keep year id_common pref estsize firmsize industry
	duplicates report id_common
	assert r(unique_value) == r(N)

	tempfile tmp`y'
	save `tmp`y'', replace
}

clear
forvalues y = 27(1)29 {
	append using `tmp`y''	
}

destring *, replace
keep if inrange(estsize, 0, 3)

tempfile chingin
save `chingin', replace

// Merge Meibo of Maikin
use "${path_meibo_maikin}/maikin_meibo.dta", clear
keep if flag_large

duplicates report id_common
bysort id_common: gen check = _N
keep if check == 1
keep id_common

merge 1:m id_common using `chingin'
keep if inlist(_merge, 2, 3)
gen flag_match = _merge == 3

// Put value labels
put_value_label_pref pref
clean_industry_wc2009_2017 industry
label define estsize 0 "15,000人以上" 1 "5,000--14,999人" 2 "1,000~4,999人" 3 "500--999人"
label values estsize estsize

// Check match rate
foreach var in pref estsize industry {
	tab `var'
	export_twoway_table `var' year, ///
		main_var(flag_match) format("%03.2f") ///
		export("${path_table}/pj3_4/check_unmatched_`var'.tex") ///
		valuelabel total1 total2
}
