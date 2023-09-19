// H25
use "${path_data}/meibo/chingin/chingin_meibo_h25.dta", clear

local cnt = 0
foreach var of varlist * {
	local lbl = usubinstr(usubinstr("`var'", "LP", "(", .), "RP", ")", .)
	label variable `var' "`lbl'"
	rename `var' v`++cnt'
}

qui destring *, replace

rename v1 Ken
rename v2 Shiku
rename v3 Kihon
rename v4 Jigyosyo

duplicates report Ken Shiku Kihon Jigyosyo
duplicates drop Ken Shiku Kihon Jigyosyo, force

merge 1:m Ken Shiku Kihon Jigyosyo using ///
	"${path_data}/chosa/chingin/chingin_h25.dta"

qui bysort Ken Shiku Kihon Jigyosyo: gen seq = _n if inlist(_merge, 2, 3)
tab _merge if seq == 1
tab _merge if !missing(seq)

qui gen unmatch = _merge == 2 if !missing(seq)
tabstat unmatch if seq == 1, by(M_Kigyokibo)
tabstat unmatch if seq == 1, by(M_JigyoKibo)

// H26
use "${path_data}/meibo/chingin/chingin_meibo_h26.dta", clear

local cnt = 0
foreach var of varlist * {
	local lbl = usubinstr(usubinstr("`var'", "LP", "(", .), "RP", ")", .)
	label variable `var' "`lbl'"
	rename `var' v`++cnt'
}

qui destring *, replace

rename v1 Ken
rename v2 Shiku
rename v3 Kihon
rename v4 Jigyosyo

duplicates report Ken Shiku Kihon Jigyosyo
duplicates drop Ken Shiku Kihon Jigyosyo, force

merge 1:m Ken Shiku Kihon Jigyosyo using ///
	"${path_data}/chosa/chingin/chingin_h26.dta"

qui bysort Ken Shiku Kihon Jigyosyo: gen seq = _n if inlist(_merge, 2, 3)
tab _merge if seq == 1
tab _merge if !missing(seq)

qui gen unmatch = _merge == 2 if !missing(seq)
tabstat unmatch if seq == 1, by(M_Kigyokibo)
tabstat unmatch if seq == 1, by(M_JigyoKibo)

// H27
use "${path_data}/meibo/chingin/chingin_meibo_h27.dta", clear

local cnt = 0
foreach var of varlist * {
	local lbl = usubinstr(usubinstr("`var'", "LP", "(", .), "RP", ")", .)
	label variable `var' "`lbl'"
	rename `var' v`++cnt'
}

qui destring *, replace

rename v2 Jigyousho

duplicates report Jigyousho
duplicates drop Jigyousho, force

merge 1:m Jigyousho using ///
	"${path_data}/chosa/chingin/chingin_h27.dta"

qui bysort Jigyousho: gen seq = _n if inlist(_merge, 2, 3)
tab _merge if seq == 1
tab _merge if !missing(seq)

qui gen unmatch = _merge == 2 if !missing(seq)
tabstat unmatch if seq == 1, by(M_Kigyokibo)
tabstat unmatch if seq == 1, by(M_JigyoKibo)
