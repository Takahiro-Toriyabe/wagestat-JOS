rename Chosa_Nen year
rename Jigyousho id_common

// Drop variables with no data
drop Katsu Maime Tsukin Seikin Kazoku Honshi Syurui

// Confirm no missing values in sampling weights
assert !missing(${weight_wc_j}) & !missing(${weight_wc_k})

/* Generate establishment identifier
	Between 2013 and 2017, ID of population database is available,
	which is supposed to be used as panel ID as well.
	
	In 2012, need to use ID for the Economic Census. To avoid
	confusing these two IDs, construct ID by
	
	ID = population database ID if year in [2013, 2017]
	   = max(population database ID) + seq(Economic Census ID)
	   if year == 2012
*/

// Confirm no missing values in key variables
assert !missing(Ken) & !missing(Shiku)
assert !missing(Kihon) & !missing(Jigyosyo) if inrange(year, 2012, 2014)
assert !missing(id_common) if inrange(year, 2013, 2017)

tempvar id_sub
gen id_est = id_common if inrange(year, 2013, 2017)
egen `id_sub' = group(Ken Shiku Kihon Jigyosyo) if year == 2012
qui sum id_est
replace id_est = r(max) + `id_sub' if year == 2012
drop `id_sub'

label variable id_est "Establishment ID"

// Confirm no missing values in the generated ID
sort id_est year
assert !missing(id_est) if year >= 2012

// Validate establishment ID
tempvar check_max check_min
by id_est year: egen `check_max' = max(${weight_wc_j})
by id_est year: egen `check_min' = min(${weight_wc_j})
gen flag_valid_id = float(`check_max') == float(`check_min')
label variable flag_valid_id "Flag for valid establishment ID"

preserve
	by id_est year: keep if _n == 1
	tab year flag_valid_id
restore

drop `check_max' `check_min'

// Confirm no missing values in master information
foreach var of varlist M_* {
	capture assert !missing(`var')
	if _rc {
		qui count if missing(`var')
		display as error "`var': `r(N)'/`c(N)' observations"
	}
}

// Establishment/Firm size
capture label drop M_JigyoKibo
label define M_JigyoKibo 0 "15,000人以上" 1 "5,000~14,999人" 2 "1,000~4,999人" 3 "500~999人" 4 "300~499人" 5 "100~299人" 6 "50~99人" 7 "30~49人" 8 "10~29人" 9 "5~9人"
label values M_JigyoKibo M_JigyoKibo

recode M_Kigyokibo (0=1)
recode M_Kigyokibo (7=6) (8=7) (9=8) if inrange(year, 2015, 2017)
assert inrange(M_Kigyokibo, 1, 8) if !missing(M_Kigyokibo)

capture label drop M_Kigyokibo
label define M_Kigyokibo 1 "5,000人以上" 2 "1,000~4,999人" 3 "500~999人" 4 "300~499人" 5 "100~299人" 6 "30~99人" 7 "10~29人" 8 "5~9人"
label values M_Kigyokibo M_Kigyokibo

capture label drop M_RinjiKibo
label define M_RinjiKibo 1 "0~9人" 2 "10~99人" 3 "100人以上"
label values M_RinjiKibo M_RinjiKibo

capture label drop JigyoKibo
label define JigyoKibo 0 "15,000人以上" 1 "5,000~14,999人" 2 "1,000~4,999人" 3 "500~999人" 4 "300~499人" 5 "100~299人" 6 "50~99人" 7 "30~49人" 8 "10~29人" 9 "5~9人"
label values JigyoKibo JigyoKibo

capture label drop KigyoKibo
label define KigyoKibo 1 "5,000人以上" 2 "1,000~4,999人" 3 "500~999人" 4 "300~499人" 5 "100~299人" 6 "30~99人" 7 "10~29人" 8 "5~9人"
label values KigyoKibo KigyoKibo

capture label drop RinjiKibo
label define RinjiKibo 1 "0~9人" 2 "10~99人" 3 "100人以上"
label values RinjiKibo RinjiKibo

capture label drop Minko
label define Minko 4 "民営" 5 "公営"
label values Minko Minko

// Worker characteristics
capture label drop Sei
label define Sei 1 "男" 2 "女"
label values Sei Sei

capture label drop RouSyu
label define RouSyu 1 "生産" 2 "管理・事務・技術"
label values RouSyu RouSyu

capture label drop Syugyo
label define Syugyo 1 "一般" 2 "短時間"
label values Syugyo Syugyo

capture label drop Koyo
label define Koyo 1 "正社員・正職員のうち雇用期間の定め無し" 2 "正社員・正職員のうち雇用期間の定め有り" 3 "正社員・正職員以外のうち雇用期間の定め無し" 4 "正社員・正職員以外のうち雇用期間の定め有り" 5 "臨時労働者"
label values Koyo Koyo

capture label drop Gakureki
label define Gakureki 1 "中学卒" 2 "高校卒" 3 "高専・短大卒" 4 "大学・大学院卒"
label values Gakureki Gakureki

capture label drop Keiken
label define Keiken 1 "1年未満" 2 "1~4年" 3 "5~9年" 4 "10~14年" 5 "15年以上"
label values Keiken Keiken

// Monthly workhours
assert !missing(SyoteiJikan) & !missing(ChokaJikan)
gen workhour = SyoteiJikan + ChokaJikan
label variable workhour "Monthly hours worked"

// Annual wage
assert !missing(Genkin) & !missing(Tokubetsu)
assert Genkin >= 0 & Tokubetsu >= 0
gen annual_wage = 12 * (Genkin + Tokubetsu) / 100
label variable annual_wage "Annual wage (10,000 JPY)"

// Flags to be compared with other surveys
assert !missing(Minko) & !missing(JigyoKibo) & !missing(Koyo)
gen flag_minkyu = Minko == 4
gen flag_shokushu = KigyoKibo <= 6 & JigyoKibo <= 6 & inlist(Koyo, 1, 3)

assert !missing(flag_minkyu) & !missing(flag_shokushu)
