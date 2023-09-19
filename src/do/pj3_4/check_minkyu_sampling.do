use "${path_chosa_minkyu_gensen}/minkyu_gensen.dta", clear
egen emp_mean = rowmean(JININ3 JININ6 JININ9 JININ12)
gen yearly_earnings0 = KYUYO / emp_mean
keep year id_minkyu ${weight_minkyu_j} JININ12 GYOSYU_BUNRUI yearly_earnings0

tempfile tmp
save `tmp', replace

use "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", clear
collapse (mean) yearly_earnings1 = KYUYOGAKU_KEI ///
	[aw=${weight_minkyu_k}], by(id_minkyu year)

merge 1:1 id_minkyu year using `tmp'
keep if _merge == 3
drop _merge

reshape long yearly_earnings, i(id_minkyu year) j(flag_kojin)
egen id = group(id_minkyu year)

// Unit of earnings is 1 million JPY
merge m:1 year using "${path_root}/data/cpi.dta", ///
	assert(2 3) nogen keep(3)

replace yearly_earnings = yearly_earnings / 1000 / cpi

xtset id flag_kojin
gen diff = d.yearly_earnings if flag_kojin == 1

/* Some outliers in Jigyosho data as the number of employees in December
	may not by appropriate as the denominator if there is substantial
	seasonality in the number of employees
*/ 
sum yearly_earnings [aw=${weight_minkyu_j}] if flag_kojin == 1, detail
sum yearly_earnings [aw=${weight_minkyu_j}] if flag_kojin == 0, detail
sum diff [aw=${weight_minkyu_j}] if flag_kojin == 1, detail

gen flag_nonoutlier_sub = inrange(diff, r(p1), r(p99)) if flag_kojin == 1
by id: egen flag_nonoutlier = mean(flag_nonoutlier_sub)

// Visualize earnings distribution
gen wt_tmp = int(10000000 * ${weight_minkyu_j})
gen yearly_earnings_capped = min(yearly_earnings, 20)
twoway (histogram yearly_earnings_capped [fw=wt_tmp] if flag_kojin == 1, ///
		color(sky%50) fraction width(0.1)) ///
	(histogram yearly_earnings_capped [fw=wt_tmp] if flag_kojin == 0, ///
		color(reddish%50) fraction width(0.1)), ///
	ytitle("Fraction") ylabel(, format(%04.3f)) ///
	xtitle("Annual salaries per worker (1 million JPY)）") xlabel(0(2)20, nogrid) ///
	legend(order(1 "Worker questionnaire" 2 "Establishment questionnaire") ring(0) pos(2) ///
		region(lw(*0.5) lc(gs10)))
export_graph earning_dist_minkyu, path("${path_figure}/pj3_4")

qui sum diff [aw=${weight_minkyu_j}], detail
qui gen diff_capped = max(min(diff, `=r(p99)'), `=r(p1)')
twoway (histogram diff_capped [fw=wt_tmp] if flag_kojin == 1, fraction), ///
	ytitle("Fraction") ylabel(, format(%04.3f)) ///
	xtitle("Difference: Worker - Establishment（1 million JPY/year）") xlabel(, format(%02.1f) nogrid)
export_graph d_earnings_minkyu, path("${path_figure}/pj3_4")

// Reset xtset to avoid error in clustering bootstrap
xtset, clear

// Check difference in mean earnings
foreach i in 0 1 {
	sum yearly_earnings [aw=${weight_minkyu_j}] if flag_kojin == `i', detail
	foreach stat in mean sd p10 p25 p50 p75 p90 {
		local `stat'_`i' = strofreal(r(`stat'), "%04.3f")
	}
}

// Check difference in mean earnings (excluding outliers)
foreach i in 0 1 {
	sum yearly_earnings [aw=${weight_minkyu_j}] ///
		if flag_kojin == `i' & flag_nonoutlier == 1, detail
	foreach stat in mean sd p10 p25 p50 p75 p90 {
		local `stat'_`i'_nonout = strofreal(r(`stat'), "%04.3f")
	}
}

// Check difference in earnings distribution
foreach i in 1 { 
	reg yearly_earnings flag_kojin [aw=${weight_minkyu_j}] ///
		, cluster(id_minkyu)
	local d_bmean_`i' = strofreal(_b[flag_kojin], "%04.3f")
	local d_semean_`i' = strofreal(_se[flag_kojin], "%04.3f")

	bootstrap_pctile_diff yearly_earnings, ///
		percentiles(10 25 50 75 90) by(flag_kojin) wt(${weight_minkyu_j}) ///
		cluster(id_minkyu) reps(${bsreps}) seed(${seed})

	foreach p in p10 p25 p50 p75 p90 {
		local d_b`p'_`i' = strofreal(_b[`p'], "%04.3f")
		local d_se`p'_`i' = strofreal(_se[`p'], "%04.3f")
	}
}

// Check difference in earnings distribution (excluding outliers)
foreach i in 1 { 
	reg yearly_earnings flag_kojin [aw=${weight_minkyu_j}] ///
		if flag_nonoutlier == 1, cluster(id_minkyu)
	local d_bmean_`i'_nonout = strofreal(_b[flag_kojin], "%04.3f")
	local d_semean_`i'_nonout = strofreal(_se[flag_kojin], "%04.3f")

	bootstrap_pctile_diff yearly_earnings if flag_nonoutlier == 1, ///
		percentiles(10 25 50 75 90) by(flag_kojin) wt(${weight_minkyu_j}) ///
		cluster(id_minkyu) reps(${bsreps}) seed(${seed})

	foreach p in p10 p25 p50 p75 p90 {
		local d_b`p'_`i'_nonout = strofreal(_b[`p'], "%04.3f")
		local d_se`p'_`i'_nonout = strofreal(_se[`p'], "%04.3f")
	}
}

// Export the results
tempname hh
file open `hh' using "${path_table}/pj3_4/check_minkyu_sampling.tex", ///
	write replace

foreach stat in mean p10 p25 p50 p75 p90 {
	local sd0 = ("`stat'" == "mean") * "[`sd_0']"
	local sd1 = ("`stat'" == "mean") * "[`sd_1']"
	local sd0_nonout = ("`stat'" == "mean") * "[`sd_0_nonout']"
	local sd1_nonout = ("`stat'" == "mean") * "[`sd_1_nonout']"
	file write `hh' "`stat' & ``stat'_1' & ``stat'_0' & `d_b`stat'_1' "
	file write `hh' "& ``stat'_1_nonout' & ``stat'_0_nonout' & `d_b`stat'_1_nonout' \\" _newline
	file write  `hh' "& `sd1' & `sd0' & (`d_se`stat'_1') "
	file write  `hh' "& `sd1_nonout' & `sd0_nonout' & (`d_se`stat'_1_nonout') \\" _newline
}

count if flag_kojin == 1
local n_full = r(N)

count if flag_kojin == 1 & flag_nonoutlier == 1
local n_sub = r(N)

file write  `hh' "Observations & `n_full' & `n_full' & `n_full' & `n_sub' & `n_sub' & `n_sub' \\" _newline

file close `hh'


