import delimited "${path_data}/cpi.csv", ///
	varnames(nonames) clear
rename v1 year
rename v2 cpi
replace cpi = cpi / 100

save "${path_data}/cpi.dta", replace
