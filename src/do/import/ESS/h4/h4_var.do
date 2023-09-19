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


capture label variable CHO_YEAR "RID: 調査年"
capture label variable CHO_MONTH "RID: 調査月"
capture label variable CHIKI_KEN "所在地に関する項目市区町村符号: 都道府県"
capture label variable CHIKI_CITY "所在地に関する項目市区町村符号: 市区町村"
capture label variable CHIKI_CHONO "所在地に関する項目: 調査区番号"
capture label variable WAT_SHUKEI "ウェイト: 集計用乗率"
capture label variable S_RENBAN "世帯番号: 調査区内連番"
capture label variable S_ORGBANGO "世帯番号: オリジナル・コード"
capture label variable S_SETIINNO "世帯員番号"
capture label variable S_IPPAN "世帯に関する事項: 一般世帯・単身世帯の別"
capture label variable S_KAZOKURUI "世帯に関する事項: 特定家族類型"
capture label variable S_JIN0 "世帯に関する事項世帯人員: 0歳"
capture label variable S_JIN1 "世帯に関する事項世帯人員: 1歳"
capture label variable S_JIN2 "世帯に関する事項世帯人員: 2歳"
capture label variable S_JIN3 "世帯に関する事項世帯人員: 3歳"
capture label variable S_JIN4 "世帯に関する事項世帯人員: 4歳"
capture label variable S_JIN5 "世帯に関する事項世帯人員: 5歳"
capture label variable S_JIN6 "世帯に関する事項世帯人員: 6歳"
capture label variable S_JIN7 "世帯に関する事項世帯人員: 7歳"
capture label variable S_JIN8 "世帯に関する事項世帯人員: 8歳"
capture label variable S_JIN9 "世帯に関する事項世帯人員: 9歳"
capture label variable S_JIN10 "世帯に関する事項世帯人員: 10歳"
capture label variable S_JIN11 "世帯に関する事項世帯人員: 11歳"
capture label variable S_JIN12 "世帯に関する事項世帯人員: 12歳"
capture label variable S_JIN13 "世帯に関する事項世帯人員: 13歳"
capture label variable S_JIN14 "世帯に関する事項世帯人員: 14歳"
capture label variable S_JIN15MI "世帯に関する事項世帯人員: 15歳未満の合計"
capture label variable S_JIN15IJO "世帯に関する事項世帯人員: 15歳以上の合計"
capture label variable S_OMOSYU "世帯に関する事項D.世帯主について世帯の収入の種類: 主な収入10区分"
capture label variable S_JYU1 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入: 1"
capture label variable S_JYU2 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入: 2"
capture label variable S_JYU3 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入: 3"
capture label variable S_JYU4 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入: 4"
capture label variable S_JYU5 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入: 5"
capture label variable S_JYU6 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入: 6"
capture label variable S_JYU7 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入: 7"
capture label variable S_JYU8 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入: 8"
capture label variable S_JYU9 "世帯に関する事項D.世帯主について世帯の収入の種類従な収入: 9"
capture label variable S_SHOTOKU "世帯に関する事項D.世帯主について: 年間世帯収入区分"
capture label variable K_SEX "個人に関する事項: 性別"
capture label variable K_TUZUKI "個人に関する事項: 続柄"
capture label variable K_NENGO "個人に関する事項生年月: 年号"
capture label variable K_NEN "個人に関する事項生年月: 年"
capture label variable K_TUKI "個人に関する事項生年月: 月区分"
capture label variable K_AGE "個人に関する事項年齢: 各歳"
capture label variable K_AGE5 "個人に関する事項年齢: 5歳階級"
capture label variable K_AGE10 "個人に関する事項年齢: 10歳階級"
capture label variable K_HAIGU "個人に関する事項: 配偶関係"
capture label variable K_ZENJYU "個人に関する事項前住地: 5区分"
capture label variable K_ZENJYUKEN "個人に関する事項前住地: 県番"
capture label variable K_SOTUGYO "個人に関する事項教育: 教育区分"
capture label variable K_GAKKO "個人に関する事項教育: 学校区分"
capture label variable K_SYUGYO "個人に関する事項教育: 就業状況"
capture label variable YH_JYUTII "個人に関する事項A有業者本業従業上の地位: 従業上の地位(8区分)"
capture label variable YH_KOSHO7 "個人に関する事項A有業者本業勤め先の呼称: 勤め先の呼称(7区分)"
capture label variable YH_KEIEI "個人に関する事項A有業者本業: 経営組織"
capture label variable YH_NOHINOU "個人に関する事項A有業者本業産業: 農・非農"
capture label variable YH_SAN3 "個人に関する事項A有業者本業産業: 3部門"
capture label variable YH_SANDAI "個人に関する事項A有業者本業産業: 産業大分類"
capture label variable YH_SANM "個人に関する事項A有業者本業産業: 産業中間分類"
capture label variable YH_SANCHU "個人に関する事項A有業者本業産業: 産業中分類"
capture label variable YH_SHODAI "個人に関する事項A有業者本業職業: 職業大分類"
capture label variable YH_SHOM "個人に関する事項A有業者本業職業: 職業中間分類"
capture label variable YH_KAIKYUU "個人に関する事項A有業者本業: 従業者規模11区分"
capture label variable YH_NISSU "個人に関する事項A有業者本業: 年間就業日数"
capture label variable YH_JYUGYO "個人に関する事項A有業者本業: 就業の規則性"
capture label variable YH_JIKAN "個人に関する事項A有業者本業: 週間就業時間"
capture label variable YH_SHOTOKU "個人に関する事項A有業者本業: 個人所得"
capture label variable YH_SYUISIKI "個人に関する事項A有業者本業: 就業希望意識"
capture label variable YH_SYUZOGEN "個人に関する事項A有業者本業: 就業時間希望"
capture label variable YH_SYURIYU "個人に関する事項A有業者本業: 転職希望理由"
capture label variable YH_SYUKEITAI "個人に関する事項A有業者本業: 希望する仕事の形態"
capture label variable YH_KATUDO "個人に関する事項A有業者本業: 求職活動の有無"
capture label variable YF_FUKU "個人に関する事項A有業者副業: 副業の有無"
capture label variable YF_JYUTII "個人に関する事項A有業者副業従業上の地位: 従業上の地位(5区分)"
capture label variable YF_NOHINOU "個人に関する事項A有業者副業産業: 産業農・非農"
capture label variable YF_SANDAI "個人に関する事項A有業者副業産業: 産業大分類"
capture label variable YF_SANCHU "個人に関する事項A有業者副業産業: 産業中分類"
capture label variable YZ_KEIZOKU "個人に関する事項A有業者一年前について: 継続就業か否か"
capture label variable YZ_KEINEN "個人に関する事項A有業者一年前について継続年数: 継続年数"
capture label variable YZ_SYUGYO "個人に関する事項A有業者一年前について一年前: 一年前就業状況"
capture label variable YZ_SYURIYU "個人に関する事項A有業者一年前について一年前: 一年前就業理由"
capture label variable YZ_ZENUMU "個人に関する事項A有業者: 前職の有無"
capture label variable M_SYUKIBOU "個人に関する事項B無業者就業希望: 有無"
capture label variable M_SYURIYU "個人に関する事項B無業者就業希望: 理由"
capture label variable M_SYUSIGOTO "個人に関する事項B無業者就業希望: 仕事の主従"
capture label variable M_SYUKEITAI "個人に関する事項B無業者就業希望: 仕事の形態"
capture label variable M_KYUKATUDO "個人に関する事項B無業者求職活動: 有無"
capture label variable M_KYUHIRIYU "個人に関する事項B無業者求職活動: 非求職理由"
capture label variable M_KYUHOHO "個人に関する事項B無業者求職活動: 求職方法"
capture label variable M_KYUKIKAN "個人に関する事項B無業者求職活動: 求職期間"
capture label variable M_KIBOJIKI "個人に関する事項B無業者: 就業希望時期"
capture label variable M_ZSYUGYO "個人に関する事項B無業者: 1年前の就業状況"
capture label variable M_ZENUMU "個人に関する事項B無業者: 前職の有無"
capture label variable Z_RIJIKI2 "個人に関する事項C前の仕事について離職時期: 区分"
capture label variable Z_RIJIKIK "個人に関する事項C前の仕事について離職時期: 年号"
capture label variable Z_RIJIKINEN "個人に関する事項C前の仕事について離職時期: 年"
capture label variable Z_RIYU "個人に関する事項C前の仕事について: 離職理由"
capture label variable Z_JYUTII "個人に関する事項C前の仕事について従業上の地位: 従業上の地位(8区分)"
capture label variable Z_NOHINOU "個人に関する事項C前の仕事について産業: 農・非農"
capture label variable Z_SAN3 "個人に関する事項C前の仕事について産業: 3部門"
capture label variable Z_SANDAI "個人に関する事項C前の仕事について産業: 大分類"
capture label variable Z_SANCHU "個人に関する事項C前の仕事について産業: 中分類"
capture label variable Z_SHODAI "個人に関する事項C前の仕事について職業: 大分類"
capture label variable Z_SHOM "個人に関する事項C前の仕事について職業: 中間分類"
capture label variable Z_KAIKYUU "個人に関する事項C前の仕事について: 従業者規模"
capture label variable Z_KEINEN "個人に関する事項C前の仕事について: 継続年数"