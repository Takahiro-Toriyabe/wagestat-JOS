use "${path_meibo_maikin}/maikin_meibo.dta", clear

// No year-month information in large-establishment list
keep if inrange(year, 2013, 2017) | flag_large == 1

// Some duplication in establishment list
duplicates report id_maikin
duplicates drop id_maikin, force
keep id_maikin flag_large

preserve
	use "${path_chosa_maikin}/maikin.dta", clear
	
	duplicates drop year id_maikin, force
	tempfile tmp
	save `tmp', replace
restore

merge 1:m id_maikin using "`tmp'
gen flag_unmatch = _merge != 3

// Check fraction of establishments in chosa but not in meibo
tabstat flag_unmatch if inlist(_merge, 2, 3), by(year)

tab v14
tabstat flag_unmatch if inlist(_merge, 2, 3), by(v14)

tabstat flag_unmatch if inlist(_merge, 2, 3) & inrange(year, 2013, 2014), by(v14)
tabstat flag_unmatch if inlist(_merge, 2, 3) & inrange(year, 2015, 2017), by(v14)

// Small establishments
tabstat flag_unmatch if inlist(_merge, 2, 3) & v14 == 5, by(year)

// Large establishments
tabstat flag_unmatch if inlist(_merge, 2, 3) & v14 <= 4, by(year)
