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


capture label define CHO_YEAR 1987 "" 
capture label values CHO_YEAR CHO_YEAR

capture label define CHO_MONTH 10 "" 
capture label values CHO_MONTH CHO_MONTH

capture label define S_IPPAN 1 "一般世帯" 2 "単身世帯" 
capture label values S_IPPAN S_IPPAN

capture label define S_KAZOKURUI 1 "夫婦のみの世帯" 2 "夫婦と子供からなる世帯" 3 "夫婦と両親からなる世帯" 4 "夫婦と片親からなる世帯" 5 "夫婦と子供と両親からなる世帯" 6 "夫婦と子供と片親からなる世帯" 7 "その他の世帯+単身世帯" 
capture label values S_KAZOKURUI S_KAZOKURUI

capture label define S_JIN0 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN0 S_JIN0

capture label define S_JIN1 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN1 S_JIN1

capture label define S_JIN2 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN2 S_JIN2

capture label define S_JIN3 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN3 S_JIN3

capture label define S_JIN4 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN4 S_JIN4

capture label define S_JIN5 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN5 S_JIN5

capture label define S_JIN6 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN6 S_JIN6

capture label define S_JIN7 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN7 S_JIN7

capture label define S_JIN8 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN8 S_JIN8

capture label define S_JIN9 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN9 S_JIN9

capture label define S_JIN10 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN10 S_JIN10

capture label define S_JIN11 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN11 S_JIN11

capture label define S_JIN12 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN12 S_JIN12

capture label define S_JIN13 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN13 S_JIN13

capture label define S_JIN14 0 "記入なし" 1 "1人" 2 "2人" 3 "3人" 4 "4人" 5 "5人" 
capture label values S_JIN14 S_JIN14

capture label define S_OMOSYU 1 "(調査:○D1)賃金・給料" 2 "農業収入" 3 "その他の事業収入" 4 "内職収入" 5 "家賃・地代" 6 "利子・配当" 7 "恩給・年金" 8 "雇用保険" 9 "生活保護" 10 "その他(仕送りなど)" 
capture label values S_OMOSYU S_OMOSYU

capture label define S_SHOTOKU 1 "(調査:○D2)100万円未満" 2 "100~149万円" 3 "150~199万円" 4 "200~249万円" 5 "250~299万円" 6 "300~399万円" 7 "400~499万円" 8 "500~699万円" 9 "700~999万円" 10 "1000~1499万円" 11 "1500万円以上" 
capture label values S_SHOTOKU S_SHOTOKU

capture label define K_SEX 1 "(調査:○1)男" 2 "女" 
capture label values K_SEX K_SEX

capture label define K_TUZUKI 1 "(調査:○2)世帯主又は代表者" 2 "世帯主の配偶者" 3 "子" 4 "子の配偶者" 5 "孫" 6 "父母" 7 "祖父母" 8 "兄弟姉妹" 9 "他の親族" 10 "その他" 
capture label values K_TUZUKI K_TUZUKI

capture label define K_NENGO 1 "(調査:○3)明治" 2 "大正" 3 "昭和" 
capture label values K_NENGO K_NENGO

capture label define K_TUKI 1 "(調査:○3)1~9月" 2 "10~12月" 
capture label values K_TUKI K_TUKI

capture label define K_AGE5 1 "15~19才" 2 "20~24才" 3 "25~29才" 4 "30~34才" 5 "35~39才" 6 "40~44才" 7 "45~49才" 8 "50~54才" 9 "55~59才" 10 "60~64才" 11 "65~69才" 12 "70~74才" 13 "75才以上" 
capture label values K_AGE5 K_AGE5

capture label define K_AGE10 1 "15~24才" 2 "25~34才" 3 "35~44才" 4 "45~54才" 5 "55~64才" 6 "65才以上" 
capture label values K_AGE10 K_AGE10

capture label define K_HAIGU 1 "(調査:○4)未婚" 2 "有配偶" 3 "死別・離別" 
capture label values K_HAIGU K_HAIGU

capture label define K_ZENJYU 1 "(調査:○5)現在の住居" 2 "同じ市区町村の別のところ" 3 "同じ都道府県の別の市区町村" 4 "他の都道府県" 5 "外国" 
capture label values K_ZENJYU K_ZENJYU

capture label define K_SOTUGYO 1 "(調査:○6)在学中" 2 "卒業" 3 "在学したことがない" 
capture label values K_SOTUGYO K_SOTUGYO

capture label define K_GAKKO 1 "(調査:○6)小学・中学" 2 "高校・旧中" 3 "短大・高専" 4 "大学・大学院" 
capture label values K_GAKKO K_GAKKO

capture label define K_SYUGYO 1 "(調査:○問1)仕事を主にしている" 2 "家事が主で仕事もしている" 3 "通学が主で仕事もしている" 4 "家事通学以外が主で仕事もしている" 5 "家事をしている" 6 "通学をしている" 7 "その他" 
capture label values K_SYUGYO K_SYUGYO

capture label define YH_JYUTII 1 "(調査:○A1)常雇(一般常雇)" 2 "臨時雇" 3 "日雇" 4 "会社団体等の役員(民間の役員)" 5 "雇人あり" 6 "雇人なし" 7 "自家営業の手伝い" 8 "家庭で内職" 
capture label values YH_JYUTII YH_JYUTII

capture label define YH_KOSHO7 1 "民間の役員" 2 "正規の職員" 3 "パート" 4 "アルバイト" 5 "嘱託など" 6 "派遣社員" 7 "その他" 
capture label values YH_KOSHO7 YH_KOSHO7

capture label define YH_KEIEI 1 "(調査:○A3)個人" 2 "会社" 3 "その他の法人・団体" 4 "官公庁" 
capture label values YH_KEIEI YH_KEIEI

capture label define YH_NOHINOU 1 "農林業" 2 "非農林業" 
capture label values YH_NOHINOU YH_NOHINOU

capture label define YH_SAN3 1 "第1次産業" 2 "第2次産業" 3 "第3次産業" 
capture label values YH_SAN3 YH_SAN3

capture label define YH_SANDAI 1 "A農業" 2 "B林業" 3 "C漁業" 4 "D鉱業" 5 "E建設業" 6 "F製造業" 7 "G電気・ガス・熱供給・水道業" 8 "H運輸・通信業" 9 "I卸売・小売業,飲食店" 10 "J金融・保険業,不動産業" 11 "Lサービス業" 12 "M公務" 
capture label values YH_SANDAI YH_SANDAI

capture label define YH_SANM 1 "農業" 2 "林業" 3 "漁業" 4 "鉱業" 5 "建設業" 6 "繊維工業" 7 "化学諸工業" 8 "金属工業" 9 "機械工業" 10 "その他の工業" 11 "電気・ガス・熱供給・水道業" 12 "運輸業" 13 "通信業" 14 "卸売業" 15 "小売業" 16 "飲食店" 17 "金融・保険業" 18 "不動産業" 19 "対個人サービス業" 20 "対事業所サービス業" 21 "修理業" 22 "医療業" 23 "教育" 24 "他に分類されない専門サービス業" 25 "その他のサービス業" 26 "公務" 
capture label values YH_SANM YH_SANM

capture label define YH_SANCHU 1 "(調査:○)01農業" 2 "02林業" 3 "03漁業" 6 "06石炭・亜炭鉱業" 8 "08その他鉱業" 9 "09建設業" 12 "12食料品・飲料・たばこ製造業" 14 "14繊維工業" 16 "16木材・木製品・家具製造業" 18 "18パルプ・紙・紙加工品製造業" 19 "19出版・印刷・同関連産業" 20 "20化学工業" 25 "25窯業・土石製品製造業" 26 "26鉄鋼業" 27 "27非鉄金属製造業" 28 "28金属製品製造業" 29 "29機械・武器製造業" 30 "30電気機械器具製造業" 31 "31輸送用機械器具製造業" 32 "32精密機械器具製造業" 34 "34その他の製造業" 36 "36電気・ガス・熱供給・水道業" 40 "40鉄道業" 41 "41運送・倉庫業" 47 "47通信業" 49 "49卸売業" 55 "55飲食料品小売業" 58 "58その他の小売業" 59 "59飲食店" 61 "61金融・保険業" 69 "69不動産業" 73 "73対個人サービス業" 79 "79対事業所サービス業" 81 "81修理業" 87 "87医療業" 91 "91教育" 94 "94他に分類されない専門サービス業" 95 "95その他のサービス業" 97 "97公務" 
capture label values YH_SANCHU YH_SANCHU

capture label define YH_SHODAI 1 "専門的・技術的職業従事者" 2 "管理的職業従事者" 3 "事務従事者" 4 "販売従事者" 5 "農林漁業作業者" 6 "採掘作業者" 7 "運輸・通信従事者" 8 "技能工,生産工程作業者" 9 "労務作業者" 10 "保安職業従事者" 11 "サービス職業従事者" 
capture label values YH_SHODAI YH_SHODAI

capture label define YH_SHOM 0 "(調査:○)専門的・技術的職業従事者" 10 "管理的職業従事者" 20 "事務従事者" 30 "販売従事者" 40 "農林漁業作業者" 50 "採掘作業者" 60 "運輸・通信従事者" 70 "金属,機械,化学等技能的職業作業者" 75 "繊維,食料品等の技能的職業作業者" 85 "建設作業者,定置機関・機械及び建設機械運転作業者" 88 "その他の職業作業者" 
capture label values YH_SHOM YH_SHOM

capture label define YH_KAIKYU11 1 "1~4人" 2 "5~9人" 3 "10~19人" 4 "20~29人" 5 "30~49人" 6 "50~99人" 7 "100~299人" 8 "300~499人" 9 "500~999人" 10 "1000人以上" 11 "官公庁" 
capture label values YH_KAIKYU11 YH_KAIKYU11

capture label define YH_NISSU 1 "(調査:○A6)50日未満" 2 "50~99日" 3 "100~149日" 4 "150~199日" 5 "200~249日" 6 "250日以上" 
capture label values YH_NISSU YH_NISSU

capture label define YH_JYUGYO 1 "(調査:○A6)不規則" 2 "ある季節だけ" 3 "だいたい規則的" 
capture label values YH_JYUGYO YH_JYUGYO

capture label define YH_JIKAN 1 "(調査:○A6)15時間未満" 2 "15~21時間" 3 "22~34時間" 4 "35~42時間" 5 "43~48時間" 6 "49~59時間" 7 "60時間以上" 
capture label values YH_JIKAN YH_JIKAN

capture label define YH_SHOTOKU 1 "(調査:○A7)収入なし・50万円未満" 2 "50~99万円" 3 "100~149万円" 4 "150~199万円" 5 "200~249万円" 6 "250~299万円" 7 "300~399万円" 8 "400~499万円" 9 "500~699万円" 10 "700~999万円" 11 "1000万円以上" 
capture label values YH_SHOTOKU YH_SHOTOKU

capture label define YH_SYUISIKI 1 "(調査:○A8)この仕事を続けたい" 2 "副業をもちたい" 3 "転職したい" 4 "仕事をやめたい" 
capture label values YH_SYUISIKI YH_SYUISIKI

capture label define YH_SYUZOGEN 1 "(調査:○A8・2)今のままでよい" 2 "時間を増やしたい" 3 "時間を減らしたい" 
capture label values YH_SYUZOGEN YH_SYUZOGEN

capture label define YH_SYURIYU 1 "(調査:○A9)一時的な仕事だから" 2 "収入が少ないから" 3 "将来性が少ないから" 4 "定年などに備えて" 5 "時間的肉体的に負担が大きいから" 6 "知識や技能を生かしたいから" 7 "余暇を増やしたいから" 8 "家事の都合から" 9 "その他" 
capture label values YH_SYURIYU YH_SYURIYU

capture label define YH_SYUKEITAI 1 "(調査:○A10)正規の職員・従業員として" 2 "パート・アルバイトの仕事" 3 "自分で事業をしたい" 4 "自家営業を手伝いたい" 5 "家庭で内職したい" 6 "その他" 
capture label values YH_SYUKEITAI YH_SYUKEITAI

capture label define YH_KATUDO 1 "(調査:○A11)探している" 2 "開業の準備をしている" 3 "何もしていない" 
capture label values YH_KATUDO YH_KATUDO

capture label define YF_FUKU 1 "(調査:○A12)別の仕事もしている" 2 "今はしていないがある時期にはしている" 3 "別の仕事はしていない" 
capture label values YF_FUKU YF_FUKU

capture label define YF_JYUTII 1 "(調査:○A13)雇われている" 2 "会社団体の役員" 3 "自営業主" 4 "自家営業の手伝い" 5 "家庭で内職" 
capture label values YF_JYUTII YF_JYUTII

capture label define YF_NOHINOU 1 "農林業" 2 "非農林業" 
capture label values YF_NOHINOU YF_NOHINOU

capture label define YF_SAN3 1 "第1次産業" 2 "第2次産業" 3 "第3次産業" 
capture label values YF_SAN3 YF_SAN3

capture label define YF_SANDAI 1 "A農業" 2 "B林業" 3 "C漁業" 4 "D鉱業" 5 "E建設業" 6 "F製造業" 7 "G電気・ガス・熱供給・水道業" 8 "H運輸・通信業" 9 "I卸売・小売業,飲食店" 10 "J金融・保険業,不動産業" 11 "Lサービス業" 12 "M公務" 
capture label values YF_SANDAI YF_SANDAI

capture label define YF_SANCHU 1 "(調査:○)01農業" 2 "02林業" 3 "03漁業" 6 "06石炭・亜炭鉱業" 8 "08その他鉱業" 9 "09建設業" 12 "12食料品・飲料・たばこ製造業" 14 "14繊維工業" 16 "16木材・木製品・家具製造業" 18 "18パルプ・紙・紙加工品製造業" 19 "19出版・印刷・同関連産業" 20 "20化学工業" 25 "25窯業・土石製品製造業" 26 "26鉄鋼業" 27 "27非鉄金属製造業" 28 "28金属製品製造業" 29 "29機械・武器製造業" 30 "30電気機械器具製造業" 31 "31輸送用機械器具製造業" 32 "32精密機械器具製造業" 34 "34その他の製造業" 36 "36電気・ガス・熱供給・水道業" 40 "40鉄道業" 41 "41運送・倉庫業" 47 "47通信業" 49 "49卸売業" 55 "55飲食料品小売業" 58 "58その他の小売業" 59 "59飲食店" 61 "61金融・保険業" 69 "69不動産業" 73 "73対個人サービス業" 79 "79対事業所サービス業" 81 "81修理業" 87 "87医療業" 91 "91教育" 94 "94他に分類されない専門サービス業" 95 "95その他のサービス業" 97 "97公務" 
capture label values YF_SANCHU YF_SANCHU

capture label define YF_SHOTOKU 1 "(調査:○A15)収入なし・15万円未満" 2 "15~29万円" 3 "30~49万円" 4 "50~69万円" 5 "70~99万円" 6 "100~149万円" 7 "150~199万円" 8 "200~299万円" 9 "300万円以上" 
capture label values YF_SHOTOKU YF_SHOTOKU

capture label define YZ_KEIZOKU 1 "(調査:○A16)一年前にも現在の仕事をしていた" 2 "一年前には現在の仕事をしていなかった" 
capture label values YZ_KEIZOKU YZ_KEIZOKU

capture label define YZ_SYUGYO 1 "(調査:○A17)仕事を主にしていた" 2 "家事通学などのかたわらにしていた" 3 "家事をしていた" 4 "通学をしていた" 5 "その他" 
capture label values YZ_SYUGYO YZ_SYUGYO

capture label define YZ_SYURIYU 1 "(調査:○A18)失業していたから" 2 "学校を卒業したから" 3 "収入を得たかったから" 4 "知識や技能を生かしたかったから" 5 "社会に出たかったから" 6 "余暇ができたから" 7 "その他" 
capture label values YZ_SYURIYU YZ_SYURIYU

capture label define YZ_ZENUMU 1 "(調査:○A19)前職あり" 2 "前職なし" 
capture label values YZ_ZENUMU YZ_ZENUMU

capture label define M_SYUKIBOU 1 "(調査:○B2)仕事をしたいと思っている" 2 "仕事をしたいと思っていない" 
capture label values M_SYUKIBOU M_SYUKIBOU

capture label define M_SYURIYU 1 "(調査:○B3)失業していたから" 2 "学校を卒業したから" 3 "収入を得たかったから" 4 "知識や技能を生かしたかったから" 5 "社会に出たかったから" 6 "余暇ができたから" 7 "その他" 
capture label values M_SYURIYU M_SYURIYU

capture label define M_SYUSIGOTO 1 "(調査:○B4)仕事を主にしていきたい" 2 "家事通学のかたわらにしたい" 
capture label values M_SYUSIGOTO M_SYUSIGOTO

capture label define M_SYUKEITAI 1 "(調査:○B5)正規の職員・従業員として" 2 "パート・アルバイトの仕事" 3 "自分で事業をしたい" 4 "自家営業を手伝いたい" 5 "家庭で内職したい" 6 "その他" 
capture label values M_SYUKEITAI M_SYUKEITAI

capture label define M_KYUKATUDO 1 "(調査:○B6)探している" 2 "開業の準備をしている" 3 "何もしていない" 
capture label values M_KYUKATUDO M_KYUKATUDO

capture label define M_KYUHIRIYU 1 "(調査:○B7)探したが見つからなかった" 2 "自分の希望する仕事がありそうにない" 3 "自分の知識能力に自信がない" 4 "家事育児や通学などで忙しい" 5 "急いで仕事につく必要がない" 6 "その他" 
capture label values M_KYUHIRIYU M_KYUHIRIYU

capture label define M_KYUHOHO 1 "(調査:○B8)公共職業安定所等に申し込み" 2 "事業所に直接応募" 3 "知人などに相談・あっせん依頼" 4 "広告・求人情報誌等" 5 "人材派遣業に登録" 6 "事業所用資金の調達等" 7 "その他" 
capture label values M_KYUHOHO M_KYUHOHO

capture label define M_KYUKIKAN 1 "(調査:○B9)1か月未満" 2 "1か月以上3か月未満" 3 "3か月以上6か月未満" 4 "6か月以上1年未満" 5 "1年以上2年未満" 6 "2年以上" 
capture label values M_KYUKIKAN M_KYUKIKAN

capture label define M_KIBOJIKI 1 "(調査:○B10)すぐつくつもり" 2 "すぐではないがつくつもり" 3 "すぐつくかどうかわからない" 
capture label values M_KIBOJIKI M_KIBOJIKI

capture label define M_ZSYUGYO 1 "(調査:○B11)家事をしていた" 2 "通学をしていた" 3 "その他" 4 "仕事を主にしていた" 5 "家事・通学のかたわらにしていた" 
capture label values M_ZSYUGYO M_ZSYUGYO

capture label define M_ZENUMU 1 "(調査:○B12)ある" 2 "ない" 
capture label values M_ZENUMU M_ZENUMU

capture label define Z_RIJIKI2 1 "(調査:○C1)昭和36年以降" 2 "昭和35年以前" 
capture label values Z_RIJIKI2 Z_RIJIKI2

capture label define Z_RIYU 1 "(調査:○C2)人員整理・会社解散・倒産のため" 2 "一時的・不安定な仕事だったから" 3 "収入が少なかったから" 4 "労働条件が悪かったから" 5 "自分に向かない仕事だったから" 6 "家族の就職・転職・転勤及び事業所の移転のため" 7 "定年などのため" 8 "病気・老齢のため" 9 "結婚のため" 10 "育児のため" 11 "その他" 
capture label values Z_RIYU Z_RIYU

capture label define Z_JYUTII 1 "(調査:○C3)常雇" 2 "臨時雇" 3 "日雇" 4 "会社・団体等の役員" 5 "自営業主・雇人あり" 6 "自営業主・雇人なし" 7 "自家営業の手伝い" 8 "家庭で内職" 
capture label values Z_JYUTII Z_JYUTII

capture label define Z_NOHINOU 1 "農林業" 2 "非農林業" 
capture label values Z_NOHINOU Z_NOHINOU

capture label define Z_SAN3 1 "第1次産業" 2 "第2次産業" 3 "第3次産業" 
capture label values Z_SAN3 Z_SAN3

capture label define Z_SANDAI 1 "A農業" 2 "B林業" 3 "C漁業" 4 "D鉱業" 5 "E建設業" 6 "F製造業" 7 "G電気・ガス・熱供給・水道業" 8 "H運輸・通信業" 9 "I卸売・小売業,飲食店" 10 "J金融・保険業,不動産業" 11 "Lサービス業" 12 "M公務" 
capture label values Z_SANDAI Z_SANDAI

capture label define Z_SANCHU 1 "(調査:○)01農業" 2 "02林業" 3 "03漁業" 6 "06石炭・亜炭鉱業" 8 "08その他鉱業" 9 "09建設業" 12 "12食料品・飲料・たばこ製造業" 14 "14繊維工業" 16 "16木材・木製品・家具製造業" 18 "18パルプ・紙・紙加工品製造業" 19 "19出版・印刷・同関連産業" 20 "20化学工業" 25 "25窯業・土石製品製造業" 26 "26鉄鋼業" 27 "27非鉄金属製造業" 28 "28金属製品製造業" 29 "29機械・武器製造業" 30 "30電気機械器具製造業" 31 "31輸送用機械器具製造業" 32 "32精密機械器具製造業" 34 "34その他の製造業" 36 "36電気・ガス・熱供給・水道業" 40 "40鉄道業" 41 "41運送・倉庫業" 47 "47通信業" 49 "49卸売業" 55 "55飲食料品小売業" 58 "58その他の小売業" 59 "59飲食店" 61 "61金融・保険業" 69 "69不動産業" 73 "73対個人サービス業" 79 "79対事業所サービス業" 81 "81修理業" 87 "87医療業" 91 "91教育" 94 "94他に分類されない専門サービス業" 95 "95その他のサービス業" 97 "97公務" 
capture label values Z_SANCHU Z_SANCHU

capture label define Z_SHODAI 1 "専門的・技術的職業従事者" 2 "管理的職業従事者" 3 "事務従事者" 4 "販売従事者" 5 "農林漁業作業者" 6 "採掘作業者" 7 "運輸・通信従事者" 8 "技能工,生産工程作業者" 9 "労務作業者" 10 "保安職業従事者" 11 "サービス職業従事者" 
capture label values Z_SHODAI Z_SHODAI

capture label define Z_SHOM 0 "(調査:○)専門的・技術的職業従事者" 10 "管理的職業従事者" 20 "事務従事者" 30 "販売従事者" 40 "農林漁業作業者" 50 "採掘作業者" 60 "運輸・通信従事者" 70 "金属,機械,化学等技能的職業作業者" 75 "繊維,食料品等の技能的職業作業者" 85 "建設作業者,定置機関・機械及び建設機械運転作業者" 88 "その他の職業作業者" 
capture label values Z_SHOM Z_SHOM

capture label define Z_KAIKYU 1 "(調査:○C6)1~4人" 2 "5~9人" 3 "10~19人" 4 "20~29人" 5 "30~49人" 6 "50~99人" 7 "100~299人" 8 "300~499人" 9 "500~999人" 10 "1000人以上" 11 "官公庁" 
capture label values Z_KAIKYU Z_KAIKYU
