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


capture count if KYOKUSYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:KYOKUSYO} (局署)"
}


capture count if SEIRI==.
if r(N)==_N {
    display as error "Only missing value: {bf:SEIRI} (番号)"
}


capture count if ERROR_FLG==.
if r(N)==_N {
    display as error "Only missing value: {bf:ERROR_FLG} (エラーフラグ)"
}


capture count if BAITAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:BAITAI} (提出方法)"
}


capture count if SOUBETU==.
if r(N)==_N {
    display as error "Only missing value: {bf:SOUBETU} (層番号)"
}


capture count if GYOSYU_BUNRUI==.
if r(N)==_N {
    display as error "Only missing value: {bf:GYOSYU_BUNRUI} (企業の主な業務)"
}
capture assert inlist(GYOSYU_BUNRUI, 1, 2, 3, 4, 5, 6, 7, 8, 9, .)
if _rc!=0 {
    display as error "WARNING: {bf:GYOSYU_BUNRUI} (企業の主な業務) may have invalid values (Check layout sheet)"
}


capture count if SOSIKI_SIHON==.
if r(N)==_N {
    display as error "Only missing value: {bf:SOSIKI_SIHON} (組織及び資本金)"
}


capture count if JININ3==.
if r(N)==_N {
    display as error "Only missing value: {bf:JININ3} (3月末現在の人員)"
}


capture count if JININ6==.
if r(N)==_N {
    display as error "Only missing value: {bf:JININ6} (6月末現在の人員)"
}


capture count if JININ9==.
if r(N)==_N {
    display as error "Only missing value: {bf:JININ9} (9月末現在の人員)"
}


capture count if JININ12==.
if r(N)==_N {
    display as error "Only missing value: {bf:JININ12} (12月末現在の人員)"
}


capture count if KYUYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:KYUYO} (年間給与支給総額)"
}


capture count if KYUYO_ZEIGAKU==.
if r(N)==_N {
    display as error "Only missing value: {bf:KYUYO_ZEIGAKU} (給与支給総額に対する年間源泉徴収税額)"
}


