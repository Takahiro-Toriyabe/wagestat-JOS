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


    Source: D:/GitHub/mic-wagestat/layout/minkyu/minkyu_kyuyo_h30.xls
    Date: 2020/08/11 22:29:38
-----------------------------------------------------------------------------*/


#delimit ;
    quietly infix
        str KYOKUSYO 1-5
        str SEIRI 6-13
        str ERROR_FLG 14-14
        str ITIREN_NO 15-18
        str SEIBETU 19-19
        str NENREI 20-21
        str KINZOKU_NEN 22-23
        str KYUYO_TUKI 24-24
        str SYOKUMU 25-25
        str NENTYO 26-26
        str HAIGU_UMU 27-28
        str IPPAN_HUYO 29-29
        str TOKUTEI_HUYO 30-30
        str DOKYO_ROSIN_ETC 31-31
        str IPPAN_ROJIN 32-32
        str HUYO_SIN 33-34
        str SYOGAI 35-35
        str DOKYO_TOKUSYO 36-36
        str HI_DOKYO_TOKUSYO 37-37
        str SYOGAI_KOJO 38-38
        str TOKU_SYOGAI_KOJO 39-39
        str TOKU_KAHU_KOJO 40-40
        str IPPAN_KAHU_KOJO 41-41
        str KAHU_KOJO 42-42
        str KINRO_KOJO 43-43
        str KYUYO_TEATE 44-50
        str SYOYO 51-57
        str KYUYOGAKU_KEI 58-64
        str SYAKAIHOKEN_KOJOGAKU 65-68
        str SYOKIBO_KOJO 69-72
        str IPPAN_SEIHO_KOJOGAKU 73-74
        str KAIGO_IRYO_KOJO 75-76
        str KOJIN_NENKIN_KOJO 77-78
        str JISIN_KOJOGAKU 79-80
        str HAIGU_TOKUBETU_KOJOGAKU 81-83
        str JUTAKU_KOJO 84-86
        str NENZE_GAKU 87-91
    using "";
#delimit cr