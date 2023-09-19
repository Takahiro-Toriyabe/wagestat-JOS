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


    Source: D:/GitHub/mic-wagestat/layout/chingin/平成16_29年_賃金構造基本統計調査_符号表(個人票).xlsx
    Date: 2020/09/30 17:06:02
-----------------------------------------------------------------------------*/


#delimit ;
    quietly infix
        str Chosa_Nen 1-4
        str Katsu 5-6
        str Ken 10-11
        str JigyoRen 12-16
        str Digit 17-17
        str Maime 18-19
        str RouRen 20-21
        str Shiku 22-24
        str Jigyousho 25-33
        str M_Sangyo 36-38
        str M_JigyoKibo 39-39
        str M_RinjiKibo 40-40
        str M_Kigyokibo 41-41
        str Sangyo 46-48
        str JigyoKibo 49-49
        str RinjiKibo 50-50
        str KigyoKibo 51-51
        str JigyoRitsu 52-55
        str RodoRitsu 56-57
        str RinjiRitsu 58-59
        str Fukugen 60-69
        str Minko 71-71
        str Syain_M 74-78
        str Syain_W 79-83
        str Hisyain_M 84-88
        str Hisyain_W 89-93
        str Rinji 94-98
        str SangyoDai 99-99
        str SangyoChu 100-101
        str SangyoSyo 102-102
        str Sei 108-108
        str Koyo 109-109
        str Syugyo 110-110
        str Gakureki 111-111
        str Nenrei 112-113
        str Kinzoku 114-115
        str RouSyu 116-116
        str Syoku 117-119
        str Keiken 120-120
        str RouNissu 121-122
        str SyoteiJikan 123-125
        str ChokaJikan 126-128
        str Genkin 129-133
        str ChokaKyuyo 134-137
        str SyoteiKyuyo 138-142
        str Tsukin 143-145
        str Seikin 146-148
        str Kazoku 149-151
        str Tokubetsu 152-157
    using "${path_chosa_raw}/200807　データ送付（厚生労働省）/調査票情報/賃金構造基本統計調査/h27_k-chin.txt";
#delimit cr
