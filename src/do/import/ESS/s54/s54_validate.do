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


capture count if var1==.
if r(N)==_N {
    display as error "Only missing value: {bf:var1} (西暦)"
}


capture count if var2==.
if r(N)==_N {
    display as error "Only missing value: {bf:var2} (調査月)"
}


capture count if KEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:KEN} (県番)"
}


capture count if var3==.
if r(N)==_N {
    display as error "Only missing value: {bf:var3} (市区町村番号)"
}


capture count if var4==.
if r(N)==_N {
    display as error "Only missing value: {bf:var4} (調査区番号)"
}


capture count if var5==.
if r(N)==_N {
    display as error "Only missing value: {bf:var5} (集計用乗率(14.9))"
}


capture count if var6==.
if r(N)==_N {
    display as error "Only missing value: {bf:var6} (世帯番号)"
}


capture count if var7==.
if r(N)==_N {
    display as error "Only missing value: {bf:var7} (世帯員番号)"
}


capture count if KTUZUKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:KTUZUKI} (10区分)"
}


capture count if KSEI==.
if r(N)==_N {
    display as error "Only missing value: {bf:KSEI} (性別)"
}


capture count if var8==.
if r(N)==_N {
    display as error "Only missing value: {bf:var8} (年号)"
}


capture count if var9==.
if r(N)==_N {
    display as error "Only missing value: {bf:var9} (年)"
}


capture count if var10==.
if r(N)==_N {
    display as error "Only missing value: {bf:var10} (月)"
}


capture count if KNEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:KNEN} (各才)"
}


capture count if KNEN5==.
if r(N)==_N {
    display as error "Only missing value: {bf:KNEN5} (5才階級)"
}


capture count if KHAIGU==.
if r(N)==_N {
    display as error "Only missing value: {bf:KHAIGU} (配偶関係)"
}


capture count if KSUMAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:KSUMAI} (1年前の住居地)"
}


capture count if KZKEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:KZKEN} (県番)"
}


capture count if KGAKU==.
if r(N)==_N {
    display as error "Only missing value: {bf:KGAKU} (在学又は卒業学校)"
}


capture count if KSYUGYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:KSYUGYO} (就業状況)"
}


capture count if YHTII==.
if r(N)==_N {
    display as error "Only missing value: {bf:YHTII} (9区分)"
}


capture count if YKEIEI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YKEIEI} (経営組織)"
}


capture count if YHNOU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YHNOU} (農非農)"
}


capture count if YHSDAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YHSDAI} (大分類)"
}


capture count if YHSANA==.
if r(N)==_N {
    display as error "Only missing value: {bf:YHSANA} (中間分類)"
}


capture count if YHSANB==.
if r(N)==_N {
    display as error "Only missing value: {bf:YHSANB} (中分類)"
}


capture count if YH3BU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YH3BU} (3部門)"
}


capture count if YHSHOKD==.
if r(N)==_N {
    display as error "Only missing value: {bf:YHSHOKD} (大分類)"
}


capture count if YHSHOKC==.
if r(N)==_N {
    display as error "Only missing value: {bf:YHSHOKC} (中間分類)"
}


capture count if YKIBO13==.
if r(N)==_N {
    display as error "Only missing value: {bf:YKIBO13} (13区分(官公庁))"
}


capture count if YNISSU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YNISSU} (7区分)"
}


capture count if YSKEITAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YSKEITAI} (年間就業形態)"
}


capture count if YJIKAN==.
if r(N)==_N {
    display as error "Only missing value: {bf:YJIKAN} (8区分)"
}


capture count if var11==.
if r(N)==_N {
    display as error "Only missing value: {bf:var11} (区分)"
}


capture count if YISIKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YISIKI} (意識)"
}


capture count if YRIYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YRIYU} (理由)"
}


capture count if YKKEITAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YKKEITAI} (形態)"
}


capture count if YKATUDO==.
if r(N)==_N {
    display as error "Only missing value: {bf:YKATUDO} (求職活動の有無)"
}


capture count if YFUKU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YFUKU} (副業の有無)"
}


capture count if YFTII==.
if r(N)==_N {
    display as error "Only missing value: {bf:YFTII} (従業上の地位)"
}


capture count if YFNOU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YFNOU} (農非農)"
}


capture count if YFSDAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:YFSDAI} (大分類)"
}


capture count if YFSAN==.
if r(N)==_N {
    display as error "Only missing value: {bf:YFSAN} (中分類)"
}


capture count if YFSYUNYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YFSYUNYU} (区分)"
}


capture count if YKEIZOKU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YKEIZOKU} (継続就業か否)"
}


capture count if var12==.
if r(N)==_N {
    display as error "Only missing value: {bf:var12} (年数)"
}


capture count if YZSYUGYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:YZSYUGYO} (就業状況)"
}


capture count if YSRIYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:YSRIYU} (就業理由)"
}


capture count if MKIBOU==.
if r(N)==_N {
    display as error "Only missing value: {bf:MKIBOU} (有無)"
}


capture count if MRIYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:MRIYU} (理由)"
}


capture count if MSIGOTO==.
if r(N)==_N {
    display as error "Only missing value: {bf:MSIGOTO} (仕事の主従)"
}


capture count if MKATATI==.
if r(N)==_N {
    display as error "Only missing value: {bf:MKATATI} (形態)"
}


capture count if MKATUDO==.
if r(N)==_N {
    display as error "Only missing value: {bf:MKATUDO} (有無)"
}


capture count if MHOHO==.
if r(N)==_N {
    display as error "Only missing value: {bf:MHOHO} (方法)"
}


capture count if MKIKAN==.
if r(N)==_N {
    display as error "Only missing value: {bf:MKIKAN} (期間)"
}


capture count if MJIKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:MJIKI} (就業希望時期)"
}


capture count if MZSYUGYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:MZSYUGYO} (1年前の就業状況)"
}


capture count if ZRIYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:ZRIYU} (転・離職理由)"
}


capture count if ZTII==.
if r(N)==_N {
    display as error "Only missing value: {bf:ZTII} (8区分)"
}


capture count if ZNOU==.
if r(N)==_N {
    display as error "Only missing value: {bf:ZNOU} (農非農)"
}


capture count if ZSDAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:ZSDAI} (大分類)"
}


capture count if ZSAN==.
if r(N)==_N {
    display as error "Only missing value: {bf:ZSAN} (中分類)"
}


capture count if Z3BUMON==.
if r(N)==_N {
    display as error "Only missing value: {bf:Z3BUMON} (3部門)"
}


capture count if ZSHOKD==.
if r(N)==_N {
    display as error "Only missing value: {bf:ZSHOKD} (大分類)"
}


capture count if ZSYOKC==.
if r(N)==_N {
    display as error "Only missing value: {bf:ZSYOKC} (中間分類)"
}


capture count if ZKIBO==.
if r(N)==_N {
    display as error "Only missing value: {bf:ZKIBO} (従業員規模)"
}


capture count if SIPPAN==.
if r(N)==_N {
    display as error "Only missing value: {bf:SIPPAN} (一般・単身)"
}


capture count if var13==.
if r(N)==_N {
    display as error "Only missing value: {bf:var13} (0~5才)"
}


capture count if var14==.
if r(N)==_N {
    display as error "Only missing value: {bf:var14} (6~11才)"
}


capture count if var15==.
if r(N)==_N {
    display as error "Only missing value: {bf:var15} (12~14才)"
}


capture count if var16==.
if r(N)==_N {
    display as error "Only missing value: {bf:var16} (14才以下)"
}


capture count if var17==.
if r(N)==_N {
    display as error "Only missing value: {bf:var17} (15才以上)"
}


capture count if SSYUNYU==.
if r(N)==_N {
    display as error "Only missing value: {bf:SSYUNYU} (世帯収入区分)"
}

