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
    Date: 2020/08/11 22:29:29
-----------------------------------------------------------------------------*/


capture label variable KYOKUSYO "局署"
capture label variable SEIRI "番号"
capture label variable ERROR_FLG "エラーフラグ"
capture label variable BAITAI "提出方法"
capture label variable SOUBETU "層番号"
capture label variable GYOSYU_BUNRUI "企業の主な業務"
capture label variable SOSIKI_SIHON "組織及び資本金"
capture label variable JININ3 "給与所得者数: 3月末現在の人員"
capture label variable JININ6 "給与所得者数: 6月末現在の人員"
capture label variable JININ9 "給与所得者数: 9月末現在の人員"
capture label variable JININ12 "給与所得者数: 12月末現在の人員"
capture label variable KYUYO "年間給与支給総額"
capture label variable KYUYO_ZEIGAKU "給与支給総額に対する年間源泉徴収税額"
