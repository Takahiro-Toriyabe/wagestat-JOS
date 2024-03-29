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


    Source: D:/GitHub/mic-wagestat/layout/ESS/（標準記法）平成29年就調個別データL5_2017_RCD_Kobetsu-kk_A.XLSX
    Date: 2021/02/17 14:32:29
-----------------------------------------------------------------------------*/


#delimit ;
    quietly infix
        str RES_NENTUKI 3-8
        str N_KEN 9-10
        str N_KENNAI 11-14
        str N_SETAI1 15-15
        str N_SETAI2 16-18
        str N_SETAI3 19-20
        str N_SETAIINNO 21-22
        str C_KEN 68-69
        str C_CITY 70-72
        str R_KEN 156-157
        str R_RITSUBLKNUM 158-158
        str R_SHUKEI 185-197
        str KC_JININ 221-222
        str KC_1_SEX 223-223
        str KC_1_HAIGU 224-224
        str KC_2_TSUZUKI 225-226
        str KC_3_GENGO 227-227
        str KC_3_NEN 228-231
        str KC_3_TSUKI 232-233
        str KC_4_1_SHUGAKU 234-234
        str KC_4_1_JIKI 235-235
        str KC_4_1_GENGO 236-236
        str KC_4_1_NEN 237-240
        str KC_4_2_GAKKO 241-241
        str KC_5_1_GENGO 242-242
        str KC_5_1_NEN 243-246
        str KC_5_1_TSUKI 247-248
        str KC_5_2_RIYU 249-250
        str KC_5_3_ZENJUKBN 251-251
        str KC_5_3_ZENJUKEN 252-253
        str KC_6_SHUNYUMAIN 254-255
        str KC_6_SHUNYU_1 256-257
        str KC_6_SHUNYU_2 258-259
        str KC_6_SHUNYU_3 260-261
        str KC_6_SHUNYU_4 262-263
        str KC_6_SHUNYU_5 264-265
        str KC_6_SHUNYU_6 266-267
        str KC_6_SHUNYU_7 268-269
        str KC_6_SHUNYU_8 270-271
        str KC_6_SHUNYU_9 272-273
        str KC_6_SHUNYU_10 274-275
        str KC_7_SHUGYO 276-276
        str KC_A1_CHII 277-278
        str KC_A1_2_KIGYO 279-279
        str KC_A1_3_KOYOKIKAN 280-281
        str KC_A1_4_KOSHIN 282-282
        str KC_A1_4_KOSHINSU 283-284
        str KC_A2_1_SOSHIKI 285-285
        str KC_A2_23_SANGS 286-288
        str KC_A3_SHOKS 289-291
        str KC_A4_KIBO 292-293
        str KC_A5_1_NISSU 294-294
        str KC_A5_2_KISOKU 295-295
        str KC_A5_3_JIKAN 296-297
        str KC_A6_SHOTOKU 298-299
        str KC_A7_STARTGENGO 300-300
        str KC_A7_STARTNEN 301-304
        str KC_A7_STARTTSUKI 305-306
        str KC_A8_SHUGYORIYU 307-307
        str KC_A9_KEITAIRIYU_1 308-308
        str KC_A9_KEITAIRIYU_2 309-309
        str KC_A9_KEITAIRIYU_3 310-310
        str KC_A9_KEITAIRIYU_4 311-311
        str KC_A9_KEITAIRIYU_5 312-312
        str KC_A9_KEITAIRIYU_6 313-313
        str KC_A9_KEITAIRIYU_7 314-314
        str KC_A9_KEITAIRIYUMAIN 315-315
        str KC_A10_CHOSEI 316-316
        str KC_A11_KEIZOKUKIBO 317-317
        str KC_A11_2_TENSHOKURIYU 318-318
        str KC_A11_3_TENSHOKUKEITAI 319-319
        str KC_A11_4_KYUSHOKU 320-320
        str KC_A12_KIBOJIKAN 321-321
        str KC_A13_FUKUKBN 322-322
        str KC_A14_FUKUSANGD 323-323
        str KC_A15_ZENSHUGYO 324-324
        str KC_A16_ZENSHUGYOUMU 325-325
        str KC_B1_KIBOUMU 326-326
        str KC_B2_KIBORIYU 327-327
        str KC_B3_KIBOSHOKUSHU 328-329
        str KC_B4_KIBOKEITAI 330-330
        str KC_B5_KYUSHOKU 331-331
        str KC_B6_HIKYUSHOKURIYU 332-333
        str KC_B7_KIKANKBN 334-334
        str KC_B7_KIKANNEN 335-336
        str KC_B7_KIKANTSUKI 337-338
        str KC_B8_KIBOJIKI 339-339
        str KC_B9_HIKIBORIYU 340-341
        str KC_B10_ZENSHUGYO 342-342
        str KC_B11_ZENSHUGYOUMU 343-343
        str KC_C1_ENDJIKI 344-344
        str KC_C1_ENDGENGO 345-345
        str KC_C1_ENDNEN 346-349
        str KC_C1_ENDTSUKI 350-351
        str KC_C2_KIKANKBN 352-352
        str KC_C2_KIKANNEN 353-354
        str KC_C2_KIKANTSUKI 355-356
        str KC_C3_RIYU 357-358
        str KC_C4_CHII 359-360
        str KC_C5_KOYOKIKAN 361-362
        str KC_C6_SANGD 363-363
        str KC_C7_SHOKD 364-364
        str KC_D1_KBN 365-365
        str KC_D2_STARTGENGO 366-366
        str KC_D2_STARTNEN 367-370
        str KC_D2_STARTTSUKI 371-372
        str KC_D3_CHII 373-374
        str KC_G1_NENSHU 414-415
        str KC_G2_15MIMANJININ 416-417
        str KC_G2_15MIMANNENREI0 418-418
        str KC_G2_15MIMANNENREI1 419-419
        str KC_G2_15MIMANNENREI2 420-420
        str KC_G2_15MIMANNENREI3 421-421
        str KC_G2_15MIMANNENREI4 422-422
        str KC_G2_15MIMANNENREI5 423-423
        str KC_G2_15MIMANNENREI6 424-424
        str KC_G2_15MIMANNENREI7 425-425
        str KC_G2_15MIMANNENREI8 426-426
        str KC_G2_15MIMANNENREI9 427-427
        str KC_G2_15MIMANNENREI10 428-428
        str KC_G2_15MIMANNENREI11 429-429
        str KC_G2_15MIMANNENREI12 430-430
        str KC_G2_15MIMANNENREI13 431-431
        str KC_G2_15MIMANNENREI14 432-432
        str S_IPPAN 440-440
        str S_KAZOKURUI12 445-446
        str K_AGE 516-518
        str K_AGE5 519-520
        str K_AGE10 521-521
        str YH_KOKUCHO_SANSYO 905-908
        str YH_KOKUCHO_SHOSYO 909-912
        str YF_KOKUCHO_SANDAI 913-913
        str Z_KOKUCHO_SANDAI 914-914
        str Z_KOKUCHO_SHODAI 915-915
    using "${path_data}/chosa/raw/210119　就業構造基本統計調査調査票情報データ/提供データ（統計委員会）/提供データ/L5_2017_RCD_Kobetsu-KK_A.txt";
#delimit cr
