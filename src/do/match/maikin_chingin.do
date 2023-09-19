// Wage Census
use "${path_chosa_chingin}/chingin.dta", clear
keep if inrange(year, 2015, 2017) & inrange(M_JigyoKibo, 0, 3)
keep year id_common

duplicates drop year id_common, force

tempfile wc_tmp
save `wc_tmp', replace

// Maikin chosa
use "${path_chosa_maikin}/maikin.dta", clear
keep if inrange(year, 2015, 2017) & inrange(v14, 1, 2)

duplicates report id_maikin year month
assert r(unique_value) == r(N)

tempfile maikin_tmp
save `maikin_tmp', replace

// Maikin meibo
use "${path_meibo_maikin}/maikin_meibo.dta", clear

keep if flag_large == 1
drop year month name
duplicates report id_maikin
assert r(unique_value) == r(N)

merge 1:m id_maikin using `maikin_tmp'

// Check fraction of establishment not appearing in meibo/chosa
preserve
	duplicates drop id_maikin, force
	tab _merge if inlist(_merge, 2, 3)
	tab _merge if inlist(_merge, 1, 3)
restore

keep if _merge == 3
drop _merge

duplicates report id_common year month
assert r(unique_value) == r(N)

save `maikin_tmp', replace

// Match Wage Census and Maikin (Test)
use `wc_tmp', clear
duplicates drop id_common, force

tempfile wc_test
save `wc_test', replace

use `maikin_tmp', clear
duplicates drop id_common, force

merge 1:1 id_common using `wc_test'

// In Maikin but not in Wage Census (Allowed by survey design)
tab _merge if inlist(_merge, 1, 3)

// In Wage Census but not in Maikin (Not allowed by survey design)
tab _merge if inlist(_merge, 2, 3)

// Match Wage Census and Maikin
use `maikin_tmp', clear
merge m:1 year id_common using `wc_tmp'
