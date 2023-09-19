local fn "inequality"
take_log `fn', path("${path_log}/pj3_6")

// Wage Census
use "${path_data}/WageCensus/dta/Kojin/data_cleaned.dta", clear
gen year = Nen
gen earnings = Genkin + Tokubetsu / 12
gen wage = earnings / (SyoteiJikan + ChokaJikan)

foreach p in 10 50 90 {
	gen earnings`p' = earnings
	gen wage`p' = wage
}

keep earnings* wage* year ${weight_wc_k}
gcollapse (p10) earnings10 wage10 (p50) earnings50 wage50 ///
	(p90) earnings90 wage90 [aw=${weight_wc_k}], by(year)
	
gen eratio_l = earnings10 / earnings50
gen eratio_u = earnings90 / earnings50

gen wratio_l = wage10 / wage50
gen wratio_u = wage90 / wage50

tempfile bsws0
save `bsws0', replace

// Wage Census by gender
use "${path_data}/WageCensus/dta/Kojin/data_cleaned.dta", clear
gen year = Nen
gen earnings = Genkin + Tokubetsu / 12
gen wage = earnings / (SyoteiJikan + ChokaJikan)
gen female = Sei == 2 if !missing(Sei)

foreach p in 10 50 90 {
	gen earnings`p' = earnings
	gen wage`p' = wage
}

keep if !missing(female)
keep earnings* wage* year female ${weight_wc_k}

gcollapse (p10) earnings10 wage10 (p50) earnings50 wage50 ///
	(p90) earnings90 wage90 [aw=${weight_wc_k}], by(year female)
	
gen eratio_l = earnings10 / earnings50
gen eratio_u = earnings90 / earnings50

gen wratio_l = wage10 / wage50
gen wratio_u = wage90 / wage50

tempfile bsws1
save `bsws1', replace

// SSPS
use "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", clear

foreach p in 10 50 90 {
	gen earnings`p' = KYUYOGAKU_KEI
}

gcollapse (p10) earnings10 (p50) earnings50 (p90) earnings90 ///
	[aw=${weight_minkyu_k}], by(year)
gen eratio_l = earnings10 / earnings50
gen eratio_u = earnings90 / earnings50

tempfile ssps0
save `ssps0', replace

// SSPS by gender
use "${path_chosa_minkyu_kyuyo}/minkyu_kyuyo.dta", clear

gen female = SEIBETU == 2 if !missing(SEIBETU)
foreach p in 10 50 90 {
	gen earnings`p' = KYUYOGAKU_KEI
}

keep if !missing(SEIBETU)
gcollapse (p10) earnings10 (p50) earnings50 (p90) earnings90 ///
	[aw=${weight_minkyu_k}], by(year female)
gen eratio_l = earnings10 / earnings50
gen eratio_u = earnings90 / earnings50

tempfile ssps1
save `ssps1', replace

clear
append using `bsws0' `bsws1' `ssps0' `ssps1', gen(dcat)

twoway (connect eratio_u year if dcat == 1 & year < 2005, color(gs6) ms(O) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect eratio_u year if dcat == 2 & female == 0 & year < 2005, color(sky) ms(T) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect eratio_u year if dcat == 2 & female == 1 & year < 2005, color(reddish) ms(D) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect eratio_u year if dcat == 3, color(gs6) ms(Oh) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	(connect eratio_u year if dcat == 4 & female == 0, color(sky) ms(Th) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	(connect eratio_u year if dcat == 4 & female == 1, color(reddish) ms(Dh) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	(connect eratio_u year if dcat == 1 & year >= 2005, color(gs6) ms(O) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect eratio_u year if dcat == 2 & female == 0 & year >= 2005, color(sky) ms(T) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect eratio_u year if dcat == 2 & female == 1 & year >= 2005, color(reddish) ms(D) lp(l) msize(*1.4) lw(*1.4)), ///
	ytitle("90-50 ratio") ylabel(1.6(0.1)2.6, format("%02.1f")) ///
	xtitle("") xlabel(1990(5)2020.5, nogrid) ///
	legend(order(1 "BSWS (All)" 2 "BSWS (Male)" 3 "BSWS (Female)" 4 "SSPS (All)" 5 "SSPS (Male)" 6 "SSPS (Female)") ///
		col(3) ring(0) pos(5) region(lw(*0.8) lc(gs10)))
export_graph eratio90_50, path("${path_figure}/pj3_6")

twoway (connect eratio_l year if dcat == 1 & year < 2005, color(gs6) ms(O) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect eratio_l year if dcat == 2 & female == 0 & year < 2005, color(sky) ms(T) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect eratio_l year if dcat == 2 & female == 1 & year < 2005, color(reddish) ms(D) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect eratio_l year if dcat == 3, color(gs6) ms(Oh) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	(connect eratio_l year if dcat == 4 & female == 0, color(sky) ms(Th) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	(connect eratio_l year if dcat == 4 & female == 1, color(reddish) ms(Dh) lp(shortdash) msize(*1.4) lw(*1.4)) ///
	(connect eratio_l year if dcat == 1 & year >= 2005, color(gs6) ms(O) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect eratio_l year if dcat == 2 & female == 0 & year >= 2005, color(sky) ms(T) lp(l) msize(*1.4) lw(*1.4)) ///
	(connect eratio_l year if dcat == 2 & female == 1 & year >= 2005, color(reddish) ms(D) lp(l) msize(*1.4) lw(*1.4)), ///
	ytitle("10-50 ratio") ylabel(0(0.1)1, format("%02.1f")) ///
	xtitle("") xlabel(1990(5)2020.5, nogrid) ///
	legend(order(1 "BSWS (All)" 2 "BSWS (Male)" 3 "BSWS (Female)" 4 "SSPS (All)" 5 "SSPS (Male)" 6 "SSPS (Female)") ///
		col(3) ring(0) pos(5) region(lw(*0.8) lc(gs10)))
export_graph eratio10_50, path("${path_figure}/pj3_6")

foreach i in 1 3 {
	foreach tag in _u _l {
		tabstat eratio`tag' if dcat == `i', by(year) format("%04.3f")
		foreach j in 0 1 {
			tabstat eratio`tag' if dcat == `i' + 1 & female == `j', by(year) format("%04.3f")
		}
	}
}

log close `fn'
