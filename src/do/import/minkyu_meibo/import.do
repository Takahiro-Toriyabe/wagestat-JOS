local path_data_raw "${path_meibo_raw}/平成24～令和元年分民間給与実態統計調査名簿データ/平成24～令和元年分民間給与実態統計調査名簿データ"
local year = 2012

foreach y in H24 H25 H26 H27 H28 H29 H30 R01 {
	import delimited ///
		"`path_data_raw'/(`y')MEIBO.csv", clear stringcols(_all) encoding(sjis)
	destring *, replace
	gen year = `year'
	save "${path_meibo_minkyu}/minkyu_meibo`year'.dta", replace
	
	local `year++'
}

clear
forvalues y = 2012(1)2019 {
	append using "${path_meibo_minkyu}/minkyu_meibo`y'.dta"
}

duplicates report year v1 v2
assert r(unique_value) == r(N)

forvalues j = 1(1)9 {
	count if missing(v`j')
}

rename v1 KYOKUSYO
rename v2 SEIRI
rename v3 SOUBETU

label define SOUBETU 1 "1--9人" 2 "10--29人" 3 "30--99人" 4 "100--499人" ///
	5 "500--999人" 6 "1000--4999人" 7 "5000人以上" 8 "500人未満で資本金10億円以上の株式会社の本社"
label values SOUBETU SOUBETU

gen estsize = 9 - SOUBETU
label define estsize 8 "1--9人" 7 "10--29人" 6 "30--99人" 5 "100--499人" ///
	4 "500--999人" 3 "1000--4999人" 2 "5000人以上" 1 "500人未満で資本金10億円以上の株式会社の本社"
label values estsize estsize

label variable v4 "資本金額"
label variable v5 "平均支給人員"
label variable v6 "前年平均支給人員"
label variable v7 "業種番号"

/* Industry code
	There is a variable of industry code, but its meaning is different
	depending on whether or not a respondent is hojin or kojin.
*/

gen flag_hojin = substr(strofreal(SEIRI, "%08.0f"), 1, 2) == "00"
tab flag_hojin

// For hojin
gen industry_sub = floor(v7 / 100) if flag_hojin

gen industry = inrange(industry_sub, 1, 29) ///
	+ 2 * inrange(industry_sub, 31, 39) ///
	+ 3 * inrange(industry_sub, 41, 49) ///
	+ 4 * inrange(industry_sub, 51, 52) ///
	+ 5 * inrange(industry_sub, 61, 69) ///
	+ 6 * inrange(industry_sub, 71, 77) ///
	+ 7 * inrange(industry_sub, 78, 79) ///
	+ 8 * inrange(industry_sub, 81, 99) ///
	if flag_hojin & !missing(industry_sub)

// One record has industry_sub = 0, so assign it to "other" category
replace industry = 8 if flag_hojin & industry == 0

// For kojin
forvalues j = 1(1)9 {
	replace industry = 8 + `j' ///
		if !flag_hojin & inrange(v7, 1000 * `j', 1000 * `j' + 999)
}
replace industry = 18 if !flag_hojin & inrange(v7, 100, 199)
replace industry = 19 if !flag_hojin & inrange(v7, 200, 999)
replace industry = 20 if !flag_hojin & v7 <= 99

assert inlist(industry, 1, 2, 3, 4, 5, 6, 7, 8) if flag_hojin & !missing(v7)
assert inlist(industry, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20) if !flag_hojin & !missing(v7)
assert missing(industry) if missing(v7)

label define industry 1 "法人：製造業" 2 "法人：卸売業" 3 "法人：小売業" ///
	4 "法人：建設業" 5 "法人：運送業" 6 "法人：サービス業" 7 "法人：料理・旅館・飲食店業" ///
	8 "法人：その他" 9 "個人：小売業" 10 "個人：卸売業" 11 "個人：製造小売業" ///
	12 "個人：製造卸売業" 13 "個人：受託加工業" 14 "個人：修理業" 15 "個人：サービス業" ///
	16 "個人：建設業" 17 "個人：その他の営業" 18 "個人：農業" 19 "個人：その他の事業" ///
	20 "個人：その他"
label values industry industry

count if missing(industry)

save "${path_meibo_minkyu}/minkyu_meibo.dta", replace

