import excel "D:/Downloads/jikei_04.xlsx", sheet("４表") cellrange(F10:S27) clear

rename F year
rename H n_tot_tmp
rename I n_self
rename L n_self_we
rename M n_self_weo
rename N n_other
rename O n_fam
rename R n_emp

gen n_tot = n_self + n_fam + n_emp

keep if inrange(year, 1977, 2017)
keep year n_*
destring n_*, replace

gen frac_self = (n_self_we + n_self_weo) / n_tot_tmp
gen frac_self_we = n_self_we / n_tot_tmp
gen frac_self_woe = n_self_weo / n_tot_tmp
gen composition_self_woe = frac_self_woe / (frac_self_we + frac_self_woe)

twoway (connect frac_self year, color(gs3) lp(l) lw(*1.4) ms(Oh) msize(*1.4) mlw(*1.2)) ///
	(connect frac_self_we year, color(gs6) lp("-##") lw(*1.4) ms(Th) msize(*1.4) mlw(*1.2)) ///
	(connect frac_self_woe year, color(gs9) lp(shortdash) lw(*1.4) ms(Dh) msize(*1.4) mlw(*1.2)) ///
	if mod(year - 1977, 5) == 0, ///
	ytitle("Fraction") ylabel(0(0.02)0.2, format("%03.2f")) ///
	xtitle("Year") xlabel(1977(5)2017.5, nogrid) ///
	legend(order(1 "Self-employed" 2 "Self-employed with employees" ///
		3 "Self-employed without employees") pos(1) ring(0) region(lw(*0.1) lc(gs10))) ///
	scheme(tt_mono)
export_graph frac_selfemp, path("${path_figure}/pj3_6")

twoway (connect composition_self_woe year, color(gs3) lp(l) lw(*1.4) ms(Oh) msize(*1.4) mlw(*1.2)) ///
	if mod(year - 1977, 5) == 0, ///
	ytitle("Fraction") ylabel(0(0.1)1, format("%02.1f")) ///
	xtitle("Year") xlabel(1977(5)2017.5, nogrid) ///
	legend(off) ///
	scheme(tt_mono)
export_graph composition_selfemp, path("${path_figure}/pj3_6")
