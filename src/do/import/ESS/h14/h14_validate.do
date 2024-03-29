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


capture count if YEAR==.
if r(N)==_N {
    display as error "Only missing value: {bf:YEAR} (調査年月)"
}


capture count if JOHO20==.
if r(N)==_N {
    display as error "Only missing value: {bf:JOHO20} (県番号)"
}


capture count if JOHO21==.
if r(N)==_N {
    display as error "Only missing value: {bf:JOHO21} (県内一連番号)"
}


capture count if JOHO22==.
if r(N)==_N {
    display as error "Only missing value: {bf:JOHO22} (居住者の有無)"
}


capture count if JOHO23==.
if r(N)==_N {
    display as error "Only missing value: {bf:JOHO23} (抽出単位番号)"
}


capture count if JOHO24==.
if r(N)==_N {
    display as error "Only missing value: {bf:JOHO24} (世帯一連番号)"
}


capture count if JOHO25==.
if r(N)==_N {
    display as error "Only missing value: {bf:JOHO25} (世帯員番号)"
}


capture count if CHIKI_KEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:CHIKI_KEN} (都道府県)"
}


capture count if CHIKI_CITY==.
if r(N)==_N {
    display as error "Only missing value: {bf:CHIKI_CITY} (市区町村)"
}


capture count if CHIKI_CHOKEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:CHIKI_CHOKEN} (都道府県)"
}


capture count if CHIKI_CHONO==.
if r(N)==_N {
    display as error "Only missing value: {bf:CHIKI_CHONO} (県内一連番号)"
}


capture count if W_SYUKEI==.
if r(N)==_N {
    display as error "Only missing value: {bf:W_SYUKEI} (集計用乗率)"
}


capture count if S_SETNO==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_SETNO} (世帯番号)"
}


capture count if S_SETINNO==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_SETINNO} (世帯員番号)"
}


capture count if S_IPPAN==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_IPPAN} (一般・単身の別)"
}


capture count if S_KAZOKURUI12==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_KAZOKURUI12} (12区分)"
}
capture assert inlist(S_KAZOKURUI12, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_KAZOKURUI12} (12区分) may have invalid values (Check layout sheet)"
}


capture count if S_JIN0==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN0} (0歳)"
}


capture count if S_JIN1==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN1} (1歳)"
}


capture count if S_JIN2==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN2} (2歳)"
}


capture count if S_JIN3==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN3} (3歳)"
}


capture count if S_JIN4==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN4} (4歳)"
}


capture count if S_JIN5==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN5} (5歳)"
}


capture count if S_JIN6==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN6} (6歳)"
}


capture count if S_JIN7==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN7} (7歳)"
}


capture count if S_JIN8==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN8} (8歳)"
}


capture count if S_JIN9==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN9} (9歳)"
}


capture count if S_JIN10==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN10} (10歳)"
}


capture count if S_JIN11==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN11} (11歳)"
}


capture count if S_JIN12==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN12} (12歳)"
}


capture count if S_JIN13==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN13} (13歳)"
}


capture count if S_JIN14==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN14} (14歳)"
}


capture count if S_JIN15MI==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN15MI} (15歳未満の合計)"
}


capture count if S_JIN15IJO==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JIN15IJO} (15歳以上の合計)"
}


capture count if S_OMOSYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_OMOSYU} (おもな収入)"
}
capture assert inlist(S_OMOSYU, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_OMOSYU} (おもな収入) may have invalid values (Check layout sheet)"
}


capture count if S_JYU1==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JYU1} (賃金・給料)"
}
capture assert inlist(S_JYU1, 1, 0, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_JYU1} (賃金・給料) may have invalid values (Check layout sheet)"
}


capture count if S_JYU2==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JYU2} (農業)"
}
capture assert inlist(S_JYU2, 1, 0, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_JYU2} (農業) may have invalid values (Check layout sheet)"
}


capture count if S_JYU3==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JYU3} (その他の事業)"
}
capture assert inlist(S_JYU3, 1, 0, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_JYU3} (その他の事業) may have invalid values (Check layout sheet)"
}


capture count if S_JYU4==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JYU4} (内職)"
}
capture assert inlist(S_JYU4, 1, 0, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_JYU4} (内職) may have invalid values (Check layout sheet)"
}


capture count if S_JYU5==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JYU5} (家賃・地代)"
}
capture assert inlist(S_JYU5, 1, 0, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_JYU5} (家賃・地代) may have invalid values (Check layout sheet)"
}


capture count if S_JYU6==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JYU6} (利子・配当)"
}
capture assert inlist(S_JYU6, 1, 0, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_JYU6} (利子・配当) may have invalid values (Check layout sheet)"
}


capture count if S_JYU7==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JYU7} (恩給・年金)"
}
capture assert inlist(S_JYU7, 1, 0, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_JYU7} (恩給・年金) may have invalid values (Check layout sheet)"
}


capture count if S_JYU8==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JYU8} (雇用保険)"
}
capture assert inlist(S_JYU8, 1, 0, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_JYU8} (雇用保険) may have invalid values (Check layout sheet)"
}


capture count if S_JYU9==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JYU9} (仕送り)"
}
capture assert inlist(S_JYU9, 1, 0, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_JYU9} (仕送り) may have invalid values (Check layout sheet)"
}


capture count if S_JYU10==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_JYU10} (その他)"
}
capture assert inlist(S_JYU10, 1, 0, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_JYU10} (その他) may have invalid values (Check layout sheet)"
}


capture count if S_SYUNYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:S_SYUNYU} (世帯の収入階級)"
}
capture assert inlist(S_SYUNYU, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:S_SYUNYU} (世帯の収入階級) may have invalid values (Check layout sheet)"
}


capture count if K_SEX==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_SEX} (性別)"
}


capture count if K_HAIGU==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_HAIGU} (配偶者の有無)"
}


capture count if K_TUZUKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_TUZUKI} (続き柄)"
}
capture assert inlist(K_TUZUKI, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:K_TUZUKI} (続き柄) may have invalid values (Check layout sheet)"
}


capture count if K_GENGO==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_GENGO} (元号)"
}


capture count if K_NEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_NEN} (年)"
}


capture count if K_TUKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_TUKI} (月)"
}


capture count if K_KYOIKU==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_KYOIKU} (教育区分)"
}


capture count if K_GAKKO==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_GAKKO} (学校区分)"
}


capture count if K_AGE==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_AGE} (各歳)"
}


capture count if K_AGE5==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_AGE5} (5歳階級)"
}
capture assert inlist(K_AGE5, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:K_AGE5} (5歳階級) may have invalid values (Check layout sheet)"
}


capture count if K_AGE10==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_AGE10} (10歳階級)"
}


capture count if K_GGENGO==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_GGENGO} (元号)"
}


capture count if K_GNEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_GNEN} (年)"
}


capture count if K_GTUKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_GTUKI} (月)"
}


capture count if K_GRIYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_GRIYU} (転居理由)"
}
capture assert inlist(K_GRIYU, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:K_GRIYU} (転居理由) may have invalid values (Check layout sheet)"
}


capture count if K_ZENJYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_ZENJYU} (区分)"
}


capture count if K_ZENJYUKEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_ZENJYUKEN} (県番号)"
}


capture count if K_SYUGYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:K_SYUGYO} (就業状態)"
}


capture count if YH_JYUTII8==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_JYUTII8} (8区分)"
}


capture count if YH_KEITAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_KEITAI} (雇用形態)"
}


capture count if YH_KEIEI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_KEIEI} (経営組織)"
}


capture count if YH_NOHINO==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_NOHINO} (農林・非農林)"
}


capture count if YH_SANDAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_SANDAI} (大分類)"
}
capture assert inlist(YH_SANDAI, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:YH_SANDAI} (大分類) may have invalid values (Check layout sheet)"
}


capture count if YH_SANCHU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_SANCHU} (分類(チェック済))"
}
capture assert inlist(YH_SANCHU, 1, 2, 3, 4, 5, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:YH_SANCHU} (分類(チェック済)) may have invalid values (Check layout sheet)"
}


capture count if YH_SANSHIN==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_SANSHIN} (分類(新))"
}


capture count if YH_SHODAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_SHODAI} (大分類)"
}
capture assert inlist(YH_SHODAI, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:YH_SHODAI} (大分類) may have invalid values (Check layout sheet)"
}


capture count if YH_SHOCHU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_SHOCHU} (中分類)"
}
capture assert inlist(YH_SHOCHU, 0, .)
if _rc!=0 {
    display as error "WARNING: {bf:YH_SHOCHU} (中分類) may have invalid values (Check layout sheet)"
}


capture count if YH_JYUKIBO==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_JYUKIBO} (従業者規模)"
}
capture assert inlist(YH_JYUKIBO, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:YH_JYUKIBO} (従業者規模) may have invalid values (Check layout sheet)"
}


capture count if YH_NISSU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_NISSU} (年間就業日数)"
}


capture count if YH_KISOKU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_KISOKU} (就業の規則性)"
}


capture count if YH_JIKAN==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_JIKAN} (週間就業時間)"
}
capture assert inlist(YH_JIKAN, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:YH_JIKAN} (週間就業時間) may have invalid values (Check layout sheet)"
}


capture count if YH_SYUNYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_SYUNYU} (個人所得)"
}
capture assert inlist(YH_SYUNYU, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:YH_SYUNYU} (個人所得) may have invalid values (Check layout sheet)"
}


capture count if YH_SYUKIBO==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_SYUKIBO} (就業希望意識)"
}


capture count if YH_SYUZOGEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_SYUZOGEN} (就業時間希望)"
}


capture count if YH_TENRIYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_TENRIYU} (転職希望理由)"
}


capture count if YH_SYUKEITAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_SYUKEITAI} (希望仕事形態)"
}


capture count if YH_KYUUMU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_KYUUMU} (求職活動の有無)"
}


capture count if YH_GENGO==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_GENGO} (元号)"
}


capture count if YH_NEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_NEN} (年)"
}


capture count if YH_TUKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_TUKI} (月)"
}


capture count if YH_SYURIYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH_SYURIYU} (就業理由)"
}


capture count if YF_FUKU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YF_FUKU} (副業の有無,従業上の地位)"
}


capture count if YF_NOHINO==.
if r(N)==_N {
    display as error "Only missing value: {bf:YF_NOHINO} (農林・非農林)"
}


capture count if YF_SANDAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YF_SANDAI} (大分類)"
}


capture count if YF_SANCHU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YF_SANCHU} (中分類)"
}
capture assert inlist(YF_SANCHU, 1, 2, 3, 4, 5, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:YF_SANCHU} (中分類) may have invalid values (Check layout sheet)"
}


capture count if YF_SANSHIN==.
if r(N)==_N {
    display as error "Only missing value: {bf:YF_SANSHIN} (分類(新))"
}


capture count if YF_ZENSYUGYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:YF_ZENSYUGYO} (1年前の就業状況)"
}


capture count if YF_ZENUMU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YF_ZENUMU} (前職の有無)"
}


capture count if M_SYUKIBO==.
if r(N)==_N {
    display as error "Only missing value: {bf:M_SYUKIBO} (有無)"
}


capture count if M_SYURIYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:M_SYURIYU} (理由)"
}


capture count if M_SHOKUSHU==.
if r(N)==_N {
    display as error "Only missing value: {bf:M_SHOKUSHU} (希望職種)"
}
capture assert inlist(M_SHOKUSHU, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:M_SHOKUSHU} (希望職種) may have invalid values (Check layout sheet)"
}


capture count if M_KEITAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:M_KEITAI} (仕事の形態)"
}


capture count if M_KYUUMU==.
if r(N)==_N {
    display as error "Only missing value: {bf:M_KYUUMU} (有無)"
}


capture count if M_HIKYURIYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:M_HIKYURIYU} (非求職理由)"
}


capture count if M_KBN==.
if r(N)==_N {
    display as error "Only missing value: {bf:M_KBN} (2区分)"
}


capture count if M_NEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:M_NEN} (年)"
}


capture count if M_TUKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:M_TUKI} (カ月)"
}


capture count if M_KIBOJIKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:M_KIBOJIKI} (就業希望時期)"
}


capture count if M_ZENSYUGYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:M_ZENSYUGYO} (1年前の就業状況)"
}


capture count if M_ZENUMU==.
if r(N)==_N {
    display as error "Only missing value: {bf:M_ZENUMU} (前職の有無)"
}


capture count if Z_RIJIKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_RIJIKI} (区分)"
}


capture count if Z_GENGO==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_GENGO} (元号)"
}


capture count if Z_NEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_NEN} (年)"
}


capture count if Z_TUKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_TUKI} (月)"
}


capture count if Z_RIRIYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_RIRIYU} (離職理由)"
}
capture assert inlist(Z_RIRIYU, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:Z_RIRIYU} (離職理由) may have invalid values (Check layout sheet)"
}


capture count if Z_JYUTII8==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_JYUTII8} (8区分)"
}


capture count if Z_KEITAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_KEITAI} (雇用形態)"
}


capture count if Z_SANDAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_SANDAI} (大分類)"
}


capture count if Z_SANCHU==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_SANCHU} (中分類)"
}
capture assert inlist(Z_SANCHU, 1, 2, 3, 4, 5, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:Z_SANCHU} (中分類) may have invalid values (Check layout sheet)"
}


capture count if Z_SANSHIN==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_SANSHIN} (分類(新))"
}


capture count if Z_SYODAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_SYODAI} (大分類)"
}


capture count if Z_SYOCHU==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_SYOCHU} (中分類)"
}
capture assert inlist(Z_SYOCHU, 0, .)
if _rc!=0 {
    display as error "WARNING: {bf:Z_SYOCHU} (中分類) may have invalid values (Check layout sheet)"
}


capture count if Z_JYUKIBO==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_JYUKIBO} (従業者規模)"
}
capture assert inlist(Z_JYUKIBO, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:Z_JYUKIBO} (従業者規模) may have invalid values (Check layout sheet)"
}


capture count if Z_KEINEN2==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_KEINEN2} (区分)"
}


capture count if Z_KEINEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_KEINEN} (年)"
}


capture count if Z_KEITUKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z_KEITUKI} (カ月)"
}


