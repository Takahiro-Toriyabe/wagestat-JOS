capture program drop clean_industry_wc2009_2017
program define clean_industry_wc2009_2017
	syntax varlist(min=1 max=1)

	replace `varlist' = "0"  if inrange(year, 2009, 2017) & `varlist' == "C"
	replace `varlist' = "1"  if inrange(year, 2009, 2017) & `varlist' == "D"
	replace `varlist' = "2"  if inrange(year, 2009, 2017) & `varlist' == "E"
	replace `varlist' = "3"  if inrange(year, 2009, 2017) & `varlist' == "F"
	replace `varlist' = "4"  if inrange(year, 2009, 2017) & `varlist' == "G"
	replace `varlist' = "5"  if inrange(year, 2009, 2017) & `varlist' == "H"
	replace `varlist' = "6"  if inrange(year, 2009, 2017) & `varlist' == "I"
	replace `varlist' = "7"  if inrange(year, 2009, 2017) & `varlist' == "J"
	replace `varlist' = "8"  if inrange(year, 2009, 2017) & `varlist' == "K"
	replace `varlist' = "9"  if inrange(year, 2009, 2017) & `varlist' == "L"
	replace `varlist' = "10" if inrange(year, 2009, 2017) & `varlist' == "M"
	replace `varlist' = "11" if inrange(year, 2009, 2017) & `varlist' == "N"
	replace `varlist' = "12" if inrange(year, 2009, 2017) & `varlist' == "O"
	replace `varlist' = "13" if inrange(year, 2009, 2017) & `varlist' == "P"
	replace `varlist' = "14" if inrange(year, 2009, 2017) & `varlist' == "Q"
	replace `varlist' = "15" if inrange(year, 2009, 2017) & `varlist' == "R"

	destring `varlist', replace

	label define `varlist' 0 "鉱業，採石業，砂利採取業"
	label define `varlist' 1 "建設業", add
	label define `varlist' 2 "製造業", add
	label define `varlist' 3 "電気・ガス・熱供給・水道業", add
	label define `varlist' 4 "情報通信業", add
	label define `varlist' 5 "運輸業，郵便業", add
	label define `varlist' 6 "卸売業，小売業", add
	label define `varlist' 7 "金融業，保険業", add
	label define `varlist' 8 "不動産業，物品賃貸業", add
	label define `varlist' 9 "学術研究，専門・技術サービス業", add
	label define `varlist' 10 "宿泊業，飲食サービス業", add
	label define `varlist' 11 "生活関連サービス業，娯楽業", add
	label define `varlist' 12 "教育，学習支援業", add
	label define `varlist' 13 "医療，福祉", add
	label define `varlist' 14 "複合サービス事業", add
	label define `varlist' 15 "サービス業（他に分類されないもの）", add
	label values `varlist' `varlist'
end
