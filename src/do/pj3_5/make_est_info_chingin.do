use "${path_data}/pj/pj3_5/chingin_matched.dta", clear
keep if inrange(year, 2012, 2017) & !missing(id_common)

merge m:1 year using "${path_root}/data/cpi.dta", ///
	nogen assert(2 3) keep(3)

gen age = Nenrei
gen tenure = Kinzoku
gen female = Sei == 2 if !missing(Sei)
gen workhours = SyoteiJikan + ChokaJikan
gen earnings = (Genkin + Tokubetsu / 12) / 100 / cpi
gen wage = earnings / workhours

/* Change weight variable to non-missing value as meibo-only observations 
   are dropped by collapse command
*/
replace ${weight_wc_k} = 1 if merge_result == 1
gcollapse (mean) age tenure female workhours earnings wage ///
	[aw=${weight_wc_k}], by(id_common year)

gen ln_workhours = ln(workhours)
gen ln_earnings = ln(earnings)
gen ln_wage = ln(wage)

sort id_common year
by id_common: gen t = _n

xtset id_common t
foreach var in age tenure female workhours earnings wage ///
		ln_workhours ln_earnings ln_wage year {
	gen l_`var' = l.`var'
}

keep id_common year l_*
save "${path_root}/data/est_info_chingin.dta", replace
