use "${path_data}/pj/pj3_5/chingin_matched.dta", clear

keep if inrange(year, 2012, 2017) & inlist(merge_result, 1, 3)
assert !missing(id_est) if merge_result == 3

// Drop observations to conduct establishment-level analysis
bysort year id_est: gen worker_num = _n if merge_result == 3
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

// Put value labels
label values estsize JigyoKibo
put_value_label_pref Ken
clean_industry_wc2009_2017 industry

qui levelsof year, local(ylist)
foreach y in `ylist' {
	capture label define year `y' "`y'"
	capture label define year `y' "`y'", add
}
label values year year

do "${path_module}/label_pref_en.do"
label values Ken _pref_en

do "${path_module}/label_industry_en.do"
label values industry _industry_en

capture label drop estsize
label define estsize 0 "15000+" 1 "5000-14999" 2 "1000-4999" 3 "500-999" 4 "300-499" ///
	5 "100-299" 6 "50-99" 7 "30-49" 8 "10-29" 9 "5-9"
label values estsize estsize

local varlist flag_resp year Ken city_code popcat industry estsize sample_rate
keep `varlist' id_common
foreach var in `varlist' {
	assert !missing(`var')
}

collapse (mean) flag_resp, by(year)
tempfile tmp
save `tmp'

use "${path_meibo_minkyu}/minkyu_meibo.dta", clear
merge 1:1 year KYOKUSYO SEIRI ///
	using "${path_chosa_minkyu_gensen}/minkyu_gensen.dta", ///
	assert(1 3)

gen flag_resp = _merge == 3
drop _merge

qui levelsof year, local(ylist)
foreach y in `ylist' {
	capture label define year `y' "`y'"
	capture label define year `y' "`y'", add
}
label values year year

label define _industry 1 "Manufacturing (C)" 2 "Wholesales (C)" 3 "Retail trade (C)" ///
    4 "Construction (C)" 5 "Transportation (C)" 6 "Service (C)" 7 "Inn/restaurant (C)" ///
    8 "Other (C)" 9 "Retail trade (I)" 10 "Wholesales (I)" 11 "Manufacturing/retailing (I)" ///
    12 "Manufacturing/wholesales (I)" 13 "Contract manufacturing (I)" 14 "Repairing (I)" ///
    15 "Service (I)" 16 "Construction (I)" 17 "Other sales (I)" 18 "Agriculture (I)" 19 "Other business (I)" ///
    20 "Other (I)"
label values industry _industry

label define _estsize 1 "Head quarter" 2 "5000+" 3 "1000-4999" 4 "500-999" 5 "100-499" 6 "30-99" 7 "10-29" 8 "1-9"
label values estsize _estsize

collapse (mean) flag_resp, by(year)

append using `tmp', gen(dcat)

twoway (connect flag_resp year if dcat == 1, color(gs3) lp(l) ms(O)) ///
	(connect flag_resp year if dcat == 0, color(gs3) lp(shortdash) ms(Oh)), ///
	ytitle("Unit response rate") ylabel(0(0.1)0.8, format(%02.1f)) ///
	xtitle("Year") xlabel(2012(1)2019.5, nogrid) ///
	legend(order(1 "BSWS" 2 "SSPS") ring(0) pos(4) region(lw(*0.1) lc(gs10))) ///
	scheme(tt_mono)
export_graph resprate, path("${path_figure}/pj3_5")
