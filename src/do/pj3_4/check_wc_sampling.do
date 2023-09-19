// Merge data sets
use "${path_data}/pj/pj3_4/chingin_tmp.dta", clear
merge m:1 id_common year ///
	using "${path_data}/pj/pj3_4/maikin_june_tmp.dta", keep(1 3)

gen flag_matched = _merge == 3
drop _merge

merge m:1 year using "${path_data}/cpi.dta", ///
	assert(2 3) nogen keep(3)

foreach var of varlist wage_* bonus_* {
	replace `var' = `var' / cpi
}

tab flag_matched
tab flag_matched if flag_large_est
tab flag_matched if flag_1stobs
tab flag_matched if flag_1stobs & flag_large_est

// Item list for comparison
sort id_common year Sei
local items nemp nday wh_shotei wh_over wh_tot wage bonus wage_tot

local xt_nemp "事業所規模の差：賃構 - 毎勤（人）"
local xt_nday "労働者一人当たり労働日数の差：賃構 - 毎勤（1日/月）"
local xt_wh_shotei "労働者一人当たり所定内労働時間の差：賃構 - 毎勤（1時間/月）"
local xt_wh_over "労働者一人当たり所定外労働時間の差：賃構 - 毎勤（1時間/月）"
local xt_wh_tot "労働者一人当たり総労働時間の差：賃構 - 毎勤（1時間/月）"
local xt_wage "労働者一人当たりきまって支給する現金給与額の差：賃構 - 毎勤（1万円/月）"
local xt_bonus "労働者一人当たり特別給与額の差：賃構 - 毎勤（1万円/月）"
local xt_wage_tot "労働者一人当たり総給与額の差：賃構 - 毎勤（1万円/月）"

local fmt "%03.2f"
foreach tag in _t _m _f {
	// Open file
	tempname hh
	file open `hh' using "${path_table}/pj3_4/meandiff`tag'.tex", ///
		write replace

	// Calculate mean and mean difference
	foreach item in `items' {
		// Mean value of Wage Census (All establishments)
		if "`item'" == "nemp" {
			local aw = "${weight_wc_j}"
		}
		else {
			local aw = "wt`tag'"
		}
		sum `item'`tag' [aw=`aw']
		local b0 = strofreal(r(mean), "`fmt'")
		local s0 = strofreal(r(sd), "`fmt'")
		
		// Mean value of Wage Census (Large establishments)
		sum `item'`tag' [aw=`aw'] if flag_large_est
		local b1 = strofreal(r(mean), "`fmt'")
		local s1 = strofreal(r(sd), "`fmt'")
		
		// Mean value of Wage Census (Matched establishments)
		sum `item'`tag' [aw=`aw'] ///
			if flag_large_est & flag_matched & !missing(`item'`tag'_maikin)
		local b2 = strofreal(r(mean), "`fmt'")
		local s2 = strofreal(r(sd), "`fmt'")

		// Mean value of Maikin (Use only 1st record and establishment weight)
		sum `item'`tag'_maikin [aw=${weight_wc_j}] ///
			if flag_large_est & flag_matched & flag_1stobs
		local b3 = strofreal(r(mean), "`fmt'")
		local s3 = strofreal(r(sd), "`fmt'")

		// Mean value of difference (Wage Census and Maikin)
		qui gen d_`item'`tag' = `item'`tag' - `item'`tag'_maikin
		mean d_`item'`tag' [aw=`aw'] ///
			if flag_large_est & flag_matched & !missing(`item'`tag'_maikin), ///
			cluster(id_common)
		local b4 = strofreal(_b[d_`item'`tag'], "`fmt'")
		local s4 = strofreal(_se[d_`item'`tag'], "`fmt'")
		
		// Visualize difference
		tempvar num den md md_capped
		by id_common year: egen `num' = total(`aw' * d_`item'`tag')
		by id_common year: egen `den' = total(`aw') if !missing(d_`item'`tag')
		gen `md' = `num' / `den' if flag_large_est & flag_matched & flag_1stobs

		qui sum `md' [aw=${weight_wc_j}], detail
		qui gen `md_capped' = max(min(`md', r(p99)), r(p1)) if !missing(`md')
		histogram `md_capped' [fw=${weight_wc_j}], ///
			fraction ///
			ytitle("割合") ylabel(, format("%03.2f")) ///
			xtitle("`xt_`item''")
		export_graph d_`item'`tag', path("${path_figure}/pj3_4")
		
		// Mean value of difference (Validation of analysis sample)
		eststo clear
		eststo est1: reg `item'`tag' [aw=`aw'] if flag_large_est
		eststo est2: reg `item'`tag' [aw=`aw'] if flag_large_est ///
			& flag_matched & !missing(`item'`tag'_maikin)
		suest est1 est2, vce(cluster id_common)
		test ([est2_mean]_b[_cons] = [est1_mean]_b[_cons])
		nlcom diff: [est2_mean]_b[_cons] - [est1_mean]_b[_cons], post
		local b5 = strofreal(_b[diff], "`fmt'")
		local s5 = strofreal(_se[diff], "`fmt'")


		// Export results
		local lbl: variable label `item'`tag'
		file write `hh' "`lbl' & `b0' & `b1' & `b2' & `b3' & `b4' & `b5' \\" _newline
		file write `hh' "& [`s0'] & [`s1'] & [`s2'] & [`s3'] & (`s4') & (`s5') \\" _newline
	}
	
	// Export number of establishments
	local idx_col = 0
	local cond "1 == 1"
	foreach cond_add in flag_1stobs flag_large_est flag_matched {
		local cond "`cond' & `cond_add'"
		qui count if `cond'
		local n`idx_col++' = r(N)
	}
	file write `hh' "Observations & `n0' & `n1' & `n2' & & & \\" _newline

	file close `hh'
}
