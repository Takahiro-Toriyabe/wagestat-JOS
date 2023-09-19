local fn "sumstat_freelance"
take_log `fn', path("${path_log}/pj3_6")

use "${path_data}/chosa/ESS/ess.dta", clear

destring KC_7_SHUGYO, replace force
keep if inrange(KC_7_SHUGYO, 1, 4)

rename K_AGE age
label variable age "年齢"

gen female = KC_1_SEX == 2 if !missing(KC_1_SEX)
label variable female "女性"

gen flag_schooling = KC_4_1_SHUGAKU == 2 if !missing(KC_4_1_SHUGAKU)
label variable flag_schooling "在学中"

gen unmarried = KC_1_HAIGU == 1 if !missing(KC_1_HAIGU)
label variable unmarried "未婚"

levelsof KC_4_2_GAKKO, local(educs)
foreach e in `educs' {
	local lbl: label KC_4_2_GAKKO `e'
	gen educ`e' = KC_4_2_GAKKO == `e' if !missing(KC_4_2_GAKKO)
	label variable educ`e' "`lbl'"
}

gen flag_freelance = KC_A1_CHII == 10 & KC_A4_KIBO == 1 ///
	if !missing(KC_A1_CHII) & !missing(KC_A4_KIBO)

foreach var of varlist age female flag_schooling flag_freelance ///
		educ* unmarried KC_A8_SHUGYORIYU KC_A11_KEIZOKUKIBO {
	drop if missing(`var')
}

foreach i in 0 1 {
	qui count if flag_freelance == `i'
	local n`i' = r(N)
}

tempname hh
file open `hh' using "${path_table}/pj3_6/sumstat_freelance.tex", write replace

foreach var of varlist age female unmarried flag_schooling educ* {
	local lbl: variable label `var'
	foreach i in 1 0 {
		qui sum `var' [aw=R_SHUKEI] if flag_freelance == `i'
		local m`i' = strofreal(r(mean), "%04.3f")
		local s`i' = "[" + strofreal(r(sd), "%04.3f") + "]"
	}
	qui reg `var' flag_freelance [aw=R_SHUKEI], robust
	local md = strofreal(_b[flag_freelance], "%04.3f")
	local sd = "(" + strofreal(_se[flag_freelance], "%04.3f") + ")"
	file write `hh' "`lbl' & `m1' & `m0' & `md' \\" _newline
	file write `hh' "& `s1' & `s0' & `sd' \\" _newline
}
file write `hh' "観測数 & `n1' & `n0' \\" _newline

local cnt = 1
foreach var in KC_A8_SHUGYORIYU KC_A11_KEIZOKUKIBO {
	levelsof `var', local(vals)
	foreach v in `vals' {
		local lbl: label `var' `v'
		gen v`cnt'_`v' = `var' == `v' if !missing(`var')
		label variable v`cnt'_`v' "`lbl'"
	}
	local `cnt++'
}

tempname hh
file open `hh' using "${path_table}/pj3_6/why_freelance.tex", write replace

foreach var of varlist v1_* {
	local lbl: variable label `var'
	foreach i in 1 0 {
		qui sum `var' [aw=R_SHUKEI] if flag_freelance == `i'
		local m`i' = strofreal(r(mean), "%04.3f")
		local s`i' = "[" + strofreal(r(sd), "%04.3f") + "]"
	}
	qui reg `var' flag_freelance [aw=R_SHUKEI], robust
	local md = strofreal(_b[flag_freelance], "%04.3f")
	local sd = "(" + strofreal(_se[flag_freelance], "%04.3f") + ")"
	file write `hh' "`lbl' & `m1' & `m0' & `md' \\" _newline
	file write `hh' "& `s1' & `s0' & `sd' \\" _newline
}
file write `hh' "観測数 & `n1' & `n0' \\" _newline

tempname hh
file open `hh' using "${path_table}/pj3_6/continue_freelance.tex", write replace

foreach var of varlist v2_* {
	local lbl: variable label `var'
	foreach i in 1 0 {
		qui sum `var' [aw=R_SHUKEI] if flag_freelance == `i'
		local m`i' = strofreal(r(mean), "%04.3f")
		local s`i' = "[" + strofreal(r(sd), "%04.3f") + "]"
	}
	qui reg `var' flag_freelance [aw=R_SHUKEI], robust
	local md = strofreal(_b[flag_freelance], "%04.3f")
	local sd = "(" + strofreal(_se[flag_freelance], "%04.3f") + ")"
	file write `hh' "`lbl' & `m1' & `m0' & `md' \\" _newline
	file write `hh' "& `s1' & `s0' & `sd' \\" _newline
}
file write `hh' "観測数 & `n1' & `n0' \\" _newline

log close `fn'
