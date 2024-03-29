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


    Source: D:/GitHub/mic-wagestat/layout/minkyu/minkyu_gensen_h30.xls
    Date: 2020/08/11 22:29:29
-----------------------------------------------------------------------------*/


#delimit ;
    quietly infix
        str KYOKUSYO 1-5
        str SEIRI 6-13
        str ERROR_FLG 14-14
        str BAITAI 15-16
        str SOUBETU 17-17
        str GYOSYU_BUNRUI 18-19
        str SOSIKI_SIHON 20-20
        str JININ3 21-26
        str JININ6 27-32
        str JININ9 33-38
        str JININ12 39-44
        str KYUYO 45-53
        str KYUYO_ZEIGAKU 54-62
    using "";
#delimit cr
