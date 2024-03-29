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
    Date: 2020/08/11 22:29:38
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


capture count if ITIREN_NO==.
if r(N)==_N {
    display as error "Only missing value: {bf:ITIREN_NO} (一連番号)"
}


capture count if SEIBETU==.
if r(N)==_N {
    display as error "Only missing value: {bf:SEIBETU} (性別)"
}


capture count if NENREI==.
if r(N)==_N {
    display as error "Only missing value: {bf:NENREI} (満年齢)"
}


capture count if KINZOKU_NEN==.
if r(N)==_N {
    display as error "Only missing value: {bf:KINZOKU_NEN} (勤続年数)"
}


capture count if KYUYO_TUKI==.
if r(N)==_N {
    display as error "Only missing value: {bf:KYUYO_TUKI} (給与を支給した月数)"
}


capture count if SYOKUMU==.
if r(N)==_N {
    display as error "Only missing value: {bf:SYOKUMU} (職務)"
}


capture count if NENTYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:NENTYO} (年末調整)"
}


capture count if HAIGU_UMU==.
if r(N)==_N {
    display as error "Only missing value: {bf:HAIGU_UMU} (控除対象配偶者)"
}


capture count if IPPAN_HUYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:IPPAN_HUYO} (一般の控除対象扶養親族)"
}


capture count if TOKUTEI_HUYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:TOKUTEI_HUYO} (特定扶養親族)"
}


capture count if DOKYO_ROSIN_ETC==.
if r(N)==_N {
    display as error "Only missing value: {bf:DOKYO_ROSIN_ETC} (老人扶養親族(同居老親等))"
}


capture count if IPPAN_ROJIN==.
if r(N)==_N {
    display as error "Only missing value: {bf:IPPAN_ROJIN} (老人扶養親族(一般))"
}


capture count if HUYO_SIN==.
if r(N)==_N {
    display as error "Only missing value: {bf:HUYO_SIN} (計)"
}


capture count if SYOGAI==.
if r(N)==_N {
    display as error "Only missing value: {bf:SYOGAI} (うち一般の障害者)"
}


capture count if DOKYO_TOKUSYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:DOKYO_TOKUSYO} (うち同居特別障害者)"
}


capture count if HI_DOKYO_TOKUSYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:HI_DOKYO_TOKUSYO} (うち非同居特別障害者)"
}


capture count if SYOGAI_KOJO==.
if r(N)==_N {
    display as error "Only missing value: {bf:SYOGAI_KOJO} (障害者控除(一般))"
}


capture count if TOKU_SYOGAI_KOJO==.
if r(N)==_N {
    display as error "Only missing value: {bf:TOKU_SYOGAI_KOJO} (障害者控除(特別))"
}


capture count if TOKU_KAHU_KOJO==.
if r(N)==_N {
    display as error "Only missing value: {bf:TOKU_KAHU_KOJO} (寡婦控除(特別))"
}


capture count if IPPAN_KAHU_KOJO==.
if r(N)==_N {
    display as error "Only missing value: {bf:IPPAN_KAHU_KOJO} (寡婦控除(一般))"
}


capture count if KAHU_KOJO==.
if r(N)==_N {
    display as error "Only missing value: {bf:KAHU_KOJO} (寡夫控除)"
}


capture count if KINRO_KOJO==.
if r(N)==_N {
    display as error "Only missing value: {bf:KINRO_KOJO} (勤労学生控除)"
}


capture count if KYUYO_TEATE==.
if r(N)==_N {
    display as error "Only missing value: {bf:KYUYO_TEATE} (給料・手当等)"
}


capture count if SYOYO==.
if r(N)==_N {
    display as error "Only missing value: {bf:SYOYO} (賞与等)"
}


capture count if KYUYOGAKU_KEI==.
if r(N)==_N {
    display as error "Only missing value: {bf:KYUYOGAKU_KEI} (計)"
}


capture count if SYAKAIHOKEN_KOJOGAKU==.
if r(N)==_N {
    display as error "Only missing value: {bf:SYAKAIHOKEN_KOJOGAKU} (社会保険料控除額)"
}


capture count if SYOKIBO_KOJO==.
if r(N)==_N {
    display as error "Only missing value: {bf:SYOKIBO_KOJO} (小規模企業共済等掛金控除額)"
}


capture count if IPPAN_SEIHO_KOJOGAKU==.
if r(N)==_N {
    display as error "Only missing value: {bf:IPPAN_SEIHO_KOJOGAKU} (一般生命保険料控除額)"
}


capture count if KAIGO_IRYO_KOJO==.
if r(N)==_N {
    display as error "Only missing value: {bf:KAIGO_IRYO_KOJO} (介護医療保険料控除額)"
}


capture count if KOJIN_NENKIN_KOJO==.
if r(N)==_N {
    display as error "Only missing value: {bf:KOJIN_NENKIN_KOJO} (個人年金保険料控除額)"
}


capture count if JISIN_KOJOGAKU==.
if r(N)==_N {
    display as error "Only missing value: {bf:JISIN_KOJOGAKU} (地震保険料控除額)"
}


capture count if HAIGU_TOKUBETU_KOJOGAKU==.
if r(N)==_N {
    display as error "Only missing value: {bf:HAIGU_TOKUBETU_KOJOGAKU} (配偶者特別控除額)"
}


capture count if JUTAKU_KOJO==.
if r(N)==_N {
    display as error "Only missing value: {bf:JUTAKU_KOJO} (住宅借入金等特別控除額)"
}


capture count if NENZE_GAKU==.
if r(N)==_N {
    display as error "Only missing value: {bf:NENZE_GAKU} (年税額)"
}


