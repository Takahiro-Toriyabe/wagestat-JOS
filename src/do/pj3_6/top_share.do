local fn "top_share"
take_log `fn', path("${path_log}/pj3_6")

// BSWS
use "${path_data}/WageCensus/dta/Kojin/data_cleaned.dta", clear

gen earnings = Genkin + Tokubetsu / 12
drop if missing(earnings)

sort Nen
capture matrix drop BSWS0

forvalues y = 1989(1)2017 {
	sum earnings [aw=${weight_wc_k}] if Nen == `y', meanonly
	local total = r(sum)
	_pctile earnings [aw=${weight_wc_k}] if Nen == `y', percentiles(99 99.5 99.9)
	matrix SHARE = r(r1) \ r(r2) \ r(r3)
	forvalues i = 1(1)3 {
		sum earnings [aw=${weight_wc_k}] if Nen == `y' & earnings >= SHARE[`i', 1], meanonly
		local s`i' = 100 * r(sum) / `total'
	}
	matrix BSWS0 = nullmat(BSWS0) \ `y', `s1', `s2', `s3', 0
}

matlist BSWS0, format("%04.3f")

// BSWS by gender
foreach g in 1 2 {
	use "${path_data}/WageCensus/dta/Kojin/data_cleaned.dta", clear

	keep if Sei == `g'
	gen earnings = Genkin + Tokubetsu / 12
	drop if missing(earnings)

	sort Nen
	capture matrix drop BSWS`g'

	forvalues y = 1989(1)2017 {
		sum earnings [aw=${weight_wc_k}] if Nen == `y', meanonly
		local total = r(sum)
		_pctile earnings [aw=${weight_wc_k}] if Nen == `y', percentiles(99 99.5 99.9)
		matrix SHARE = r(r1) \ r(r2) \ r(r3)
		forvalues i = 1(1)3 {
			sum earnings [aw=${weight_wc_k}] if Nen == `y' & earnings >= SHARE[`i', 1], meanonly
			local s`i' = 100 * r(sum) / `total'
		}
		matrix BSWS`g' = nullmat(BSWS`g') \ `y', `s1', `s2', `s3', `g'
	}

	matlist BSWS`g', format("%04.3f")
}

// SSPS
use "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", clear

gen earnings = KYUYOGAKU_KEI
drop if missing(earnings)

sort year
capture matrix drop SSPS

forvalues y = 2012(1)2019 {
	sum earnings [aw=${weight_minkyu_k}] if year == `y', meanonly
	local total = r(sum)
	_pctile earnings [aw=${weight_minkyu_k}] if year == `y', percentiles(99 99.5 99.9)
	matrix SHARE = r(r1) \ r(r2) \ r(r3)
	forvalues i = 1(1)3 {
		sum earnings [aw=${weight_minkyu_k}] if year == `y' & earnings >= SHARE[`i', 1], meanonly
		local s`i' = 100 * r(sum) / `total'
	}
	matrix SSPS0 = nullmat(SSPS0) \ `y', `s1', `s2', `s3', 3
}

matlist SSPS0, format("%04.3f")

// SSPS by gender
foreach g in 1 2 {
	use "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", clear
	keep if SEIBETU == `g'
	
	gen earnings = KYUYOGAKU_KEI
	drop if missing(earnings)

	sort year
	capture matrix drop SSPS

	forvalues y = 2012(1)2019 {
		sum earnings [aw=${weight_minkyu_k}] if year == `y', meanonly
		local total = r(sum)
		_pctile earnings [aw=${weight_minkyu_k}] if year == `y', percentiles(99 99.5 99.9)
		matrix SHARE = r(r1) \ r(r2) \ r(r3)
		forvalues i = 1(1)3 {
			sum earnings [aw=${weight_minkyu_k}] if year == `y' & earnings >= SHARE[`i', 1], meanonly
			local s`i' = 100 * r(sum) / `total'
		}
		matrix SSPS`g' = nullmat(SSPS`g') \ `y', `s1', `s2', `s3', 3 + `g'
	}
	matlist SSPS`g'
}

// Visualize result
clear
matrix DATA = BSWS0 \ BSWS1 \ BSWS2 \ SSPS0 \ SSPS1 \ SSPS2
svmat DATA

rename DATA1 year
rename DATA2 share99
rename DATA3 share99_5
rename DATA4 share99_9
rename DATA5 dcat

save "${path_data}/top_share.dta", replace

twoway (connect share99 year if dcat == 0 & year < 2005, sort lp(l) color(gs6) ms(O) msize(*1.4) lw(*1.4)) ///
	(connect share99 year if dcat == 1 & year < 2005, sort lp(l) color(sky) ms(T) msize(*1.4) lw(*1.4)) ///
	(connect share99 year if dcat == 2 & year < 2005, sort lp(l) color(reddish) ms(D) msize(*1.4) lw(*1.4)) ///
	(connect share99 year if dcat == 3, sort lp(shortdash) color(gs6) ms(Oh) msize(*1.4) lw(*1.4)) ///
	(connect share99 year if dcat == 4, sort lp(shortdash) color(sky) ms(Th) msize(*1.4) lw(*1.4)) ///
	(connect share99 year if dcat == 5, sort lp(shortdash) color(reddish) ms(Dh) msize(*1.4) lw(*1.4)) ///
	(connect share99 year if dcat == 0 & year >= 2005, sort lp(l) color(gs6) ms(O) msize(*1.4) lw(*1.4)) ///
	(connect share99 year if dcat == 1 & year >= 2005, sort lp(l) color(sky) ms(T) msize(*1.4) lw(*1.4)) ///
	(connect share99 year if dcat == 2 & year >= 2005, sort lp(l) color(reddish) ms(D) msize(*1.4) lw(*1.4)), ///
	ytitle("Share (%)") ylabel(0(1)8, format("%01.0f")) ///
	xtitle("") xlabel(1990(5)2020.5, nogrid) ///
	legend(order(1 "BSWS (All)" 2 "BSWS (Male)" 3 "BSWS (Female)" 4 "SSPS (All)" 5 "SSPS (Male)" 6 "SSPS (Female)") ///
		col(3) ring(0) pos(5) region(lw(*0.8) lc(gs10)))
export_graph top_share99, path("${path_figure}/pj3_6")
		
twoway (connect share99_5 year if dcat == 0 & year < 2005, sort lp(l) color(gs6) ms(O) msize(*1.4) lw(*1.4)) ///
	(connect share99_5 year if dcat == 1 & year < 2005, sort lp(l) color(sky) ms(T) msize(*1.4) lw(*1.4)) ///
	(connect share99_5 year if dcat == 2 & year < 2005, sort lp(l) color(reddish) ms(D) msize(*1.4) lw(*1.4)) ///
	(connect share99_5 year if dcat == 3, sort lp(shortdash) color(gs6) ms(Oh) msize(*1.4) lw(*1.4)) ///
	(connect share99_5 year if dcat == 4, sort lp(shortdash) color(sky) ms(Th) msize(*1.4) lw(*1.4)) ///
	(connect share99_5 year if dcat == 5, sort lp(shortdash) color(reddish) ms(Dh) msize(*1.4) lw(*1.4)) ///
	(connect share99_5 year if dcat == 0 & year >= 2005, sort lp(l) color(gs6) ms(O) msize(*1.4) lw(*1.4)) ///
	(connect share99_5 year if dcat == 1 & year >= 2005, sort lp(l) color(sky) ms(T) msize(*1.4) lw(*1.4)) ///
	(connect share99_5 year if dcat == 2 & year >= 2005, sort lp(l) color(reddish) ms(D) msize(*1.4) lw(*1.4)), ///
	ytitle("Share (%)") ylabel(0(1)8, format("%01.0f")) ///
	xtitle("") xlabel(1990(5)2020.5, nogrid) ///
	legend(order(1 "BSWS (All)" 2 "BSWS (Male)" 3 "BSWS (Female)" 4 "SSPS (All)" 5 "SSPS (Male)" 6 "SSPS (Female)") ///
		col(3) ring(0) pos(5) region(lw(*0.8) lc(gs10)))
export_graph top_share99_5, path("${path_figure}/pj3_6")
		
twoway (connect share99_9 year if dcat == 0 & year < 2005, sort lp(l) color(gs6) ms(O) msize(*1.4) lw(*1.4)) ///
	(connect share99_9 year if dcat == 1 & year < 2005, sort lp(l) color(sky) ms(T) msize(*1.4) lw(*1.4)) ///
	(connect share99_9 year if dcat == 2 & year < 2005, sort lp(l) color(reddish) ms(D) msize(*1.4) lw(*1.4)) ///
	(connect share99_9 year if dcat == 3, sort lp(shortdash) color(gs6) ms(Oh) msize(*1.4) lw(*1.4)) ///
	(connect share99_9 year if dcat == 4, sort lp(shortdash) color(sky) ms(Th) msize(*1.4) lw(*1.4)) ///
	(connect share99_9 year if dcat == 5, sort lp(shortdash) color(reddish) ms(Dh) msize(*1.4) lw(*1.4)) ///
	(connect share99_9 year if dcat == 0 & year >= 2005, sort lp(l) color(gs6) ms(O) msize(*1.4) lw(*1.4)) ///
	(connect share99_9 year if dcat == 1 & year >= 2005, sort lp(l) color(sky) ms(T) msize(*1.4) lw(*1.4)) ///
	(connect share99_9 year if dcat == 2 & year >= 2005, sort lp(l) color(reddish) ms(D) msize(*1.4) lw(*1.4)), ///
	ytitle("Share (%)") ylabel(0(1)8, format("%01.0f")) ///
	xtitle("") xlabel(1990(5)2020.5, nogrid) ///
	legend(order(1 "BSWS (All)" 2 "BSWS (Male)" 3 "BSWS (Female)" 4 "SSPS (All)" 5 "SSPS (Male)" 6 "SSPS (Female)") ///
		col(3) ring(0) pos(1) region(lw(*0.8) lc(gs10)))
export_graph top_share99_9, path("${path_figure}/pj3_6")

twoway (connect share99 year if dcat == 0 & year < 2005, sort lp(l) color(gs6) ms(O) msize(*1.4) lw(*1.4)) ///
	(connect share99_9 year if dcat == 0 & year < 2005, sort lp(l) color(gs6) ms(T) msize(*1.4) lw(*1.4)) ///
	(connect share99 year if dcat == 3, sort lp(shortdash) color(gs6) ms(Oh) msize(*1.4) lw(*1.4)) ///
	(connect share99_9 year if dcat == 3, sort lp(shortdash) color(gs6) ms(Th) msize(*1.4) lw(*1.4)) ///
	(connect share99 year if dcat == 0 & year >= 2005, sort lp(l) color(gs6) ms(O) msize(*1.4) lw(*1.4)) ///
	(connect share99_9 year if dcat == 0 & year >= 2005, sort lp(l) color(gs6) ms(T) msize(*1.4) lw(*1.4)), ///
	ytitle("Share (%)") ylabel(0(1)8, format("%01.0f")) ///
	xtitle("") xlabel(1990(5)2020.5, nogrid) ///
	legend(order(1 "BSWS: Top 1%" 2 "BSWS: Top 0.1%" 3 "SSPS: Top 1%" 4 "SSPS: Top 0.1%") ///
		col(2) ring(0) pos(1) region(lw(*0.8) lc(gs10)))
export_graph top_share, path("${path_figure}/pj3_6")

log close `fn'
