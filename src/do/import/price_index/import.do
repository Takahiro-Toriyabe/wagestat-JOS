foreach index in cpi cpi_sub gdp gdp_sub {
	import delimited "${path_data}/price_index/`index'.csv", clear
	rename v1 Nen
	rename v2 `index'
	
	qui sum `index' if Nen == 2000, meanonly
	replace `index' = `index' / r(mean)

	save "${path_data}/price_index/`index'.dta", replace
}

clear
use "${path_data}/price_index/cpi.dta", clear
foreach index in cpi_sub gdp gdp_sub {
	merge 1:1 Nen using "${path_data}/price_index/`index'.dta", assert(1 3) nogen
}

save "${path_data}/price_index/price_index.dta", replace
