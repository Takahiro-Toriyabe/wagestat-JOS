rename v16 year
rename v17 month
assert !missing(year) & !missing(month)

// Drop variables with no data
foreach var of varlist * {
	qui count if !missing(`var')
	if r(N) == 0 {
		di "`var': `:variable label `var''"
		drop `var'
	}
}

// Generate establishment identifier
gen_id v5 v6 v7, gen(id_maikin)
label variable id_maikin "Establishment ID"

qui duplicates report year month id_maikin
assert r(unique_value) == r(N) & !missing(id_maikin)

sort id_maikin year month

// Establishment/Firm size
recode v14 (3=2) (5=3) (7=4) (9=5)
assert inrange(v14, 1, 5) if !missing(v14)
capture label drop v14
label define v14 1 "1,000人以上" 2 "500~999人" 3 "100~499人" 4 "30~99人" 5 "5~29人"
label values v14 v14

destring v15, replace ignore("V")
capture label drop v15
label define v15 1 "1,000人以上" 2 "500~999人" 3 "100~499人" 4 "30~99人" 5 "5~29人"
label values v15 v15
