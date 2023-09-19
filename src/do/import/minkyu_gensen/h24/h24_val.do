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


capture label define GYOSYU_BUNRUI 1 "建設業" 2 "製造業" 3 "卸売業,小売業" 4 "宿泊業,飲食サービス業" 5 "金融業,保険業" 6 "不動産業,物品賃貸業" 7 "運輸業,郵便業" 8 "電気・ガス・熱供給・水道業" 9 "情報通信業" 
capture label values GYOSYU_BUNRUI GYOSYU_BUNRUI

