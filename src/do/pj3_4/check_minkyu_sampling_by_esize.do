use "${path_meibo_minkyu}/minkyu_meibo.dta", clear

// Grouping establishment size
gen esize = estsize
label define esize 1 "Headquarters" 2 "5000+" 3 "1000--4999" 4 "500--999" 5 "100--499" ///
	6 "30--99" 7 "10--29" 8 "1--9"
label values esize esize

keep year KYOKUSYO SEIRI esize
merge 1:1 KYOKUSYO SEIRI year ///
	using "${path_chosa_minkyu_gensen}/minkyu_gensen.dta", ///
	assert(1 3) keep(3)
keep id_minkyu year esize

tempfile esize
save `esize', replace

// Main part
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

// Merge establishment size data
merge m:1 id_minkyu year using `esize', assert(3) keep(3) nogen

// Check difference in mean earnings
qui levelsof esize, local(elist)
foreach i in `elist' {
	foreach j in 0 1 {
		sum yearly_earnings [aw=${weight_minkyu_j}] ///
			if esize == `i' & flag_kojin == `j' & flag_nonoutlier == 1
		local mean`i'`j' = strofreal(r(mean), "%04.3f")
		local sd`i'`j' = "[" + strofreal(r(sd), "%04.3f") + "]"
	}
	reg yearly_earnings flag_kojin [aw=${weight_minkyu_j}] ///
		if esize == `i' & flag_nonoutlier == 1, cluster(id_minkyu)
	local d`i' = strofreal(_b[flag_kojin], "%04.3f")
	local pd`i' = strofreal(100 * _b[flag_kojin] / _b[_cons], "%04.3f")
	local se`i' = "(" + strofreal(_se[flag_kojin], "%04.3f") + ")"
	local n`i' = e(N)
}

// Export the results
tempname hh
file open `hh' using "${path_table}/pj3_4/check_minkyu_sampling_by_esize.tex", ///
	write replace

foreach i in `elist' {
	file write `hh' "`:label esize `i'' & `mean`i'1' & `mean`i'0' & `d`i'' & `pd`i'' & `n`i'' \\" _newline
	file write `hh' "& `sd`i'1' & `sd`i'0' & `se`i'' & & \\" _newline
}

file close `hh'

cat "${path_table}/pj3_4/check_minkyu_sampling_by_esize.tex"
