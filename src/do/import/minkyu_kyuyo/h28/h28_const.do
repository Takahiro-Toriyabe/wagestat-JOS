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


    Source: D:/GitHub/mic-wagestat/layout/minkyu/minkyu_kyuyo_h24.xls
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
        str HAIGU_UMU 27-27
        str IPPAN_HUYO 28-28
        str TOKUTEI_HUYO 29-29
        str DOKYO_ROSIN_ETC 30-30
        str IPPAN_ROJIN 31-31
        str HUYO_SIN 32-33
        str SYOGAI 34-34
        str DOKYO_TOKUSYO 35-35
        str HI_DOKYO_TOKUSYO 36-36
        str SYOGAI_KOJO 37-37
        str TOKU_SYOGAI_KOJO 38-38
        str TOKU_KAHU_KOJO 39-39
        str IPPAN_KAHU_KOJO 40-40
        str KAHU_KOJO 41-41
        str KINRO_KOJO 42-42
        str KYUYO_TEATE 43-49
        str SYOYO 50-56
        str KYUYOGAKU_KEI 57-63
        str SYAKAIHOKEN_KOJOGAKU 64-67
        str SYOKIBO_KOJO 68-71
        str IPPAN_SEIHO_KOJOGAKU 72-73
        str KAIGO_IRYO_KOJO 74-75
        str KOJIN_NENKIN_KOJO 76-77
        str JISIN_KOJOGAKU 78-79
        str HAIGU_TOKUBETU_KOJOGAKU 80-82
        str JUTAKU_KOJO 83-85
        str NENZE_GAKU 86-90
    using "";
#delimit cr
