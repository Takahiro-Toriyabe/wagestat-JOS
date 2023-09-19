local fn "analyze_small_est_minkyu"
take_log `fn', path("${path_log}/pj3_6")

use "${path_chosa_minkyu_gensen}/minkyu_gensen.dta", clear
gen flag_small = JININ12 <= 12 if !missing(JININ12)
keep year id_minkyu ${weight_minkyu_j} flag_small GYOSYU_BUNRUI

tab flag_small [aw=${weight_minkyu_j}]

merge 1:m id_minkyu year using "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", ///
	keep(3) nogen
	
merge m:1 year using "${path_data}/cpi.dta", ///
	assert(2 3) nogen keep(3)
	
tab flag_small [aw=${weight_minkyu_k}]

gen female = SEIBETU == 2 if !missing(SEIBETU)
gen earnings = KYUYO_TEATE / 1000 /cpi
gen bonus = SYOYO / 1000 / cpi
gen earnings_tot = earnings + bonus

label variable flag_small "従業員数4人以下事業所"
label variable female "Female"
label variable NENREI "Age"
label variable KINZOKU_NEN "Tenure"
label variable earnings "Salary excl. bonus"
label variable bonus "Bonus"
label variable earnings_tot "Total salary"

tempname hh
file open `hh' using "${path_table}/pj3_6/small_est_minkyu.tex", ///
	write replace

foreach var in female NENREI KINZOKU_NEN earnings bonus earnings_tot {
	foreach i in 0 1 {
		qui sum `var' [aw=${weight_minkyu_k}] if flag_small == `i'
		local m`var'`i' = strofreal(r(mean), "%04.3f")
		local sd`var'`i' = strofreal(r(sd), "%04.3f")
	}
	qui reg `var' flag_small [aw=${weight_minkyu_k}], cluster(id_minkyu)
	local db`var' = strofreal(_b[flag_small], "%04.3f")
	local dse`var' = strofreal(_se[flag_small], "%04.3f")
	
	file write `hh' "`: variable label `var'' & `m`var'1' & `m`var'0' & `db`var'' \\" _newline
	file write `hh' "& [`sd`var'1'] & [`sd`var'0'] & (`dse`var'') \\" _newline
}

foreach i in 0 1 {
	qui count if flag_small == `i'
	local n`i' = r(N)
}

file write `hh' "Observations & `n1' & `n0' & \\" _newline
file close `hh'

// Regression analysis
local cnt = 1
foreach var in earnings earnings_tot {
	capture gen ln`var' = ln(`var')
	reg ln`var' flag_small [aw=${weight_minkyu_k}] ///
		 if earnings != 0, cluster(id_minkyu)
	local b`cnt' = strofreal(_b[flag_small], "%04.3f")
	local se`cnt' = strofreal(_se[flag_small], "%04.3f")
	local n`cnt++' = e(N)

	eststo: reg ln`var' flag_small female NENREI KINZOKU_NEN ///
		[aw=${weight_minkyu_k}] if earnings != 0, cluster(id_minkyu)
	local b`cnt' = strofreal(_b[flag_small], "%04.3f")
	local se`cnt' = strofreal(_se[flag_small], "%04.3f")
	local n`cnt++' = e(N)
}
count if e(sample)
local n

tempname hh
file open `hh' using "${path_table}/pj3_6/small_est_reg_minkyu.tex", ///
	write replace

file write `hh' "`:variable label flag_small' & `b1' & `b2' & `b3' & `b4' \\" _newline
file write `hh' "& (`se1') & (`se2') & (`se3') & (`se4') \\" _newline
file write `hh' "\midrule" _newline
file write `hh' "Controls & & X & & X \\" _newline
file write `hh' "Observations & `n1' & `n2' & `n3' & `n4' \\" _newline

file close `hh'

log close `fn'
