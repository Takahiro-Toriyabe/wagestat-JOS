use "${path_data}/Census/data2010_use.dta", clear

gen code = 1000 * id_pref + id_mun
gen pop = 1

keep code pop
gcollapse (sum) pop, by(code)

merge 1:1 code using "${path_data}/city_converter_census.dta", ///
	assert(3) nogen

gcollapse (sum) pop, by(code_h)

gen pref_code = floor(code_h / 1000)
gen city_code = mod(code_h, 1000)

xtile popcat = pop, nq(10)
forvalues i = 1(1)10 {
	local v_l = (`i' - 1) * 10
	local v_u = `i' * 10
	local add = (`i' > 1) * "add"
	label define popcat `i' "`v_l'-`v_u'", `add'
}
label values popcat popcat

save "${path_data}/pop.dta", replace
