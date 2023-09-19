local fn "top_income"
take_log `fn', path("${path_log}/pj3_6")

use "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", clear
merge m:1 year using "${path_root}/data/cpi.dta", ///
	assert(2 3) nogen keep(3)

egen cluster_var = group(KYOKUSYO SEIRI)

// Earnings: Unit: 1 million JPY
gen y = KYUYOGAKU_KEI / 1000 / cpi
bysort year: cumul y [aw=${weight_minkyu_k}], gen(Fy)

gen lny = ln(y)
gen lnx = ln(1 / (1 - Fy))

matrix B = J(31, 6, .)
matrix SE = J(31, 6, .)

local cutoff = 9

local cnt = 24
forvalues y = 2012(1)2019 {	
	reg lny lnx [aw=${weight_minkyu_k}] if y >= `cutoff' & year == `y', ///
		cluster(cluster_var)
	nlcom 1 / _b[lnx], post

	matrix B[`cnt', 4] = _b[_nl_1]
	matrix SE[`cnt', 4] = _se[_nl_1]
	
	local `cnt++'
}

local cnt = 22
forvalues y = 2012(1)2019 {
	forvalues g = 1(1)2 {		
		reg lny lnx [aw=${weight_minkyu_k}] ///
			if y >= `cutoff' & year == `y' & SEIBETU == `g', ///
			cluster(cluster_var)
		nlcom 1 / _b[lnx], post

		matrix B[`cnt', 4 + `g'] = _b[_nl_1]
		matrix SE[`cnt', 4 + `g'] = _se[_nl_1]
	}
	local `cnt++'
}

// Statistical test
matrix STAT_TEST_b = J(6, 4, .)
matrix STAT_TEST_se = J(6, 4, .)

reg lny ib2012.year#c.lnx i.year [aw=${weight_minkyu_k}] if y >= `cutoff', ///
	cluster(cluster_var)
nlcom (a2012: 1 / _b[2012.year#c.lnx]) ///
	(a2013: 1 / _b[2013.year#c.lnx]) ///
	(a2014: 1 / _b[2014.year#c.lnx]) ///
	(a2015: 1 / _b[2015.year#c.lnx]) ///
	(a2016: 1 / _b[2016.year#c.lnx]) ///
	(a2017: 1 / _b[2017.year#c.lnx]) ///
	(a2018: 1 / _b[2018.year#c.lnx]) ///
	(a2019: 1 / _b[2019.year#c.lnx]), post

forvalues i = 1(1)6 {
	local y = 2011 + `i'
	foreach tag in _b _se {
		matrix STAT_TEST`tag'[`i', 1] = `tag'[a`y']
	}
}

nlcom (d2013: 100 * (_b[a2013] / _b[a2012] - 1)) ///
	(d2014: 100 * (_b[a2014] / _b[a2013] - 1)) ///
	(d2015: 100 * (_b[a2015] / _b[a2014] - 1)) ///
	(d2016: 100 * (_b[a2016] / _b[a2015] - 1)) ///
	(d2017: 100 * (_b[a2017] / _b[a2016] - 1)) ///
	(d2018: 100 * (_b[a2018] / _b[a2017] - 1)) ///
	(d2019: 100 * (_b[a2019] / _b[a2018] - 1)), post

forvalues i = 2(1)6 {
	local y = 2011 + `i'
	foreach tag in _b _se {
		matrix STAT_TEST`tag'[`i', 2] = `tag'[d`y']
	}
}

// Wage Census
use "${path_data}/WageCensus/dta/Kojin/data_cleaned.dta", clear

rename Nen year
merge m:1 year using "${path_root}/data/cpi.dta", ///
	assert(2 3) nogen keep(3)

egen cluster_var = group(year Ken JigyoRen City Chosaku JigyoBan Jigyousho), missing

// Unit: 1 million JPY
gen earnings = (12 * Genkin + Tokubetsu) / 1000000 / cpi
bysort year: cumul earnings [aw=${weight_wc_k}], gen(Fy)
gen lny = ln(earnings)
gen lnx = ln(1 / (1 - Fy))

keep if earnings >= `cutoff'

local cnt = 1
forvalues y = 1989(1)2017 {
	reg lny lnx [aw=${weight_wc_k}] if year == `y', cluster(cluster_var)
	nlcom 1 / _b[lnx], post

	matrix B[`cnt', 1] = _b[_nl_1]
	matrix SE[`cnt', 1] = _se[_nl_1]

	local `cnt++'
}

local cnt = 1
forvalues y = 1989(1)2017 {
	forvalues g = 1(1)2 {
		reg lny lnx [aw=${weight_wc_k}] if year == `y' & Sei == `g', cluster(cluster_var)
		nlcom 1 / _b[lnx], post

		matrix B[`cnt', 1 + `g'] = _b[_nl_1]
		matrix SE[`cnt', 1 + `g'] = _se[_nl_1]
	}
	local `cnt++'
}

matlist B
matlist SE

tempname hh
file open `hh' using "${path_table}/pj3_6/top_income.tex", write replace
forvalues i = 1(1)29 {
	forvalues j = 1(1)6 {
		local b`j' = strofreal(B[`i', `j'], "%04.3f")
		local se`j' = strofreal(SE[`i', `j'], "%04.3f")
	}
	local y = 1988 + `i'
	file write `hh' "`y' & `b1' & `b2' & `b3' & `b4' & `b5' & `b6' \\" _newline
	file write `hh' "& (`se1') & (`se2') & (`se3') & (`se4') & (`se5') & (`se6') \\" _newline
}

file close `hh'

// Statistical test
reg lny ib2012.year#c.lnx i.year [aw=${weight_wc_k}] if y >= `cutoff' & year >= 2012, ///
	cluster(cluster_var)
nlcom (a2012: 1 / _b[2012.year#c.lnx]) ///
	(a2013: 1 / _b[2013.year#c.lnx]) ///
	(a2014: 1 / _b[2014.year#c.lnx]) ///
	(a2015: 1 / _b[2015.year#c.lnx]) ///
	(a2016: 1 / _b[2016.year#c.lnx]) ///
	(a2017: 1 / _b[2017.year#c.lnx]), post

forvalues i = 1(1)6 {
	local y = 2011 + `i'
	foreach tag in _b _se {
		matrix STAT_TEST`tag'[`i', 3] = `tag'[a`y']
	}
}

nlcom (d2013: 100 * (_b[a2013] / _b[a2012] - 1)) ///
	(d2014: 100 * (_b[a2014] / _b[a2013] - 1)) ///
	(d2015: 100 * (_b[a2015] / _b[a2014] - 1)) ///
	(d2016: 100 * (_b[a2016] / _b[a2015] - 1)) ///
	(d2017: 100 * (_b[a2017] / _b[a2016] - 1)), post

forvalues i = 2(1)6 {
	local y = 2011 + `i'
	foreach tag in _b _se {
		matrix STAT_TEST`tag'[`i', 4] = `tag'[d`y']
	}
}

tempname hh
file open `hh' using "${path_table}/pj3_6/top_income_stat_test.tex", write replace
forvalues i = 1(1)6 {
	local b_ssps = strofreal(STAT_TEST_b[`i', 1], "%04.3f")
	local se_ssps = "(" + strofreal(STAT_TEST_se[`i', 1], "%04.3f") + ")"
	local b_bsws = strofreal(STAT_TEST_b[`i', 3], "%04.3f")
	local se_bsws = "(" + strofreal(STAT_TEST_se[`i', 3], "%04.3f") + ")"
	
	if `i' > 1 {
		local d_b_ssps = strofreal(STAT_TEST_b[`i', 2], "%04.3f")
		local d_se_ssps = "(" + strofreal(STAT_TEST_se[`i', 2], "%04.3f") + ")"
		local d_b_bsws = strofreal(STAT_TEST_b[`i', 4], "%04.3f")
		local d_se_bsws = "(" + strofreal(STAT_TEST_se[`i', 4], "%04.3f") + ")"
		
		local dd_b = strofreal(STAT_TEST_b[`i', 4] - STAT_TEST_b[`i', 2], "%04.3f")
		local dd_se = "(" + strofreal(sqrt(STAT_TEST_se[`i', 2]^2 + STAT_TEST_se[`i', 4]^2), "%04.3f") + ")"
		
		local t`i' = abs(STAT_TEST_b[`i', 4] - STAT_TEST_b[`i', 2]) / sqrt(STAT_TEST_se[`i', 2]^2 + STAT_TEST_se[`i', 4]^2)
	}
	
	local y = 2011 + `i'
	file write `hh' "`y' & `b_bsws' & `d_b_bsws' & `b_ssps' & `d_b_ssps' & `dd_b' \\" _newline
	file write `hh' "& `se_bsws' & `d_se_bsws' & `se_ssps' & `d_se_ssps' & `dd_se' \\" _newline
}

file close `hh'

forvalues i = 2(1)6 {
	di %04.3f (`t`i''), %1.0f (`t`i'' > invnormal(0.975)), %1.0f (`t`i'' > invnormal(0.95))
}

// Visualize the result
clear
svmat B
svmat SE

gen t = _n + 1988

twoway (connect B1 t, color(gs6) ms(O) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect B2 t, color(sky) ms(T) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect B3 t, color(reddish) ms(S) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect B4 t, color(gs6) ms(Oh) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	(connect B5 t, color(sky) ms(Th) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	(connect B6 t, color(reddish) ms(Sh) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	if t >= 2012, ///
	ytitle("Pareto coefficient") ylabel(2(0.5)5, format("%02.1f")) ///
	xtitle("") xlabel(2012(1)2019.2, nogrid) ///
	legend(order(1 "BSWS: All" 2 "BSWS: Male" 3 "BSWS: Female" ////
		4 "SSPS: All" 5 "SSPS: Male" 6 "SSPS: Female") ///
		ring(0) pos(5) region(lw(*0.8) lc(gs10)) col(3))
export_graph pareto_coef, path("${path_figure}/pj3_6")


gen d1 = B3 / B2
gen d2 = B6 / B5

twoway (connect d1 t, color(gs6) ms(O) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect d2 t, color(gs6) ms(Oh) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	if t >= 2012, ///
	ytitle("Male-female ratio of Pareto coefficient") ylabel(0.98(0.005)1.02, format("%04.3f")) ///
	xtitle("") xlabel(2012(1)2019.2, nogrid) ///
	legend(order(1 "BSWS" 2 "SSPS") ///
		ring(0) pos(5) region(lw(*0.8) lc(gs10)) col(1))
export_graph pareto_coef_diff, path("${path_figure}/pj3_6")

// All years
twoway (connect B1 t if t < 2005, color(gs6) ms(O) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect B2 t if t < 2005, color(sky) ms(T) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect B3 t if t < 2005, color(reddish) ms(S) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect B4 t, color(gs6) ms(Oh) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	(connect B5 t, color(sky) ms(Th) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	(connect B6 t, color(reddish) ms(Sh) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	(connect B1 t if t >= 2005, color(gs6) ms(O) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect B2 t if t >= 2005, color(sky) ms(T) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect B3 t if t >= 2005, color(reddish) ms(S) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect B4 t, color(gs6) ms(Oh) lp(shortdash) msize(*1.4) lw(*1.4)), ///
	ytitle("Pareto coefficient") ylabel(2(0.5)6, format("%02.1f")) ///
	xtitle("") xlabel(1990(5)2020.2, nogrid) ///
	legend(order(1 "BSWS: All" 2 "BSWS: Male" 3 "BSWS: Female" ////
		4 "SSPS: All" 5 "SSPS: Male" 6 "SSPS: Female") ///
		ring(0) pos(5) region(lw(*0.8) lc(gs10)) col(3))
export_graph pareto_coef_long, path("${path_figure}/pj3_6")

twoway (connect d1 t if t < 2005, color(gs6) ms(O) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect d2 t, color(gs6) ms(Oh) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	(connect d1 t if t >= 2005, color(gs6) ms(O) lp(l) msize(*1.4) lw(*1.4)), ///
	ytitle("Male-female ratio of Pareto coefficient") ylabel(0.95(0.01)1.05, format("%03.2f")) ///
	xtitle("") xlabel(1990(5)2020.2, nogrid) ///
	legend(order(1 "BSWS" 2 "SSPS") ring(0) pos(5) region(lw(*0.8) lc(gs10)) col(1))
export_graph pareto_coef_diff_long, path("${path_figure}/pj3_6")

save "${path_data}/pareto_coef.dta", replace

log close `fn'
