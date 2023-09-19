clear
set seed 112002

use "${path_data}/pj/pj3_5/chingin_matched.dta", clear

keep if inrange(year, 2016, 2017) & inlist(merge_result, 2, 3)

// The prefecture and city codes are masked by XX and XXX, respectively for a confidential reason
keep if pref_code == XX & inrange(city_code, XXX, XXX)

gen earnings = (12 * SyoteiKyuyo + Tokubetsu) * 100
gen female = Sei == 2 if !missing(Sei)
rename Nenrei age

assert !missing(earnings, age, female)
gen flag_no_earnings = earnings == 0
tab flag_no_earnings

drop if flag_no_earnings

keep year age female earnings ${weight_wc_k}

tempfile tmp
save `tmp'

use "${path_root}/data/tax_data.dta", clear

keep if inrange(year, 2016, 2017)

rename 給与収入一般 earnings
gen female = sex == 2 if !missing(sex)
gen age = year - birthYear

keep if earnings > 0
assert !missing(earnings)
count if missing(age, female)
drop if missing(age, female)

keep year age female earnings
append using `tmp', gen(dcat)

label define dcat 1 "BSWS" 0 "Tax data"
label values dcat dcat

replace ${weight_wc_k} = 1 if dcat == 0

// Unit: 1 million JPY/year
replace earnings = earnings / 1000000

keep if inrange(age, 25, 59) & year == 2017
save "${path_root}/data/_tax_data_bs_tmp.dta", replace

// Get point estimate
local stat_list "mean p5 p10 p25 p50 p75 p90 p95"
forvalues i = 0(1)1 {
	qui sum earnings [aw=${weight_wc_k}] if dcat == `i', detail
	local j = 1
	foreach stat in `stat_list' {
		local b`i'`j' = r(`stat')
		local j = `j' + 1
	}
	local n`i' = r(N)
}

forvalues j = 1(1)8 {
	local b_d`j' = strofreal(`b1`j'' - `b0`j'', "%04.3f")
	local p_d`j' = strofreal(100 * (`b1`j'' / `b0`j'' - 1), "%04.2f")
	forvalues i = 0(1)1 {
		local b`i'`j' = strofreal(`b`i'`j'', "%04.3f")
	}
	
}

// Bootstrap
local R = 1000
matrix B0 = J(`R', 8, .)
matrix B1 = J(`R', 8, .)

forvalue r = 1(1)`R' {
	display "Iteration `r'..." _continue
	qui use "${path_root}/data/_tax_data_bs_tmp.dta", clear
	qui bsample, strata(dcat)
	
	foreach d in 0 1 {
		qui sum earnings [aw=${weight_wc_k}] if dcat == `d', detail
		local j = 1
		foreach stat in `stat_list' {
			matrix B`d'[`r', `j'] = r(`stat')
			local j = `j' + 1
		}
	}
	display "Done"
}

matrix D = B1 - B0

clear
svmat B0
svmat B1
svmat D

forvalues i = 0(1)1 {
	forvalues j = 1(1)8 {
		qui sum B`i'`j'
		local s`i'`j' = "(" + strofreal(r(sd), "%04.3f") + ")"
		qui sum D`j'
		local s_d`j' = "(" + strofreal(r(sd), "%04.3f") + ")"
	}
}

tempname hh
file open `hh' using "${path_table}/pj3_5/tax_data.tex", write replace
forvalues j = 1(1)8 {
	file write `hh' "`:word `j' of `stat_list'' & `b1`j'' & `b0`j'' & `b_d`j'' & `p_d`j'' \\" _newline
	file write `hh' "& `s1`j'' & `s0`j'' & `s_d`j'' & \\" _newline
}
file write `hh' "Observations & `n1' & `n0' & & \\" _newline
file close `hh'

cat "${path_table}/pj3_5/tax_data.tex"
