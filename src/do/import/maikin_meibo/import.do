clear

local pwd "${path_meibo_raw}/【毎月勤労統計調査関係】調査対象事業所と共通事業所コードの対応表"
local flist: dir "`pwd'" file "*.csv", respectcase

// Firm size < 29
local y = 24
local m = 1
foreach f in `flist' {
		import delimited "`pwd'/`f'", ///
			delimiter(comma) varnames(1) encoding(Shift_JIS) stringcols(_all) clear
		
		local cnt = 0
		foreach var of varlist * {
			rename `var' var`++cnt'
			label variable var`cnt' "`var'"
		}
		
		// Harmonize ichiren-bango (See レイアウト補足.xlsx)
		if `y' == 24 | (`y' == 25 & `m' == 1) {
			assert inlist(strlen(var3), 8, 9)
			replace var3 = strofreal(real(var3), "%09.0f")
		}
		else {
			assert strlen(var3) == 10
			assert substr(var3, 1, 1) == "M"
			replace var3 = substr(var3, 2, .)
			assert strlen(var3) == 9
		}	
		
		// Generate survey year and month variables
		qui gen year = 1988 + `y'
		qui gen month = `m'
		qui gen flag_large = 0
		
		save "${path_meibo_maikin}/maikin_meibo_h`y'm`m'.dta", replace
		
		local y = `y' + (`m' == 7)
		local m = mod(`m' + 6, 12)
}

// Firm size >= 30
import excel "`pwd'/調査対象事業所と共通事業所コードの対応表（規模30人以上）.xlsx", ///
	sheet("規模30人以上") firstrow allstring clear

local cnt = 0
foreach var of varlist * {
	rename `var' var`++cnt'
	label variable var`cnt' "`var'"
}

assert inlist(strlen(var3 + var4 + var5), 8, 9)
replace var3 = strofreal(real(var3 + var4 + var5), "%09.0f")
label variable var3 "府県調査区一連番号"

gen flag_large = 1

keep var1-var3 flag_large
save "${path_meibo_maikin}/maikin_meibo_large.dta", replace

// Append data
clear
local dtalist: dir "${path_meibo_maikin}" file "maikin_meibo_*.dta", respectcase
foreach f in `dtalist' {
	append using "${path_meibo_maikin}/`f'"
}

destring var1 var3, replace
rename var1 id_common
rename var2 name
rename var3 id_maikin

label variable flag_large "Large establishment"

qui duplicates report year month id_maikin
assert r(unique_value) == r(N)

sort id_maikin year month
order year month id_maikin id_common flag_large name

save "${path_meibo_maikin}/maikin_meibo.dta", replace
