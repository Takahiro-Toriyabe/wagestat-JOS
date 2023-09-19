use "${path_meibo_minkyu}/minkyu_meibo.dta", clear
merge 1:m year KYOKUSYO SEIRI ///
	using "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", ///
	keep(1 3) gen(merge_result)

merge m:1 year using "${path_root}/data/cpi.dta", ///
	nogen assert(2 3) keep(3)

gen age =  NENREI
gen tenure = KINZOKU_NEN
gen female = SEIBETU == 2 if !missing(SEIBETU)
gen earnings = KYUYOGAKU_KEI / 1000 / cpi

/* Change weight variable to non-missing value as meibo-only observations 
   are dropped by collapse command
*/
replace ${weight_minkyu_k} = 1 if merge_result == 1
gcollapse (mean) age tenure female earnings [aw=${weight_minkyu_k}], ///
	by(KYOKUSYO SEIRI year)

egen id = group(KYOKUSYO SEIRI)
gen ln_earnings = ln(earnings)

sort id year
by id: gen t = _n

xtset id t
foreach var in age tenure female earnings ln_earnings year {
	gen l_`var' = l.`var'
}

keep KYOKUSYO SEIRI year l_*
save "${path_root}/data/est_info_minkyu.dta", replace
