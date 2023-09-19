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


capture label variable CHO_YEAR "調査に関する事項: 調査年"
capture label variable CHO_MONTH "調査に関する事項: 調査月"
capture label variable CHIKI_KEN "所在地に関する項目: 都道府県"
capture label variable CHIKI_CITY "所在地に関する項目: 市区町村"
capture label variable CHIKI_CHONO "所在地に関する項目: 調査区番号"
capture label variable WAT_SHUKEI "ウェイト: 集計用乗率"
capture label variable S_RENBAN "世帯番号: 調査区内連番"
capture label variable S_ORGBANGO "世帯番号: オリジナル・コード"
capture label variable S_SETIINNO "世帯員番号"
capture label variable S_IPPAN "世帯に関する事項: 一般・単身の別"
capture label variable S_KAZOKURUI "世帯に関する事項: 特定家族類型"
capture label variable S_JIN0 "世帯に関する事項世帯人員: 0才"
capture label variable S_JIN1 "世帯に関する事項世帯人員: 1才"
capture label variable S_JIN2 "世帯に関する事項世帯人員: 2才"
capture label variable S_JIN3 "世帯に関する事項世帯人員: 3才"
capture label variable S_JIN4 "世帯に関する事項世帯人員: 4才"
capture label variable S_JIN5 "世帯に関する事項世帯人員: 5才"
capture label variable S_JIN6 "世帯に関する事項世帯人員: 6才"
capture label variable S_JIN7 "世帯に関する事項世帯人員: 7才"
capture label variable S_JIN8 "世帯に関する事項世帯人員: 8才"
capture label variable S_JIN9 "世帯に関する事項世帯人員: 9才"
capture label variable S_JIN10 "世帯に関する事項世帯人員: 10才"
capture label variable S_JIN11 "世帯に関する事項世帯人員: 11才"
capture label variable S_JIN12 "世帯に関する事項世帯人員: 12才"
capture label variable S_JIN13 "世帯に関する事項世帯人員: 13才"
capture label variable S_JIN14 "世帯に関する事項世帯人員: 14才"
capture label variable S_JIN15MI "世帯に関する事項世帯人員: 15才未満の合計"
capture label variable S_JIN15IJO "世帯に関する事項世帯人員: 15才以上の合計"
capture label variable S_OMOSYU "世帯に関する事項D.世帯主について世帯の収入の種類主な収入: 10区分"
capture label variable S_JYU1 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入(マルチアンサー項目): 賃金・給料"
capture label variable S_JYU2 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入(マルチアンサー項目): 農業収入"
capture label variable S_JYU3 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入(マルチアンサー項目): その他の事業収入"
capture label variable S_JYU4 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入(マルチアンサー項目): 内職収入"
capture label variable S_JYU5 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入(マルチアンサー項目): 家賃・地代"
capture label variable S_JYU6 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入(マルチアンサー項目): 利子・配当"
capture label variable S_JYU7 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入(マルチアンサー項目): 恩給・年金"
capture label variable S_JYU8 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入(マルチアンサー項目): 雇用保険"
capture label variable S_JYU9 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入(マルチアンサー項目): 生活保護"
capture label variable S_JYU10 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入(マルチアンサー項目): その他(仕送りなど)"
capture label variable S_SHOTOKU "世帯に関する事項D.世帯主について: 年間世帯収入区分"
capture label variable K_SEX "個人に関する事項基本属性: 性別"
capture label variable K_TUZUKI "個人に関する事項基本属性続柄: 9区分"
capture label variable K_NENGO "個人に関する事項基本属性生年月: 年号"
capture label variable K_NEN "個人に関する事項基本属性生年月: 年"
capture label variable K_TUKI "個人に関する事項基本属性生年月: 月"
capture label variable K_AGE "個人に関する事項基本属性年令: 各才"
capture label variable K_AGE5 "個人に関する事項基本属性年令: 5才階級"
capture label variable K_HAIGU "個人に関する事項基本属性: 配偶関係"
capture label variable K_ZENJYU "個人に関する事項基本属性前住地: 5区分"
capture label variable K_ZENJYUKEN "個人に関する事項基本属性前住地: 県番"
capture label variable K_SOTUGYO "個人に関する事項基本属性教育: 教育区分"
capture label variable K_GAKKO "個人に関する事項基本属性教育: 学校区分"
capture label variable K_SYUGYO "個人に関する事項就業状態: 就業状況"
capture label variable YH_JYUTII "個人に関する事項A.有業者本業従業上の地位: 8区分"
capture label variable YH_KOSHO "個人に関する事項A.有業者本業: 勤め先における呼称"
capture label variable YH_KEIEI "個人に関する事項A.有業者本業: 経営組織"
capture label variable YH_NOHINOU "個人に関する事項A.有業者本業産業: 農・非農"
capture label variable YH_SAN3 "個人に関する事項A.有業者本業産業: 3部門"
capture label variable YH_SANDAI "個人に関する事項A.有業者本業産業: 大分類"
capture label variable YH_SANM "個人に関する事項A.有業者本業産業: 中間分類"
capture label variable YH_SANCHU "個人に関する事項A.有業者本業産業: 中分類"
capture label variable YH_SHODAI "個人に関する事項A.有業者本業職業: 大分類"
capture label variable YH_SHOM "個人に関する事項A.有業者本業職業: 中間分類"
capture label variable YH_KAIKYU11 "個人に関する事項A.有業者本業従業者階級: 11区分"
capture label variable YH_NISSU "個人に関する事項A.有業者本業年間就業日数: 6区分"
capture label variable YH_JYUGYO "個人に関する事項A.有業者本業: 従業状況"
capture label variable YH_JIKAN "個人に関する事項A.有業者本業週間就業時間: 7区分"
capture label variable YH_SHOTOKU "個人に関する事項A.有業者本業年間収入個人収入: 11区分"
capture label variable YH_SHUISIKI "個人に関する事項A.有業者本業就業希望: 意識"
capture label variable YH_SYURIYU "個人に関する事項A.有業者本業就業希望: 理由"
capture label variable YH_SYUKEITAI "個人に関する事項A.有業者本業就業希望: 形態"
capture label variable YH_KATUDO "個人に関する事項A.有業者本業: 求職活動の有無"
capture label variable YF_FUKU "個人に関する事項A.有業者副業: 副業の有無"
capture label variable YF_JYUTII "個人に関する事項A.有業者副業: 従業上の地位"
capture label variable YF_NOHINOU "個人に関する事項A.有業者副業産業: 農・非農"
capture label variable YF_SAN3 "個人に関する事項A.有業者副業産業: 3部門"
capture label variable YF_SANDAI "個人に関する事項A.有業者副業産業: 大分類"
capture label variable YF_SANCHU "個人に関する事項A.有業者副業産業: 中分類"
capture label variable YF_SHOTOKU "個人に関する事項A.有業者副業年間収入個人収入: 9区分"
capture label variable YZ_KEIZOKU "個人に関する事項A.有業者一年前について: 継続就業か否か"
capture label variable YZ_KEINEN10 "個人に関する事項A.有業者一年前について継続年数: 10区分"
capture label variable YZ_KEINEN "個人に関する事項A.有業者一年前について継続年数: 年数"
capture label variable YZ_SYUGYO "個人に関する事項A.有業者一年前について: 就業状況"
capture label variable YZ_SYURIYU "個人に関する事項A.有業者一年前について: 就業理由"
capture label variable YZ_ZENUMU "個人に関する事項A.有業者: 前職の有無"
capture label variable M_SYUKIBOU "個人に関する事項B.無業者就業希望: 有無"
capture label variable M_SYURIYU "個人に関する事項B.無業者就業希望: 理由"
capture label variable M_SYUSIGOTO "個人に関する事項B.無業者就業希望: 仕事の主従"
capture label variable M_SYUKEITAI "個人に関する事項B.無業者就業希望: 形態"
capture label variable M_KYUKATUDO "個人に関する事項B.無業者求職活動: 有無"
capture label variable M_KYUHIRIYU "個人に関する事項B.無業者求職活動: 非求職理由"
capture label variable M_KYUHOHO "個人に関する事項B.無業者求職活動: 方法"
capture label variable M_KYUKIKAN "個人に関する事項B.無業者求職活動: 期間"
capture label variable M_KIBOJIKI "個人に関する事項B.無業者: 就業希望時期"
capture label variable M_ZSYUGYO "個人に関する事項B.無業者: 1年前の就業状況"
capture label variable M_ZENUMU "個人に関する事項B.無業者: 前職の有無"
capture label variable Z_RIJIKI2 "個人に関する事項C.前の仕事について離職時期: 2区分"
capture label variable Z_RIJIKINEN "個人に関する事項C.前の仕事について離職時期: 年"
capture label variable Z_RIYU "個人に関する事項C.前の仕事について: 離職理由"
capture label variable Z_JYUTII "個人に関する事項C.前の仕事について: 従業上の地位"
capture label variable Z_NOHINOU "個人に関する事項C.前の仕事について産業: 農・非農"
capture label variable Z_SAN3 "個人に関する事項C.前の仕事について産業: 3部門"
capture label variable Z_SANDAI "個人に関する事項C.前の仕事について産業: 大分類"
capture label variable Z_SANCHU "個人に関する事項C.前の仕事について産業: 中分類"
capture label variable Z_SHODAI "個人に関する事項C.前の仕事について職業: 大分類"
capture label variable Z_SHOM "個人に関する事項C.前の仕事について職業: 中間分類"
capture label variable Z_KAIKYU "個人に関する事項C.前の仕事について: 従業者階級"
capture label variable Z_KEINEN "個人に関する事項C.前の仕事について: 継続年数"
