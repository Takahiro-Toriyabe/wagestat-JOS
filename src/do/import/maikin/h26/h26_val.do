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
    Date: 2020/08/11 21:22:29
-----------------------------------------------------------------------------*/


capture label define var5 1 "北海道" 2 "青森" 3 "岩手" 4 "宮城" 5 "秋田" 6 "山形" 7 "福島" 8 "茨城" 9 "栃木" 10 "群馬" 11 "埼玉" 12 "千葉" 13 "東京" 14 "神奈川" 15 "新潟" 16 "富山" 17 "石川" 18 "福井" 19 "山梨" 20 "長野" 21 "岐阜" 22 "静岡" 23 "愛知" 24 "三重" 25 "滋賀" 26 "京都" 27 "大阪" 28 "兵庫" 29 "奈良" 30 "和歌山" 31 "鳥取" 32 "島根" 33 "岡山" 34 "広島" 35 "山口" 36 "徳島" 37 "香川" 38 "愛媛" 39 "高知" 40 "福岡" 41 "佐賀" 42 "長崎" 43 "熊本" 44 "大分" 45 "宮崎" 46 "鹿児島" 47 "沖縄" 
capture label values var5 var5

capture label define var8 0 "重複なし" 
capture label values var8 var8

capture label define var14 1 "1,000人以上" 3 "500~999人" 5 "100~499人" 7 "30~99人" 9 "5~29人" 
capture label values var14 var14

capture label define var15 1 "1,000人以上" 2 "500~999人" 3 "100~499人" 4 "30~99人" 5 "5~29人" 
capture label values var15 var15

capture label define var18 1 "照合済" 
capture label values var18 var18
