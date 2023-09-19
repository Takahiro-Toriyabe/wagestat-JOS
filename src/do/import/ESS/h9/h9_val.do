/*-----------------------------------------------------------------------------
    <README>
    This do-file is generated from the python program provided
    in 'https://github.com/Takahiro-Toriyabe/MicroDataCleaning'.
        _const.do:    Import fixed-length data
        _var.do:      Put variable labels
        _val.do:      Put value labels
        _validate.do: Check if the data seems correctly imported
        rename.do:    Rename variable to harmonize several data

    WARNING:
        1. The generated do-files do not necessarily correct. If you find
           something wrong regarding the program or the resulting do-file(s),
           please report at the above GitHub web page.

        2. _validate.do checks if each variable has the values that it is
           supposed to have (only for categorical variables).

        3. rename.do is generated by finding a variable with a similar variable
           description and, if any, a similar variable name from the base data.
           So it is quite likely that some variables are renamed incorrectly.
           Please check and modify rename.do.

        4. Although value labels are put for each individual data, the labels
           are not put for the appended data, because the categories for each
           variable are very likely to be inconsistent across years.

        5. There is no file to make variable values consistent across different
           data.


    Source: 
    Date: 2021/03/12 16:37:32
-----------------------------------------------------------------------------*/


capture label define var1 1997 "" 
capture label values var1 var1

capture label define var2 10 "" 
capture label values var2 var2

capture label define var10 1 "一般世帯:15歳未満世帯人員を含めて世帯人員が2人以上の世帯" 2 "単身世帯:15歳未満世帯人員を含めても世帯人員が1人の世帯" 
capture label values var10 var10

capture label define var11 1 "夫婦と両親から成る世帯(夫の両親か妻の両親かわからない世帯)" 2 "夫婦と夫の両親から成る世帯" 3 "夫婦と妻の両親から成る世帯" 4 "夫婦と片親から成る世帯(夫の親か妻の親かわからない世帯)" 5 "夫婦と夫の男親から成る世帯" 6 "夫婦と夫の女親から成る世帯" 7 "夫婦と妻の男親から成る世帯" 8 "夫婦と妻の女親から成る世帯" 9 "夫婦,子供と両親から成る世帯(夫の両親か妻の両親かわからない世帯)" 10 "夫婦,子供と夫の両親から成る世帯" 11 "夫婦,子供と妻の両親から成る世帯" 12 "夫婦,子供と片親から成る世帯(夫の親か妻の親かわからない世帯)" 13 "夫婦,子供と夫の男親から成る世帯" 14 "夫婦,子供と夫の女親から成る世帯" 15 "夫婦,子供と妻の男親から成る世帯" 16 "夫婦,子供と妻の女親から成る世帯" 17 "上記以外" 
capture label values var11 var11

capture label define var12 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values var12 var12

capture label define var29 1 "賃金・給料" 2 "農業収入" 3 "その他の事業収入" 4 "内職収入" 5 "家賃・地代" 6 "利子・配当" 7 "恩給・年金" 8 "雇用保険" 9 "仕送り" 10 "その他" 
capture label values var29 var29

capture label define var40 1 "100万円未満" 2 "100~199万円" 3 "200~299万円" 4 "300~399万円" 5 "400~499万円" 6 "500~599万円" 7 "600~699万円" 8 "700~799万円" 9 "800~899万円" 10 "900~999万円" 11 "1000~1499万円" 12 "1500万円以上" 
capture label values var40 var40

capture label define var41 1 "男" 2 "女" 
capture label values var41 var41

capture label define var42 1 "世帯主" 2 "世帯主の配偶者" 3 "子" 4 "子の配偶者" 5 "孫" 6 "世帯主の父母" 7 "世帯主の配偶者の父母" 8 "祖父母" 9 "兄弟姉妹" 10 "他の親族" 11 "その他" 
capture label values var42 var42

capture label define var43 1 "明治" 2 "大正" 3 "昭和" 
capture label values var43 var43

capture label define var45 1 "1~3月" 2 "4~6月" 3 "7~9月" 4 "10~12月" 
capture label values var45 var45

capture label define var47 1 "15~19歳" 2 "20~24歳" 3 "25~29歳" 4 "30~34歳" 5 "35~39歳" 6 "40~44歳" 7 "45~49歳" 8 "50~54歳" 9 "55~59歳" 10 "60~64歳" 11 "65~69歳" 12 "70~74歳" 13 "75歳以上" 
capture label values var47 var47

capture label define var48 1 "15~24歳" 2 "25~34歳" 3 "35~44歳" 4 "45~54歳" 5 "55~64歳" 6 "65歳以上" 
capture label values var48 var48

capture label define var49 1 "未婚" 2 "配偶者あり" 3 "死別・離別" 
capture label values var49 var49

capture label define var50 1 "現在の住所" 2 "同じ市区町村内の別のところ" 3 "同じ都道府県内の別の市区町村" 4 "他の都道府県" 5 "外国" 
capture label values var50 var50

capture label define var52 1 "在学中" 2 "卒業" 3 "在学したことがない" 
capture label values var52 var52

capture label define var53 1 "小学・中学" 2 "高校・旧制中" 3 "短大・高専" 4 "大学・大学院" 
capture label values var53 var53

capture label define var54 1 "仕事をおもにしている" 2 "家事がおもで仕事もしている" 3 "通学がおもで仕事もしている" 4 "家事・通学以外のことがおもで仕事もしている" 5 "家事をしている" 6 "通学している" 7 "その他" 
capture label values var54 var54

capture label define var55 1 "常雇" 2 "臨時雇" 3 "日雇" 4 "会社・団体等の役員(民間の役員)" 5 "自営業主で雇人あり" 6 "自営業主で雇人なし" 7 "自家営業の手伝い(家族従業者)" 8 "家庭で内職" 
capture label values var55 var55

capture label define var56 1 "民間の役員" 2 "正規の職員・従業員" 3 "パート" 4 "アルバイト" 5 "嘱託など" 6 "人材派遣企業の派遣社員" 7 "その他" 
capture label values var56 var56

capture label define var57 1 "個人" 2 "会社" 3 "その他の法人・団体" 4 "官公庁" 
capture label values var57 var57

capture label define var58 1 "農林業" 2 "非農林業" 
capture label values var58 var58

capture label define var59 1 "農業" 2 "林業" 3 "漁業" 4 "鉱業" 5 "建設業" 6 "製造業" 7 "電気・ガス・熱供給・水道業" 8 "運輸・通信業" 9 "卸売・小売業,飲食店" 10 "金融・保険業" 11 "不動産業" 12 "サービス業" 13 "公務(他に分類されないもの)" 
capture label values var59 var59

capture label define var60 1 "農業" 2 "林業" 3 "漁業" 5 "鉱業" 9 "建設業" 12 "食料品・飲料・たばこ製造業" 14 "繊維工業・繊維製品製造業" 16 "木材・木製品・家具製造業" 18 "パルプ・紙・紙加工品製造業" 19 "出版・印刷・同関連産業" 20 "化学工業,石油・石炭製品製造業" 22 "プラスチック・ゴム製品製造業" 25 "窯業・土石製品製造業" 26 "鉄鋼業" 27 "非鉄金属製造業" 28 "金属製品製造業" 29 "一般機械器具製造業" 30 "電気機械器具製造業" 31 "輸送用機械器具製造業" 32 "精密機械器具製造業" 34 "その他の製造業" 35 "電気・ガス・熱供給・水道業" 39 "鉄道業" 40 "輸送・倉庫業" 46 "郵便業" 47 "電気通信業" 48 "卸売業" 54 "各種商品小売業" 55 "衣料・住居関連商品小売業" 56 "飲食料品小売業" 59 "その他の小売業" 60 "飲食店" 62 "金融・保険業" 70 "不動産業" 74 "生活関連サービス業" 75 "旅館・その他の宿泊所" 76 "娯楽業" 77 "整備・修理業" 81 "放送・情報サービス業" 84 "専門サービス業(他に分類されないもの)" 86 "事業サービス業" 88 "医療・保健衛生" 90 "社会保険・社会福祉" 91 "教育" 93 "宗教,政治・経済・文化団体" 95 "その他のサービス業" 97 "公務(他に分類されないもの)" 
capture label values var60 var60

capture label define var61 1 "専門的・技術的職業従事者" 2 "管理的職業従事者" 3 "事務従事者" 4 "販売従事者" 5 "サービス職業従事者" 6 "保安職業従事者" 7 "農林漁業作業者" 8 "運輸・通信従事者" 9 "技能工,採掘・製造・建設作業及び労務従事者" 
capture label values var61 var61

capture label define var62 1 "技術者" 2 "保健医療従事者" 4 "社会福祉専門職業従事者" 7 "教員" 
capture label values var62 var62

capture label define var63 1 "1~4人" 2 "5~9人" 3 "10~19人" 4 "20~29人" 5 "30~49人" 6 "50~99人" 7 "100~299人" 8 "300~499人" 9 "500~999人" 10 "1000人以上" 11 "官公庁" 
capture label values var63 var63

capture label define var64 1 "50日未満" 2 "50~99日" 3 "100~149日" 4 "150~199日" 5 "200~249日" 6 "250日以上" 
capture label values var64 var64

capture label define var65 1 "不規則" 2 "ある季節だけ" 3 "だいたい規則的" 
capture label values var65 var65

capture label define var66 1 "15時間未満" 2 "15~21時間" 3 "22~34時間" 4 "35~42時間" 5 "43~45時間" 6 "46~48時間" 7 "49~59時間" 8 "60時間以上" 
capture label values var66 var66

capture label define var67 1 "収入なし,50万円未満" 2 "50~99万円" 3 "100~149万円" 4 "150~199万円" 5 "200~249万円" 6 "250~299万円" 7 "300~399万円" 8 "400~499万円" 9 "500~699万円" 10 "700~999万円" 11 "1000~1499万円" 12 "1500万円以上" 13 "家族従業者" 
capture label values var67 var67

capture label define var68 1 "この仕事を続けたい(継続就業希望者)" 2 "この仕事のほかに別の仕事もしたい(追加就業希望者)" 3 "ほかの仕事に変わりたい(転職希望者)" 4 "仕事をすっかりやめてしまいたい(就業休止希望者)" 
capture label values var68 var68

capture label define var69 1 "今のままでよい" 2 "就業時間を増やしたい" 3 "就業時間を減らしたい" 
capture label values var69 var69

capture label define var70 1 "一時的についた仕事だから" 2 "収入が少ないから" 3 "将来性がないから" 4 "定年などに備えて" 5 "時間的・肉体的に負担が大きいから" 6 "知識や技能を生かしたいから" 7 "余暇を増やしたいから" 8 "家事の都合から" 9 "その他" 
capture label values var70 var70

capture label define var71 1 "正規の職員・従業員として雇われたい" 2 "パート・アルバイトの仕事をしたい" 3 "自分で事業をしたい" 4 "自家営業を手伝いたい" 5 "家庭で内職をしたい" 6 "その他" 
capture label values var71 var71

capture label define var72 1 "探している" 2 "開業の準備をしている" 3 "何もしていない" 
capture label values var72 var72

capture label define var73 1 "別の仕事もしている" 2 "今はしていないがある時期にはしている" 3 "別の仕事はしていない" 
capture label values var73 var73

capture label define var74 1 "雇われている" 2 "会社・団体等の役員" 3 "自営業主" 4 "自家営業の手伝い" 5 "家庭で内職" 
capture label values var74 var74

capture label define var78 1 "1年前にも現在の仕事をしていた" 2 "1年前には現在の仕事をしていなかった" 
capture label values var78 var78

capture label define var79 1 "1年未満(転職者,新規就業者のみ)" 2 "1年" 3 "2年" 4 "3~4年" 5 "5~6年" 6 "7~9年" 7 "10~14年" 8 "15~19年" 9 "20~24年" 10 "25~29年" 11 "30年以上" 
capture label values var79 var79

capture label define var81 1 "仕事をおもにしていた" 2 "家事・通学などのかたわらにしていた" 3 "家事をしていた" 4 "通学していた" 5 "その他" 
capture label values var81 var81

capture label define var82 1 "失業していたから" 2 "学校を卒業したから" 3 "収入を得たかったから" 4 "知識や技能を生かしたかったから" 5 "社会に出たかったから" 6 "余暇ができたから" 7 "健康を維持したいから" 8 "その他" 
capture label values var82 var82

capture label define var83 1 "ある" 2 "ない" 
capture label values var83 var83

capture label define var84 1 "仕事をしたいと思っている(就業希望者)" 2 "仕事をしたいと思っていない(非就業希望者)" 
capture label values var84 var84

capture label define var85 1 "失業しているから" 2 "学校を卒業したから" 3 "収入を得たいから" 4 "知識や技能を生かしたいから" 5 "社会に出たいから" 6 "余暇ができたから" 7 "健康を維持したいから" 8 "その他" 
capture label values var85 var85

capture label define var86 1 "仕事をおもにしていきたい" 2 "家事や通学などのかたわらにしたい" 
capture label values var86 var86

capture label define var87 1 "正規の職員・従業員として雇われたい" 2 "パート・アルバイトの仕事がしたい" 3 "自分で事業をしたい" 4 "自家営業を手伝いたい" 5 "家庭で内職をしたい" 6 "その他" 
capture label values var87 var87

capture label define var88 1 "探している" 2 "開業の準備をしている" 3 "何もしていない" 
capture label values var88 var88

capture label define var89 1 "探したが見つからなかった" 2 "自分の希望する仕事がありそうにない" 3 "自分の知識・能力に自信がない" 4 "病気・高齢のため" 5 "家事・育児や通学などで忙しい" 6 "家族の介護・看護のため" 7 "急いで仕事につく必要がない" 8 "その他" 
capture label values var89 var89

capture label define var90 1 "公共職業安定所等に申込み" 2 "事業所に直接応募" 3 "知人などに相談・あっせん依頼" 4 "広告・求人情報誌等" 5 "人材派遣企業に登録" 6 "事業用資金の調達等" 7 "その他" 
capture label values var90 var90

capture label define var91 1 "1か月未満" 2 "1か月以上3か月未満" 3 "3か月以上6か月未満" 4 "6か月以上1年未満" 5 "1年以上2年未満" 6 "2年以上" 
capture label values var91 var91

capture label define var92 1 "すぐつくつもり" 2 "すぐではないがつくつもり" 3 "つくかどうかわからない" 
capture label values var92 var92

capture label define var93 1 "家事をしていた" 2 "通学していた" 3 "その他" 4 "仕事をおもにしていた" 5 "通学・家事などのかたわらにしていた" 
capture label values var93 var93

capture label define var94 1 "ある" 2 "ない" 
capture label values var94 var94

capture label define var95 1 "昭和46年以後" 2 "昭和45年以前" 
capture label values var95 var95

capture label define var96 1 "昭和" 2 "平成" 
capture label values var96 var96

capture label define var98 1 "人員整理・会社解散・倒産のため" 2 "一時的・不安定な仕事だったから" 3 "収入が少なかったから" 4 "労働条件が悪かったから" 5 "自分に向かない仕事だったから" 6 "家族の就職・転職・転勤及び事業所の移転のため" 7 "定年などのため" 8 "病気・高齢のため" 9 "結婚のため" 10 "育児のため" 11 "家族の介護・看護のため" 12 "その他" 
capture label values var98 var98

capture label define var105 0 "0年" 1 "1~2年" 2 "3~4年" 3 "5~9年" 4 "10~14年" 5 "15~19年" 6 "20~24年" 7 "25~29年" 8 "30年以上" 
capture label values var105 var105
