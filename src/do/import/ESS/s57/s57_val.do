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


capture label define CHO_YEAR 1982 "調査の年(西暦)" 
capture label values CHO_YEAR CHO_YEAR

capture label define CHO_MONTH 10 "調査の月" 
capture label values CHO_MONTH CHO_MONTH

capture label define S_IPPAN 1 "一般世帯" 2 "単身世帯" 
capture label values S_IPPAN S_IPPAN

capture label define S_KAZOKURUI 1 "夫婦のみの世帯" 2 "夫婦と子供からなる世帯" 3 "夫婦と両親からなる世帯" 4 "夫婦と片親からなる世帯" 5 "夫婦と子供と両親からなる世帯" 6 "夫婦と子供と片親からなる世帯" 7 "その他の世帯" 
capture label values S_KAZOKURUI S_KAZOKURUI

capture label define S_JIN0 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN0 S_JIN0

capture label define S_JIN1 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN1 S_JIN1

capture label define S_JIN2 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN2 S_JIN2

capture label define S_JIN3 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN3 S_JIN3

capture label define S_JIN4 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN4 S_JIN4

capture label define S_JIN5 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN5 S_JIN5

capture label define S_JIN6 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN6 S_JIN6

capture label define S_JIN7 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN7 S_JIN7

capture label define S_JIN8 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN8 S_JIN8

capture label define S_JIN9 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN9 S_JIN9

capture label define S_JIN10 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN10 S_JIN10

capture label define S_JIN11 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN11 S_JIN11

capture label define S_JIN12 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN12 S_JIN12

capture label define S_JIN13 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN13 S_JIN13

capture label define S_JIN14 0 "記入無し" 1 "1人" 2 "2人" 
capture label values S_JIN14 S_JIN14

capture label define S_OMOSYU 1 "(調査:○D問1)賃金・給料" 2 "農業収入" 3 "その他の事業収入" 4 "内職収入" 5 "家賃・地代" 6 "利子・配当" 7 "恩給・年金" 8 "雇用保険" 9 "生活保護" 10 "その他(仕送りなど)" 
capture label values S_OMOSYU S_OMOSYU

capture label define S_SHOTOKU 1 "(調査:○D問2)100万円未満" 2 "100~149万円" 3 "150~199" 4 "200~249" 5 "250~299" 6 "300~399" 7 "400~499" 8 "500~699" 9 "700~999" 10 "1000~1499" 11 "1500万円以上" 
capture label values S_SHOTOKU S_SHOTOKU

capture label define K_SEX 1 "(調査:○1)男" 2 "女" 
capture label values K_SEX K_SEX

capture label define K_TUZUKI 1 "(調査:○2)世帯主又は代表者" 2 "世帯主の配偶者" 3 "子又は子の配偶者" 4 "孫" 5 "父母" 6 "祖父母" 7 "兄弟姉妹" 8 "他の家族" 9 "その他" 
capture label values K_TUZUKI K_TUZUKI

capture label define K_NENGO 1 "(調査:○3)明治" 2 "大正" 3 "昭和" 
capture label values K_NENGO K_NENGO

capture label define K_TUKI 1 "(調査:○3)1~9月" 2 "10~12月" 
capture label values K_TUKI K_TUKI

capture label define K_AGE5 1 "15~19才" 2 "20~24才" 3 "25~29才" 4 "30~34才" 5 "35~39才" 6 "40~44才" 7 "45~49才" 8 "50~54才" 9 "55~59才" 10 "60~64才" 11 "65~69才" 12 "70~74才" 13 "75~79才" 14 "80才以上" 
capture label values K_AGE5 K_AGE5

capture label define K_HAIGU 1 "(調査:○4)未婚" 2 "有配偶" 3 "死別・離別" 
capture label values K_HAIGU K_HAIGU

capture label define K_ZENJYU 1 "(調査:○5)現在の住居" 2 "同じ市区町村の別のところ" 3 "同じ都道府県の別の市区町村" 4 "他の都道府県" 5 "外国" 
capture label values K_ZENJYU K_ZENJYU

capture label define K_SOTUGYO 1 "(調査:○6)在学中" 2 "卒業" 3 "在学したことがない" 
capture label values K_SOTUGYO K_SOTUGYO

capture label define K_GAKKO 1 "(調査:○6)小学・中学" 2 "高校・旧中" 3 "短大・高専" 4 "大学・大学院" 
capture label values K_GAKKO K_GAKKO

capture label define K_SYUGYO 1 "(調査:○問1)仕事を主にしている" 2 "家事が主で仕事もしている" 3 "通学が主で仕事もしている" 4 "家事・通学以外が主で仕事もしている" 5 "家事をしている" 6 "通学している" 7 "その他" 
capture label values K_SYUGYO K_SYUGYO

capture label define YH_JYUTII 1 "(調査:○A問2)常雇" 2 "臨時雇" 3 "日雇" 4 "会社・団体等の役員" 5 "雇人あり" 6 "雇人なし" 7 "自家営業の手伝い" 8 "家庭で内職" 
capture label values YH_JYUTII YH_JYUTII

capture label define YH_KOSHO 1 "(調査:○A問2(1))正規の職員・従業員" 2 "パート・アルバイト" 3 "嘱託など" 4 "その他" 
capture label values YH_KOSHO YH_KOSHO

capture label define YH_KEIEI 1 "(調査:○A問3(1))個人" 2 "会社" 3 "その他の法人・団体" 4 "官公庁" 
capture label values YH_KEIEI YH_KEIEI

capture label define YH_NOHINOU 1 "農林業" 2 "非農林業" 
capture label values YH_NOHINOU YH_NOHINOU

capture label define YH_SAN3 1 "第1次産業" 2 "第2次産業" 3 "第3次産業" 
capture label values YH_SAN3 YH_SAN3

capture label define YH_SANDAI 1 "農業" 2 "林業,狩猟業" 3 "漁業,水産養殖業" 4 "鉱業" 5 "建設業" 6 "製造業" 7 "卸売業,小売業" 8 "金融・保険業,不動産業" 9 "運輸・通信業" 10 "電気・ガス・水道・熱供給業" 11 "サービス業" 12 "公務" 
capture label values YH_SANDAI YH_SANDAI

capture label define YH_SANM 1 "農業" 2 "林業,狩猟業" 3 "漁業,水産養殖業" 4 "鉱業" 5 "建設業" 6 "繊維工業" 7 "化学諸工業" 8 "金属工業" 9 "機械工業" 10 "その他の工業" 11 "卸売業" 12 "小売業" 13 "飲食店" 14 "金融・保険業" 15 "不動産業" 16 "運輸業" 17 "通信業" 18 "電気・ガス・水道・熱供給業" 19 "対個人サービス業" 20 "対事業所サービス業" 21 "修理業" 22 "医療業" 23 "教育" 24 "他に分類されない専門サービス業" 25 "その他のサービス業" 26 "公務" 
capture label values YH_SANM YH_SANM

capture label define YH_SANCHU 1 "(調査:○A問3(3))農業" 6 "林業,狩猟業" 8 "漁業,水産養殖業" 11 "石炭・亜炭鉱業" 13 "その他の鉱業" 15 "建設業" 18 "食料品・たばこ製造業" 20 "繊維工業" 22 "木材・木製品・家具製造業" 24 "パルプ・紙・紙加工品製造業" 25 "出版・印刷・同関連産業" 26 "化学工業" 30 "窯業,土石製品製造業" 31 "鉄鋼業" 32 "非鉄金属製造業" 33 "金属製品製造業" 34 "機械・武器製造業" 35 "電気機械器具製造業" 36 "輸送用機械器具製造業" 37 "精密機械器具製造業" 39 "その他の製造業" 40 "卸売業" 45 "飲食料品小売業" 46 "飲食店" 49 "その他の小売業" 50 "金融・保険業" 59 "不動産業" 60 "鉄道業" 61 "運送・倉庫業" 67 "通信業" 70 "電気・ガス・水道・熱供給業" 75 "対個人サービス業" 81 "対事業所サービス業" 82 "修理業" 88 "医療業" 91 "教育" 94 "他に分類されない専門サービス業" 95 "その他のサービス業" 97 "公務" 
capture label values YH_SANCHU YH_SANCHU

capture label define YH_SHODAI 1 "専門的・技術的職業従事者" 2 "管理的職業従事者" 3 "事務従事者" 4 "販売従事者" 5 "農林・漁業作業者" 6 "採鉱・採石作業者" 7 "運輸・通信従事者" 8 "技能工・生産工程作業者" 9 "労務作業者" 10 "保安職業従事者" 11 "サービス職業従事者" 
capture label values YH_SHODAI YH_SHODAI

capture label define YH_SHOM 0 "(調査:○A問4)専門的・技術的職業従事者" 10 "管理的職業従事者" 20 "事務従事者" 30 "販売従事者" 40 "農林・漁業作業者" 50 "採鉱・採石作業者" 60 "運輸・通信従事者" 70 "金属・機械・化学等技能的職業作業者" 75 "繊維・食料品等の技能的職業作業者" 85 "建設作業者,定置機関・建設機械運転作業者" 88 "その他の技能的職業作業者" 89 "労務作業者" 90 "保安職業従事者" 91 "サービス職業従事者" 
capture label values YH_SHOM YH_SHOM

capture label define YH_KAIKYU11 1 "1~4人" 2 "5~9" 3 "10~19" 4 "20~29" 5 "30~49" 6 "50~99" 7 "100~299" 8 "300~499" 9 "500~999" 10 "1000人以上" 11 "官公庁" 
capture label values YH_KAIKYU11 YH_KAIKYU11

capture label define YH_NISSU 1 "(調査:○A問6(1))50日未満" 2 "50~99日" 3 "100~149" 4 "150~199" 5 "200~249" 6 "250日以上" 
capture label values YH_NISSU YH_NISSU

capture label define YH_JYUGYO 1 "(調査:○A問6(2))不規則" 2 "ある季節だけ" 3 "だいたい規則的" 
capture label values YH_JYUGYO YH_JYUGYO

capture label define YH_JIKAN 1 "(調査:○A問6(3))15時間未満" 2 "15~21時間" 3 "22~34" 4 "35~42" 5 "43~48" 6 "49~59" 7 "60時間以上" 
capture label values YH_JIKAN YH_JIKAN

capture label define YH_SHOTOKU 1 "(調査:○A問7)収入なし・50万円未満" 2 "50~99万円" 3 "100~149" 4 "150~199" 5 "200~249" 6 "250~299" 7 "300~399" 8 "400~499" 9 "500~699" 10 "700~999" 11 "1000万円以上" 
capture label values YH_SHOTOKU YH_SHOTOKU

capture label define YH_SHUISIKI 1 "(調査:○A問8)この仕事を続けたい" 2 "この仕事のほかに別の仕事もしたい" 3 "ほかの仕事に変わりたい" 4 "仕事をすっかりやめてしまいたい" 
capture label values YH_SHUISIKI YH_SHUISIKI

capture label define YH_SYURIYU 1 "(調査:○A問9)一時的についた仕事だから" 2 "収入が少ないから" 3 "将来性がないから" 4 "定年などに備えて" 5 "時間的・肉体的に負担が大きい" 6 "知識や技能を生かしたいから" 7 "余暇を生かしたいから" 8 "家事の都合から" 9 "その他" 
capture label values YH_SYURIYU YH_SYURIYU

capture label define YH_SYUKEITAI 1 "(調査:○A問10)正規の職員・従業員として雇われたい" 2 "パート・アルバイトの仕事をしたい" 3 "自分で事業をしたい" 4 "自家営業を手伝いたい" 5 "家庭で内職したい" 6 "その他" 
capture label values YH_SYUKEITAI YH_SYUKEITAI

capture label define YH_KATUDO 1 "(調査:○A問11)探している" 2 "開業の準備をしている" 3 "何もしていない" 
capture label values YH_KATUDO YH_KATUDO

capture label define YF_FUKU 1 "(調査:○A問12)別の仕事もしている" 2 "今はしてないがある時期にはしている" 3 "別の仕事はしていない" 
capture label values YF_FUKU YF_FUKU

capture label define YF_JYUTII 1 "(調査:○A問13)雇われている" 2 "会社・団体等の役員" 3 "自営業主" 4 "自家営業の手伝い" 5 "家庭で内職" 
capture label values YF_JYUTII YF_JYUTII

capture label define YF_NOHINOU 1 "農林業" 2 "非農林業" 
capture label values YF_NOHINOU YF_NOHINOU

capture label define YF_SAN3 1 "第1次産業" 2 "第2次産業" 3 "第3次産業" 
capture label values YF_SAN3 YF_SAN3

capture label define YF_SANDAI 1 "農業" 2 "林業,狩猟業" 3 "漁業,水産養殖業" 4 "鉱業" 5 "建設業" 6 "製造業" 7 "卸売業,小売業" 8 "金融・保険業,不動産業" 9 "運輸・通信業" 10 "電気・ガス・水道・熱供給業" 11 "サービス業" 12 "公務" 
capture label values YF_SANDAI YF_SANDAI

capture label define YF_SANCHU 1 "(調査:○A問14)農業" 6 "林業,狩猟業" 8 "漁業,水産養殖業" 11 "石炭・亜炭鉱業" 13 "その他の鉱業" 15 "建設業" 18 "食料品・たばこ製造業" 20 "繊維工業" 22 "木材・木製品・家具製造業" 24 "パルプ・紙・紙加工品製造業" 25 "出版・印刷・同関連産業" 26 "化学工業" 30 "窯業,土石製品製造業" 31 "鉄鋼業" 32 "非鉄金属製造業" 33 "金属製品製造業" 34 "機械・武器製造業" 35 "電気機械器具製造業" 36 "輸送用機械器具製造業" 37 "精密機械器具製造業" 39 "その他の製造業" 40 "卸売業" 45 "飲食料品小売業" 46 "飲食店" 49 "その他の小売業" 50 "金融・保険業" 59 "不動産業" 60 "鉄道業" 61 "運送・倉庫業" 67 "通信業" 70 "電気・ガス・水道・熱供給業" 75 "対個人サービス業" 81 "対事業所サービス業" 82 "修理業" 88 "医療業" 91 "教育" 94 "他に分類されない専門サービス業" 95 "その他のサービス業" 97 "公務" 
capture label values YF_SANCHU YF_SANCHU

capture label define YF_SHOTOKU 1 "(調査:○A問15)収入なし・15万円未満" 2 "15~29万円" 3 "30~49" 4 "50~69" 5 "70~99" 6 "100~149" 7 "150~199" 8 "200~299" 9 "300万円以上" 
capture label values YF_SHOTOKU YF_SHOTOKU

capture label define YZ_KEIZOKU 1 "(調査:○A問16)一年前にも現在の仕事をしていた" 2 "一年前には現在の仕事をしていなかった" 
capture label values YZ_KEIZOKU YZ_KEIZOKU

capture label define YZ_KEINEN10 1 "1年未満" 2 "1年" 3 "2年" 4 "3~4年" 5 "5~6年" 6 "7~9年" 7 "10~14年" 8 "15~19年" 9 "20~29年" 10 "30年以上" 
capture label values YZ_KEINEN10 YZ_KEINEN10

capture label define YZ_SYUGYO 1 "(調査:○A問17)仕事をおもにしていた" 2 "家事・通学などのかたわらにしていた" 3 "家事をしていた" 4 "通学をしていた" 5 "その他" 
capture label values YZ_SYUGYO YZ_SYUGYO

capture label define YZ_SYURIYU 1 "(調査:○A問18)失業していたから" 2 "学校を卒業したから" 3 "収入を得たかったから" 4 "知識や技能を生かしたかったから" 5 "社会に出たかったから" 6 "余暇ができたから" 7 "その他" 
capture label values YZ_SYURIYU YZ_SYURIYU

capture label define YZ_ZENUMU 1 "(調査:○A問19)ある" 2 "ない" 
capture label values YZ_ZENUMU YZ_ZENUMU

capture label define M_SYUKIBOU 1 "(調査:○B問2)仕事をしたいと思っている" 2 "仕事をしたいと思っていない" 
capture label values M_SYUKIBOU M_SYUKIBOU

capture label define M_SYURIYU 1 "(調査:○B問3)失業しているから" 2 "学校を卒業したから" 3 "収入を得たいから" 4 "知識や技能を生かしたいから" 5 "社会に出たいから" 6 "余暇ができたから" 7 "その他" 
capture label values M_SYURIYU M_SYURIYU

capture label define M_SYUSIGOTO 1 "(調査:○B問4)仕事をおもにしていきたい" 2 "家事や通学のかたわらにしたい" 
capture label values M_SYUSIGOTO M_SYUSIGOTO

capture label define M_SYUKEITAI 1 "(調査:○B問5)正規の職員・従業員として雇われたい" 2 "パート・アルバイトの仕事をしたい" 3 "自分で事業をしたい" 4 "自家営業を手伝いたい" 5 "家庭で内職を手伝いたい" 6 "その他" 
capture label values M_SYUKEITAI M_SYUKEITAI

capture label define M_KYUKATUDO 1 "(調査:○B問6)探している" 2 "開業の準備をしている" 3 "何もしていない" 
capture label values M_KYUKATUDO M_KYUKATUDO

capture label define M_KYUHIRIYU 1 "(調査:○B問7)探したが見つからなかった" 2 "自分の希望する仕事がありそうにない" 3 "自分の知識・能力に自信がない" 4 "家事・育児や通学などで忙しい" 5 "急いで仕事につく必要がない" 6 "その他" 
capture label values M_KYUHIRIYU M_KYUHIRIYU

capture label define M_KYUHOHO 1 "(調査:○B問8)公共職業安定所等に申込み" 2 "事業所に直接応募" 3 "知人などに相談・あっせん依頼" 4 "広告・求人情報誌等" 5 "事業用資金の調達等" 6 "その他" 
capture label values M_KYUHOHO M_KYUHOHO

capture label define M_KYUKIKAN 1 "(調査:○B問9)1ヶ月未満" 2 "1ヶ月以上3ヶ月未満" 3 "3ヶ月以上6ヶ月未満" 4 "6ヶ月以上1年未満" 5 "1年以上2年未満" 6 "2年以上" 
capture label values M_KYUKIKAN M_KYUKIKAN

capture label define M_KIBOJIKI 1 "(調査:○B問10)すぐつくつもり" 2 "すぐではないがつくつもり" 3 "つくかどうかわからない" 
capture label values M_KIBOJIKI M_KIBOJIKI

capture label define M_ZSYUGYO 1 "(調査:○B問11)家事をしていた" 2 "通学していた" 3 "その他" 4 "仕事をおもにしていた" 5 "家事・通学などのかたわらにしていた" 
capture label values M_ZSYUGYO M_ZSYUGYO

capture label define M_ZENUMU 1 "(調査:○B問12)ある" 2 "ない" 
capture label values M_ZENUMU M_ZENUMU

capture label define Z_RIJIKI2 1 "(調査:○C問1)昭和31年以後" 2 "昭和30年以前" 
capture label values Z_RIJIKI2 Z_RIJIKI2

capture label define Z_RIYU 1 "(調査:○C問2)人員整理・会社解散・倒産のため" 2 "一時的・不安定な仕事だったから" 3 "収入が少なかったから" 4 "労働条件が悪かったから" 5 "自分に向かない仕事だったから" 6 "家族の就職・転職・転勤及び事業所の移転のため" 7 "定年などのため" 8 "病気・老齢のため" 9 "結婚のため" 10 "育児のため" 11 "その他" 
capture label values Z_RIYU Z_RIYU

capture label define Z_JYUTII 1 "(調査:○C問3)常雇" 2 "臨時雇" 3 "日雇" 4 "会社・団体等の役員" 5 "雇人あり" 6 "雇人なし" 7 "自家営業の手伝い" 8 "家庭で内職" 
capture label values Z_JYUTII Z_JYUTII

capture label define Z_NOHINOU 1 "農林業" 2 "非農林業" 
capture label values Z_NOHINOU Z_NOHINOU

capture label define Z_SAN3 1 "第1次産業" 2 "第2次産業" 3 "第3次産業" 
capture label values Z_SAN3 Z_SAN3

capture label define Z_SANDAI 1 "農業" 2 "林業,狩猟業" 3 "漁業,水産養殖業" 4 "鉱業" 5 "建設業" 6 "製造業" 7 "卸売業,小売業" 8 "金融・保険業,不動産業" 9 "運輸・通信業" 10 "電気・ガス・水道・熱供給業" 11 "サービス業" 12 "公務" 
capture label values Z_SANDAI Z_SANDAI

capture label define Z_SANCHU 1 "(調査:○C問4)農業" 6 "林業,狩猟業" 8 "漁業,水産養殖業" 11 "石炭・亜炭鉱業" 13 "その他の鉱業" 15 "建設業" 18 "食料品・たばこ製造業" 20 "繊維工業" 22 "木材・木製品・家具製造業" 24 "パルプ・紙・紙加工品製造業" 25 "出版・印刷・同関連産業" 26 "化学工業" 30 "窯業,土石製品製造業" 31 "鉄鋼業" 32 "非鉄金属製造業" 33 "金属製品製造業" 34 "機械・武器製造業" 35 "電気機械器具製造業" 36 "輸送用機械器具製造業" 37 "精密機械器具製造業" 39 "その他の製造業" 40 "卸売業" 45 "飲食料品小売業" 46 "飲食店" 49 "その他の小売業" 50 "金融・保険業" 59 "不動産業" 60 "鉄道業" 61 "運送・倉庫業" 67 "通信業" 70 "電気・ガス・水道・熱供給業" 75 "対個人サービス業" 81 "対事業所サービス業" 82 "修理業" 88 "医療業" 91 "教育" 94 "他に分類されない専門サービス業" 95 "その他のサービス業" 97 "公務" 
capture label values Z_SANCHU Z_SANCHU

capture label define Z_SHODAI 1 "専門的・技術的職業従事者" 2 "管理的職業従事者" 3 "事務従事者" 4 "販売従事者" 5 "農林・漁業作業者" 6 "採鉱・採石作業者" 7 "運輸・通信従事者" 8 "技能工・生産工程作業者" 9 "労務作業者" 10 "保安職業従事者" 11 "サービス職業従事者" 
capture label values Z_SHODAI Z_SHODAI

capture label define Z_SHOM 0 "(調査:○C問5)専門的・技術的職業従事者" 10 "管理的職業従事者" 20 "事務従事者" 30 "販売従事者" 40 "農林・漁業作業者" 50 "採鉱・採石作業者" 60 "運輸・通信従事者" 70 "金属・機械・化学等技能的職業作業者" 75 "繊維・食料品等の技能的職業作業者" 85 "建設作業者,定置機関・建設機械運転作業者" 88 "その他の技能的職業作業者" 89 "労務作業者" 90 "保安職業従事者" 91 "サービス職業従事者" 
capture label values Z_SHOM Z_SHOM

capture label define Z_KAIKYU 1 "(調査:○C問6)1~4人" 2 "5~9" 3 "10~19" 4 "20~29" 5 "30~49" 6 "50~99" 7 "100~299" 8 "300~499" 9 "500~999" 10 "1000人以上" 11 "官公庁" 
capture label values Z_KAIKYU Z_KAIKYU
