use "${path_meibo_minkyu}/minkyu_meibo.dta", clear
merge 1:m KYOKUSYO SEIRI year using "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", ///
	assert(1 2 3) keep(1 3) gen(merge_result)

merge m:1 year using "${path_root}/data/cpi.dta", ///
	nogen assert(2 3) keep(3)

gen age =  NENREI
gen tenure = KINZOKU_NEN
gen female = SEIBETU == 2 if !missing(SEIBETU)
gen earnings = KYUYOGAKU_KEI / 1000 / cpi

/* Change weight variable to non-missing value as otherwise meibo-only observations 
   are dropped by collapse command
*/
replace ${weight_minkyu_k} = 1 if merge_result == 1
gcollapse (mean) age tenure female earnings ///
	[aw=${weight_minkyu_k}], by(KYOKUSYO SEIRI year)

gen ln_earnings = ln(earnings)

egen id_tmp = group(KYOKUSYO SEIRI)
xtset id_tmp year

forvalues t = 1(1)7 {
	gen l`t'_ln_earnings = l`t'.ln_earnings
}

keep KYOKUSYO SEIRI year l*_ln_earnings
save "${path_root}/data/lagged_wage_minkyu.dta", replace
