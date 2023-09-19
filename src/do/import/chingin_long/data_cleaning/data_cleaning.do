
// Rename variables common across Jigyosho-hyo and Kojin-hyo

cd "${DoFilePathTemp}"
run "../MatchJigyoshoKojin/RenameCommonVar.do"


// Drop variables which only have missing values

drop ///
	Katsu /// 府県ごとの括通し番号
	v1 /// 括内事業所番号
	v6 /// マスター：抽出単産業番号
	M_Sangyo /// マスター：産業番号
	M_JigyoKibo /// マスター：事業所規模番号
	M_Kigyokibo /// マスター：企業規模番号
	M_RinjiKibo /// マスター：臨時雇用者規模番号


// Category variables

capture label drop JigyoKibo
label define JigyoKibo 0 "15,000人以上" 1 "5,000~14,999人" 2 "1,000~4,999人" 3 "500~999人" 4 "300~499人" 5 "100~299人" 6 "50~99人" 7 "30~49人" 8 "10~29人" 9 "5~9人"
label values JigyoKibo JigyoKibo

capture label drop KigyoKibo
label define KigyoKibo 1 "5,000人以上" 2 "1,000~4,999人" 3 "500~999人" 4 "300~499人" 5 "100~299人" 6 "30~99人" 7 "10~29人" 8 "5~9人"
label values KigyoKibo KigyoKibo

rename v2 BaseUp
capture label drop BaseUp
label define BaseUp 1 "算入済" 2 "未算入" 3 "未決定" 4 "実施無" 
label values BaseUp BaseUp

capture label drop Honshi
label define Honshi 1 "単独" 2 "本店" 3 "支店"
label values Honshi Honshi

capture label drop Minko
label define Minko 4 "民営" 5 "公営"
label values Minko Minko

capture label drop Sei
label define Sei 1 "男" 2 "女"
label values Sei Sei

capture label drop RouSyu
label define RouSyu 1 "生産" 2 "管理・事務・技術"
label values RouSyu RouSyu

capture label drop Syugyo
label define Syugyo 1 "一般" 2 "短時間"
label values Syugyo Syugyo

capture label drop Gakureki
label define Gakureki 1 "中学卒" 2 "高校卒" 3 "高専・短大卒" 4 "大学・大学院卒"
label values Gakureki Gakureki

capture label drop Keiken
label define Keiken 1 "1年未満" 2 "1~4年" 3 "5~9年" 4 "10~14年" 5 "15年以上"
label values Keiken Keiken

capture label drop RinjiKibo
label define RinjiKibo 1 "0~9人" 2 "10~99人" 3 "100人以上"
label values RinjiKibo RinjiKibo

capture label drop Syurui
label define Syurui 1 "国" 2 "都道府県" 3 "市区町村" 4 "独立行政法人" 5 "その他"
label values Syurui Syurui


// Harmonize industry code

gen industry_code_group = 1*inrange(Nen, 1989, 1995) + 2*inrange(Nen, 1996, 2003) ///
	+ 3*inrange(Nen, 2004, 2008) + 4*inrange(Nen, 2009, 2014) + 5*inrange(Nen, 2015, 2017)
	// Update this variable by checking https://www.mhlw.go.jp/toukei/list/chinginkouzou_b.html#09

label variable industry_code_group "Industry code group (Derived)"
label define industry_code_group 1 "1989-1995" 2 "1996-2003" 3 "2004-2008" 4 "2009-2014" 5 "2015-2017"
label values industry_code_group industry_code_group

gen SangyoD_harmonized = SangyoD
local cnt = 0
foreach char in `c(ALPHA)' {
	local cnt = `cnt' + 1
	replace SangyoD_harmonized = "`cnt'" if SangyoDai=="`char'"
}
destring SangyoD_harmonized, replace
replace SangyoD_harmonized= 1000*industry_code_group + SangyoD_harmonized
label variable SangyoD_harmonized "Harmonized industry code: Large category (Derived)"
 
gen SangyoC_harmonized = 1000*industry_code_group + SangyoChu
label variable SangyoC_harmonized "Harmonized industry code: Middle category (Derived)"

gen Sangyo_harmonized = 1000*industry_code_group + Sangyo
label variable Sangyo_harmonized "Harmonized industry code: Small category (Derived)"


// Earnings

foreach v in Genkin ChokaKyuyo SyoteiKyuyo Tsukin Seikin Kazoku Tokubetsu {
	replace `v' = `v' * 100
		// Unit: 100 JPY -> 1 JPY
	local varlab: variable label `v'
	label variable `v' "`varlab'（円）" 
}


// Employee characteristics

* Employment type
gen Koyo_harmonized = Koyo
recode Koyo_harmonized (3=1) (4=2) (5=3) if Nen>=2005

label variable Koyo_harmonized "Employment type (Derived)"
label define Koyo_harmonized 1 "常用（期間の定め無し）" 2 "常用（期間の定め有り）" 3 "臨時（2005年～）"
label values Koyo_harmonized Koyo_harmonized

rename Koyo Koyo_original

* Occupation
gen occup_code_group = 1*inrange(Nen, 1989, 1994) + 2*inrange(Nen, 1995, 2000) ///
	+ 3*inrange(Nen, 2001, 2004) + 4*inrange(Nen, 2005, 2017)
replace occup_code_group = 0 if inrange(Syoku, 101, 105)
label variable occup_code_group "Occupation code group (Derived)"
label define occup_code_group 0 "Maneger" 1 "1989-1994" 2 "1995-2000" 3 "2001-2004" 4 "2005-2017"
label values occup_code_group industry_code_group

gen Syoku_harmonized = 1000*occup_code_group + Syoku


label variable Syoku_harmonized "Job title and occupation (Derived)"
label define Syoku_harmonized 101 "部長級" 102 "課長級" 103 "係長級" 104 "職長級" 105 "その他役職"
label values Syoku_harmonized Syoku_harmonized

rename Syoku Syoku_original


// Other

rename v3 RoudouRitsu

replace v4 = Syain_M + Hisyain_M if (Nen>=2005)&(Nen!=.)
rename v4 Jyoyo_M

replace v5 = Syain_W + Hisyain_W if (Nen>=2005)&(Nen!=.)
rename v5 Jyoyo_W

gen weight_k = Fukugen
label variable weight_k "Survey weight for Kojin-hyo"


// Check
/*
foreach v of varlist * {
	local storage_type: type `v'
	if substr("`storage_type'", 1, 3)=="str" {
		display "`v' is storaged as string"
	}
	else {
		tabstat `v', by(Nen) stat(mean min max N)
	}
}
*/

// TODO

* RouRen: Some dirty string values
* Nenrei: Capped at 79 in 2007 and before?
* Earnings variables: 999, 9999 -> missing? or capped?
* Earnings variables: Non-negligible fraction has 0 value in Genkin and SyoteiKyuyo
* No missing values in Work hour and earnings variables. Missing values are converted into 0?
* Many missing values in Keiken (about 65-75% in each year)

* Put value labels to industry code
