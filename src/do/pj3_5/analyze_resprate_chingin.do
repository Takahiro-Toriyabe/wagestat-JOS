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

// Visualize
graph hbar flag_resp if year == 2017, ///
	ytitle("Response rate") ylabel(0(0.1)1, format(%02.1f)) ///
	over(estsize) ///
	scheme(tt_mono)
export_graph resprate_estsize_wc, path("${path_figure}/pj3_5")

graph hbar flag_resp if year == 2017, ///
	ytitle("Response rate") ylabel(0(0.1)1, format(%02.1f)) ///
	over(industry) ///
	scheme(tt_mono)
export_graph resprate_industry_wc, path("${path_figure}/pj3_5")

graph hbar flag_resp if year == 2017, ///
	ytitle("Response rate") ylabel(0(0.1)1, format(%02.1f)) ///
	over(popcat) ///
	scheme(tt_mono)
export_graph resprate_popcat_wc, path("${path_figure}/pj3_5")

graph hbar flag_resp if year == 2017, ///
	ytitle("Response rate") ylabel(0(0.1)1, format(%02.1f)) ///
	over(Ken, label(labsize(*0.7))) ///
	scheme(tt_mono)
export_graph resprate_Ken_wc, path("${path_figure}/pj3_5")


// Export as tables
foreach var in Ken popcat estsize industry {
	// Without weight
	export_twoway_table `var' year, main_var(flag_resp) format("%03.2f") ///
		valuelabel total1 export("${path_table}/pj3_5/resprate_`var'_wc.tex")
		
	// With weight
	export_twoway_table `var' year [aw=sample_rate], main_var(flag_resp) format("%03.2f") ///
		valuelabel total1 export("${path_table}/pj3_5/resprate_`var'_wt_wc.tex")
}

/* Regression analysis
	Reference category is
		- year: 2012
		- Industry: Manufacture
		- Establishment size: 100-299
		- Prefecture: Tokyo
*/

// Parameters
local b_year = 2012
local xmin_year = -0.025
local xmax_year = 0.021
local xd_year = 0.005
local fmt_year "%04.3f"

local b_industry = 2
local xmin_industry = -0.20
local xmax_industry = 0.11
local xd_industry = 0.1
local fmt_industry "%03.2f"

local b_estsize = 5
local xmin_estsize = -0.40
local xmax_estsize = 0.36
local xd_estsize = 0.1
local fmt_estsize "%03.2f"

local b_Ken = 13
local xmin_Ken = -0.05
local xmax_Ken = 0.26
local xd_Ken = 0.05
local fmt_Ken "%03.2f"

local b_popcat = 5
local xmin_popcat = -0.020
local xmax_popcat = 0.052
local xd_popcat = 0.010
local fmt_popcat "%04.3f"


// Estmation and visualize the result
eststo clear
eststo est0: reg flag_resp ib`b_year'.year ib`b_industry'.industry ///
	ib`b_estsize'.estsize ib`b_Ken'.Ken ib`b_popcat'.popcat, cluster(id_common)

foreach var in year industry estsize Ken popcat {
	local lbl_base_`var': label `:value label `var'' `b_`var''
	if "`var'" == "Ken" {
		local aspect_option "ysize(10) xsize(5.5)"
	}
	else {
		local aspect_option ""
	}

	coefplot (est0, keep(*.`var') baselevels levels(95)), ///
		xlabel(`xmin_`var''(`xd_`var'')`xmax_`var'', ///
			format(`fmt_`var'')) xline(0, lp(l) lc(gs6)) ///
		coeflabels(`b_`var''.`var' = "`lbl_base_`var''") ///
		`aspect_option'
	export_graph reg_resprate_`var'_chingin, path("${path_figure}/pj3_5")
	if "`var'" == "Ken" {
		graph export "${path_figure}/pj3_5/png/reg_resprate_`var'_chingin.png", ///
			replace as(png) height(1200) width(660)
	}
}

// Estmation and visualize the result (with weight)
local b_year = 2012
local xmin_year = -0.05
local xmax_year = 0.021
local xd_year = 0.005
local fmt_year "%04.3f"

local b_industry = 2
local xmin_industry = -0.20
local xmax_industry = 0.11
local xd_industry = 0.1
local fmt_industry "%03.2f"

local b_estsize = 5
local xmin_estsize = -0.40
local xmax_estsize = 0.41
local xd_estsize = 0.1
local fmt_estsize "%03.2f"

local b_Ken = 13
local xmin_Ken = -0.05
local xmax_Ken = 0.26
local xd_Ken = 0.05
local fmt_Ken "%03.2f"

local b_popcat = 5
local xmin_popcat = -0.040
local xmax_popcat = 0.122
local xd_popcat = 0.020
local fmt_popcat "%04.3f"

eststo clear
eststo est0: reg flag_resp ib`b_year'.year ib`b_industry'.industry ///
	ib`b_estsize'.estsize ib`b_Ken'.Ken ib`b_popcat'.popcat [aw=sample_rate], cluster(id_common)
foreach var in year industry estsize Ken popcat {
	local lbl_base_`var': label `:value label `var'' `b_`var''
	if "`var'" == "Ken" {
		local aspect_option "ysize(10) xsize(5.5)"
	}
	else {
		local aspect_option ""
	}

	coefplot (est0, keep(*.`var') baselevels levels(95)), ///
		xlabel(`xmin_`var''(`xd_`var'')`xmax_`var'', ///
			format(`fmt_`var'')) xline(0, lp(l) lc(gs6)) ///
		coeflabels(`b_`var''.`var' = "`lbl_base_`var''") ///
		`aspect_option'
	export_graph reg_resprate_`var'_wt_chingin, path("${path_figure}/pj3_5")
	if "`var'" == "Ken" {
		graph export "${path_figure}/pj3_5/png/reg_resprate_`var'_wt_chingin.png", ///
			replace as(png) height(1200) width(660)
	}
}
