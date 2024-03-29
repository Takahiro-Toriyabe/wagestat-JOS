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
    Date: 2020/09/30 17:06:04
-----------------------------------------------------------------------------*/


capture label variable var1 "調査年"
capture label variable var2 "府県ごとの括通し番号"
capture label variable var4 "都道府県番号"
capture label variable var5 "事業所一連番号"
capture label variable var6 "チェックディジット"
capture label variable var7 "○○枚目"
capture label variable var8 "労働者一連番号"
capture label variable var9 "市区町村番号"
capture label variable var10 "基本調査区番号"
capture label variable var11 "事業所番号"
capture label variable var13 "マスター: 産業分類番号"
capture label variable var14 "マスター: 事業所規模"
capture label variable var15 "マスター: 臨時雇用者規模番号"
capture label variable var16 "マスター: 企業規模"
capture label variable var19 "事業所票: 産業分類番号"
capture label variable var20 "事業所票: 事業所規模"
capture label variable var21 "事業所票: 臨時雇用者規模番号"
capture label variable var22 "事業所票: 企業規模"
capture label variable var23 "抽出率: 事業所"
capture label variable var24 "抽出率: 常用労働者"
capture label variable var25 "抽出率: 臨時労働者"
capture label variable var26 "復元倍率"
capture label variable var27 "本・支区分"
capture label variable var28 "民・公区分"
capture label variable var29 "種類"
capture label variable var31 "常用労働者数正社員・正職員: 男"
capture label variable var32 "常用労働者数正社員・正職員: 女"
capture label variable var33 "常用労働者数正社員・正職員以外: 男"
capture label variable var34 "常用労働者数正社員・正職員以外: 女"
capture label variable var35 "臨時労働者数"
capture label variable var36 "産業番号: 大"
capture label variable var37 "産業番号: 中"
capture label variable var38 "産業番号: 小"
capture label variable var40 "性別"
capture label variable var41 "雇用形態"
capture label variable var42 "就業形態"
capture label variable var43 "最終学歴"
capture label variable var44 "年齢"
capture label variable var45 "勤続年数"
capture label variable var46 "労働者の種類"
capture label variable var47 "役職・職種番号"
capture label variable var48 "経験年数"
capture label variable var49 "実労働日数"
capture label variable var50 "所定内実労働時間数"
capture label variable var51 "超過実労働時間数"
capture label variable var52 "決まって支給する現金給与額"
capture label variable var53 "超過労働給与額"
capture label variable var54 "所定内給与額"
capture label variable var55 "通勤手当"
capture label variable var56 "精皆勤手当"
capture label variable var57 "家族手当"
capture label variable var58 "昨年1年間の賞与期末手当等特別支給額"
