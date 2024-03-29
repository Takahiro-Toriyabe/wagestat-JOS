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


capture label variable YEAR "調査年月"
capture label variable JOHO20 "チェック情報データ抜き出し情報調査区符号: 県番号"
capture label variable JOHO21 "チェック情報データ抜き出し情報調査区符号: 県内一連番号"
capture label variable JOHO22 "チェック情報データ抜き出し情報世帯番号抽出単位番号: 居住者の有無"
capture label variable JOHO23 "チェック情報データ抜き出し情報世帯番号抽出単位番号: 抽出単位番号"
capture label variable JOHO24 "チェック情報データ抜き出し情報世帯番号: 世帯一連番号"
capture label variable JOHO25 "チェック情報データ抜き出し情報: 世帯員番号"
capture label variable CHIKI_KEN "所在地に関する情報市区町村コード: 都道府県"
capture label variable CHIKI_CITY "所在地に関する情報市区町村コード: 市区町村"
capture label variable CHIKI_CHOKEN "所在地に関する情報調査区符号: 都道府県"
capture label variable CHIKI_CHONO "所在地に関する情報調査区符号: 県内一連番号"
capture label variable W_SYUKEI "乗率: 集計用乗率"
capture label variable S_SETNO "世帯番号"
capture label variable S_SETINNO "世帯員番号"
capture label variable S_IPPAN "世帯に関する事項: 一般・単身の別"
capture label variable S_KAZOKURUI12 "世帯に関する事項家族類型: 12区分"
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
capture label variable S_OMOSYU "世帯に関する事項世帯の収入の種類: おもな収入"
capture label variable S_JYU1 "世帯に関する事項世帯の収入の種類従な収入: 賃金・給料"
capture label variable S_JYU2 "世帯に関する事項世帯の収入の種類従な収入: 農業"
capture label variable S_JYU3 "世帯に関する事項世帯の収入の種類従な収入: その他の事業"
capture label variable S_JYU4 "世帯に関する事項世帯の収入の種類従な収入: 内職"
capture label variable S_JYU5 "世帯に関する事項世帯の収入の種類従な収入: 家賃・地代"
capture label variable S_JYU6 "世帯に関する事項世帯の収入の種類従な収入: 利子・配当"
capture label variable S_JYU7 "世帯に関する事項世帯の収入の種類従な収入: 恩給・年金"
capture label variable S_JYU8 "世帯に関する事項世帯の収入の種類従な収入: 雇用保険"
capture label variable S_JYU9 "世帯に関する事項世帯の収入の種類従な収入: 仕送り"
capture label variable S_JYU10 "世帯に関する事項世帯の収入の種類従な収入: その他"
capture label variable S_SYUNYU "世帯に関する事項: 世帯の収入階級"
capture label variable K_SEX "個人に関する事項: 性別"
capture label variable K_HAIGU "個人に関する事項: 配偶者の有無"
capture label variable K_TUZUKI "個人に関する事項: 続き柄"
capture label variable K_GENGO "個人に関する事項生年月: 元号"
capture label variable K_NEN "個人に関する事項生年月: 年"
capture label variable K_TUKI "個人に関する事項生年月: 月"
capture label variable K_KYOIKU "個人に関する事項教育: 教育区分"
capture label variable K_GAKKO "個人に関する事項教育: 学校区分"
capture label variable K_AGE "個人に関する事項年齢: 各歳"
capture label variable K_AGE5 "個人に関する事項年齢: 5歳階級"
capture label variable K_AGE10 "個人に関する事項年齢: 10歳階級"
capture label variable K_GGENGO "個人に関する事項現住居居住開始時期: 元号"
capture label variable K_GNEN "個人に関する事項現住居居住開始時期: 年"
capture label variable K_GTUKI "個人に関する事項現住居居住開始時期: 月"
capture label variable K_GRIYU "個人に関する事項現住居: 転居理由"
capture label variable K_ZENJYU "個人に関する事項前住地: 区分"
capture label variable K_ZENJYUKEN "個人に関する事項前住地: 県番号"
capture label variable K_SYUGYO "個人に関する事項: 就業状態"
capture label variable YH_JYUTII8 "個人に関する事項有業者本業従業上の地位: 8区分"
capture label variable YH_KEITAI "個人に関する事項有業者本業: 雇用形態"
capture label variable YH_KEIEI "個人に関する事項有業者本業: 経営組織"
capture label variable YH_NOHINO "個人に関する事項有業者本業産業: 農林・非農林"
capture label variable YH_SANDAI "個人に関する事項有業者本業産業: 大分類"
capture label variable YH_SANCHU "個人に関する事項有業者本業産業: 分類(チェック済)"
capture label variable YH_SANSHIN "個人に関する事項有業者本業産業: 分類(新)"
capture label variable YH_SHODAI "個人に関する事項有業者本業職業: 大分類"
capture label variable YH_SHOCHU "個人に関する事項有業者本業職業: 中分類"
capture label variable YH_JYUKIBO "個人に関する事項有業者本業: 従業者規模"
capture label variable YH_NISSU "個人に関する事項有業者本業: 年間就業日数"
capture label variable YH_KISOKU "個人に関する事項有業者本業: 就業の規則性"
capture label variable YH_JIKAN "個人に関する事項有業者本業: 週間就業時間"
capture label variable YH_SYUNYU "個人に関する事項有業者本業: 個人所得"
capture label variable YH_SYUKIBO "個人に関する事項有業者本業: 就業希望意識"
capture label variable YH_SYUZOGEN "個人に関する事項有業者本業: 就業時間希望"
capture label variable YH_TENRIYU "個人に関する事項有業者本業: 転職希望理由"
capture label variable YH_SYUKEITAI "個人に関する事項有業者本業: 希望仕事形態"
capture label variable YH_KYUUMU "個人に関する事項有業者本業: 求職活動の有無"
capture label variable YH_GENGO "個人に関する事項有業者本業現職就業時期: 元号"
capture label variable YH_NEN "個人に関する事項有業者本業現職就業時期: 年"
capture label variable YH_TUKI "個人に関する事項有業者本業現職就業時期: 月"
capture label variable YH_SYURIYU "個人に関する事項有業者本業: 就業理由"
capture label variable YF_FUKU "個人に関する事項有業者副業: 副業の有無,従業上の地位"
capture label variable YF_NOHINO "個人に関する事項有業者副業産業: 農林・非農林"
capture label variable YF_SANDAI "個人に関する事項有業者副業産業: 大分類"
capture label variable YF_SANCHU "個人に関する事項有業者副業産業: 中分類"
capture label variable YF_SANSHIN "個人に関する事項有業者副業産業: 分類(新)"
capture label variable YF_ZENSYUGYO "個人に関する事項有業者: 1年前の就業状況"
capture label variable YF_ZENUMU "個人に関する事項有業者: 前職の有無"
capture label variable M_SYUKIBO "個人に関する事項無業者就業希望: 有無"
capture label variable M_SYURIYU "個人に関する事項無業者就業希望: 理由"
capture label variable M_SHOKUSHU "個人に関する事項無業者就業希望: 希望職種"
capture label variable M_KEITAI "個人に関する事項無業者就業希望: 仕事の形態"
capture label variable M_KYUUMU "個人に関する事項無業者求職活動: 有無"
capture label variable M_HIKYURIYU "個人に関する事項無業者求職活動: 非求職理由"
capture label variable M_KBN "個人に関する事項無業者求職活動求職期間: 2区分"
capture label variable M_NEN "個人に関する事項無業者求職活動求職期間: 年"
capture label variable M_TUKI "個人に関する事項無業者求職活動求職期間: カ月"
capture label variable M_KIBOJIKI "個人に関する事項無業者: 就業希望時期"
capture label variable M_ZENSYUGYO "個人に関する事項無業者: 1年前の就業状況"
capture label variable M_ZENUMU "個人に関する事項無業者: 前職の有無"
capture label variable Z_RIJIKI "個人に関する事項前の仕事について離職時期: 区分"
capture label variable Z_GENGO "個人に関する事項前の仕事について離職時期: 元号"
capture label variable Z_NEN "個人に関する事項前の仕事について離職時期: 年"
capture label variable Z_TUKI "個人に関する事項前の仕事について離職時期: 月"
capture label variable Z_RIRIYU "個人に関する事項前の仕事について: 離職理由"
capture label variable Z_JYUTII8 "個人に関する事項前の仕事について従業上の地位: 8区分"
capture label variable Z_KEITAI "個人に関する事項前の仕事について: 雇用形態"
capture label variable Z_SANDAI "個人に関する事項前の仕事について産業: 大分類"
capture label variable Z_SANCHU "個人に関する事項前の仕事について産業: 中分類"
capture label variable Z_SANSHIN "個人に関する事項前の仕事について産業: 分類(新)"
capture label variable Z_SYODAI "個人に関する事項前の仕事について職業: 大分類"
capture label variable Z_SYOCHU "個人に関する事項前の仕事について職業: 中分類"
capture label variable Z_JYUKIBO "個人に関する事項前の仕事について: 従業者規模"
capture label variable Z_KEINEN2 "個人に関する事項前の仕事について継続就業期間: 区分"
capture label variable Z_KEINEN "個人に関する事項前の仕事について継続就業期間: 年"
capture label variable Z_KEITUKI "個人に関する事項前の仕事について継続就業期間: カ月"
