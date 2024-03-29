/*----------------------------------------------------------------------
    <README>
    This do-file is generated from the python program provided by [URL].
        _const.do:    Import fixed-length data
        _var.do:      Put variable labels
        _val.do:      Put value labels
        _validate.do: Check if the data seems correctly imported
        _rename.do: Rename variable names to append several data

    WARNING:
        1. The generated do-files do not necessarily correct.
           If you find something wrong regarding the program or
           the resulting do-file(s), please send email to [Email Address].

        2. All variables are assumed to be numeric, if there is a variable
           with non-missing string value, modify _const.do and _val.do

        3. _validate.do checks if each variable has the values that it is
           supposed to have. (Categorical variables only)

        4. _rename.do is generated by finding a variable with a similar
           variable description and, if any, a similar variable name from
           the base data. So it is quite likely that some variables are
           renamed incorrectly. Please check and modify _rename.do.

        5. In addition, there is no file to make variable values consistent
           across different data.


    Source: 平成16～29年_賃金福祉基本統計調査_符号表(個人票).xlsx
    Date: 2019/03/12 16:13:40
----------------------------------------------------------------------*/


#delimit ;
    quietly infix
        str var1 1-4
        str var2 5-6
        str var4 10-11
        str var5 12-16
        str var6 17-17
        str var7 18-19
        str var8 20-21
        str var9 22-24
        str var10 25-30
        str var11 31-34
        str var13 36-38
        str var14 39-39
        str var15 40-40
        str var16 41-41
        str var19 46-48
        str var20 49-49
        str var21 50-50
        str var22 51-51
        str var23 52-55
        str var24 56-57
        str var25 58-59
        str var26 60-65
        str var27 66-66
        str var28 67-67
        str var29 68-68
        str var31 70-74
        str var32 75-79
        str var33 80-84
        str var34 85-89
        str var35 90-94
        str var36 95-95
        str var37 96-97
        str var38 98-98
        str var40 104-104
        str var41 105-105
        str var42 106-106
        str var43 107-107
        str var44 108-109
        str var45 110-111
        str var46 112-112
        str var47 113-115
        str var48 116-116
        str var49 117-118
        str var50 119-121
        str var51 122-124
        str var52 125-129
        str var53 130-133
        str var54 134-138
        str var55 139-141
        str var56 142-144
        str var57 145-147
        str var58 148-153
    using "${path_data}/WageCensus/raw/調査票情報/h01-29_k-chin/h20_k-chin.txt";
#delimit cr
